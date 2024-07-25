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
        const db await cds.connect.to("db");

        this.on('READ', [PurchaseOrder, PurchaseOrderItem], async (req) => {
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            return await pos.run(req.query);
        });

        this.on('READ', A_MaterialDocumentHeader, async (req) => {
            const grd = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');
            return await grd.run(req.query);
        });


        this.on('doThreeWayMatch', 'Invoice', async req => {

            // For fetching Purchase Order details
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            console.log("Three way Verification Code Check");
            const { ID } = req.params[0];
            if (!ID) { return; }
            const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            const recordItem = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
            const { purchaseOrder } = recordItem[0];

            const purchaseS4 = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder: purchaseOrder }));
            if (!purchaseS4) {
                return req.reject(404, `Purchase Order ${purchaseOrder} not found`);//validation 1
            }
            const purchaseS4Item = await pos.run(SELECT.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder }));

            console.log(purchaseS4);
            console.log(purchaseS4Item);


            // For fetching Material Documents
            const grs = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');
            //const { ID } = req.params[0];
            //if (!ID) { return; }
            //const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            // const recordItem = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
            // const { ReferenceDocument } = recordItem[0];

            //const materialS4 = await grs.run(SELECT.one.from(A_MaterialDocumentHeader).where({ ReferenceDocument: ReferenceDocument }));
            //const materialS4 = await grs.run(SELECT.one.from(A_MaterialDocumentHeader).where(`ReferenceDocument eq '${ReferenceDocument}'`));
            // if (!materialS4) {
            //     return req.reject(404, `Material Document ${ReferenceDocument} not found`);//validation 1
            // }
            //const purchaseS4Item = await pos.run(SELECT.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder }));

            //const { purchaseOrder } = recordItem[0];
            let materialS4;
            try {
                console.log(`Attempting to fetch Material Document for Purchase Order: ${purchaseOrder}`);
                materialS4 = await grs.run(
                    SELECT.one.from(A_MaterialDocumentHeader)
                        .where({ ReferenceDocument: purchaseOrder })
                );
                if (!materialS4) {
                    console.log(`No Material Document found for Purchase Order ${purchaseOrder}`);
                    // Handle the case when no document is found
                } else {
                    console.log(`Material Document found for Purchase Order ${purchaseOrder}:`, materialS4);
                }
            } catch (error) {
                console.error(`Error fetching Material Document for Purchase Order ${purchaseOrder}:`, error);
                // Handle the error appropriately
            }

            console.log(materialS4);
            //console.log(purchaseS4Item);

        });

        return super.init();
    }
}

module.exports = InvCatalogService;
