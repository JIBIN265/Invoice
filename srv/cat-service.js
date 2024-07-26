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

        // Existing code for READ operations...

        this.on('doThreeWayMatch', 'Invoice', async req => {
            console.log("Three way Verification Code Check");
            const { ID } = req.params[0];
            if (!ID) { return req.reject(400, 'Invoice ID is required'); }

            const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
            if (!record) { return req.reject(404, `Invoice with ID ${ID} not found`); }

            const recordItems = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
            if (!recordItems || recordItems.length === 0) { return req.reject(404, `No items found for Invoice ${ID}`); }

            const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
            const grs = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');

            let matchResults = [];

            for (const invoiceItem of recordItems) {
                const { purchaseOrder, purchaseOrderItem, sup_InvoiceItem, quantityPOUnit, supInvItemAmount } = invoiceItem;

                // Fetch PO details
                let purchaseOrderData, purchaseOrderItemData;
                try {
                    purchaseOrderData = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder: purchaseOrder }));
                    if (!purchaseOrderData) {
                        matchResults.push({ item: sup_InvoiceItem, status: 'Failed', reason: `PO ${purchaseOrder} not found` });
                        continue;
                    }

                    purchaseOrderItemData = await pos.run(SELECT.one.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder, PurchaseOrderItem: purchaseOrderItem }));
                    if (!purchaseOrderItemData) {
                        matchResults.push({ item: sup_InvoiceItem, status: 'Failed', reason: `PO Item ${purchaseOrderItem} not found` });
                        continue;
                    }
                } catch (error) {
                    console.error(`Error fetching PO data: ${error.message}`);
                    matchResults.push({ item: sup_InvoiceItem, status: 'Error', reason: `Error fetching PO data: ${error.message}` });
                    continue;
                }

                // Fetch GR details
                let materialDocumentData, materialItemData;
                try {
                    materialDocumentData = await grs.run(
                        SELECT.one.from('A_MaterialDocumentHeader')
                            .where({ ReferenceDocument: purchaseOrder })
                    );

                    if (materialDocumentData) {
                        materialItemData = await grs.run(
                            SELECT.one.from('A_MaterialDocumentItem')
                                .where({
                                    MaterialDocument: materialDocumentData.MaterialDocument,
                                    MaterialDocumentYear: materialDocumentData.MaterialDocumentYear,
                                    PurchaseOrderItem: purchaseOrderItem
                                })
                        );
                    }
                } catch (error) {
                    console.error(`Error fetching GR data: ${error.message}`);
                    matchResults.push({ item: sup_InvoiceItem, status: 'Error', reason: `Error fetching GR data: ${error.message}` });
                    continue;
                }

                // Perform three-way matching
                let matchStatus = 'Passed';
                let matchReason = [];

                // Check quantity
                if (quantityPOUnit !== purchaseOrderItemData.OrderQuantity) {
                    matchStatus = 'Failed';
                    matchReason.push('Quantity mismatch with PO');
                }

                // Check amount
                if (supInvItemAmount !== purchaseOrderItemData.NetPriceAmount) {
                    matchStatus = 'Failed';
                    matchReason.push('Amount mismatch with PO');
                }

                // Check GR
                if (!materialItemData) {
                    matchStatus = 'Failed';
                    matchReason.push('No matching Goods Receipt found');
                } else if (quantityPOUnit !== Number(materialItemData.QuantityInBaseUnit)) {
                    matchStatus = 'Failed';
                    matchReason.push('Quantity mismatch with GR');
                }

                matchResults.push({
                    item: sup_InvoiceItem,
                    status: matchStatus,
                    reason: matchReason.join(', ') || 'All checks passed'
                });
            }

            // Update the invoice status based on the match results
            const overallStatus = matchResults.every(result => result.status === 'Passed') ? 'Matched' : 'Discrepancy';

            try {
                const updateResult = await db.run(UPDATE(Invoice).set({ status: overallStatus }).where({ ID: ID }));
                console.log(`Update result for Invoice ${ID}:`, updateResult);

                if (updateResult === 0) {
                    console.warn(`No rows updated for Invoice ${ID}. Ensure 'status' field exists in the Invoice entity.`);
                }
            } catch (error) {
                console.error(`Error updating Invoice ${ID} status:`, error);
            }

            return { invoiceID: ID, status: overallStatus, itemResults: matchResults };
        });

        return super.init();
    }
}

module.exports = InvCatalogService;