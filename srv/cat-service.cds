using zsupplier as persistence from '../db/schema';
using {sap.common as common} from '../db/common';
using {CE_PURCHASEORDER_0001 as external} from './external/CE_PURCHASEORDER_0001';

service InvCatalogService @(requires: 'authenticated-user') {

    entity PurchaseOrder     as
        projection on external.PurchaseOrder {
            *,
            _PurchaseOrderItem : redirected to PurchaseOrderItem,
            _PurchaseOrderPartner,
            _SupplierAddress
        };

    entity PurchaseOrderItem as projection on external.PurchaseOrderItem{
            *
        };
    entity Invoice           as projection on persistence.InvoiceEntity;
    entity InvoiceItem       as projection on persistence.InvoiceEntity.to_InvoiceItem;


}
