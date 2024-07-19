/* eslint-disable no-empty */
/* eslint-disable no-unused-vars */
/* eslint-disable no-debugger */

// Import necessary modules
const cds = require("@sap/cds");
const { SELECT, INSERT, UPDATE } = cds.ql;


class InvCatalogService extends cds.ApplicationService {
    async init() {
        const {
            InvoiceEntity,
            InvoiceItemEntity,

        } = this.entities;
        const db = await cds.connect.to("db");

        return super.init();
    }
}

module.exports = InvCatalogService;
