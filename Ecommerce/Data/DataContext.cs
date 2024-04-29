global using Microsoft.EntityFrameworkCore.SqlServer;

using Ecommerce.Models;
using Microsoft.Extensions.Hosting;

namespace Ecommerce.Data
{
    public class DataContext: DbContext
    {
        public DataContext():base() { } 
 
        public DataContext(DbContextOptions<DataContext> options):base(options) 
        {
          
        }
        public DbSet<Product> Products { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<ShoppingCart> ShoppingCarts { get; set;}
        public DbSet<ShoppingCartItem> ShoppingCartItems { get; set;}

        public DbSet<Order> Orders { get; set; }

        public DbSet<OrderLine> OrderLines { get; set; }


    }
}
