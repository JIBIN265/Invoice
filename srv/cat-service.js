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
            PurchaseOrder

        } = this.entities;
        const db = await cds.connect.to("db");



        this.on('READ', PurchaseOrder, async req => {
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            console.log(req.query);
            const record2 = await pos.run(req.query);
            console.log(record2);
            return record2;
            //return pos.run(req.query);
        });

        this.on('doThreeWayMatch', 'Invoice', async req => {

            console.log("Three way Verification Code Check");
            const { ID } = req.params[0];
            if (!ID) { return; }
            const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            const recordItem = await db.run(SELECT.from(InvoiceItem).where({ UP__ID: ID }));
            const { purchaseOrder } = recordItem[0];
            console.log(record);
        });

        return super.init();
    }
}

module.exports = InvCatalogService;
