const { createProxyMiddleware } = require('http-proxy-middleware');

//const context = [
//    "/weatherforecast",
//    "/api/**"
//];

//module.exports = function (app) {
//    const appProxy = createProxyMiddleware(context, {
//        target: 'https://localhost:7056',
//        secure: false
//    });

//    app.use(appProxy);
//};

module.exports = function (app) {
    app.use(
        '/api/**',
        createProxyMiddleware({
            target: 'https://localhost:7056', // Replace with your actual backend URL
            secure: false,
        })
    );
};