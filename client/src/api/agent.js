import axios, { AxiosError, AxiosResponse } from "axios";
import { Agent, request } from "https";
import { router } from "../router/Routes";

const sleep = () => new Promise(resolve => setTimeout(resolve, 500));

axios.defaults.baseURL = "https://localhost:7056/api/";
axios.defaults.withCredentials = true;

const responseBody = (response) =>  response.data;

axios.interceptors.response.use(async response => {
    await sleep();

    console.log('response from API call ' + JSON.stringify(response));
        return response
    
}, (error) => {
    const { data, status } = error.response;
    switch (status) {
        case 400:
            if (data.errors) {
                const errorString = [];
                for (const key in data.errors) {
                    if (data.errors[key]) {
                        errorString.push(data.errors[key]);
                    }
                }
                throw errorString.flat(); // flattens array [[1,2],[3,4]] becomes [1,2,3,4]
            }
            break;
        case 500:
            router.navigate('/server-error', { state: { error: data } });
            break;
        default:

    }

    return Promise.reject(error.response);
})

const requests = {
    get: (url) => axios.get(url).then(responseBody),
    post: (url, body) => axios.post(url, body).then(responseBody),
    put: (url, body) => axios.put(url, body).then(responseBody),
    delete: (url) => axios.delete(url).then(responseBody),
}


const Catalogue = {
    list: (name) => {
        console.log(`Name: ${name}`);
        requests.get(`category/${name}`)
    },
    details: (name) =>  requests.get(`category/${name}/products`) 
}


const agent = {
    Catalogue,
}

export default agent; 