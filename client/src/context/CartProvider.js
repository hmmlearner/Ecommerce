import React, { useReducer } from 'react';
import CartContext from './cart-context';
// Define the initial state
const initialState = {
    cartItems: [],
    totalItems: 0,
    totalPrice: 0,
};

// Define actions
const ADD_TO_CART = 'ADD_TO_CART';
const REMOVE_FROM_CART = 'REMOVE_FROM_CART';

// Reducer function
const cartReducer = (state, action) => {
    switch (action.type) {
        case ADD_TO_CART:
            console.log("ADD_TO_CART " + action.payload.quantity);
            const updatedTotalAmount = state.totalPrice + action.payload.item.price * action.payload.quantity;
            console.log("ADD_TO_CART " + updatedTotalAmount);
            const itemExists = state.cartItems.find(item => item.id === action.payload.item.id);
            const existingCartItems = [...state.cartItems];
            if (itemExists) {
                let index = existingCartItems.findIndex(item => item.id === action.payload.item.id);
                existingCartItems[index].quantity += action.payload.item.quantity;

                return {
                    //...state,
                    //cartItems: [...state.cartItems, action.payload],
                    //totalItems: state.totalItems + 1,
                    //totalPrice: state.totalPrice + action.payload.price,
                    ...state,
                    cartItems: existingCartItems,
                    totalItems: state.totalItems + 1,
                    totalPrice: updatedTotalAmount,
                };
            } else {
                // Example: You might use fetch or an API call to add the item to the server
                addToServerCart(action.payload);
                return {
                        ...state,
                        cartItems: [...state.cartItems, action.payload],
                        totalItems: state.totalItems + 1,
                        totalPrice: updatedTotalAmount,
                        };
            }
        case REMOVE_FROM_CART:
            const itemIndex = state.cartItems.findIndex(item => item.id === action.payload.id);
            const updatedTotalAmount2 = state.totalPrice - state.cartItems[itemIndex].price;
            const existingItems = [...state.cartItems];
            const existingItem = existingItems[itemIndex];
            if (existingItem.quantity > 1) {
                //state.cartItems[itemIndex].quantity -= 1; //dont manupulate state directly
                existingItems[itemIndex].quantity -= 1;
                return {
                    //cartItems: state.cartItems,
                    ...state,
                    cartItems: existingItems,
                    totalItems: state.totalItems - 1,
                    totalPrice: updatedTotalAmount2,
                };
            }
            else {
                //remove item from the cart
                return {
                        ...state,
                        //cartItems: state.cartItems.filter(item => item.id !== action.payload.id), //dont manupulate state directly
                        cartItems: existingItems.filter(item => item.id !== action.payload.id),
                        totalItems: state.totalItems - 1,
                        totalPrice: updatedTotalAmount2,
                    };
            }
            
        default:
            return state;
    }
};

const addToServerCart = (item) => {
    // Simulated API call or fetch to add the item to the server
    console.log(`Item added to server cart: ${item.name}`);
};

const CartProvider = (props) => {
    const [cartState, cartDispatch] = useReducer(cartReducer, initialState);

    const onAddToCartHandler = (item, quantity) => {
        cartDispatch({ type: ADD_TO_CART, payload: { item: item, quantity: quantity } });
    };

    const onRemoveFromCartHandler = (item) => {
        cartDispatch({ type: REMOVE_FROM_CART, payload: item.id });
    };

    const cartContext = {
        cartItems: cartState.cartItems,
        totalItems: cartState.totalItems,
        totalPrice: cartState.totalPrice,
        addToCart: onAddToCartHandler,
        removeFromCart: onRemoveFromCartHandler
    };
    return (
        <CartContext.Provider value={cartContext} > {props.children}</CartContext.Provider>
    )
}
export default CartProvider;