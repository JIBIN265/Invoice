/* eslint-disable no-empty */
/* eslint-disable no-unused-vars */
/* eslint-disable no-debugger */

// Import necessary modules
const cds = require("@sap/cds");
const { SELECT, INSERT, UPDATE } = cds.ql;


class InvCatalogService extends cds.ApplicationService {
    async init() {
        const {
            Invoice,
            InvoiceItem,
            PurchaseOrder,
            PurchaseOrderItem
        } = this.entities;
        const db = await cds.connect.to("db");
        
        this.on('READ', [PurchaseOrder, PurchaseOrderItem], async (req) => {
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            return await pos.run(req.query);
        });
        
        // this.on("READ", 'PurchaseOrder', async (req) => {
        //     // The API Sandbox returns alot of business partners with empty names.
        //     // We don't want them in our application
        //     // req.query.where("LastName <> '' and FirstName <> '' ");
        //     console.log('here');
        //     const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
        //     const result = await pos.run(req.query);
        //     console.log('result');
        //     return result;
        // });


        // this.on('READ', 'PurchaseOrderItem', async (req) => {
        //     const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
        //     return pos.run(req.query);
        // });


        return super.init();
    }
}

module.exports = InvCatalogService;
