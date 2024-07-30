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
            try {
                console.log("Three way Verification Code Check");
                const { ID } = req.params[0];
                if (!ID) {
                    return req.reply({
                        statusCode: 400,
                        body: {
                            id: null,
                            status: "Invoice ID is required"
                        }
                    });
                }

                const record = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
                if (!record) {
                    return req.reply({
                        statusCode: 404,
                        body: {
                            id: ID,
                            status: `Invoice with ID ${ID} not found`
                        }
                    });
                }

                const recordItems = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
                if (!recordItems || recordItems.length === 0) {
                    return req.reply({
                        statusCode: 404,
                        body: {
                            id: ID,
                            status: `No items found for Invoice ${ID}`
                        }
                    });
                }

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
                            matchResults.push({ item: sup_InvoiceItem, status: `Failed: PO ${purchaseOrder} not found` });
                            continue;
                        }

                        purchaseOrderItemData = await pos.run(SELECT.one.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder, PurchaseOrderItem: purchaseOrderItem }));
                        if (!purchaseOrderItemData) {
                            matchResults.push({ item: sup_InvoiceItem, status: `Failed: PO Item ${purchaseOrderItem} not found` });
                            continue;
                        }
                    } catch (error) {
                        console.error(`Error fetching PO data: ${error.message}`);
                        matchResults.push({ item: sup_InvoiceItem, status: `Error: Fetching PO data failed - ${error.message}` });
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
                        matchResults.push({ item: sup_InvoiceItem, status: `Error: Fetching GR data failed - ${error.message}` });
                        continue;
                    }

                    // Perform three-way matching
                    let matchStatus = 'Passed';
                    let matchReasons = [];

                    // Check quantity
                    if (quantityPOUnit !== purchaseOrderItemData.OrderQuantity) {
                        matchStatus = 'Failed';
                        matchReasons.push('Quantity mismatch with PO');
                    }

                    // Check amount
                    if (supInvItemAmount !== purchaseOrderItemData.NetPriceAmount) {
                        matchStatus = 'Failed';
                        matchReasons.push('Amount mismatch with PO');
                    }

                    // Check GR
                    if (!materialItemData) {
                        matchStatus = 'Failed';
                        matchReasons.push('No matching Goods Receipt found');
                    } else if (quantityPOUnit !== Number(materialItemData.QuantityInBaseUnit)) {
                        matchStatus = 'Failed';
                        matchReasons.push('Quantity mismatch with GR');
                    }

                    matchResults.push({
                        item: sup_InvoiceItem,
                        status: matchStatus === 'Passed' ? 'Passed' : `Failed: ${matchReasons.join(', ')}`
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
                    return req.reply({
                        statusCode: 500,
                        body: {
                            id: ID,
                            status: `Error updating invoice status: ${error.message}`
                        }
                    });
                }

                // Return OData compliant response
                return req.reply({
                    statusCode: 200,
                    body: {
                        id: ID,
                        status: overallStatus,
                        itemResults: matchResults
                    }
                });

            } catch (error) {
                console.error("Unexpected error in doThreeWayMatch:", error);
                return req.reply({
                    statusCode: 500,
                    body: {
                        id: req.params[0].ID || null,
                        status: `Unexpected error: ${error.message}`
                    }
                });
            }
        });

        return super.init();
    }
}

module.exports = InvCatalogService;