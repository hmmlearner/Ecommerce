using Microsoft.AspNetCore.Mvc.ModelBinding.Validation;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Ecommerce.DTO.Product
{
    public class ProductCreateDto
    {
        [Required]
        public string Title { get; set; }
        public string Description { get; set; }
        [Required]
        public string SKU { get; set; }

        [Required]
        [Range(1, 10000)]
        [Display(Name = "Price")]
        public double Price { get; set; }

        [Range(1, 10000)]
        [Display(Name = "Sale Price")]
        public double SalePrice { get; set; }

        [Range(1, 10000)]
        [Display(Name = "Was Price")]
        public double WasPrice { get; set; }
        [ValidateNever]
        public string ImageUrl { get; set; }

        [ForeignKey("CategoryId")]
        [ValidateNever]
        public int CategoryId { get; set; }
        [Range(1, 10000)]
        [Display(Name = "Inventory")]
        public int Inventory { get; set; }
    }
}
