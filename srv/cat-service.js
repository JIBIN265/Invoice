const cds = require("@sap/cds");
const { SELECT, INSERT, UPDATE } = cds.ql;

class InvCatalogService extends cds.ApplicationService {
    async init() {
        const {
            Invoice,
            InvoiceItem,
            PurchaseOrder,
            PurchaseOrderItem,
            A_MaterialDocumentHeader,
            A_MaterialDocumentItem
        } = this.entities;

        const db = await cds.connect.to("db");
        const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
        const grs = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');

        this.on('doThreeWayMatch', 'Invoice', async req => {
            try {
                console.log("Three way Verification Code Check");
                const { ID } = req.params[0];
                if (!ID) {
                    return req.error(400, "Invoice ID is required");
                }

                // Fetch invoice
                const invoice = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
                if (!invoice) {
                    return req.error(404, `Invoice with ID ${ID} not found`);
                }

                // Fetch invoice items
                const invoiceItems = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
                if (!invoiceItems || invoiceItems.length === 0) {
                    return req.error(404, `No items found for Invoice ${ID}`);
                }

                let allItemsMatched = true;
                let itemCounter = 10;
                let allStatusReasons = [];
                let result = {
                    FiscalYear: "",
                    CompanyCode: "",
                    DocumentDate: null,
                    PostingDate: null,
                    SupplierInvoiceIDByInvcgParty: "",
                    DocumentCurrency: "",
                    InvoiceGrossAmount: invoice.invGrossAmount,
                    Status: "",
                    to_SuplrInvcItemPurOrdRef: []
                };

                for (const invoiceItem of invoiceItems) {
                    const { purchaseOrder, purchaseOrderItem, sup_InvoiceItem, quantityPOUnit, supInvItemAmount } = invoiceItem;

                    // Fetch PO details
                    const purchaseOrderData = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder: purchaseOrder }));
                    if (!purchaseOrderData) {
                        allItemsMatched = false;
                        allStatusReasons.push(`Item ${sup_InvoiceItem}: Purchase Order not found`);
                        continue;
                    }

                    const purchaseOrderItemData = await pos.run(SELECT.one.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder, PurchaseOrderItem: purchaseOrderItem }));
                    if (!purchaseOrderItemData) {
                        allItemsMatched = false;
                        allStatusReasons.push(`Item ${sup_InvoiceItem}: Purchase Order Item not found`);
                        continue;
                    }

                    // Fetch GR details
                    const materialDocumentData = await grs.run(
                        SELECT.one.from(A_MaterialDocumentHeader)
                            .where({ ReferenceDocument: purchaseOrder })
                    );

                    let materialItemData;
                    if (materialDocumentData) {
                        materialItemData = await grs.run(
                            SELECT.one.from(A_MaterialDocumentItem)
                                .where({
                                    MaterialDocument: materialDocumentData.MaterialDocument,
                                    MaterialDocumentYear: materialDocumentData.MaterialDocumentYear,
                                    PurchaseOrderItem: purchaseOrderItem
                                })
                        );
                    }

                    // Determine item status
                    let itemStatus = 'Matched';
                    let statusReasons = [];

                    if (quantityPOUnit !== purchaseOrderItemData.OrderQuantity) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('Quantity mismatch with PO');
                    }

                    if (supInvItemAmount !== purchaseOrderItemData.NetPriceAmount) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('Amount mismatch with PO');
                    }

                    if (!materialItemData) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('No matching Goods Receipt found');
                    } else if (quantityPOUnit !== Number(materialItemData.QuantityInBaseUnit)) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('Quantity mismatch with GR');
                    }

                    if (itemStatus !== 'Matched') {
                        allItemsMatched = false;
                        if (statusReasons.length > 0) {
                            allStatusReasons.push(`Item ${sup_InvoiceItem}: ${statusReasons.join(', ')}`);
                        }
                    }

                    // Populate result object
                    result.FiscalYear = materialItemData ? materialItemData.ReferenceDocumentFiscalYear : "";
                    result.CompanyCode = purchaseOrderData.CompanyCode;
                    result.DocumentDate = materialDocumentData ? materialDocumentData.DocumentDate : null;
                    result.PostingDate = materialDocumentData ? materialDocumentData.PostingDate : null;
                    result.SupplierInvoiceIDByInvcgParty = purchaseOrderData.SupplierInvoiceIDByInvcgParty;
                    result.DocumentCurrency = purchaseOrderData.DocumentCurrency;
                    result.to_SuplrInvcItemPurOrdRef.push({
                        SupplierInvoice: invoiceItem.supplierInvoice,
                        FiscalYear: materialItemData ? materialItemData.ReferenceDocumentFiscalYear : "",
                        SupplierInvoiceItem: itemCounter.toString(),
                        PurchaseOrder: purchaseOrder,
                        PurchaseOrderItem: purchaseOrderItem,
                        ReferenceDocument: materialItemData ? materialItemData.MaterialDocument : "",
                        ReferenceDocumentFiscalYear: materialItemData ? materialItemData.ReferenceDocumentFiscalYear : "",
                        ReferenceDocumentItem: materialItemData ? materialItemData.MaterialDocumentItem : "",
                        TaxCode: purchaseOrderItemData.TaxCode,
                        DocumentCurrency: purchaseOrderItemData.DocumentCurrency,
                        SupplierInvoiceItemAmount: supInvItemAmount,
                        PurchaseOrderQuantityUnit: purchaseOrderItemData.PurchaseOrderQuantityUnit,
                        QuantityInPurchaseOrderUnit: purchaseOrderItemData.OrderQuantity,
                    });

                    itemCounter += 10;
                }

                // Determine overall invoice status and update the database
                const overallStatus = allItemsMatched ? 'Matched' : 'Discrepancy';
                let statusWithReasons = overallStatus;
                if (overallStatus === 'Discrepancy') {
                    statusWithReasons += `: ${allStatusReasons.join('; ')}`;
                }
                await db.run(UPDATE(Invoice).set({ status: statusWithReasons }).where({ ID: ID }));

                // Set the status in the result object
                result.Status = statusWithReasons;

                // Send response
                return result;

            } catch (error) {
                console.error("Unexpected error in doThreeWayMatch:", error);
                return req.error(500, `Unexpected error: ${error.message}`);
            }
        });

        return super.init();
    }
}

module.exports = InvCatalogService;