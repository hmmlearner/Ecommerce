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
        [Display(Name = "Price for 1-50")]
        public double Price { get; set; }

        [Range(1, 10000)]
        [Display(Name = "Price for 51-100")]
        public double SalePrice { get; set; }

        [Range(1, 10000)]
        [Display(Name = "Price for 100+")]
        public double WasPrice { get; set; }
        [ValidateNever]
        public string ImageUrl { get; set; }

        [ForeignKey("CategoryId")]
        [ValidateNever]
        public int CategoryId { get; set; }
    }
}
