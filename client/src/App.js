import RootLayout from "./pages/Root";
import { RouterProvider, createBrowserRouter, createRoutesFromElements, Route } from "react-router-dom";
import HomePage from "./pages/HomePage";
import CartProvider from "./context/CartProvider";
import CustomerProvider from "./context/CustomerProvider";
import Product, { loader as productLoader } from "./pages/product/Product";
import Category, { loader as productsLoader } from "./pages/Category";
import NotFoundError from "./pages/errors/NotFoundError"


const router = createBrowserRouter([
    {
        path: "",
        element: <RootLayout />,
        errorElement: <NotFoundError/>,
        children: [
              { index: true, element: <HomePage /> },
            { path: "/category/:name", id: "category-products", element: <Category />, loader: productsLoader },
            { path: "category/:name/:id", element: <Product />, loader: productLoader },
        ],
    },
]);




//const router = createBrowserRouter(
//    createRoutesFromElements(
//        <Route element={<RootLayout />}>
//            <Route index element={<HomePage />} />
//            <Route
//                path="/category/:name"
//                loader={productsLoader}
//                id= "category-products"
//                element={<Category />}
//            />
//        </Route>
//    )
//);





function App() {

    require('react-dom');
    window.React2 = require('react');
    console.log(window.React1 === window.React2);


    return (
        <CustomerProvider>
        <CartProvider>
            <RouterProvider router={router} />
            </CartProvider>
        </CustomerProvider>
    );
}

export default App;

