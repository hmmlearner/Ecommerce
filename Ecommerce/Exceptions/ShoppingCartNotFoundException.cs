namespace Ecommerce.Exceptions
{
    public class ShoppingCartNotFoundException : Exception
    {
        public ShoppingCartNotFoundException(string message) : base(message)
        {
        }

        public ShoppingCartNotFoundException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}
