using zsupplier as persistence from '../db/schema';
using {sap.common as common} from '../db/common';
using {CE_PURCHASEORDER_0001 as po} from './external/CE_PURCHASEORDER_0001';
using {API_MATERIAL_DOCUMENT_SRV as gr} from './external/API_MATERIAL_DOCUMENT_SRV';

service InvCatalogService @(requires: 'authenticated-user') {

    entity PurchaseOrder            as
        projection on po.PurchaseOrder {
            *,
            _PurchaseOrderItem : redirected to PurchaseOrderItem,
            _PurchaseOrderPartner,
            _SupplierAddress
        };

    entity PurchaseOrderItem        as
        projection on po.PurchaseOrderItem {
            *
        };

    entity Invoice                  as projection on persistence.InvoiceEntity
        actions {
            action doThreeWayMatch() returns {
                FiscalYear : String;
                CompanyCode : String;
                DocumentDate : Date;
                PostingDate : Date;
                SupplierInvoiceIDByInvcgParty : String;
                DocumentCurrency : String;
                InvoiceGrossAmount : Decimal;
                Status : String;
                to_SuplrInvcItemPurOrdRef : many {
                    SupplierInvoice : String;
                    FiscalYear : String;
                    SupplierInvoiceItem : String;
                    PurchaseOrder : String;
                    PurchaseOrderItem : String;
                    ReferenceDocument : String;
                    ReferenceDocumentFiscalYear : String;
                    ReferenceDocumentItem : String;
                    TaxCode : String;
                    DocumentCurrency : String;
                    SupplierInvoiceItemAmount : Decimal;
                    PurchaseOrderQuantityUnit : String;
                    QuantityInPurchaseOrderUnit : Decimal;
                }
            };
        };


    entity InvoiceItem              as projection on persistence.InvoiceEntity.to_InvoiceItem;

    entity A_MaterialDocumentHeader as
        projection on gr.A_MaterialDocumentHeader {
            *
        };
}
