using AutoMapper;
using Ecommerce.Data;
using Ecommerce.DTO.Category;
using Ecommerce.DTO.Product;
using Ecommerce.Interfaces;
using Ecommerce.Models;

namespace Ecommerce.Services
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly DataContext _dataContext;
        private readonly IMapper _mapper;

        public CategoryRepository(DataContext dataContext, IMapper mapper) 
        {
            _dataContext = dataContext;
            _mapper = mapper;
        }
        public async Task<ServiceResponse<CategoryRetrieveDto>> CreateCategory(CategoryCreateDto product)
        {
            var serviceReponse = new ServiceResponse<CategoryRetrieveDto>();
            var category = _mapper.Map<Category>(product);
            _dataContext.Categories.Add(category);
            await _dataContext.SaveChangesAsync();
            var newCategory = await _dataContext.Categories.SingleOrDefaultAsync(x => x.Id == category.Id);
            serviceReponse.Data = _mapper.Map<CategoryRetrieveDto>(newCategory);
            return serviceReponse;
        }

        public async Task<ServiceResponse<List<CategoryRetrieveDto>>> GetAllCategories()
        {
            var serviceResponse = new ServiceResponse<List<CategoryRetrieveDto>>();
            var categories = await _dataContext.Categories.ToListAsync();
            serviceResponse.Data = categories.Select(x => _mapper.Map<CategoryRetrieveDto>(x)).ToList(); 
            return serviceResponse;
        }

        public async Task<ServiceResponse<Category>> GetCategoryById(int id)
        {
            var serviceResponse = new ServiceResponse<Category>();
            var category = await _dataContext.Categories.SingleOrDefaultAsync(x => x.Id == id);
            serviceResponse.Data = category;
            return serviceResponse;
        }

        public async Task<ServiceResponse<CategoryRetrieveDto>> GetCategoryByName(string categoryName)
        {
            var serviceResponse = new ServiceResponse<CategoryRetrieveDto>();
            var category = await _dataContext.Categories.SingleOrDefaultAsync(x => x.Name == categoryName);
            serviceResponse.Data = _mapper.Map<CategoryRetrieveDto>(category);
            return serviceResponse;
        }
    }
}
