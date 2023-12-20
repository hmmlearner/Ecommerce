import React from "react";
import ProductCard from "./product/ProductCard";

const ProductList = ({ products }) => {
    return (
        products.map(prod => {
            <ProductCard key={ prod.id} product={prod} />
        })
    );
};

export default ProductList;
