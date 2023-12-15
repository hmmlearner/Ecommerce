using AutoMapper;
using Ecommerce.Data;
using Ecommerce.DTO.Order;
using Ecommerce.DTO.ShoppingCart;
using Ecommerce.Interfaces;
using Ecommerce.Models;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Ecommerce.Services
{
    public class OrderRepository : IOrderRepository
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public OrderRepository(DataContext dataContext, IMapper mapper, IHttpContextAccessor httpContextAccessor)
        {
            _dataContext = dataContext;
            _mapper = mapper;
            _httpContextAccessor = httpContextAccessor;
        }

        public DataContext _dataContext { get; }
        public IMapper _mapper { get; }

        private int GetCustomerID()
        {
            return int.Parse(_httpContextAccessor.HttpContext!.User.FindFirstValue(ClaimTypes.NameIdentifier));
        }
        public async Task<ServiceResponse<OrderRetrieveDto>> OrderConfirmation()
        {
            var customerid = GetCustomerID();
            var orderResponse = new ServiceResponse<OrderRetrieveDto>();
            var shoppingCart = await _dataContext.ShoppingCarts
                                .Include(c => c.Items)
                                .ThenInclude(p => p.Product)
                                .Include(c => c.customer)
                                .FirstOrDefaultAsync(c => c.CustomerId == customerid);
            ;

            if (shoppingCart == null)
            {
                orderResponse.StatusMessage = "Cart is empty";
                orderResponse.Success = false;
                return orderResponse;
            }
            var order = new Order
            {
                OrderItems = new List<OrderLine>(),
                CustomerId = customerid,
                ShippingName = shoppingCart.customer.Name,
                ShippingStreetAddress = shoppingCart.customer.StreetAddress,
                ShippingCity = shoppingCart.customer.City,
                ShippingState = shoppingCart.customer.State,
                ShippingPostCode = shoppingCart.customer.PostalCode
            };
            _dataContext.Orders.Add(order);
            //order.PhoneNumber = shoppingCart.customer.p
            foreach (var item in shoppingCart.Items)
            {
                var orderItem = new OrderLine
                {
                    ProductId = item.ProductId,
                    count = item.Quantity,
                    price = item.Product.SalePrice
                };
                order.OrderItems.Add(orderItem);
            }

            _dataContext.SaveChanges();
            orderResponse.Data = _mapper.Map<OrderRetrieveDto>(order);
            return await Task.FromResult(orderResponse);
        }

        public async Task<ServiceResponse<OrderRetrieveDto>> RetrieveOrder(int ordernumber)
        {

            var orderResponse = new ServiceResponse<OrderRetrieveDto>();
            var customerid = GetCustomerID();
            var order = await _dataContext.Orders.Include(c => c.OrderItems)
                        .ThenInclude(c=>c.Product).Include(c=>c.customer)
                        .FirstOrDefaultAsync(o => o.OrderNumber == ordernumber && o.CustomerId == customerid);

            if (order == null)
            {
                orderResponse.StatusMessage = "Order not not found";
                return orderResponse;
            }
            orderResponse.Data = _mapper.Map<OrderRetrieveDto>(order);
            return orderResponse;

        }

        // test: Is delete order required?
    }
}
