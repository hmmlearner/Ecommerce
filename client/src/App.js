import RootLayout from "./pages/Root";
import { RouterProvider, createBrowserRouter } from "react-router-dom";
import HomePage from "./pages/HomePage";
import Product from "./pages/product/Product";
import Category from "./pages/Category";
import NotFoundError from "./pages/errors/NotFoundError"


const router = createBrowserRouter([
    {
        path: "/",
        element: <RootLayout />,
        errorElement: <NotFoundError/>,
        children: [
            { index: true, element: <HomePage /> },
            { path: "category/:name", element: <Category /> },
            { path: "category/:name/product", element: <Product /> },
        ],
    },
]);

function App() {

    require('react-dom');
    window.React2 = require('react');
    console.log(window.React1 === window.React2);


    return (
                <RouterProvider router={router} />
    );
}

export default App;

