import React, { useState, useEffect } from "react";
import classes from "./Header.module.css";
import HeaderCartButton from "./HeaderCartButton";
import { NavLink } from "react-router-dom";
import axios, { AxiosError, AxiosResponse } from "axios";

const Header = () => {

    const [categories, setCategories] = useState([]);
    const fetchCategoriesAsync = async () => {
        console.log("fetchCategoriesAsync ");
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
        console.log("in effect " + categories);
    }, []);

    return (
        <>
            <header className={classes.header}>
                <nav>
                    <ul>

                        {categories.map(item => (<li key={item.id}>
                            <NavLink className={({ isActive }) => isActive ? classes.active : undefined} end to={`/category/${item.name}`}>{item.name}</NavLink>
                                </li> )) }
                    </ul>
                </nav>
{/*                <HeaderCartButton />*/}
            </header>

        </>
    );
}

export default Header;

