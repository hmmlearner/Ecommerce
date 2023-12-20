import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import ProductList from "./ProductList";
import axios, { AxiosError, AxiosResponse } from "axios";

const Category = () => {
    const { name } = useParams();
    console.log(name);
  const [products, setProducts] = useState([]);

  //  const fetchProductsAsync = (name) => {
  //  "catalogue",
  //    async (name) => {
  //        try {
  //            console.log("name in fetch "+ name);
  //          const response = await agent.Catalogue.list(name);
  //        if (response?.length) setProducts([response]);
  //      } catch (error) {
  //        console.log(error);
  //      }
  //    };
  //};
    const fetchProductsAsync = async (name) => {
        console.log("fetchProductsAsync " + name);
        try {
            axios.get(`https://localhost:7056/api/category/${name}/products`)
                .then((response) => {
                    console.log(response.data);
                    console.log(response.status);
                    console.log(response.statusText);
                    console.log(response.headers);
                    console.log(response.config);
                });
        }
        catch (error) {
            console.log("Error " + error.message);
        }
    };

    useEffect(() => {
        console.log("in effect "+name);
      fetchProductsAsync(name);
  }, []);

  return <ProductList products={products} />;
};

export default Category;
