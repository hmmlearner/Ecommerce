using Ecommerce.DTO.Order;
using Ecommerce.DTO.ShoppingCart;
using Ecommerce.Interfaces;
using Ecommerce.Models;
using Ecommerce.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Ecommerce.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : Controller
    {
        private readonly ILogger _logger;
        private readonly IOrderRepository _orderRepository;

        public OrderController(ILogger<Order> logger, IOrderRepository orderRepository)
        {
            _logger = logger;
            _orderRepository = orderRepository;
        }

        [Route("OrderConfirmation")]
        [HttpPost]
        public async Task<ActionResult<ServiceResponse<OrderRetrieveDto>>> OrderConfirmation()
        {
            try
            {
                var orderConfirmationReponse = await _orderRepository.OrderConfirmation();
                return (orderConfirmationReponse == null) ? BadRequest("Couldn't submit order") : Ok(orderConfirmationReponse);

            }
            catch (Exception ex)
            {
                return BadRequest($"Couldn't submit order {ex.InnerException}");
            }
        }

        [Route("RetrieveOrder")]
        [HttpGet]
        public async Task<ActionResult<ServiceResponse<OrderRetrieveDto>>> RetrieveOrder(int ordernumber)
        {
            try
            {
                var orderReponse = await _orderRepository.RetrieveOrder(ordernumber);
                return (orderReponse == null) ? BadRequest("Couldn't retrieve order") : Ok(orderReponse);

            }
            catch (Exception ex)
            {
                return BadRequest($"Couldn't retrieve order {ex.Message}");
            }
        }
    }
}
