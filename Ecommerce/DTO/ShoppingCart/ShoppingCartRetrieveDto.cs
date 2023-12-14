using Ecommerce.Models;

namespace Ecommerce.DTO.ShoppingCart
{
    public class ShoppingCartRetrieveDto
    {
        public int Quantity { get; set; }

        public int ProductId { get; set; }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public CustomerType IsAdmin { get; set; } = CustomerType.Customer;
        public string StreetAddress { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public string State { get; set; } = string.Empty;
        public string PostalCode { get; set; } = string.Empty;

        public List<ShoppingCartItem> Items { get; set;}
    }
}
