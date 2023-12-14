using Ecommerce.DTO.Product;
using Ecommerce.DTO.ShoppingCart;
using Ecommerce.Models;

namespace Ecommerce.Interfaces
{
    public interface IShoppingCartRepository
    {
        public Task<ServiceResponse<ShoppingCart>> AddToShoppingCart(int productId, int quantity);

        public Task<ServiceResponse<ShoppingCartRetrieveDto>> DeleteFromShoppingCart(int productId, int quantity);
        public Task<ServiceResponse<ShoppingCartRetrieveDto>> RetrieveShoppingCart();

    }
}
