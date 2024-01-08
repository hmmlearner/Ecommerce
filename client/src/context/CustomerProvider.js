import React, { useReducer } from 'react';
import CustomerContext from './customer-context';


// Define the initial state
const initialState = {
    loggedIn: false,
    name: ""
};

//Define customer actions
const LOG_IN = 'LOG_IN';
const LOG_OUT = 'LOG_OUT';

//create customer reducer
const customerReducer =  (state, action) => {
    switch (action.type) {
        case LOG_IN:
            console.log("LOG_IN " + action.payload.loggedIn );
            return {
                ...state,
                loggedIn: action.payload.loggedIn,
                name: action.payload.name
            };          

        case LOG_OUT:
            return {
                ...state,
                loggedIn: false,
                name: ""
            };
        default:
            return state;
    }
};


     //create a function to call login api
const authenticateCustomer = async  (email, password) => {
    // Simulated API call or fetch to add the item to the server
    let eod;


    try {
        const response = await axios.post(`https://localhost:7056/api/customer/Login?username=${email}&password=${password}`);
        const data = response.data;
        eod = data;
        console.log('Data from async/await:', data);
        return eod;

        // You can work with the data here
    } catch (error) {
        console.error('Error:', error);
        return error;
    }

  /*  await axios.post(`https://localhost:7056/api/customer/Login?username=${email}&password=${password}`)
        .then(response => response.json())
        .then(data => {
            console.log('Data from promise:', data);
            eod = data;
            // You can work with the data here
        })
        .catch(function (error) {
            console.log("Error " + error.message);
            return error
        });*/
   
};

//create customer provider with useReducer hook
const CustomerProvider = (props) => {
    const [customerState, dispatchCustomerAction] = useReducer(customerReducer, initialState);

    //const logInHandler = (email, password) => {
    //    //call login api
    //    dispatchCustomerAction({ type: LOG_IN, payload: { email: email, password: password } });

    //    console.log("logInHandler " + customerState.loggedIn);
    //};
    const logInHandler = (loggedIn, name) => {
        //call login api
        dispatchCustomerAction({ type: LOG_IN, payload: { loggedIn: loggedIn, name: name } });

        console.log("logInHandler " + customerState.loggedIn);
    };

    const logOutHandler = () => {
        //call logout api
        console.log("logOutHandler");
        dispatchCustomerAction({ type: LOG_OUT });
    };

    const customerContext = {
        loggedIn: customerState.loggedIn,
        name: customerState.name,
        logIn: logInHandler,
        logOut: logOutHandler
    };

    return (
        <CustomerContext.Provider value={customerContext}>
            {props.children}
        </CustomerContext.Provider>
    );
};

export default CustomerProvider;