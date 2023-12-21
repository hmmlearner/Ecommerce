using Ecommerce.DTO.Category;
using Ecommerce.Models;

namespace Ecommerce.Interfaces
{
    public interface ICategoryRepository
    {
        public Task<ServiceResponse<Category>> GetCategoryById(int id);
        public Task<ServiceResponse<CategoryRetrieveDto>> CreateCategory(CategoryCreateDto product);
        public Task<ServiceResponse<CategoryRetrieveDto>> GetCategoryByName(string categoryName);
        public Task<ServiceResponse<List<CategoryRetrieveDto>>> GetAllCategories();
    }
}
