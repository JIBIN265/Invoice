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

        this.on('doThreeWayMatch', 'Invoice', async req => {
            try {
                console.log("Three way Verification Code Check");
                const { ID } = req.params[0];
                if (!ID) {
                    return req.error(400, "Invoice ID is required");
                }

                const db = await cds.connect.to("db");
                const pos = await cds.connect.to('CE_PURCHASEORDER_0001');
                const grs = await cds.connect.to('API_MATERIAL_DOCUMENT_SRV');

                const invoice = await db.run(SELECT.one.from(Invoice).where({ ID: ID }));
                if (!invoice) {
                    return req.error(404, `Invoice with ID ${ID} not found`);
                }

                const invoiceItems = await db.run(SELECT.from(InvoiceItem).where({ up__ID: ID }));
                if (!invoiceItems || invoiceItems.length === 0) {
                    return req.error(404, `No items found for Invoice ${ID}`);
                }

                let allItemsMatched = true;
                let itemCounter = 10;
                let result = {
                    FiscalYear: "",
                    CompanyCode: "",
                    DocumentDate: null,
                    PostingDate: null,
                    SupplierInvoiceIDByInvcgParty: "",
                    DocumentCurrency: "",
                    InvoiceGrossAmount: invoice.invGrossAmount,
                    Status: "",  // Status will be set here
                    to_SuplrInvcItemPurOrdRef: []
                };

                for (const invoiceItem of invoiceItems) {
                    const { purchaseOrder, purchaseOrderItem, sup_InvoiceItem, quantityPOUnit, supInvItemAmount } = invoiceItem;

                    // Fetch PO details
                    const purchaseOrderData = await pos.run(SELECT.one.from(PurchaseOrder).where({ PurchaseOrder: purchaseOrder }));
                    if (!purchaseOrderData) {
                        allItemsMatched = false;
                        continue;
                    }

                    const purchaseOrderItemData = await pos.run(SELECT.one.from(PurchaseOrderItem).where({ PurchaseOrder: purchaseOrder, PurchaseOrderItem: purchaseOrderItem }));
                    if (!purchaseOrderItemData) {
                        allItemsMatched = false;
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
                await db.run(UPDATE(Invoice).set({ status: overallStatus }).where({ ID: ID }));

                // Set the status in the result object
                result.Status = overallStatus;

                // Set the result in req.data
                req.data = result;

                return req.reply({
                    statusCode: 200,
                    body: result
                });

            } catch (error) {
                console.error("Unexpected error in doThreeWayMatch:", error);
                return req.error(500, `Unexpected error: ${error.message}`);
            }
        });

        return super.init();
    }
}

module.exports = InvCatalogService;
