using zsupplier as persistence from '../db/schema';
using {sap.common as common} from '../db/common';
using {CE_PURCHASEORDER_0001 as external} from './external/CE_PURCHASEORDER_0001';

service InvCatalogService @(requires: 'authenticated-user') {

    entity PurchaseOrder as
       projection on external.PurchaseOrder {
           key PurchaseOrder,
               CompanyCode
        };
    //entity PurchaseOrder as projection on persistence.PurchaseOrder;

    entity Invoice       as projection on persistence.InvoiceEntity
        actions {
            action doThreeWayMatch();
        };

    entity InvoiceItem   as projection on persistence.InvoiceEntity.to_InvoiceItem;
}
