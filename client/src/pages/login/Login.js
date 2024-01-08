//create Cart component to display cart page in reactimport React from 'react';

import { useContext, useState } from 'react';
import CustomerContext from '../../context/customer-context';
import axios from "axios";
import { setAuthToken } from "../../utils/AuthService";


const Login = ({ loginClose }) => {
    const customerCtx = useContext(CustomerContext);
    console.log(customerCtx.loggedIn, customerCtx.name);


    const [formData, setFormData] = useState({
        username: '',
        password: '',
    });

    // Handler function to update form data on input change
    const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };
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

        setAuthToken(data.data.token);
        customerCtx.logIn(data.success, data.data.name);
  
        console.log('Login submitted with:'+ customerCtx.loggedIn, customerCtx.name);
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
        <div id="customer">
           
           
            {/* Add your cart content here */}
            {customerCtx.loggedIn ? <p>Hello: {customerCtx.name}</p>
                : <form onSubmit={handleSubmit}>
                    <div>
                        <label htmlFor="username">Username:</label>
                        <input
                            type="text"
                            id="username"
                            name="username"
                            value={formData.username}
                            onChange={handleInputChange}
                            required
                        />
                    </div>

                    <div>
                        <label htmlFor="password">Password:</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            value={formData.password}
                            onChange={handleInputChange}
                            required
                        />
                    </div>

                    <button type="submit">Login</button>
                </form>}
            
        </div>
    );
};

export default Login;
