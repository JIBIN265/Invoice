/* checksum : 7317ee007f9134c61fbecfd03fd75010 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service API_MATERIAL_DOCUMENT_SRV {};

@cds.external : true
@cds.persistence.skip : true
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Document Header'
entity API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentHeader {
  @sap.display.format : 'NonNegative'
  @sap.label : 'Material Document Year'
  key MaterialDocumentYear : String(4) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Material Document'
  @sap.quickinfo : 'Number of Material Document'
  key MaterialDocument : String(10) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Trans. / Event Type'
  @sap.quickinfo : 'Transaction/Event Type'
  InventoryTransactionType : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'Document Date'
  @sap.quickinfo : 'Document Date in Document'
  DocumentDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Posting Date'
  @sap.quickinfo : 'Posting Date in the Document'
  PostingDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Entry Date'
  @sap.quickinfo : 'Day On Which Accounting Document Was Entered'
  CreationDate : Date;
  @sap.label : 'Time of Entry'
  CreationTime : Time;
  @sap.display.format : 'UpperCase'
  @sap.label : 'User Name'
  CreatedByUser : String(12);
  @sap.label : 'Document Header Text'
  MaterialDocumentHeaderText : String(25);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reference'
  @sap.quickinfo : 'Reference Document Number'
  ReferenceDocument : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Print Version'
  @sap.quickinfo : 'Version for Printing GR/GI Slip'
  VersionForPrintingSlip : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Print Active'
  @sap.quickinfo : 'Print via Output Control'
  ManualPrintIsTriggered : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ext. WMS control'
  @sap.quickinfo : 'Control posting for external WMS'
  CtrlPostgForExtWhseMgmtSyst : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Goods Movement Code'
  GoodsMovementCode : String(2);
  to_MaterialDocumentItem : Composition of many API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentItem {  };
} actions {
  action Cancel(
    @odata.Type : 'Edm.DateTime'
    @sap.label : 'Posting Date'
    PostingDate : DateTime
  ) returns API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentHeader;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Document Items'
entity API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentItem {
  @sap.display.format : 'NonNegative'
  @sap.label : 'Material Document Year'
  key MaterialDocumentYear : String(4) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Material Document'
  @sap.quickinfo : 'Number of Material Document'
  key MaterialDocument : String(10) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Material Document Item'
  key MaterialDocumentItem : String(4) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Material'
  @sap.quickinfo : 'Material Number'
  Material : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Plant'
  Plant : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Storage Location'
  StorageLocation : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Batch'
  @sap.quickinfo : 'Batch Number'
  Batch : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Movement Type'
  @sap.quickinfo : 'Movement Type (Inventory Management)'
  GoodsMovementType : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Stock Type'
  @sap.quickinfo : 'Stock Type of Goods Movement (Stock Identifier)'
  InventoryStockType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Valuation Type'
  InventoryValuationType : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Special Stock Type'
  InventorySpecialStockType : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Supplier''s Account Number'
  Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Account number of customer'
  Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Order'
  @sap.quickinfo : 'Sales Order Number'
  SalesOrder : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sales Order Item'
  SalesOrderItem : String(6);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sales Order Schedule'
  SalesOrderScheduleLine : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purchase Order'
  @sap.quickinfo : 'Purchase Order Number'
  PurchaseOrder : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Purchase Order Item'
  @sap.quickinfo : 'Item Number of Purchasing Document'
  PurchaseOrderItem : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'WBS Element'
  @sap.quickinfo : 'Work Breakdown Structure Element (WBS Element)'
  WBSElement : String(24);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Manufacturing Order'
  ManufacturingOrder : String(12);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Manufacturing Order Item'
  ManufacturingOrderItem : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reference Doc. Type'
  @sap.quickinfo : 'Goods movement ref doc type'
  GoodsMovementRefDocType : String(1);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reason for Movement'
  GoodsMovementReasonCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivery'
  Delivery : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Delivery Item'
  DeliveryItem : String(6);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account Assignment Category'
  AccountAssignmentCategory : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Cost Center'
  CostCenter : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Controlling Area'
  ControllingArea : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Cost Object'
  CostObject : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'G/L Account'
  @sap.quickinfo : 'G/L Account Number'
  GLAccount : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Functional Area'
  FunctionalArea : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Profitability Segment'
  ProfitabilitySegment : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Profit Center'
  ProfitCenter : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Asset'
  @sap.quickinfo : 'Main Asset Number'
  MasterFixedAsset : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Subnumber'
  @sap.quickinfo : 'Asset Subnumber'
  FixedAsset : String(4);
  @sap.label : 'Base Unit of Measure'
  @sap.semantics : 'unit-of-measure'
  MaterialBaseUnit : String(3);
  @sap.unit : 'MaterialBaseUnit'
  @sap.label : 'Quantity'
  QuantityInBaseUnit : Decimal(13, 3);
  @sap.label : 'Unit of Entry'
  @sap.quickinfo : 'Unit of entry'
  @sap.semantics : 'unit-of-measure'
  EntryUnit : String(3);
  @sap.unit : 'EntryUnit'
  @sap.label : 'Qty in unit of entry'
  @sap.quickinfo : 'Quantity in unit of entry'
  QuantityInEntryUnit : Decimal(13, 3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code Currency'
  @sap.semantics : 'currency-code'
  CompanyCodeCurrency : String(5);
  @sap.unit : 'CompanyCodeCurrency'
  @sap.label : 'Ext. Amount in LC'
  @sap.quickinfo : 'Externally Entered Posting Amount in Local Currency'
  GdsMvtExtAmtInCoCodeCrcy : Decimal(14, 3);
  @sap.unit : 'CompanyCodeCurrency'
  @sap.label : 'Sales Value inc. VAT'
  @sap.quickinfo : 'Value at Sales Prices Including Value-Added Tax'
  SlsPrcAmtInclVATInCoCodeCrcy : Decimal(14, 3);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Fiscal Year'
  FiscalYear : String(4);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Fiscal Year & Period from Posting date'
  @sap.quickinfo : 'Period Year'
  FiscalYearPeriod : String(7);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fiscal Year Variant'
  FiscalYearVariant : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transfer Material'
  IssgOrRcvgMaterial : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transfer Batch'
  IssgOrRcvgBatch : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Rec/Iss Plant'
  @sap.quickinfo : 'Receiving/Issuing Plant'
  IssuingOrReceivingPlant : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Receiving stor. loc.'
  @sap.quickinfo : 'Receiving/issuing storage location'
  IssuingOrReceivingStorageLoc : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transfer Stock Type'
  IssuingOrReceivingStockType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transfer Special Stock Type'
  IssgOrRcvgSpclStockInd : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Val. Type Tfr Batch'
  @sap.quickinfo : 'Valuation Type of Transfer Batch'
  IssuingOrReceivingValType : String(10);
  @sap.label : 'Delivery Completed'
  @sap.quickinfo : '&quot;Delivery Completed&quot; Indicator'
  IsCompletelyDelivered : Boolean;
  @sap.label : 'Text'
  @sap.quickinfo : 'Item Text'
  MaterialDocumentItemText : String(50);
  @sap.label : 'Goods Recipient'
  GoodsRecipientName : String(12);
  @sap.label : 'Unloading Point'
  UnloadingPointName : String(25);
  @sap.display.format : 'Date'
  @sap.label : 'SLED/BBD'
  @sap.quickinfo : 'Shelf Life Expiration or Best-Before Date'
  ShelfLifeExpirationDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Date of Manufacture'
  ManufactureDate : Date;
  @sap.label : 'SerialNo. auto.'
  @sap.quickinfo : 'Create serial number automatically'
  SerialNumbersAreCreatedAutomly : Boolean;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reservation'
  @sap.quickinfo : 'Number of reservation/dependent requirements'
  Reservation : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reservation Item'
  @sap.quickinfo : 'Item Number of Reservation / Dependent Requirements'
  ReservationItem : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reservation Record Type'
  ReservationItemRecordType : String(1);
  @sap.label : 'Res Final Issue'
  @sap.quickinfo : 'Final Issue for Reservation'
  ReservationIsFinallyIssued : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales order'
  @sap.quickinfo : 'Sales order number of valuated sales order stock'
  SpecialStockIdfgSalesOrder : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sales order item'
  @sap.quickinfo : 'Sales Order Item of Valuated Sales Order Stock'
  SpecialStockIdfgSalesOrderItem : String(6);
  @sap.display.format : 'UpperCase'
  @sap.label : 'WBS Element'
  @sap.quickinfo : 'Work Breakdown Structure Element (WBS Element)'
  SpecialStockIdfgWBSElement : String(24);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Automat. Created'
  @sap.quickinfo : 'Item Automatically Created Indicator'
  IsAutomaticallyCreated : String(1);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Line ID'
  @sap.quickinfo : 'Unique Identification of Document Line'
  MaterialDocumentLine : String(6);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Parent line ID'
  @sap.quickinfo : 'Identifier of immediately superior line'
  MaterialDocumentParentLine : String(6);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Hierarchy level'
  @sap.quickinfo : 'Hierarchy level of line in document'
  HierarchyNodeLevel : String(2);
  @sap.label : 'Is Item Cancelled'
  @sap.quickinfo : 'Item has been Cancelled'
  GoodsMovementIsCancelled : Boolean;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reversed Doc Year'
  @sap.quickinfo : 'Reversed Material Document Year'
  ReversedMaterialDocumentYear : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reversed Mat Doc'
  @sap.quickinfo : 'Reversed Material Document'
  ReversedMaterialDocument : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reversed Doc Item'
  @sap.quickinfo : 'Reversed Material Document Item'
  ReversedMaterialDocumentItem : String(4);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Fisc.yr.ref.doc'
  @sap.quickinfo : 'Fiscal Year of a Reference Document'
  ReferenceDocumentFiscalYear : String(4);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Reference Doc. Item'
  @sap.quickinfo : 'Item of a Reference Document'
  InvtryMgmtRefDocumentItem : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reference Document'
  @sap.quickinfo : 'Document No. of a Reference Document'
  InvtryMgmtReferenceDocument : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Type of posting'
  @sap.quickinfo : 'Reversal, return delivery, or transfer posting'
  MaterialDocumentPostingType : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Posting Control Stock Type'
  InventoryUsabilityCode : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Warehouse Number'
  @sap.quickinfo : 'Warehouse Number/Warehouse Complex'
  EWMWarehouse : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Storage Bin'
  EWMStorageBin : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Debit/Credit Ind.'
  @sap.quickinfo : 'Debit/Credit Indicator'
  DebitCreditCode : String(1);
  to_MaterialDocumentHeader : Association to API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentHeader {  };
  to_SerialNumbers : Association to many API_MATERIAL_DOCUMENT_SRV.A_SerialNumberMaterialDocument {  };
} actions {
  action CancelItem(
    @odata.Type : 'Edm.DateTime'
    @sap.label : 'Posting Date'
    PostingDate : DateTime
  ) returns API_MATERIAL_DOCUMENT_SRV.A_MaterialDocumentItem;
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Serial Numbers'
entity API_MATERIAL_DOCUMENT_SRV.A_SerialNumberMaterialDocument {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Material'
  @sap.quickinfo : 'Material Number'
  key Material : String(40) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Serial Number'
  key SerialNumber : String(18) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Material Document'
  @sap.quickinfo : 'Number of Material Document'
  key MaterialDocument : String(10) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Material Document Item'
  key MaterialDocumentItem : String(4) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Material Document Year'
  key MaterialDocumentYear : String(4) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Manuf. Serial Number'
  @sap.quickinfo : 'Manufacturer''s Serial Number'
  ManufacturerSerialNumber : String(30);
};

