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
            PurchaseOrderItem,
            A_MaterialDocumentHeader
        } = this.entities;
        const db = await cds.connect.to("db");
        
        this.on('READ', [PurchaseOrder, PurchaseOrderItem], async (req) => {
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            return await pos.run(req.query);
        });
        
        this.on('READ', A_MaterialDocumentHeader, async (req) => {
            const grd = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');
            return await grd.run(req.query);
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




        // this.on('READ', PurchaseOrder, async req => {
        //     const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
        //     console.log(req.query);
        //     const record2 = await pos.run(req.query);
        //     console.log(record2);
        //     return record2;
        //     //return pos.run(req.query);
        // });

        this.on('doThreeWayMatch', 'Invoice', async req => {
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            console.log("Three way Verification Code Check");
            const { ID } = req.params[0];
            if (!ID) { return; }
            const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            const recordItem = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
            const { purchaseOrder } = recordItem[0];

            const recordS4 = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder : purchaseOrder }));
            if (!recordS4) {
                return req.reject(404, `Purchase Order ${purchaseOrder} not found`);//validation 1
            }
            const recordS4Item = await pos.run(SELECT.from(PurchaseOrderItem).where({ PurchaseOrder : purchaseOrder }));



            console.log(recordS4);
            console.log(recordS4Item);
            console.log(recordS4);
        });

        return super.init();
    }
}

module.exports = InvCatalogService;
