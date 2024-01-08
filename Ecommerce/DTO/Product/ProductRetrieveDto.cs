using Ecommerce.Models;
using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Ecommerce.DTO.Product
{
    public class ProductRetrieveDto
    {
        public int Id { get; set; }
        public string Title { get; set; } 
        public string Description { get; set; } 
        public string SKU { get; set; } 

        public double Price { get; set; } 

        public double SalePrice { get; set; } 

        public double WasPrice { get; set; } 
        public string ImageUrl { get; set; } 
        public int CategoryId { get; set; }
        public string Category { get; set; } 
        public int Inventory { get; set; }

    }
}
