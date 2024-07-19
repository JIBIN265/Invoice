using zsupplier as persistence from '../db/schema';
using {sap.common as common} from '../db/common';

service InvCatalogService @(requires: 'authenticated-user') {

    
    entity Invoice            as projection on persistence.InvoiceEntity;

    entity InvoiceItem as projection on persistence.InvoiceEntity.to_InvoiceItem;


}
