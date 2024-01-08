import React, {useContext} from "react";
import { useLoaderData } from "react-router-dom";
import axios from "axios";
import CartContext from "../../context/cart-context";


//create product component to display product page

const Product = () => {

    const { addToCart } = useContext(CartContext);
    const product = useLoaderData();


    // Handler function to handle form submission
    const handleSubmit = async (event) => {
        event.preventDefault();
        // Add your logic for handling the login here
        let data;
        try {
            data = await authenticateCustomer(formData.username, formData.password);
            console.log('Data outside async/await:', data.data);
            console.log("After LOG_IN " + (data.success ? true : false));

        } catch (error) {
            console.error('Error outside async/await:', error);
            return error;
        }

        getAuthToken();
        addToCart(product.id, 1);

        console.log('Login submitted with:' + customerCtx.loggedIn, customerCtx.name);
        loginClose();
    };



    //create a function to call login api
    const authenticateCustomer = async (email, password) => {
        // Simulated API call or fetch to add the item to the server
        let eod;


        try {
            const response = await axios.post(`https://localhost:7056/api/customer/Login?username=${email}&password=${password}`);
            const data = response.data;
            eod = data;
            console.log('Data from async/await:', data);
            return eod;

            // You can work with the data here
        } catch (error) {
            console.error('Error:', error);
            return error;
        }
    };



    return (

     <article className="product">
      <img src={`/productimgs/${product.imageUrl}`} alt={product.title} />
      <div className="product-content">
        <div>
          <h3>{product.title}</h3>
          <p className='product-price'>${product.price}</p>
          <p>{product.description}</p>
        </div>
                <p className='product-actions'>
                    <button onClick={() => { addToCart(product,1) }} >Add to Cart</button>
        </p>
      </div>
    </article>
    );
};

export default Product;

// create loader function to fetch product data from product controller in Ecommerce.API
export async function loader({ request, params }) {
    let eod;
    console.log("in loader");
    console.log(params.id);
    await axios.get(`https://localhost:7056/api/product/${params.id}`)
        .then((response) => {
            console.log(response.data.data);
            eod = response.data.data;
            //console.log(response.status);
            //console.log(response.statusText);
            //console.log(response.headers);
            //console.log(response.config);
        })
        .catch(function (error) {
            console.log("Error " + error.message);
            return error
        });
    return eod;
}

