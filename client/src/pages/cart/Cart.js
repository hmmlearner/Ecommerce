//create Cart component to display cart page in reactimport React from 'react';
import classes from "./Cart.module.css";
import { useContext } from 'react';
import CartContext from '../../context/cart-context';

const Cart = () => {
    const cartCtx = useContext(CartContext);
    console.log(cartCtx.cartItems, cartCtx.totalPrice, cartCtx.totalItems);
  return (
      <div id="cart">
          <ul className={classes.cart_items}>
              {cartCtx.cartItems.map((item) => {
                  console.log(item);
                  //const formattedPrice = `$${item.price.toFixed(2)}`;
                  return  (<li key={item.id}>
                      <div className={classes.item}>

                          <div className={classes.item_details}>
                              <div className={classes.item_title}>{item.title}</div>
                              <div className={classes.item_price}>${item.price}</div>
                              <div className={classes.cart_item_actions}>
                                  <div className={classes.item_quantity}>
                                      <button>-</button>
                                      <span>{item.quantity}</span>
                                      <button>+</button>
                                  </div>
                                  <button className={classes.item_remove}>Remove</button>
                              </div>
                          </div>
                      </div>
                  </li>
                   );
              })}

          </ul>
          {/* Add your cart content here */}
          <p>Cart Total: ${cartCtx.totalPrice.toFixed(2)}</p>
    </div>
  );
};

export default Cart;
