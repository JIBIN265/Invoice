/* eslint-disable no-debugger */
/* eslint-disable no-unused-vars */
const axios = require('axios');
const querystring = require('querystring');

// Helper to create a soap service usign axios
module.exports = class SOAPHelper {
    constructor(options) {
        this.rawdata = options.rawdata;
        this.clientId = options.clientId;
        this.clientSecret = options.clientSecret;
        this.tokenUrl = options.tokenUrl;
        this.bodyUrl = options.bodyUrl;
    }

    async postToSOAPService(

    ) {
        try {
            let requestBody = this.rawdata;
            debugger;
            const credentials = `${this.clientId}:${this.clientSecret}`;
            const encodedCredentials = Buffer.from(credentials).toString("base64");

            const formData = querystring.stringify({
                grant_type: "client_credentials",
                // No other necessary parameters required by our service
            });

            const tokenResponse = await axios.post(this.tokenUrl, formData, {
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                    Authorization: `Basic ${encodedCredentials}`,
                },
            });

            const tokendata = tokenResponse.data;

            const bodyResponse = await axios.post(this.bodyUrl, requestBody, {
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${tokendata.access_token}`, // Use the access token here
                },
            });


            // Extract the product number using substring and regular expression
            const productNumber = bodyResponse.data.match(/\d+/)[0]; // Extracts the first sequence of digits

            // console.log("SAP Product Number:", productNumber);


            return productNumber;
        } catch (error) {
            // console.error("Error:", error.response ? error.response.data : error);
            return "Error";
        }
    }


};