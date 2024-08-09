const cds = require("@sap/cds");
const { SELECT, UPDATE } = cds.ql;
const SequenceHelper = require("./lib/SequenceHelper");

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
        const NEW_STATUS = 'N';
        const DRAFT_STATUS = 'D';
        const FAILURE_STATUS = 'F';

        this.before("NEW", Invoice.drafts, async (req) => {
            // console.log(req.target.name)
            if (req.target.name !== "InvCatalogService.Invoice.drafts") { return; }
            const { ID } = req.data;
            req.data.statusFlag = DRAFT_STATUS;
           
            const documentId = new SequenceHelper({
                db: db,
                sequence: "ZSUPPLIER_DOCUMENT_ID",
                table: "zsupplier_InvoiceEntity",
                field: "documentId",
            });

            let number = await documentId.getNextNumber();
            req.data.documentId = number.toString();;

        });

        this.on('doThreeWayMatch', 'Invoice', async req => {
            try {
                console.log("Three-way Verification Code Check");
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
                let itemCounter = 1;
                let allStatusReasons = [];
                let result = {
                    FiscalYear: "",
                    CompanyCode: "",
                    DocumentDate: null,
                    PostingDate: null,
                    SupplierInvoiceIDByInvcgParty: "",
                    DocumentCurrency: "",
                    InvoiceGrossAmount: invoice.invGrossAmount.toString(),
                    status: "",
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

                    // Convert quantityPOUnit from string to number
                    const quantityPOUnitNumber = Number(quantityPOUnit);

                    // Ensure supInvItemAmount and purchaseOrderItemData.NetPriceAmount are numbers
                    const supInvItemAmountNumber = Number(supInvItemAmount);
                    const netPriceAmountNumber = Number(purchaseOrderItemData.NetPriceAmount);

                    // Compare quantityPOUnit with purchaseOrderItemData.OrderQuantity
                    if (quantityPOUnitNumber !== purchaseOrderItemData.OrderQuantity) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('Quantity mismatch with PO');
                    }

                    // Compare supInvItemAmount with purchaseOrderItemData.NetPriceAmount
                    if (supInvItemAmountNumber !== netPriceAmountNumber) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('Amount mismatch with PO');
                    }

                    // Check if materialItemData exists and compare quantities
                    if (!materialItemData) {
                        itemStatus = 'Discrepancy';
                        statusReasons.push('No matching Goods Receipt found');
                    } else {
                        const materialQuantityNumber = Number(materialItemData.QuantityInBaseUnit);
                        if (quantityPOUnitNumber > materialQuantityNumber) {
                            itemStatus = 'Discrepancy';
                            statusReasons.push('Quantity mismatch with GR (Partial delivery)');
                        }
                        if (quantityPOUnitNumber < materialQuantityNumber) {
                            itemStatus = 'Discrepancy';
                            statusReasons.push('Quantity mismatch with GR (Over-delivery)');
                        }
                    }

                    if (itemStatus !== 'Matched') {
                        allItemsMatched = false;
                        if (statusReasons.length > 0) {
                            allStatusReasons.push(`Item ${purchaseOrderItem}: ${statusReasons.join(', ')}`);
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
                        SupplierInvoiceItemAmount: supInvItemAmount.toString(),
                        PurchaseOrderQuantityUnit: purchaseOrderItemData.PurchaseOrderQuantityUnit,
                        QuantityInPurchaseOrderUnit: purchaseOrderItemData.OrderQuantity.toString(),
                    });

                    itemCounter += 1;
                }

                // Determine overall invoice status and update the database
                const overallStatus = allItemsMatched ? 'Matched' : 'Discrepancy';
                let statusWithReasons = overallStatus;
                let failFlag = 'S';

                if (overallStatus === 'Discrepancy') {
                    statusWithReasons += `: ${allStatusReasons.join('; ')}`;
                }
                const overallStatusFlag = failFlag ? 'E' : 'S';
                await db.run(UPDATE(Invoice).set({ status: statusWithReasons, statusFlag: overallStatusFlag }).where({ ID: ID }));

                // Set the status in the result object
                result.status = statusWithReasons;

                // Send response
                return req.reply(result);

            } catch (error) {
                console.error("Unexpected error in doThreeWayMatch:", error);
                return req.error(500, `Unexpected error: ${error.message}`);
            }
        });

        return super.init();
    }
}

module.exports = InvCatalogService;
