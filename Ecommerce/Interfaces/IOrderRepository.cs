using Ecommerce.DTO.Order;
using Ecommerce.Models;
using Microsoft.AspNetCore.Mvc;

namespace Ecommerce.Interfaces
{
    public interface IOrderRepository
    {
        public Task<ServiceResponse<OrderRetrieveDto>> OrderConfirmation(int ordernumber, string sessionid);

        public Task<ServiceResponse<string>> SubmitPayment();
        public Task<ServiceResponse<OrderRetrieveDto>> RetrieveOrder(int ordernumber);
    }
}
