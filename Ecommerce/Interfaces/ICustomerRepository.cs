using Ecommerce.DTO.Customer;
using Ecommerce.Models;

namespace Ecommerce.Interfaces
{
    public interface ICustomerRepository
    {
        public Task<ServiceResponse<CustomerRetrieveDto>> GetCustomerById(int id);
        public Task<ServiceResponse<CustomerRetrieveDto>> GetCustomerByEmail(string email);
        public Task<ServiceResponse<CustomerRetrieveDto>> CreateCustomer(CustomerCreateDto customer);

        public Task<ServiceResponse<Customer>> UpdateCustomer(Customer customer);
        public Task<ServiceResponse<CustomerRetrieveDto>> CustomerLogin(string email, string password);

        public Task<bool> CustomerExists(string email);

    }
}
