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

        this.on('doThreeWayMatch', 'Invoice', async req => {
            console.log("Three way Verification Code Check");
            const { ID } = req.params[0];
            if (!ID) { return; }

            const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            const recordItem = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
            const { purchaseOrder } = recordItem[0];

            // For fetching Purchase Order details
            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            let purchaseS4, purchaseS4Item;

            try {
                console.log(`Attempting to fetch Purchase Order: ${purchaseOrder}`);
                purchaseS4 = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder: purchaseOrder }));

                if (!purchaseS4) {
                    console.log(`Purchase Order ${purchaseOrder} not found`);
                    return req.reject(404, `Purchase Order ${purchaseOrder} not found`);//validation 1
                } else {
                    console.log(`Purchase Order ${purchaseOrder} found:`, purchaseS4);

                    // Fetch Purchase Order Items
                    purchaseS4Item = await pos.run(SELECT.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder }));

                    if (purchaseS4Item && purchaseS4Item.length > 0) {
                        console.log(`Purchase Order Items found for Purchase Order ${purchaseOrder}:`, purchaseS4Item);
                    } else {
                        console.log(`No Purchase Order Items found for Purchase Order ${purchaseOrder}`);
                    }
                }
            } catch (error) {
                console.error(`Error fetching Purchase Order or Items for Purchase Order ${purchaseOrder}:`, error);
                return req.reject(500, `Error fetching Purchase Order details: ${error.message}`);
            }

            console.log(purchaseS4);
            console.log(purchaseS4Item);

            // For fetching Material Documents
            const grs = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');
            let materialS4, materialItems;

            try {
                console.log(`Attempting to fetch Material Document for Purchase Order: ${purchaseOrder}`);
                materialS4 = await grs.run(
                    SELECT.one.from('A_MaterialDocumentHeader')
                        .where({ ReferenceDocument: purchaseOrder })
                );

                if (!materialS4) {
                    console.log(`No Material Document found for Purchase Order ${purchaseOrder}`);
                    // Handle the case when no document is found
                } else {
                    console.log(`Material Document found for Purchase Order ${purchaseOrder}:`, materialS4);

                    // Fetch Material Items using a separate query
                    materialItems = await grs.run(
                        SELECT.from('A_MaterialDocumentItem')
                            .where({
                                MaterialDocument: materialS4.MaterialDocument,
                                MaterialDocumentYear: materialS4.MaterialDocumentYear
                            })
                    );

                    if (materialItems && materialItems.length > 0) {
                        console.log(`Material Items found for Material Document ${materialS4.MaterialDocument}:`, materialItems);
                    } else {
                        console.log(`No Material Items found for Material Document ${materialS4.MaterialDocument}`);
                    }
                }
            } catch (error) {
                console.error(`Error fetching Material Document or Items for Purchase Order ${purchaseOrder}:`, error);
                // Handle the error appropriately 
            }

            console.log(materialS4);
            console.log(materialItems);

            // Additional logic for three-way matching can be added here

        });

        return super.init();
    }
}

module.exports = InvCatalogService;