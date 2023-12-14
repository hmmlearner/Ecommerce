using Ecommerce.DTO.Order;
using Ecommerce.Models;

namespace Ecommerce.Interfaces
{
    public interface IOrderRepository
    {
        public Task<ServiceResponse<OrderRetrieveDto>> OrderConfirmation();

        public Task<ServiceResponse<OrderRetrieveDto>> RetrieveOrder(int ordernumber);
    }
}
