import React, { useState, useEffect, useRef, useContext } from "react";
import classes from "./Header.module.css";
import HeaderCartButton from "./HeaderCartButton";
import { NavLink, useRouteLoaderData } from "react-router-dom";
import axios, { AxiosError, AxiosResponse } from "axios";
import CartModal from "../../pages/cart/CartModal";
import Button from '@mui/material/Button';
import CartContext from "../../context/cart-context";
import CustomerContext from "../../context/customer-context";
import LoginModal from "../../pages/login/LoginModal";
import { removeAuthToken } from "../../utils/AuthService";
import agent from "../../api/agent";

const Header = () => {
    const { totalItems } = useContext(CartContext);
    //const { loggedIn, name } = useContext(CustomerContext);
    const customerCtx = useContext(CustomerContext);
    const loggedIn = customerCtx.loggedIn;
    const name = customerCtx.name;
    const [categories, setCategories] = useState([]);

    const modal = useRef();
    const loginModal = useRef();
    const fetchCategoriesAsync = async () => {
        console.log("fetchCategoriesAsync ");
         //await agent.Category.list()
         //       .then((response) => {
         //           console.log("PRD DATA " + response);
         //           setCategories(response.data);
         //       })
         //       .catch(function (error) {
         //           console.log("Error " + error.message);
         //           return error
         //       });

/*        try {
            const response = await agent.Category.list()
            console.log(response);
        } catch (error) {
            console.error(error);
        }*/


      
        try {
            axios.get(`https://localhost:7056/api/category/all`)
                .then((response) => {
                    console.log('response.data ' + response.data);
                    console.log(response.data.statusCode);
                    console.log(response.data);
                    console.log(response.headers);
                    console.log(response.config);
                    setCategories(response.data.data);
                    console.log("in fetchCategoriesAsync " + categories);
                })
                .catch(error => console.error('Error fetching categories', error.message));
        }
        catch (error) {
            console.log("Error " + error.message);
        }
    };

    useEffect(() => {
    
        fetchCategoriesAsync();
        /*
        const fetchData = async () => {
            let eod;
            await agent.Catalogue.list()
                .then((response) => {
                    console.log("PRD DATA " + response.data.data);
                    eod = response.data.data;
                    setCategories(response.data.data);
                })
                .catch(function (error) {
                    console.log("Error " + error.message);
                    return error
                });
        };

        // Call the fetchData function when the component mounts
        fetchData();
        */

        console.log("in effect " + categories);
    }, []);

    //useEffect(() => {
    //    // Your logic here that depends on yourValue
    //    console.log('Effect triggered. YourValue:', loggedIn);

    //}, [loggedIn, name]); // Add yourValue as a dependency to the useEffect


    const openCartHandler = () => {
        // Call the onOpen method from the child component
        modal.current.onOpen();
    };
    const openLoginHandler = () => {
        // Call the onOpen method from the child component
        loginModal.current.onOpen();
    };

    const logoutHandler = () => {
        removeAuthToken();
        // Call the onOpen method from the child component
        customerCtx.logOut();
    };

    return (
        <>

            <CartModal ref={modal} />
            <LoginModal ref={loginModal} />
            <header className={classes.header}>
                <div className={classes.title}>
                    <img src="logo.png" alt="EcommerceStore" className={classes.headerimage} />
                    <h1>Ecommerce Store</h1>
                </div>
                {loggedIn ? <Button onClick={logoutHandler}> Log out</Button> : <Button onClick={openLoginHandler}> Login</Button>}
                
                <Button onClick={openCartHandler}>Cart ({totalItems})</Button>
                <nav>
                    <ul>

                        {categories.map(item => (<li key={item.id}>
                            <NavLink className={({ isActive }) => isActive ? classes.active : undefined} end to={`/category/${item.name}`}>{item.name}</NavLink>
                        </li>))}
                    </ul>
                </nav>
            </header>






        </>
    );
}

export default Header;

