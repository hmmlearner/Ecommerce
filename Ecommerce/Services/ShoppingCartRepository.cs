using Ecommerce.Data;
using Ecommerce.DTO.Product;
using Ecommerce.Interfaces;
using Ecommerce.Models;

using AutoMapper;
using Ecommerce.DTO.ShoppingCart;
using System.Security.Claims;

namespace Ecommerce.Services
{
    public class ShoppingCartRepository : IShoppingCartRepository
    {
        private readonly DataContext _dataContext;
        private readonly IMapper _mapper;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public ShoppingCartRepository(DataContext dataContext, IMapper mapper, IHttpContextAccessor httpContextAccessor)
        {
            _dataContext = dataContext;
            _mapper = mapper;
            _httpContextAccessor = httpContextAccessor;
        }
        public ShoppingCart GetCart(int shoppingCartId)
        {
            return _dataContext.ShoppingCarts.Include(c => c.Items).FirstOrDefault(c => c.Id == shoppingCartId);
        }

        private int GetCustomerID()
        {
            return int.Parse(_httpContextAccessor.HttpContext!.User.FindFirstValue(ClaimTypes.NameIdentifier));
        }

        public async Task<ServiceResponse<ShoppingCartRetrieveDto>> RetrieveShoppingCart()
        {


            var customerId = GetCustomerID();

            var serviceReponse = new ServiceResponse<ShoppingCartRetrieveDto>();
            var shoppingCart = await _dataContext.ShoppingCarts.Include(cartItem => cartItem.Items)
                                .ThenInclude(ci=>ci.Product)
                                .Include(c => c.customer)
                                .FirstOrDefaultAsync(c => c.CustomerId == customerId);
            if (shoppingCart == null)
            {
                serviceReponse.StatusMessage = "Not not fount";
                return serviceReponse;
            }
            serviceReponse.Data = _mapper.Map<ShoppingCartRetrieveDto>(shoppingCart);
            return serviceReponse;
        }


        public async Task<ServiceResponse<ShoppingCart>> AddToShoppingCart(int productId, int quantity)
        {
            //throw new NotImplementedException();
            // dont have to check if the cart already exists for customer?
            //TODO: Need to do a check if productId is valid
            var customerId = GetCustomerID();
            var serviceReponse = new ServiceResponse<ShoppingCart>();
            var product = await _dataContext.Products.SingleOrDefaultAsync(x => x.Id == productId);
            if(product == null)
            {
                serviceReponse.StatusCode = 400;
                serviceReponse.StatusMessage = "Invalid product to add";
                return await Task.FromResult(serviceReponse);
            }

            
            var shoppingCart =  _dataContext.ShoppingCarts.Include(c => c.customer).Include(cartItem => cartItem.Items).FirstOrDefault(c => c.CustomerId == customerId);// each customer will have 1 shoppingcart
            if(shoppingCart == null) 
            {
                shoppingCart = new ShoppingCart { Items= new List<ShoppingCartItem>(), CustomerId = customerId };
                _dataContext.ShoppingCarts.Add(shoppingCart);
            }
            var shoppingCartItem = shoppingCart.Items.FirstOrDefault(c => c.ProductId == productId);
            if(shoppingCartItem == null)
            {
                shoppingCartItem = new ShoppingCartItem
                {
                    ProductId = productId,
                    Quantity = quantity
                };
                shoppingCart.Items.Add(shoppingCartItem);
            }
            else
            {
                shoppingCartItem.Quantity += quantity;
            }
            _dataContext.SaveChanges();

            serviceReponse.Data = shoppingCart;
            return await Task.FromResult(serviceReponse);
        }

        public async Task<ServiceResponse<ShoppingCartRetrieveDto>> DeleteFromShoppingCart(int productId, int quantity)
        {
            var customerId = GetCustomerID();
            var serviceReponse = new ServiceResponse<ShoppingCartRetrieveDto>();
            var shoppingCart = _dataContext.ShoppingCarts.Include(c=>c.customer).Include(cartItem => cartItem.Items).FirstOrDefault(c => c.CustomerId == customerId);
            if(shoppingCart == null)
            {
                serviceReponse.StatusCode = 400;
                serviceReponse.StatusMessage = "Shopping cart not found invalid deletion";
                return await Task.FromResult(serviceReponse);
            }
            var shoppingCartItem = shoppingCart.Items.FirstOrDefault(c => c.ProductId == productId);
            if(shoppingCartItem == null)
            {
                serviceReponse.StatusCode = 400;
                serviceReponse.StatusMessage = "Product not found in the cart invalid deletion";
                return await Task.FromResult(serviceReponse);
            }
            if(shoppingCartItem.Quantity > 1)
            {
                shoppingCartItem.Quantity -= quantity;
            }
            else
            {
                _dataContext.ShoppingCartItems.Remove(shoppingCartItem);
                // may need to check if there are any shoppingcartitems in cart if not then delete the shoppingcart record as well
            }
            _dataContext.SaveChanges();
            serviceReponse.Data = _mapper.Map<ShoppingCartRetrieveDto>(shoppingCart);
            return serviceReponse;
        }

    }
}
