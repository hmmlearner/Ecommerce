import React, { createContext } from 'react';

const CartContext = createContext({
    cartItems: [],
    totalItems: 0,
    totalPrice: 0,
    addToCart: (item,quantity) => { },
    removeFromCart: (id) => { },
    clearCart: () => { }
});

export default CartContext;
