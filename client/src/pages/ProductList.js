import React from "react";
import ProductCard from "./product/ProductCard"

const ProductList = ({ products }) => {
    console.log("in productlist " + products);
    return (
        <>
        <h1>Product List</h1>
            {products.map((prod) => (
                <ProductCard key={prod.id} product={prod} />
            ))}
        </>
    );
};

export default ProductList;
