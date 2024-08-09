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
            @(
                cds.odata.bindingparameter.name: '_it',
                Common.SideEffects             : {TargetProperties: ['_it/status']}
            )
            action doThreeWayMatch() returns {
                FiscalYear : String(4);
                CompanyCode : String(4);
                DocumentDate : Date;
                PostingDate : Date;
                SupplierInvoiceIDByInvcgParty : String(10);
                DocumentCurrency : String(3);
                InvoiceGrossAmount : String;
                status : String(200);
                comments : String(150);
                newInvoice : String(10);
                to_SuplrInvcItemPurOrdRef : many {
                    SupplierInvoice : String(10);
                    FiscalYear : String(4);
                    SupplierInvoiceItem : String(5);
                    PurchaseOrder : String(10);
                    PurchaseOrderItem : String(5);
                    ReferenceDocument : String(10);
                    ReferenceDocumentFiscalYear : String(4);
                    ReferenceDocumentItem : String(5);
                    TaxCode : String(3);
                    DocumentCurrency : String(3);
                    SupplierInvoiceItemAmount : String;
                    PurchaseOrderQuantityUnit : String(3);
                    QuantityInPurchaseOrderUnit : String;
                }
            };
        };


    entity InvoiceItem              as projection on persistence.InvoiceEntity.to_InvoiceItem;

    entity A_MaterialDocumentHeader as
        projection on gr.A_MaterialDocumentHeader {
            *
        };

    @readonly
    entity StatusValues             as projection on persistence.StatusValues;
}
