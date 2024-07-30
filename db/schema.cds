namespace zsupplier;

using {
  Country,
  sap.common.CodeList as CodeList,
  cuid,
  Language,
  managed,
  Currency,
} from '@sap/cds/common';
using {
  sap.common.Region,
  sap.common.UnitOfMeasure,
  sap.common.Criticality
} from '../db/common.cds';

//using {CE_PURCHASEORDER_0001 as external} from '../srv/external/CE_PURCHASEORDER_0001';

// entity PurchaseOrder as
//   projection on external.PurchaseOrder {
//     key PurchaseOrder,
//         CompanyCode
//   };

entity InvoiceEntity : cuid, managed, {
  @description: 'Product Group Association'
  fiscalYear       : String(4);
  companyCode      : String(4);
  documentDate     : Date;
  postingDate      : Date;
  supInvParty      : String(10);
  documentCurrency : String(3);
  invGrossAmount   : Decimal(13, 3);
  status           : String(35); 
  comments         : String(150);
  newInvoice       : String(10);
  to_InvoiceItem   : Composition of many InvoiceItemEntity;
};

aspect InvoiceItemEntity : cuid, managed {

  @description: 'Product Restriction ID'
  supplierInvoice   : String(10);
  fiscalYear        : String(4);
  sup_InvoiceItem   : String(5);
  purchaseOrder     : String(10);
  purchaseOrderItem : String(5);
  referenceDocument : String(10);
  refDocFiscalYear  : String(4);
  refDocItem        : String(5);
  taxCode           : String(3);
  documentCurrency  : String(3);
  supInvItemAmount  : Decimal(13, 3);
  poQuantityUnit    : String(3);
  quantityPOUnit    : Decimal(13, 3);
}
