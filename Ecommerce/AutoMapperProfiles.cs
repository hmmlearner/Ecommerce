using AutoMapper;
using Ecommerce.DTO.Category;
using Ecommerce.DTO.Customer;
using Ecommerce.DTO.Order;
using Ecommerce.DTO.Product;
using Ecommerce.DTO.ShoppingCart;
using Ecommerce.Models;

namespace Ecommerce
{
    public class AutoMapperProfiles:Profile
    {
        public AutoMapperProfiles()
        {
            CreateMap<Customer, CustomerCreateDto>();
            CreateMap<CustomerCreateDto, Customer>()
                                .ForMember(
                                dest => dest.Password,
                                t => t.Ignore()
                                );
            CreateMap<Customer, CustomerRetrieveDto>().ReverseMap();
            CreateMap<Customer, CustomerUpdateDto>().ReverseMap();

            CreateMap<Product, ProductRetrieveDto>();
                //.ForMember(
                //dest => dest.Category,
                //opt => opt.MapFrom(src => src.CategoryId)
                //);

            CreateMap<ProductCreateDto, Product>().ReverseMap();
            CreateMap<Category, CategoryRetrieveDto>();
            CreateMap<CategoryCreateDto, Category>();

            CreateMap<ShoppingCart, ShoppingCartRetrieveDto>()
                .ForMember(dest => dest.Email, opt => opt.MapFrom(src => src.customer.Email))
                .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.customer.Name))
                .ForMember(dest => dest.IsAdmin, opt => opt.MapFrom(src => src.customer.IsAdmin))
                .ForMember(dest => dest.StreetAddress, opt => opt.MapFrom(src => src.customer.StreetAddress))
                .ForMember(dest => dest.City, opt => opt.MapFrom(src => src.customer.City))
                .ForMember(dest => dest.State, opt => opt.MapFrom(src => src.customer.State))
                .ForMember(dest => dest.PostalCode, opt => opt.MapFrom(src => src.customer.PostalCode))
                .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.Items));


            CreateMap<Order, OrderRetrieveDto>().
                ForMember(dest => dest.OrderItems, opt => opt.MapFrom(src => src.OrderItems));
        }
    }
}
