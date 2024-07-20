/* checksum : bea5ef4a272be42c40cb4d05f2255b6c */
@cds.external: true
type CE_PURCHASEORDER_0001.SAP__Message {
  code              :      LargeString not null;
  message           :      LargeString not null;
  target            :      LargeString;
  additionalTargets : many LargeString not null;
  transition        :      Boolean not null;

  @odata.Type: 'Edm.Byte'
  numericSeverity   :      Integer not null;
  longtextUrl       :      LargeString;
};

@cds.external                                       : true
@CodeList.CurrencyCodes                             : {
  Url           : '../../../../default/iwbep/common/0001/$metadata',
  CollectionPath: 'Currencies'
}
@CodeList.UnitsOfMeasure                            : {
  Url           : '../../../../default/iwbep/common/0001/$metadata',
  CollectionPath: 'UnitsOfMeasure'
}
@Aggregation.ApplySupported                         : {
  Transformations: [
    'aggregate',
    'groupby',
    'filter'
  ],
  Rollup         : #None
}
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering: true
@Capabilities.FilterFunctions                       : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@Capabilities.SupportedFormats                      : [
  'application/json',
  'application/pdf'
]
@PDF.Features                                       : {
  DocumentDescriptionReference : '../../../../default/iwbep/common/0001/$metadata',
  DocumentDescriptionCollection: 'MyDocumentDescriptions',
  ArchiveFormat                : true,
  Border                       : true,
  CoverPage                    : true,
  FitToPage                    : true,
  FontName                     : true,
  FontSize                     : true,
  Margin                       : true,
  Padding                      : true,
  Signature                    : true,
  HeaderFooter                 : true,
  ResultSizeDefault            : 20000,
  ResultSizeMaximum            : 20000,
  IANATimezoneFormat           : true,
  Treeview                     : true
}
@Capabilities.KeyAsSegmentSupported                 : true
@Capabilities.AsynchronousRequestsSupported         : true
@Authorization.SecuritySchemes                      : [
  {
    Authorization : 'OAuth2Auth',
    RequiredScopes: ['OV4:API_PURCHASEORDER_2']
  },
  {Authorization: 'BasicAuth'}
]
@Authorization.Authorizations                       : [
  {
    $Type           : 'Auth.OAuth2AuthCode',
    Name            : 'OAuth2Auth',
    RefreshUrl      : 'https://{host}:{port}',
    AuthorizationUrl: 'https://{host}:{port}',
    TokenUrl        : 'https://{host}:{port}',
    Scopes          : [{Scope: 'OV4:API_PURCHASEORDER_2'}]
  },
  {
    $Type : 'Auth.Http',
    Name  : 'BasicAuth',
    Scheme: 'basic'
  }
]
service CE_PURCHASEORDER_0001 {};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Subcontracting Components'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem',
  '_ScheduleLine'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
  {
    Property          : RequiredQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : QuantityInEntryUnit,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : VariableSizeItemQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : VariableSizeComponentQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Size1,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Size2,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Size3,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : WithdrawnQuantity,
    AllowedExpressions: 'MultiValue'
  }
]
entity CE_PURCHASEORDER_0001.POSubcontractingComponent {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
  key PurchaseOrder                  :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchasing Document Item'
  key PurchaseOrderItem              :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Schedule Line'
      @Common.Heading        : 'Schd.'
      @Common.QuickInfo      : 'Delivery Schedule Line Counter'
  key ScheduleLine                   :      String(4) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Reservation Item'
  key ReservationItem                :      String(4) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Reservation Record Type'
  key RecordType                     :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material'
      @Common.QuickInfo      : 'Material Number'
      Material                       :      String(18) not null;

      @Common.Label          : 'Mat. Provision Ind.'
      @Common.Heading        : 'MP Ind.'
      @Common.QuickInfo      : 'Material Provision Indicator'
      IsMaterialProvision            :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Provision Type'
      MaterialProvisionType          :      String(1) not null;

      @Common.Label          : 'Numerator'
      @Common.Heading        : 'Numer.'
      @Common.QuickInfo      : 'Numerator for Conversion to Base Units of Measure'
      MaterialQtyToBaseQtyNmrtr      :      Decimal (precision : 5) not null;

      @Common.Label          : 'Denominator'
      @Common.Heading        : 'Denom.'
      @Common.QuickInfo      : 'Denominator for conversion to base units of measure'
      MaterialQtyToBaseQtyDnmntr     :      Decimal (precision : 5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Revision Level'
      MaterialRevisionLevel          :      String(2) not null;

      @Common.Label          : 'Variable-Sized Item'
      @Common.QuickInfo      : 'Variable-Sized Item Indicator'
      MaterialCompIsVariableSized    :      Boolean not null;

      @Common.Label          : 'Phantom Item'
      @Common.QuickInfo      : 'Phantom Item Indicator'
      MaterialComponentIsPhantomItem :      Boolean not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Reservation'
      @Common.Heading        : 'Reserv.no.'
      @Common.QuickInfo      : 'Number of reservation/dependent requirements'
      Reservation                    :      String(10) not null;

      @Core.Computed         : true
      @Measures.Unit         : BaseUnit
      @Common.Label          : 'Requirement Quantity'
      @Common.Heading        : 'Reqmnt qty'
      RequiredQuantity               :      Decimal(13, 3) not null;

      @Common.Label          : 'Requirement Date'
      @Common.QuickInfo      : 'Material Component Requirement Date'
      RequirementDate                :      Date;

      @Common.Label          : 'Requirement Time'
      @Common.QuickInfo      : 'Material Component Requirement Time'
      RequirementTime                :      Time not null;

      @Common.Label          : 'Final Issue'
      @Common.Heading        : 'FIs'
      @Common.QuickInfo      : 'Final Issue for Reservation'
      ReservationIsFinallyIssued     :      Boolean not null;

      @Common.IsUnit         : true
      @Core.Immutable        : true
      @Common.Label          : 'Base Unit of Measure'
      @Common.Heading        : 'BUn'
      BaseUnit                       :      String(3) not null;

      @Measures.Unit         : EntryUnit
      @Common.Label          : 'Quantity in Unit of Entry'
      QuantityInEntryUnit            :      Decimal(13, 3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Unit of Entry'
      @Common.Heading        : 'EUn'
      @Common.QuickInfo      : 'Unit of entry'
      EntryUnit                      :      String(3) not null;

      @Measures.Unit         : VariableSizeItemUnit
      @Common.Label          : 'Number of Variable-Size Components'
      VariableSizeItemQuantity       :      Decimal(13, 3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Variable-Size Item Unit'
      @Common.QuickInfo      : 'Variable-Size Item Unit of Measure'
      VariableSizeItemUnit           :      String(3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Variable-Size Component Unit'
      @Common.QuickInfo      : 'Unit of Measure for Variable-Size Components'
      VariableSizeComponentUnit      :      String(3) not null;

      @Measures.Unit         : VariableSizeComponentUnit
      @Common.Label          : 'VSI Quantity'
      @Common.QuickInfo      : 'Variable-Size Item Quantity per PC'
      VariableSizeComponentQuantity  :      Decimal(13, 3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Size unit'
      @Common.Heading        : 'SzUn'
      @Common.QuickInfo      : 'Unit of measure for sizes 1 to 3'
      UnitOfMeasureForSize1To3       :      String(3) not null;

      @Measures.Unit         : UnitOfMeasureForSize1To3
      @Common.Label          : 'Size 1'
      Size1                          :      Decimal(13, 3) not null;

      @Measures.Unit         : UnitOfMeasureForSize1To3
      @Common.Label          : 'Size 2'
      Size2                          :      Decimal(13, 3) not null;

      @Measures.Unit         : UnitOfMeasureForSize1To3
      @Common.Label          : 'Size 3'
      Size3                          :      Decimal(13, 3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Plant'
      @Common.Heading        : 'Plnt'
      Plant                          :      String(4) not null;

      @Common.Label          : 'Latest Requirement Date'
      LatestRequirementDate          :      Date;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Order level'
      @Common.Heading        : 'OLvl'
      OrderLevelValue                :      String(2) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Order path'
      @Common.Heading        : 'Path'
      OrderPathValue                 :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Bill Of Material Item Number'
      BillOfMaterialItemNumber       :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Sort String'
      @Common.Heading        : 'SortStrng'
      MatlCompFreeDefinedAttribute   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'BOM Item Category'
      @Common.QuickInfo      : 'Bill of Material Item Category'
      BOMItemCategory                :      String(1) not null;

      @Common.Label          : 'Bulk Material'
      @Common.Heading        : 'Bulk'
      @Common.QuickInfo      : 'Indicator: Bulk Material'
      IsBulkMaterialComponent        :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Account Assignment Category'
      AccountAssignmentCategory      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Special Stock Type'
      @Common.Heading        : 'Sp. Stock'
      @Common.QuickInfo      : 'Inventory Special Stock Type'
      InventorySpecialStockType      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Consumption Posting'
      ConsumptionPosting             :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Special Stock Valuation Type'
      @Common.QuickInfo      : 'Inventory Special Stock Valuation Type'
      InventorySpecialStockValnType  :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Debit Credit Code'
      @Common.QuickInfo      : 'Debit/Credit Code'
      DebitCreditCode                :      String(1) not null;

      @Core.Computed         : true
      @Measures.Unit         : BaseUnit
      @Common.Label          : 'Withdrawn Quantity'
      WithdrawnQuantity              :      Decimal(13, 3) not null;

      @Common.Label          : 'Quantity is fixed'
      @Common.Heading        : 'Fix'
      QuantityIsFixed                :      Boolean not null;

      @Common.Label          : 'Component Scrap (%)'
      @Common.Heading        : 'C.scrap'
      @Common.QuickInfo      : 'Component Scrap in Percent'
      ComponentScrapInPercent        :      Decimal(5, 2) not null;

      @Common.Label          : 'Operation Scrap in %'
      @Common.Heading        : 'OpScrap'
      @Common.QuickInfo      : 'Operation Scrap'
      OperationScrapInPercent        :      Decimal(5, 2) not null;

      @Common.Label          : 'Net Scrap Indicator'
      @Common.Heading        : 'Net ID'
      IsNetScrap                     :      Boolean not null;

      @Common.Label          : 'Lead-Time Offset'
      LeadTimeOffset                 :      Decimal (precision : 3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Distribution Key'
      @Common.Heading        : 'DKey'
      @Common.QuickInfo      : 'MRP Distribution Key'
      QuantityDistributionKey        :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'VSI Formula'
      @Common.Heading        : 'Formula'
      @Common.QuickInfo      : 'Formula Key for Variable-Size Items'
      FormulaKey                     :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Storage Location'
      StorageLocation                :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Production Supply Area'
      ProductionSupplyArea           :      String(10) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Batch'
      @Common.QuickInfo      : 'Batch Number'
      Batch                          :      String(10) not null;

      @Core.Computed         : true
      @Common.Label          : 'Item Text'
      @Common.Heading        : 'Item Text Line 1'
      @Common.QuickInfo      : 'BOM Item Text (Line 1)'
      BOMItemDescription             :      String(40) not null;

      @Common.Label          : 'Item Text 2'
      @Common.Heading        : 'Item Text Line 2'
      @Common.QuickInfo      : 'BOM Item Text (Line 2)'
      BOMItemText2                   :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Change Number'
      @Common.Heading        : 'Change No.'
      ChangeNumber                   :      String(12) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                 :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                              on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem {};

      @cds.ambiguous         : 'missing on condition?'
      _ScheduleLine                  :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderScheduleLine
                                              on _ScheduleLine.ScheduleLine = ScheduleLine;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Purchase Order'
@Common.SemanticKey                                              : ['PurchaseOrder']
@Common.Messages                                                 : SAP__Messages
@Capabilities.NavigationRestrictions.RestrictedProperties        : [
  {
    NavigationProperty: _PurchaseOrderItem,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurchaseOrderNote,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _SupplierAddress,
    InsertRestrictions: {Insertable: true}
  }
]
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrderItem',
  '_PurchaseOrderNote',
  '_PurchaseOrderPartner',
  '_SupplierAddress'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : DownPaymentAmount,
  AllowedExpressions: 'MultiValue'
}]
entity CE_PURCHASEORDER_0001.PurchaseOrder {
      @Core.Immutable                   : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Purchase Order'
      @Common.Heading                   : 'Purchase Order Number'
      @Common.QuickInfo                 : 'Purchase Order Number'
  key PurchaseOrder                  :      String(10) not null;

      @Common.FieldControl              : #Mandatory
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Purchasing Doc. Type'
      @Common.Heading                   : 'Type'
      @Common.QuickInfo                 : 'Purchasing Document Type'
      PurchaseOrderType              :      String(4) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Control indicator'
      @Common.Heading                   : 'Ctl'
      @Common.QuickInfo                 : 'Control indicator for purchasing document type'
      PurchaseOrderSubtype           :      String(1) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Status'
      @Common.Heading                   : 'S'
      @Common.QuickInfo                 : 'Status of Purchasing Document'
      PurchasingDocumentOrigin       :      String(1) not null;

      @Common.SAPObjectNodeTypeReference: 'PurchasingDocumentProcessCode'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Process Indicator'
      @Common.QuickInfo                 : 'Process Indicator for Purchase Order'
      PurchasingDocumentProcessCode  :      String(3) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Created By'
      @Common.QuickInfo                 : 'User of person who created a purchasing document'
      CreatedByUser                  :      String(12) not null;

      @Core.Computed                    : true
      @Common.Label                     : 'Created On'
      @Common.Heading                   : 'Created'
      @Common.QuickInfo                 : 'Creation Date of Purchasing Document'
      CreationDate                   :      Date;

      @Common.Label                     : 'Purchase Order Date'
      @Common.Heading                   : 'PO Date'
      PurchaseOrderDate              :      Date;

      @odata.Precision                  : 7
      @odata.Type                       : 'Edm.DateTimeOffset'
      @Core.Computed                    : true
      @Common.Label                     : 'Last Changed'
      @Common.QuickInfo                 : 'Change Time Stamp'
      LastChangeDateTime             :      Timestamp;

      @Common.Label                     : 'Validity Per. Start'
      @Common.Heading                   : 'VP Start'
      @Common.QuickInfo                 : 'Start of Validity Period'
      ValidityStartDate              :      Date;

      @Common.Label                     : 'Validity Period End'
      @Common.Heading                   : 'VPer.End'
      @Common.QuickInfo                 : 'End of Validity Period'
      ValidityEndDate                :      Date;

      @Common.Label                     : 'Language Key'
      @Common.Heading                   : 'Language'
      Language                       :      String(2) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Deletion Code'
      @Common.Heading                   : 'Purchase Order Deletion Code'
      @Common.QuickInfo                 : 'Purchase Order Deletion Code'
      PurchaseOrderDeletionCode      :      String(1) not null;

      @Core.Computed                    : true
      @Common.Label                     : 'Subject to Release'
      @Common.Heading                   : 'R'
      @Common.QuickInfo                 : 'Release Not Yet Completely Effected'
      ReleaseIsNotCompleted          :      Boolean not null;

      @Common.Label                     : 'Incomplete'
      @Common.Heading                   : 'I'
      @Common.QuickInfo                 : 'Purchase order not yet complete'
      PurchasingCompletenessStatus   :      Boolean not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Proc. State'
      @Common.Heading                   : 'Purchasing Doc. Processing State'
      @Common.QuickInfo                 : 'Purchasing Document Processing State'
      PurchasingProcessingStatus     :      String(2) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Release Status'
      @Common.Heading                   : 'Release'
      PurgReleaseSequenceStatus      :      String(8) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Release indicator'
      @Common.Heading                   : 'Rel'
      @Common.QuickInfo                 : 'Release Indicator: Purchasing Document'
      ReleaseCode                    :      String(1) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Release Strategy'
      @Common.Heading                   : 'Strat'
      PurchasingReleaseStrategy      :      String(2) not null;

      @Common.IsDigitSequence           : true
      @Common.Label                     : 'Reason for Canc.'
      @Common.Heading                   : 'Reas. Canc.'
      @Common.QuickInfo                 : 'Reason for Cancellation'
      PurgReasonForDocCancellation   :      String(2) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Company Code'
      @Common.Heading                   : 'CoCd'
      CompanyCode                    :      String(4) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Purch. Organization'
      @Common.Heading                   : 'POrg'
      @Common.QuickInfo                 : 'Purchasing Organization'
      PurchasingOrganization         :      String(4) not null;

      @Common.SAPObjectNodeTypeReference: 'PurchasingGroup'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Purchasing Group'
      @Common.Heading                   : 'PGr'
      PurchasingGroup                :      String(3) not null;

      @Common.FieldControl              : #Mandatory
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Supplier'
      Supplier                       :      String(10) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Address Number'
      @Common.Heading                   : 'Addr. No.'
      ManualSupplierAddressID        :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Address Number'
      @Common.Heading                   : 'Addr. No.'
      SupplierAddressID              :      String(10) not null;

      @Common.Label                     : 'Salesperson'
      @Common.QuickInfo                 : 'Responsible Salesperson at Supplier''s Office'
      SupplierRespSalesPersonName    :      String(30) not null;

      @Common.Label                     : 'Supplier Phone'
      @Common.QuickInfo                 : 'Supplier''s Phone Number'
      SupplierPhoneNumber            :      String(16) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Goods Supplier'
      @Common.Heading                   : 'Goods Supp'
      SupplyingSupplier              :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Supplying Plant'
      @Common.Heading                   : 'SPlt'
      @Common.QuickInfo                 : 'Supplying (issuing) plant in case of stock transport order'
      SupplyingPlant                 :      String(4) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Invoicing Party'
      @Common.Heading                   : 'Inv. Pty'
      @Common.QuickInfo                 : 'Different Invoicing Party'
      InvoicingParty                 :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Customer'
      @Common.QuickInfo                 : 'Customer Number'
      Customer                       :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Outline agreement'
      @Common.Heading                   : 'Agmt.'
      @Common.QuickInfo                 : 'Number of principal purchase agreement'
      PurchaseContract               :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Quotation'
      @Common.QuickInfo                 : 'Quotation Number'
      SupplierQuotationExternalID    :      String(10) not null;

      @Common.Label                     : 'Quotation Date'
      @Common.Heading                   : 'Quot. Date'
      @Common.QuickInfo                 : 'Quotation Submission Date'
      QuotationSubmissionDate        :      Date;

      @Common.IsDigitSequence           : true
      @Common.Label                     : 'Subitem Interval'
      @Common.Heading                   : 'SIInt'
      @Common.QuickInfo                 : 'Item Number Interval for Subitems'
      ItemNumberIntervalForSubItems  :      String(5) not null;

      @Common.SAPObjectNodeTypeReference: 'PaymentTerms'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Payment Terms'
      @Common.Heading                   : 'PayT'
      @Common.QuickInfo                 : 'Terms of Payment Key'
      PaymentTerms                   :      String(4) not null;

      @Common.Label                     : 'Days 1'
      @Common.Heading                   : 'Day1'
      @Common.QuickInfo                 : 'Cash Discount Days 1'
      CashDiscount1Days              :      Decimal (precision : 3) not null;

      @Common.Label                     : 'Days 2'
      @Common.Heading                   : 'Day2'
      @Common.QuickInfo                 : 'Cash Discount Days 2'
      CashDiscount2Days              :      Decimal (precision : 3) not null;

      @Common.Label                     : 'Days Net'
      @Common.Heading                   : 'Net'
      @Common.QuickInfo                 : 'Net Payment Terms Period'
      NetPaymentDays                 :      Decimal (precision : 3) not null;

      @Common.Label                     : 'CD Percentage 1'
      @Common.Heading                   : 'CD P.1'
      @Common.QuickInfo                 : 'Cash Discount Percentage 1'
      CashDiscount1Percent           :      Decimal(5, 3) not null;

      @Common.Label                     : 'CD Percentage 2'
      @Common.Heading                   : 'CD P.2'
      @Common.QuickInfo                 : 'Cash Discount Percentage 2'
      CashDiscount2Percent           :      Decimal(5, 3) not null;

      @Common.SAPObjectNodeTypeReference: 'DownPaymentType'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Down Payment'
      @Common.QuickInfo                 : 'Down Payment Indicator'
      DownPaymentType                :      String(4) not null;

      @Common.Label                     : 'Down Payment %'
      @Common.Heading                   : 'Down Payt Percentage'
      @Common.QuickInfo                 : 'Down Payment Percentage'
      DownPaymentPercentageOfTotAmt  :      Decimal(5, 2) not null;

      @Measures.ISOCurrency             : DocumentCurrency
      @Common.Label                     : 'Down Payment Amount'
      @Common.QuickInfo                 : 'Down Payment Amount in Document Currency'
      DownPaymentAmount              :      Decimal (precision : 11) not null;

      @Common.Label                     : 'Due Date for DP'
      @Common.Heading                   : 'Due Date for Down Payment'
      @Common.QuickInfo                 : 'Due Date for Down Payment'
      DownPaymentDueDate             :      Date;

      @Common.SAPObjectNodeTypeReference: 'IncotermsClassification'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Incoterms'
      @Common.Heading                   : 'IncoT'
      @Common.QuickInfo                 : 'Incoterms (Part 1)'
      IncotermsClassification        :      String(3) not null;

      @Common.Label                     : 'Incoterms (Part 2)'
      @Common.Heading                   : 'Inco. 2'
      IncotermsTransferLocation      :      String(28) not null;

      @Common.SAPObjectNodeTypeReference: 'IncotermsVersion'
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Incoterms Version'
      @Common.Heading                   : 'IncoV'
      IncotermsVersion               :      String(4) not null;

      @Common.Label                     : 'Incoterms Location 1'
      IncotermsLocation1             :      String(70) not null;

      @Common.Label                     : 'Incoterms Location 2'
      IncotermsLocation2             :      String(70) not null;

      @Common.Label                     : 'Intrastat Relevance'
      @Common.Heading                   : 'relevant for Intrastat'
      @Common.QuickInfo                 : 'Relevant for Intrastat Reporting'
      IsIntrastatReportingRelevant   :      Boolean not null;

      @Common.Label                     : 'Intrastat Exclusion'
      @Common.Heading                   : 'exclude from Intrastat'
      @Common.QuickInfo                 : 'Exclude from Intrastat Reporting'
      IsIntrastatReportingExcluded   :      Boolean not null;

      @Common.Label                     : 'Your Reference'
      @Common.Heading                   : 'Your Ref.'
      CorrespncExternalReference     :      String(12) not null;

      @Common.Label                     : 'Our Reference'
      CorrespncInternalReference     :      String(12) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Doc. Condition No.'
      @Common.Heading                   : 'Doc.Cond.'
      @Common.QuickInfo                 : 'Number of the Document Condition'
      PricingDocument                :      String(10) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Procedure'
      @Common.Heading                   : 'Proc.'
      @Common.QuickInfo                 : 'Procedure (Pricing, Output Control, Acct. Det., Costing,...)'
      PricingProcedure               :      String(6) not null;

      @Common.SAPObjectNodeTypeReference: 'Currency'
      @Common.IsCurrency                : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Currency'
      @Common.Heading                   : 'Crcy'
      @Common.QuickInfo                 : 'Currency Key'
      DocumentCurrency               :      String(3) not null;

      @Common.Label                     : 'Exchange Rate'
      ExchangeRate                   :      Decimal(9, 5) not null;

      @Common.Label                     : 'Fixed Exchange Rate'
      @Common.Heading                   : 'Fix'
      @Common.QuickInfo                 : 'Indicator for Fixed Exchange Rate'
      ExchangeRateIsFixed            :      Boolean not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Reporting C/R'
      @Common.Heading                   : 'TR'
      @Common.QuickInfo                 : 'Country/Region for Tax Report'
      TaxReturnCountry               :      String(3) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Ctry/Rgn Sls Tax No.'
      @Common.Heading                   : 'STC'
      @Common.QuickInfo                 : 'Country/Region of Sales Tax ID Number'
      VATRegistrationCountry         :      String(3) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Supplier Check Sts'
      @Common.Heading                   : 'Supplier Ck Sts'
      @Common.QuickInfo                 : 'Product Compliance Supplier Check Status (All Items)'
      PurgAggrgdProdCmplncSuplrSts   :      String(1) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Prod. Marktablty Sts'
      @Common.Heading                   : 'ProdMarktabltyS'
      @Common.QuickInfo                 : 'Product Marketability Status (All Items)'
      PurgAggrgdProdMarketabilitySts :      String(1) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Sfty Data Sheet Sts'
      @Common.Heading                   : 'SftyDataSheetS'
      @Common.QuickInfo                 : 'Safety Data Sheet Status (All Items)'
      PurgAggrgdSftyDataSheetStatus  :      String(1) not null;

      @Core.Computed                    : true
      @Common.IsUpperCase               : true
      @Common.Label                     : 'Dangerous Goods Sts'
      @Common.Heading                   : 'Dngrs Goods Sts'
      @Common.QuickInfo                 : 'Dangerous Goods Status (All Items)'
      PurgProdCmplncTotDngrsGoodsSts :      String(1) not null;

      @Common.IsUpperCase               : true
      @Common.Label                     : 'Collective Number'
      @Common.Heading                   : 'Coll. No.'
      PurchasingCollectiveNumber     :      String(10) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous                    : 'missing on condition?'
      @Common.Composition               : true
      _PurchaseOrderItem             :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderItem
                                              on _PurchaseOrderItem.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous                    : 'missing on condition?'
      @Common.Composition               : true
      _PurchaseOrderNote             :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderNote
                                              on _PurchaseOrderNote.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous                    : 'missing on condition?'
      @Common.Composition               : true
      _PurchaseOrderPartner          :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderPartner
                                              on _PurchaseOrderPartner.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous                    : 'missing on condition?'
      @Common.Composition               : true
      _SupplierAddress               :      Composition of one CE_PURCHASEORDER_0001.PurchaseOrderSupplierAddress
                                              on _SupplierAddress.PurchaseOrder = PurchaseOrder;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Account Assignment'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
  {
    Property          : Quantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : PurgDocNetAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : NonDeductibleInputTaxAmount,
    AllowedExpressions: 'MultiValue'
  }
]
entity CE_PURCHASEORDER_0001.PurchaseOrderAccountAssignment {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
      @Common.Heading        : 'Pur. Doc.'
      @Common.QuickInfo      : 'Purchasing Document Number'
  key PurchaseOrder                  :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchasing Document'
  key PurchaseOrderItem              :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Account Assgmt No.'
      @Common.Heading        : 'SAA'
      @Common.QuickInfo      : 'Sequential Number of Account Assignment'
  key AccountAssignmentNumber        :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Cost Center'
      @Common.Heading        : 'Cost Ctr'
      CostCenter                     :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Asset'
      @Common.QuickInfo      : 'Main Asset Number'
      MasterFixedAsset               :      String(12) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Network'
      @Common.QuickInfo      : 'Network Number for Account Assignment'
      ProjectNetwork                 :      String(12) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Oper./Act.'
      @Common.Heading        : 'Operation/Activity Number'
      @Common.QuickInfo      : 'Operation/Activity Number'
      NetworkActivity                :      String(4) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Order Unit'
      @Common.Heading        : 'OUn'
      @Common.QuickInfo      : 'Purchase Order Unit of Measure'
      OrderQuantityUnit              :      String(3) not null;

      @Measures.Unit         : OrderQuantityUnit
      @Common.Label          : 'Quantity'
      Quantity                       :      Decimal(13, 3) not null;

      @Common.Label          : 'Distribution (%)'
      @Common.Heading        : 'Percent'
      @Common.QuickInfo      : 'Distribution percentage in the case of multiple acct assgt'
      MultipleAcctAssgmtDistrPercent :      Decimal(3, 1) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'Currency Key'
      DocumentCurrency               :      String(3) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Net Order Value'
      @Common.Heading        : 'Net Value'
      @Common.QuickInfo      : 'Net Order Value in PO Currency'
      PurgDocNetAmount               :      Decimal (precision : 13) not null;

      @Core.Computed         : true
      @Common.Label          : 'Deletion Indicator'
      @Common.Heading        : 'D'
      @Common.QuickInfo      : 'Deletion Indicator: Purchasing Document Account Assignment'
      IsDeleted                      :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'G/L Account'
      @Common.Heading        : 'G/L Acct'
      @Common.QuickInfo      : 'G/L Account Number'
      GLAccount                      :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Business Area'
      @Common.Heading        : 'BusA'
      BusinessArea                   :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'SD Document'
      @Common.Heading        : 'Document'
      @Common.QuickInfo      : 'Sales and Distribution Document Number'
      SalesOrder                     :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Sales Document Item'
      SalesOrderItem                 :      String(6) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Schedule Line Number'
      @Common.Heading        : 'SLNo'
      SalesOrderScheduleLine         :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Subnumber'
      @Common.Heading        : 'SNo.'
      @Common.QuickInfo      : 'Asset Subnumber'
      FixedAsset                     :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Order'
      @Common.QuickInfo      : 'Order Number'
      OrderID                        :      String(12) not null;

      @Common.Label          : 'Unloading Point'
      UnloadingPointName             :      String(25) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Controlling Area'
      @Common.Heading        : 'COAr'
      ControllingArea                :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Cost Object'
      @Common.Heading        : 'CostObject'
      CostObject                     :      String(12) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Profit Center'
      @Common.Heading        : 'Profit Ctr'
      ProfitCenter                   :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'WBS Internal ID'
      @Common.Heading        : 'WBS Elem'
      @Common.QuickInfo      : 'WBS Element'
      WBSElementInternalID           :      String(8) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'WBS Element'
      @Common.QuickInfo      : 'Work Breakdown Structure Element (WBS Element) Edited'
      WBSElementExternalID           :      String(24) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Opertn task list no.'
      @Common.Heading        : 'Routing number for operations'
      @Common.QuickInfo      : 'Routing number of operations in the order'
      ProjectNetworkInternalID       :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Commitment Item Short ID'
      CommitmentItemShortID          :      String(14) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Funds Center'
      @Common.Heading        : 'Funds Ctr'
      FundsCenter                    :      String(16) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Fund'
      Fund                           :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Functional Area'
      FunctionalArea                 :      String(16) not null;

      @Common.Label          : 'Goods Recipient'
      @Common.Heading        : 'Recipient'
      GoodsRecipientName             :      String(12) not null;

      @Common.Label          : 'Final Invoice'
      @Common.Heading        : 'FIn'
      @Common.QuickInfo      : 'Final Invoice Indicator'
      IsFinallyInvoiced              :      Boolean not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Counter'
      @Common.QuickInfo      : 'Internal counter'
      NetworkActivityInternalID      :      String(8) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Partner'
      @Common.QuickInfo      : 'Partner account number'
      PartnerAccountNumber           :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Recovery Indicator'
      @Common.Heading        : 'RI'
      JointVentureRecoveryCode       :      String(2) not null;

      @Common.Label          : 'Reference Date'
      @Common.Heading        : 'Ref date'
      @Common.QuickInfo      : 'Reference date for settlement'
      SettlementReferenceDate        :      Date;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Opertn task list no.'
      @Common.Heading        : 'Routing number for operations'
      @Common.QuickInfo      : 'Routing number of operations in the order'
      OrderInternalID                :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Counter'
      @Common.QuickInfo      : 'General counter for order'
      OrderIntBillOfOperationsItem   :      String(8) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Code'
      @Common.Heading        : 'Tx'
      @Common.QuickInfo      : 'Tax on Sales/Purchases Code'
      TaxCode                        :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Jurisdiction'
      @Common.Heading        : 'Tax Jur.'
      TaxJurisdiction                :      String(15) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Non-deductible'
      @Common.QuickInfo      : 'Non-deductible input tax'
      NonDeductibleInputTaxAmount    :      Decimal (precision : 13) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Activity Type'
      @Common.Heading        : 'ActTyp'
      CostCtrActivityType            :      String(6) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Business Process'
      @Common.Heading        : 'Bus. Process'
      BusinessProcess                :      String(12) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Grant'
      GrantID                        :      String(20) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Budget Period'
      BudgetPeriod                   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Earmarked Funds'
      @Common.Heading        : 'Earm. Fnds'
      @Common.QuickInfo      : 'Document Number for Earmarked Funds'
      EarmarkedFundsDocument         :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Document Item'
      @Common.Heading        : 'Itm'
      @Common.QuickInfo      : 'Earmarked Funds: Document Item'
      EarmarkedFundsDocumentItem     :      String(3) not null;
      ValidityDate                   :      Date;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Chart of Accounts'
      ChartOfAccounts                :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Service Doc. Type'
      @Common.Heading        : 'Service Document Type'
      @Common.QuickInfo      : 'Service Document Type'
      ServiceDocumentType            :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Service Document'
      @Common.QuickInfo      : 'Service Document ID'
      ServiceDocument                :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Service Doc. Item'
      @Common.Heading        : 'Service Document Item'
      @Common.QuickInfo      : 'Service Document Item ID'
      ServiceDocumentItem            :      String(6) not null;

      @Common.Label          : 'Created On'
      @Common.QuickInfo      : 'Record Creation Date'
      CreationDate                   :      Date;

      @Common.Label          : 'Final AA'
      @Common.Heading        : 'Final AA Indicator'
      @Common.QuickInfo      : 'Final Account Assignment Indicator'
      IsAcctLineFinal                :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Final AA Reason'
      @Common.QuickInfo      : 'Final Account Assignment Reason Code'
      AcctLineFinalReason            :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Company Code'
      @Common.Heading        : 'CoCd'
      CompanyCode                    :      String(4) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                 :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                              on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                              on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Invoicing Plan'
@Common.Messages                                                 : SAP__Messages
@Capabilities.NavigationRestrictions.RestrictedProperties        : [{
  NavigationProperty: _POInvoicingPlanItem,
  InsertRestrictions: {Insertable: true}
}]
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_POInvoicingPlanItem',
  '_PurchaseOrder',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
entity CE_PURCHASEORDER_0001.PurchaseOrderInvoicingPlan {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Order'
      @Common.Heading        : 'Purchase Order Number'
      @Common.QuickInfo      : 'Purchase Order Number'
  key PurchaseOrder                 :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchase Order Item'
      @Common.Heading        : 'Item Number of Purchase Order'
      @Common.QuickInfo      : 'Item Number of Purchase Order'
  key PurchaseOrderItem             :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Bill. Plan No.'
      @Common.Heading        : 'Bill. Plan'
      @Common.QuickInfo      : 'Billing/Invoicing Plan Number'
  key InvoicingPlan                 :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Billing Plan Type'
      @Common.Heading        : 'BT'
      @Common.QuickInfo      : 'Billing/Invoicing Plan Type'
      InvoicingPlanType             :      String(2) not null;

      @Common.Label          : 'Start Date'
      @Common.QuickInfo      : 'Start Date of Billing/Invoicing Plan'
      InvoicingPlanStartDate        :      Date;

      @Common.Label          : 'End Date'
      @Common.QuickInfo      : 'End Date of Billing/Invoicing Plan'
      InvoicingPlanEndDate          :      Date;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Next Billing Date'
      @Common.Heading        : 'ND'
      @Common.QuickInfo      : 'Rule for Origin of Next Billing/Invoice Date'
      InvoicingPlanNextInvcDateRule :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purch. Organization'
      @Common.Heading        : 'POrg'
      @Common.QuickInfo      : 'Purchasing Organization'
      PurchasingOrganization        :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Group'
      @Common.Heading        : 'PGr'
      PurchasingGroup               :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Doc. Type'
      @Common.Heading        : 'Type'
      @Common.QuickInfo      : 'Purchasing Document Type'
      PurchaseOrderType             :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Plant'
      @Common.Heading        : 'Plnt'
      Plant                         :      String(4) not null;
      SAP__Messages                 : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _POInvoicingPlanItem          :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderInvoicingPlanItem;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                             on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem            :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                             on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Invoicing Plan Item'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderInvoicingPlan',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : InvoicingPlanAmount,
  AllowedExpressions: 'MultiValue'
}]
entity CE_PURCHASEORDER_0001.PurchaseOrderInvoicingPlanItem {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Order'
      @Common.Heading        : 'Purchase Order Number'
      @Common.QuickInfo      : 'Purchase Order Number'
  key PurchaseOrder                  :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchase Order Item'
      @Common.Heading        : 'Item Number of Purchase Order'
      @Common.QuickInfo      : 'Item Number of Purchase Order'
  key PurchaseOrderItem              :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item for billing plan/invoice plan/payment cards'
  key InvoicingPlanItem              :      String(6) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Bill. Plan No.'
      @Common.Heading        : 'Bill. Plan'
      @Common.QuickInfo      : 'Billing/Invoicing Plan Number'
  key InvoicingPlan                  :      String(10) not null;

      @Common.Label          : 'Settlement Start Date'
      @Common.QuickInfo      : 'Settlement Start Date of Billing/Invoicing Date'
      InvoicingPlanSettlementFromDte :      Date;

      @Common.Label          : 'Settlement End Date'
      @Common.QuickInfo      : 'Settlement End Date of Billing/Invoicing Date'
      InvoicingPlanSettlementToDte   :      Date;

      @Common.Label          : 'Billing Date'
      InvoicingPlanInvoicingDate     :      Date;

      @Measures.ISOCurrency  : TransactionCurrency
      @Common.Label          : 'Billing Value'
      @Common.QuickInfo      : 'Value to be billed/calc. on date in billing/invoice plan'
      InvoicingPlanAmount            :      Decimal (precision : 15) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'Currency Key'
      TransactionCurrency            :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purch. Organization'
      @Common.Heading        : 'POrg'
      @Common.QuickInfo      : 'Purchasing Organization'
      PurchasingOrganization         :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Group'
      @Common.Heading        : 'PGr'
      PurchasingGroup                :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Doc. Type'
      @Common.Heading        : 'Type'
      @Common.QuickInfo      : 'Purchasing Document Type'
      PurchaseOrderType              :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Plant'
      @Common.Heading        : 'Plnt'
      Plant                          :      String(4) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                 :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                              on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderInvoicingPlan    :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderInvoicingPlan
                                              on _PurchaseOrderInvoicingPlan.InvoicingPlan = InvoicingPlan;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem {};
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Purchase Order Item'
@Common.Messages                                                 : SAP__Messages
@Capabilities.NavigationRestrictions.RestrictedProperties        : [
  {
    NavigationProperty: _DeliveryAddress,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurchaseOrderInvoicingPlan,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurchaseOrderItemNote,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurchaseOrderScheduleLineTP,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurOrdAccountAssignment,
    InsertRestrictions: {Insertable: true}
  },
  {
    NavigationProperty: _PurOrdPricingElement,
    InsertRestrictions: {Insertable: true}
  }
]
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_DeliveryAddress',
  '_PurchaseOrder',
  '_PurchaseOrderInvoicingPlan',
  '_PurchaseOrderItemNote',
  '_PurchaseOrderScheduleLineTP',
  '_PurOrdAccountAssignment',
  '_PurOrdPricingElement'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
  {
    Property          : ProductPurchasePointsQty,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : NetPriceQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : NetAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : GrossAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : EffectiveAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal1Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal2Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal3Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal4Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal5Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : Subtotal6Amount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : OrderQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : NetPriceAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ItemVolume,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ItemGrossWeight,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ItemNetWeight,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : NonDeductibleInputTaxAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : DownPaymentAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ExpectedOverallLimitAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : OverallLimitAmount,
    AllowedExpressions: 'MultiValue'
  }
]
entity CE_PURCHASEORDER_0001.PurchaseOrderItem {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Order'
      @Common.Heading        : 'Purchase Order Number'
      @Common.QuickInfo      : 'Purchase Order Number'
  key PurchaseOrder                  :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchase Order Item'
      @Common.Heading        : 'Item Number of Purchase Order'
      @Common.QuickInfo      : 'Item Number of Purchase Order'
  key PurchaseOrderItem              :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purch. Doc. Category'
      @Common.Heading        : 'Cat'
      @Common.QuickInfo      : 'Purchasing Document Category'
      PurchaseOrderCategory          :      String(1) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'Currency Key'
      DocumentCurrency               :      String(3) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Deletion Indicator'
      @Common.Heading        : 'D'
      @Common.QuickInfo      : 'Deletion Indicator in Purchasing Document'
      PurchasingDocumentDeletionCode :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Group'
      @Common.Heading        : 'Matl Group'
      MaterialGroup                  :      String(9) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material'
      @Common.QuickInfo      : 'Material Number'
      Material                       :      String(18) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Type'
      @Common.Heading        : 'MTyp'
      MaterialType                   :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier Mat. No.'
      @Common.Heading        : 'Supplier Material Number'
      @Common.QuickInfo      : 'Material Number Used by Supplier'
      SupplierMaterialNumber         :      String(35) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier Subrange'
      @Common.Heading        : 'SSR'
      SupplierSubrange               :      String(6) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Mfr Part Number'
      @Common.Heading        : 'MPN'
      @Common.QuickInfo      : 'Manufacturer Part Number'
      ManufacturerPartNmbr           :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Manufacturer'
      @Common.Heading        : 'Manufact.'
      @Common.QuickInfo      : 'Number of a Manufacturer'
      Manufacturer                   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material'
      @Common.QuickInfo      : 'Material number'
      ManufacturerMaterial           :      String(18) not null;

      @Common.Label          : 'Short Text'
      PurchaseOrderItemText          :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Product Type Group'
      @Common.Heading        : 'Product Type Grp'
      ProductTypeCode                :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Company Code'
      @Common.Heading        : 'CoCd'
      CompanyCode                    :      String(4) not null;

      @Common.FieldControl   : #Mandatory
      @Common.IsUpperCase    : true
      @Common.Label          : 'Plant'
      @Common.Heading        : 'Plnt'
      Plant                          :      String(4) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Address'
      @Common.QuickInfo      : 'Manual address number in purchasing document item'
      ManualDeliveryAddressID        :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Address'
      @Common.QuickInfo      : 'Number of delivery address'
      ReferenceDeliveryAddressID     :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Customer'
      Customer                       :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier'
      @Common.QuickInfo      : 'Supplier to be Supplied/Who is to Receive Delivery'
      Subcontractor                  :      String(10) not null;

      @Common.Label          : 'SC Supplier'
      @Common.Heading        : 'S'
      @Common.QuickInfo      : 'Subcontracting Supplier'
      SupplierIsSubcontractor        :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Cross-plant CM'
      @Common.QuickInfo      : 'Cross-Plant Configurable Material'
      CrossPlantConfigurableProduct  :      String(18) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Category'
      @Common.Heading        : 'Ct'
      ArticleCategory                :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Kanban Indicator'
      PlndOrderReplnmtElmntType      :      String(1) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Points Unit'
      @Common.Heading        : 'PUn'
      ProductPurchasePointsQtyUnit   :      String(3) not null;

      @Measures.Unit         : ProductPurchasePointsQtyUnit
      @Common.Label          : 'Points'
      @Common.QuickInfo      : 'Number of Points'
      ProductPurchasePointsQty       :      Decimal(13, 3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Storage Location'
      StorageLocation                :      String(4) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Order Unit'
      @Common.Heading        : 'OUn'
      @Common.QuickInfo      : 'Purchase Order Unit of Measure'
      PurchaseOrderQuantityUnit      :      String(3) not null;

      @Common.Label          : 'Equal To'
      @Common.Heading        : 'Eq. To'
      @Common.QuickInfo      : 'Numerator for Conversion of Order Unit to Base Unit'
      OrderItemQtyToBaseQtyNmrtr     :      Decimal (precision : 5) not null;

      @Common.Label          : 'Denominator'
      @Common.Heading        : 'Denom.'
      @Common.QuickInfo      : 'Denominator for Conversion of Order Unit to Base Unit'
      OrderItemQtyToBaseQtyDnmntr    :      Decimal (precision : 5) not null;

      @Measures.Unit         : OrderPriceUnit
      @Common.Label          : 'Price Unit'
      @Common.Heading        : 'Per'
      NetPriceQuantity               :      Decimal (precision : 5) not null;

      @Common.Label          : 'Delivery Completed'
      @Common.Heading        : 'DCI'
      @Common.QuickInfo      : '"Delivery Completed" Indicator'
      IsCompletelyDelivered          :      Boolean not null;

      @Common.Label          : 'Final Invoice'
      @Common.Heading        : 'FIn'
      @Common.QuickInfo      : 'Final Invoice Indicator'
      IsFinallyInvoiced              :      Boolean not null;

      @Common.Label          : 'Goods Receipt'
      @Common.Heading        : 'GR'
      @Common.QuickInfo      : 'Goods Receipt Indicator'
      GoodsReceiptIsExpected         :      Boolean not null;

      @Common.Label          : 'Invoice Receipt'
      @Common.Heading        : 'IR'
      @Common.QuickInfo      : 'Invoice Receipt Indicator'
      InvoiceIsExpected              :      Boolean not null;

      @Common.Label          : 'Acknowledgment Reqd.'
      @Common.Heading        : 'ARq'
      @Common.QuickInfo      : 'Order Acknowledgment Requirement'
      IsOrderAcknRqd                 :      Boolean not null;

      @Common.Label          : 'GR-Based Inv. Verif.'
      @Common.Heading        : 'GR-IV'
      @Common.QuickInfo      : 'Indicator: GR-Based Invoice Verification'
      InvoiceIsGoodsReceiptBased     :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Outline agreement'
      @Common.Heading        : 'Agmt.'
      @Common.QuickInfo      : 'Number of principal purchase agreement'
      PurchaseContract               :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Agreement Item'
      @Common.Heading        : 'Item'
      @Common.QuickInfo      : 'Item Number of Principal Purchase Agreement'
      PurchaseContractItem           :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Requisition'
      @Common.Heading        : 'Purch.Req.'
      @Common.QuickInfo      : 'Purchase Requisition Number'
      PurchaseRequisition            :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item of requisition'
      @Common.Heading        : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchase Requisition'
      PurchaseRequisitionItem        :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Req. Tracking Number'
      @Common.Heading        : 'TrackingNo'
      @Common.QuickInfo      : 'Requirement Tracking Number'
      RequirementTracking            :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'RFQ'
      @Common.QuickInfo      : 'RFQ Number'
      SupplierQuotation              :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item Number of RFQ'
      SupplierQuotationItem          :      String(5) not null;

      @Common.Label          : 'Eval. Receipt Sett.'
      @Common.Heading        : 'E'
      @Common.QuickInfo      : 'Evaluated Receipt Settlement (ERS)'
      EvaldRcptSettlmtIsAllowed      :      Boolean not null;

      @Common.Label          : 'Unltd Overdelivery'
      @Common.Heading        : 'Unlimited'
      @Common.QuickInfo      : 'Unlimited Overdelivery Allowed'
      UnlimitedOverdeliveryIsAllowed :      Boolean not null;

      @Common.Label          : 'Overdeliv. Tolerance'
      @Common.Heading        : 'Overdel. Tol.'
      @Common.QuickInfo      : 'Overdelivery Tolerance'
      OverdelivTolrtdLmtRatioInPct   :      Decimal(3, 1) not null;

      @Common.Label          : 'Underdel. Tolerance'
      @Common.Heading        : 'Underdel.Tol.'
      @Common.QuickInfo      : 'Underdelivery Tolerance'
      UnderdelivTolrtdLmtRatioInPct  :      Decimal(3, 1) not null;

      @Common.Label          : 'Requisitioner'
      @Common.Heading        : 'Requisnr.'
      @Common.QuickInfo      : 'Name of requisitioner/requester'
      RequisitionerName              :      String(12) not null;

      @Common.Label          : 'Planned Deliv. Time'
      @Common.Heading        : 'PTm'
      @Common.QuickInfo      : 'Planned Delivery Time in Days'
      PlannedDeliveryDurationInDays  :      Decimal (precision : 3) not null;

      @Common.Label          : 'GR processing time'
      @Common.Heading        : 'GRT'
      @Common.QuickInfo      : 'Goods receipt processing time in days'
      GoodsReceiptDurationInDays     :      Decimal (precision : 3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Partial Deliv./Item'
      @Common.Heading        : 'PD'
      @Common.QuickInfo      : 'Partial Delivery at Item Level (Stock Transfer)'
      PartialDeliveryIsAllowed       :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Consumption'
      @Common.Heading        : 'Cns'
      @Common.QuickInfo      : 'Consumption posting'
      ConsumptionPosting             :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Service Performer'
      @Common.Heading        : 'SrvPrfm'
      ServicePerformer               :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Package number'
      @Common.Heading        : 'Number'
      ServicePackage                 :      String(10) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Base Unit of Measure'
      @Common.Heading        : 'BUn'
      BaseUnit                       :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Item Category'
      @Common.Heading        : 'I'
      @Common.QuickInfo      : 'Item category in purchasing document'
      PurchaseOrderItemCategory      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Profit Center'
      @Common.Heading        : 'Profit Ctr'
      ProfitCenter                   :      String(10) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Order Price Unit'
      @Common.Heading        : 'OPU'
      @Common.QuickInfo      : 'Order Price Unit (Purchasing)'
      OrderPriceUnit                 :      String(3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Volume Unit'
      @Common.Heading        : 'VUn'
      ItemVolumeUnit                 :      String(3) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Unit of Weight'
      @Common.Heading        : 'Un'
      ItemWeightUnit                 :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Distribut. Indicator'
      @Common.Heading        : 'D'
      @Common.QuickInfo      : 'Distribution Indicator for Multiple Account Assignment'
      MultipleAcctAssgmtDistribution :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Partial invoice'
      @Common.Heading        : 'PIn'
      @Common.QuickInfo      : 'Partial invoice indicator'
      PartialInvoiceDistribution     :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Pricing Date Control'
      @Common.Heading        : 'C'
      @Common.QuickInfo      : 'Price Determination (Pricing) Date Control'
      PricingDateControl             :      String(1) not null;

      @Common.Label          : 'Statistical'
      @Common.Heading        : 'S'
      @Common.QuickInfo      : 'Item is statistical'
      IsStatisticalItem              :      Boolean not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Higher-Level Item'
      @Common.Heading        : 'HLIt'
      @Common.QuickInfo      : 'Higher-Level Item in Purchasing Documents'
      PurchasingParentItem           :      String(5) not null;

      @Common.Label          : 'Latest GR Date'
      @Common.Heading        : 'GR Date'
      @Common.QuickInfo      : 'Latest Possible Goods Receipt'
      GoodsReceiptLatestCreationDate :      Date;

      @Common.Label          : 'Returns Item'
      @Common.Heading        : 'R'
      IsReturnsItem                  :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Reason for Ordering'
      @Common.Heading        : 'OrRea'
      PurchasingOrderReason          :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Incoterms'
      @Common.Heading        : 'IncoT'
      @Common.QuickInfo      : 'Incoterms (Part 1)'
      IncotermsClassification        :      String(3) not null;

      @Common.Label          : 'Incoterms (Part 2)'
      @Common.Heading        : 'Inco. 2'
      IncotermsTransferLocation      :      String(28) not null;

      @Common.Label          : 'Incoterms Location 1'
      IncotermsLocation1             :      String(70) not null;

      @Common.Label          : 'Incoterms Location 2'
      IncotermsLocation2             :      String(70) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Prior Supplier'
      @Common.Heading        : 'Prior Spp.'
      PriorSupplier                  :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'EAN/UPC'
      @Common.QuickInfo      : 'International Article Number (EAN/UPC)'
      InternationalArticleNumber     :      String(18) not null;

      @Common.Label          : 'Intrastat Srvc. Code'
      @Common.Heading        : 'Intrastat Service Code'
      @Common.QuickInfo      : 'Intrastat Service Code'
      IntrastatServiceCode           :      String(30) not null;

      @Common.Label          : 'Commodity Code'
      CommodityCode                  :      String(30) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Freight Grp'
      @Common.Heading        : 'MatFrtGp'
      @Common.QuickInfo      : 'Material Freight Group'
      MaterialFreightGroup           :      String(8) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Qual.f.FreeGoodsDis.'
      @Common.Heading        : 'DiK'
      @Common.QuickInfo      : 'Material qualifies for discount in kind'
      DiscountInKindEligibility      :      String(1) not null;

      @Common.Label          : 'Shipping block'
      @Common.QuickInfo      : 'Item blocked for SD delivery'
      PurgItemIsBlockedForDelivery   :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Confirmation Control'
      @Common.Heading        : 'Ctr.'
      @Common.QuickInfo      : 'Confirmation Control Key'
      SupplierConfirmationControlKey :      String(4) not null;

      @Common.Label          : 'Order Acknowledgment'
      @Common.Heading        : 'Acknowledgment'
      @Common.QuickInfo      : 'Order Acknowledgment Number'
      PurgDocOrderAcknNumber         :      String(20) not null;

      @Common.Label          : 'Print Price'
      @Common.Heading        : 'P'
      @Common.QuickInfo      : 'Price Printout'
      PriceIsToBePrinted             :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Acct Assignment Cat.'
      @Common.Heading        : 'A'
      @Common.QuickInfo      : 'Account Assignment Category'
      AccountAssignmentCategory      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Info Rec.'
      @Common.Heading        : 'Info Rec.'
      @Common.QuickInfo      : 'Purchasing Info Record Number'
      PurchasingInfoRecord           :      String(10) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Net Order Value'
      @Common.Heading        : 'Net Value'
      @Common.QuickInfo      : 'Net Order Value in PO Currency'
      NetAmount                      :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Gross order value'
      @Common.Heading        : 'Gross value'
      @Common.QuickInfo      : 'Gross order value in PO currency'
      GrossAmount                    :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Effective value'
      @Common.QuickInfo      : 'Effective value of item'
      EffectiveAmount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 1'
      @Common.QuickInfo      : 'Subtotal 1 from Pricing Procedure for Price Element'
      Subtotal1Amount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 2'
      @Common.QuickInfo      : 'Subtotal 2 from Pricing Procedure for Price Element'
      Subtotal2Amount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 3'
      @Common.QuickInfo      : 'Subtotal 3 from Pricing Procedure for Price Element'
      Subtotal3Amount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 4'
      @Common.QuickInfo      : 'Subtotal 4 from Pricing Procedure for Price Element'
      Subtotal4Amount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 5'
      @Common.QuickInfo      : 'Subtotal 5 from Pricing Procedure for Price Element'
      Subtotal5Amount                :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Subtotal 6'
      @Common.QuickInfo      : 'Subtotal 6 from Pricing Procedure for Price Element'
      Subtotal6Amount                :      Decimal (precision : 13) not null;

      @Measures.Unit         : PurchaseOrderQuantityUnit
      @Common.Label          : 'Order Quantity'
      @Common.Heading        : 'PO Quantity'
      @Common.QuickInfo      : 'Purchase Order Quantity'
      OrderQuantity                  :      Decimal(13, 3) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Net Order Price'
      @Common.Heading        : 'Net Price'
      @Common.QuickInfo      : 'Net Price in Purchasing Document (in Document Currency)'
      NetPriceAmount                 :      Decimal (precision : 11) not null;

      @Measures.Unit         : ItemVolumeUnit
      @Common.Label          : 'Volume'
      ItemVolume                     :      Decimal(13, 3) not null;

      @Measures.Unit         : ItemWeightUnit
      @Common.Label          : 'Gross Weight'
      ItemGrossWeight                :      Decimal(13, 3) not null;

      @Measures.Unit         : ItemWeightUnit
      @Common.Label          : 'Net Weight'
      ItemNetWeight                  :      Decimal(13, 3) not null;

      @Common.Label          : 'Quantity Conversion'
      @Common.Heading        : 'Conv.'
      @Common.QuickInfo      : 'Numerator for Conversion of Order Price Unit into Order Unit'
      OrderPriceUnitToOrderUnitNmrtr :      Decimal (precision : 5) not null;

      @Common.Label          : 'Quantity Conversion'
      @Common.Heading        : 'Conv.'
      @Common.QuickInfo      : 'Denominator for Conv. of Order Price Unit into Order Unit'
      OrdPriceUnitToOrderUnitDnmntr  :      Decimal (precision : 5) not null;

      @Common.Label          : 'GR Non-Valuated'
      @Common.Heading        : 'N'
      @Common.QuickInfo      : 'Goods Receipt, Non-Valuated'
      GoodsReceiptIsNonValuated      :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Code'
      @Common.Heading        : 'Tx'
      @Common.QuickInfo      : 'Tax on Sales/Purchases Code'
      TaxCode                        :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Jurisdiction'
      @Common.Heading        : 'Tax Jur.'
      TaxJurisdiction                :      String(15) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Ctry/Reg.'
      @Common.Heading        : 'Tax Country/Region'
      @Common.QuickInfo      : 'Tax Reporting Country/Region'
      TaxCountry                     :      String(3) not null;

      @Common.Label          : 'Tax Date'
      @Common.QuickInfo      : 'Date for Determining Tax Rates'
      TaxDeterminationDate           :      Date;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Shipping Instr.'
      @Common.Heading        : 'SI'
      @Common.QuickInfo      : 'Shipping Instructions'
      ShippingInstruction            :      String(2) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Non-deductible'
      @Common.QuickInfo      : 'Non-deductible input tax'
      NonDeductibleInputTaxAmount    :      Decimal (precision : 13) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Stock Type'
      @Common.Heading        : 'T'
      StockType                      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Valuation Type'
      @Common.Heading        : 'Val. Type'
      ValuationType                  :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Valuation Category'
      @Common.Heading        : 'ValCat'
      ValuationCategory              :      String(1) not null;

      @Common.Label          : 'Rejection Indicator'
      @Common.Heading        : 'R'
      ItemIsRejectedBySupplier       :      Boolean not null;

      @Common.Label          : 'Price Date'
      @Common.QuickInfo      : 'Date of Price Determination'
      PurgDocPriceDate               :      Date;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Info Record Update'
      @Common.Heading        : 'I'
      @Common.QuickInfo      : 'Indicator: Update Info Record'
      PurchasingInfoRecordUpdateCode :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Special Stock'
      @Common.Heading        : 'S'
      @Common.QuickInfo      : 'Special Stock Indicator'
      InventorySpecialStockType      :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Del. Type f. Returns'
      @Common.Heading        : 'Del. Type Returns'
      @Common.QuickInfo      : 'Delivery Type for Returns to Supplier'
      DeliveryDocumentType           :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Issuing Storage Loc.'
      @Common.Heading        : 'IStLoc'
      @Common.QuickInfo      : 'Issuing Storage Location for Stock Transport Order'
      IssuingStorageLocation         :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Allocation Table'
      @Common.Heading        : 'Alloc.Tab.'
      AllocationTable                :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.Heading        : 'Itm'
      @Common.QuickInfo      : 'Allocation Table Item'
      AllocationTableItem            :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Retail Promotion'
      @Common.Heading        : 'Promotion'
      RetailPromotion                :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Hierarchy Number'
      PurgConfigurableItemNumber     :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Sub-items'
      @Common.Heading        : 'S'
      @Common.QuickInfo      : 'Subitems Exist'
      PurgDocAggrgdSubitemCategory   :      String(1) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'External Sort No.'
      @Common.Heading        : 'External Sort Number'
      @Common.QuickInfo      : 'External Sort Number'
      PurgExternalSortNumber         :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Batch'
      @Common.QuickInfo      : 'Batch Number'
      Batch                          :      String(10) not null;

      @Common.Label          : 'Free of Charge'
      @Common.Heading        : 'Free'
      @Common.QuickInfo      : 'Free Item'
      PurchasingItemIsFreeOfCharge   :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Down Payment'
      @Common.QuickInfo      : 'Down Payment Indicator'
      DownPaymentType                :      String(4) not null;

      @Common.Label          : 'Down Payment %'
      @Common.Heading        : 'Down Payt Percentage'
      @Common.QuickInfo      : 'Down Payment Percentage'
      DownPaymentPercentageOfTotAmt  :      Decimal(5, 2) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Down Payment Amount'
      @Common.QuickInfo      : 'Down Payment Amount in Document Currency'
      DownPaymentAmount              :      Decimal (precision : 11) not null;

      @Common.Label          : 'Due Date for DP'
      @Common.Heading        : 'Due Date for Down Payment'
      @Common.QuickInfo      : 'Due Date for Down Payment'
      DownPaymentDueDate             :      Date;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Expected Value'
      @Common.QuickInfo      : 'Expected Value of Overall Limit'
      ExpectedOverallLimitAmount     :      Decimal (precision : 13) not null;

      @Measures.ISOCurrency  : DocumentCurrency
      @Common.Label          : 'Overall Limit'
      OverallLimitAmount             :      Decimal (precision : 13) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Contract For Limit'
      @Common.QuickInfo      : 'Purchase Contract for Enhanced Limit'
      PurContractForOverallLimit     :      String(10) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier Check Sts'
      @Common.Heading        : 'Supplier Ck Sts'
      @Common.QuickInfo      : 'Product Compliance Supplier Check Status (Item)'
      PurgProdCmplncSupplierStatus   :      String(1) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Prod. Marktablty Sts'
      @Common.Heading        : 'ProdMarktabltyS'
      @Common.QuickInfo      : 'Product Marketability Status (Item)'
      PurgProductMarketabilityStatus :      String(1) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Sfty Data Sheet Sts'
      @Common.Heading        : 'SftyDataSheetS'
      @Common.QuickInfo      : 'Safety Data Sheet Status (Item)'
      PurgSafetyDataSheetStatus      :      String(1) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Dangerous Goods Sts'
      @Common.Heading        : 'Dngrs Goods Sts'
      @Common.QuickInfo      : 'Dangerous Goods Status (Item)'
      PurgProdCmplncDngrsGoodsStatus :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Origin'
      @Common.Heading        : 'O'
      @Common.QuickInfo      : 'Origin of the material'
      BR_MaterialOrigin              :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Material Usage'
      @Common.QuickInfo      : 'Usage of the material'
      BR_MaterialUsage               :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Mat. CFOP category'
      @Common.Heading        : 'MC'
      @Common.QuickInfo      : 'Material CFOP category'
      BR_CFOPCategory                :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'NCM Code'
      @Common.QuickInfo      : 'Brazilian NCM Code'
      BR_NCM                         :      String(16) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'HSN/SAC Code'
      @Common.QuickInfo      : 'HSN or SAC Code'
      ConsumptionTaxCtrlCode         :      String(16) not null;

      @Common.Label          : 'Produced in-house'
      @Common.Heading        : 'P'
      BR_IsProducedInHouse           :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Season Year'
      ProductSeasonYear              :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Season'
      ProductSeason                  :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Collection'
      @Common.QuickInfo      : 'Fashion Collection'
      ProductCollection              :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Theme'
      @Common.QuickInfo      : 'Fashion Theme'
      ProductTheme                   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Season Comp.Ind'
      @Common.Heading        : 'Season Completeness Indicator'
      @Common.QuickInfo      : 'Season Completeness Indicator'
      SeasonCompletenessStatus       :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PSST Grouping Rule'
      ShippingGroupRule              :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PSST Group'
      ShippingGroupNumber            :      String(10) not null;

      @Common.Label          : 'Characteristic 1'
      @Common.Heading        : 'Characteristic Value 1'
      @Common.QuickInfo      : 'Characteristic Value 1'
      ProductCharacteristic1         :      String(18) not null;

      @Common.Label          : 'Characteristic 2'
      @Common.Heading        : 'Characteristic Value 2'
      @Common.QuickInfo      : 'Characteristic Value 2'
      ProductCharacteristic2         :      String(18) not null;

      @Common.Label          : 'Characteristic 3'
      @Common.Heading        : 'Characteristic Value 3'
      @Common.QuickInfo      : 'Characteristic Value 3'
      ProductCharacteristic3         :      String(18) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Subitem Category'
      @Common.Heading        : 'S'
      @Common.QuickInfo      : 'Subitem Category, Purchasing Document'
      PurgDocSubitemCategory         :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Diversion Status'
      @Common.Heading        : 'Status of Diversion process'
      @Common.QuickInfo      : 'Status of Diversion process'
      DiversionStatus                :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Reference Document'
      @Common.Heading        : 'Reference Document for PO Traceability'
      @Common.QuickInfo      : 'Reference Document number for PO Traceability'
      ReferenceDocumentNumber        :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Reference Item'
      @Common.Heading        : 'Reference Item for PO'
      @Common.QuickInfo      : 'Reference Item number for PO Traceability'
      ReferenceDocumentItem          :      String(6) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Reference Action'
      @Common.Heading        : 'Reference Split Action in PO'
      @Common.QuickInfo      : 'Action for Traceability in  PO'
      PurchaseOrderReferenceType     :      String(1) not null;

      @Common.Label          : 'VAS Relevant'
      ItemHasValueAddedService       :      Boolean not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchasing Document'
      ValAddedSrvcParentItmNumber    :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Stock Segment'
      StockSegment                   :      String(40) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _DeliveryAddress               :      Composition of one CE_PURCHASEORDER_0001.PurOrderItemDeliveryAddress;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                 :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                              on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _PurchaseOrderInvoicingPlan    :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderInvoicingPlan;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _PurchaseOrderItemNote         :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderItemNote;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _PurchaseOrderScheduleLineTP   :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderScheduleLine;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _PurOrdAccountAssignment       :      Composition of many CE_PURCHASEORDER_0001.PurchaseOrderAccountAssignment;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _PurOrdPricingElement          :      Composition of many CE_PURCHASEORDER_0001.PurOrderItemPricingElement;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Item Notes'
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.FilterRestrictions.Filterable                      : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : PlainLongText,
  AllowedExpressions: 'SearchExpression'
}]
@Capabilities.SortRestrictions.NonSortableProperties             : ['PlainLongText']
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.Updatable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
entity CE_PURCHASEORDER_0001.PurchaseOrderItemNote {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Order'
      @Common.Heading        : 'Purchase Order Number'
      @Common.QuickInfo      : 'Purchase Order Number'
  key PurchaseOrder             : String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchase Order Item'
      @Common.Heading        : 'Item Number of Purchase Order'
      @Common.QuickInfo      : 'Item Number of Purchase Order'
  key PurchaseOrderItem         : String(5) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Text ID'
      @Common.Heading        : 'ID'
  key TextObjectType            : String(4) not null;

      @Core.Immutable        : true
      @Common.Label          : 'Language Key'
      @Common.Heading        : 'Language'
  key Language                  : String(2) not null;

      @Common.Label          : 'Long Text'
      PlainLongText             : LargeString not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Document Item'
      @Common.Heading        : 'Item'
      @Common.QuickInfo      : 'Concatenation of EBELN and EBELP'
      PurchaseOrderItemUniqueID : String(15) not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder            : Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                    on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem        : Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                    on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Header Notes'
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.FilterRestrictions.Filterable                      : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : PlainLongText,
  AllowedExpressions: 'SearchExpression'
}]
@Capabilities.SortRestrictions.NonSortableProperties             : ['PlainLongText']
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.Updatable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_PurchaseOrder']
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
entity CE_PURCHASEORDER_0001.PurchaseOrderNote {
      @Core.Immutable    : true
      @Common.IsUpperCase: true
      @Common.Label      : 'Purchase Order'
      @Common.Heading    : 'Purchase Order Number'
      @Common.QuickInfo  : 'Purchase Order Number'
  key PurchaseOrder  : String(10) not null;

      @Core.Immutable    : true
      @Common.IsUpperCase: true
      @Common.Label      : 'Text ID'
      @Common.Heading    : 'ID'
  key TextObjectType : String(4) not null;

      @Core.Immutable    : true
      @Common.Label      : 'Language Key'
      @Common.Heading    : 'Language'
  key Language       : String(2) not null;

      @Common.Label      : 'Long Text'
      PlainLongText  : LargeString not null;

      @cds.ambiguous     : 'missing on condition?'
      _PurchaseOrder : Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                         on _PurchaseOrder.PurchaseOrder = PurchaseOrder;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Partner'
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.Updatable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_PurchaseOrderTP']
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
entity CE_PURCHASEORDER_0001.PurchaseOrderPartner {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
      @Common.Heading        : 'Pur. Doc.'
      @Common.QuickInfo      : 'Purchasing Document Number'
  key PurchaseOrder                 : String(10) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Partner Function'
      @Common.Heading        : 'PartF'
  key PartnerFunction               : String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier Subrange'
      @Common.Heading        : 'SSR'
      SupplierSubrange              : String(6) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Plant'
      @Common.Heading        : 'Plnt'
      Plant                         : String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purch. Organization'
      @Common.Heading        : 'POrg'
      @Common.QuickInfo      : 'Purchasing Organization'
      PurchasingOrganization        : String(4) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Partner counter'
      @Common.Heading        : 'ParC'
      PartnerCounter                : String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Created By'
      @Common.QuickInfo      : 'Name of Person Responsible for Creating the Object'
      CreatedByUser                 : String(12) not null;

      @Common.Label          : 'Created On'
      @Common.QuickInfo      : 'Record Creation Date'
      CreationDate                  : Date;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Partner Type'
      @Common.Heading        : 'NoTy.'
      @Common.QuickInfo      : 'Type of partner number'
      PurchasingDocumentPartnerType : String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier'
      @Common.QuickInfo      : 'Account Number of Supplier'
      Supplier                      : String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Hierarchy Cat.'
      @Common.Heading        : 'Hierarchy Category Supplier'
      @Common.QuickInfo      : 'Hierarchy Category: Supplier Hierarchy'
      SupplierHierarchyCategory     : String(1) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Contact Person'
      @Common.Heading        : 'Partner'
      @Common.QuickInfo      : 'Number of Contact Person'
      SupplierContact               : String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Personnel Number'
      @Common.Heading        : 'Pers.No.'
      PersonWorkAgreement           : String(8) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Personnel Number'
      @Common.Heading        : 'Pers.No.'
      EmploymentInternalID          : String(8) not null;

      @Common.Label          : 'Default Partner'
      @Common.Heading        : 'D'
      DefaultPartner                : Boolean not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderTP              : Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                        on _PurchaseOrderTP.PurchaseOrder = PurchaseOrder;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Schedule Lines'
@Common.Messages                                                 : SAP__Messages
@Capabilities.NavigationRestrictions.RestrictedProperties        : [{
  NavigationProperty: _SubcontractingComponent,
  InsertRestrictions: {Insertable: true}
}]
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem',
  '_SubcontractingComponent'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
  {
    Property          : ScheduleLineOrderQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : OpenPurchaseOrderQuantity,
    AllowedExpressions: 'MultiValue'
  }
]
entity CE_PURCHASEORDER_0001.PurchaseOrderScheduleLine {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
      @Common.Heading        : 'Pur. Doc.'
      @Common.QuickInfo      : 'Purchasing Document Number'
  key PurchaseOrder              :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchasing Document'
  key PurchaseOrderItem          :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Schedule Line'
      @Common.Heading        : 'Schd.'
      @Common.QuickInfo      : 'Delivery Schedule Line Counter'
  key ScheduleLine               :      String(4) not null;

      @Common.Label          : 'Delivery Date'
      @Common.Heading        : 'Deliv. Date'
      @Common.QuickInfo      : 'Item Delivery Date'
      ScheduleLineDeliveryDate   :      Date;

      @Common.Label          : 'Stat.-Rel. Del. Date'
      @Common.Heading        : 'StatDelD'
      @Common.QuickInfo      : 'Statistics-Relevant Delivery Date'
      SchedLineStscDeliveryDate  :      Date;

      @Common.Label          : 'Start Date'
      @Common.QuickInfo      : 'Start Date for Period of Performance'
      PerformancePeriodStartDate :      Date;

      @Common.Label          : 'End Date'
      @Common.QuickInfo      : 'End Date for Period of Performance'
      PerformancePeriodEndDate   :      Date;

      @Common.Label          : 'Time'
      @Common.QuickInfo      : 'Delivery Date Time-Spot'
      ScheduleLineDeliveryTime   :      Time not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Batch'
      @Common.QuickInfo      : 'Batch Number'
      Batch                      :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier Batch'
      @Common.QuickInfo      : 'Supplier Batch Number'
      BatchBySupplier            :      String(15) not null;

      @Measures.Unit         : PurchaseOrderQuantityUnit
      @Common.Label          : 'Scheduled Quantity'
      @Common.Heading        : 'Scheduled Qty'
      ScheduleLineOrderQuantity  :      Decimal(13, 3) not null;

      @Measures.Unit         : PurchaseOrderQuantityUnit
      OpenPurchaseOrderQuantity  :      Decimal(14, 3) not null;

      @Common.IsUnit         : true
      @Core.Computed         : true
      @Common.Label          : 'Order Unit'
      @Common.Heading        : 'OUn'
      @Common.QuickInfo      : 'Purchase Order Unit of Measure'
      PurchaseOrderQuantityUnit  :      String(3) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'Currency Key'
      Currency                   :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchase Requisition'
      @Common.Heading        : 'Purch.Req.'
      @Common.QuickInfo      : 'Purchase Requisition Number'
      PurchaseRequisition        :      String(10) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Item of requisition'
      @Common.Heading        : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchase Requisition'
      PurchaseRequisitionItem    :      String(5) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Deliv. date category'
      @Common.Heading        : 'C'
      @Common.QuickInfo      : 'Category of delivery date'
      DelivDateCategory          :      String(1) not null;

      @Common.Label          : 'Purchase Order Date'
      @Common.Heading        : 'Order date'
      @Common.QuickInfo      : 'Order date of schedule line'
      ScheduleLineOrderDate      :      Date;

      @Common.Label          : 'Material Avail. Date'
      @Common.Heading        : 'Mat.Av.Dt.'
      @Common.QuickInfo      : 'Material Staging/Availability Date'
      ProductAvailabilityDate    :      Date;

      @Common.Label          : 'Loading Date'
      @Common.Heading        : 'Loadg Date'
      LoadingDate                :      Date;

      @Common.Label          : 'Loading Time'
      @Common.Heading        : 'Loadg Time'
      @Common.QuickInfo      : 'Loading Time (Local Time Relating to a Shipping Point)'
      LoadingTime                :      Time not null;

      @Common.Label          : 'Transptn Plang Date'
      @Common.Heading        : 'TrpPlanDt'
      @Common.QuickInfo      : 'Transportation Planning Date'
      TransportationPlanningDate :      Date;

      @Common.Label          : 'Transp. Plan. Time'
      @Common.Heading        : 'TP Time'
      @Common.QuickInfo      : 'Transp. Planning Time (Local, Relating to a Shipping Point)'
      TransportationPlanningTime :      Time not null;

      @Common.Label          : 'Goods Issue Date'
      @Common.Heading        : 'GI Date'
      GoodsIssueDate             :      Date;

      @Common.Label          : 'Goods Issue Time'
      @Common.Heading        : 'GI Time'
      @Common.QuickInfo      : 'Time of Goods Issue (Local, Relating to a Plant)'
      GoodsIssueTime             :      Time not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Route Schedule'
      @Common.Heading        : 'RSch'
      RouteSchedule              :      String(10) not null;

      @Common.Label          : 'Matl Staging Time'
      @Common.Heading        : 'Stag. Time'
      @Common.QuickInfo      : 'Material Staging Time (Local, Relating to a Plant)'
      ProductAvailabilityTime    :      Time not null;
      SAP__Messages              : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                          on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem         :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                          on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;

      @cds.ambiguous         : 'missing on condition?'
      @Common.Composition    : true
      _SubcontractingComponent   :      Composition of many CE_PURCHASEORDER_0001.POSubcontractingComponent;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Supplier Address'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_PurchaseOrderTP']
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : EmailAddress,
  AllowedExpressions: 'MultiValue'
}]
entity CE_PURCHASEORDER_0001.PurchaseOrderSupplierAddress {
      @Core.Immutable    : true
      @Common.IsUpperCase: true
      @Common.Label      : 'Address Number'
      @Common.Heading    : 'Addr. No.'
  key SupplierAddressID            :      String(10) not null;

      @Core.Immutable    : true
      @Common.IsUpperCase: true
      @Common.Label      : 'Purchase Order'
      @Common.Heading    : 'Purchase Order Number'
      @Common.QuickInfo  : 'Purchase Order Number'
  key PurchaseOrder                :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Address Number'
      @Common.Heading    : 'Addr. No.'
      AddressID                    :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Person Number'
      @Common.Heading    : 'Person'
      AddressPersonID              :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Address Version'
      @Common.Heading    : 'Version'
      @Common.QuickInfo  : 'Version ID for International Addresses'
      AddressRepresentationCode    :      String(1) not null;

      @Common.Label      : 'Language Key'
      @Common.Heading    : 'Language'
      CorrespondenceLanguage       :      String(2) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Comm. Method'
      @Common.QuickInfo  : 'Communication Method (Key) (Business Address Services)'
      PrfrdCommMediumType          :      String(3) not null;

      @Common.Label      : 'Full Name'
      @Common.QuickInfo  : 'Full Name of Person'
      AddresseeFullName            :      String(80) not null;

      @Common.Label      : 'Name'
      @Common.QuickInfo  : 'Name 1'
      OrganizationName1            :      String(40) not null;

      @Common.Label      : 'Name 2'
      OrganizationName2            :      String(40) not null;

      @Common.Label      : 'Name 3'
      OrganizationName3            :      String(40) not null;

      @Common.Label      : 'Name 4'
      OrganizationName4            :      String(40) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Search Term 1'
      AddressSearchTerm1           :      String(20) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Search Term 2'
      AddressSearchTerm2           :      String(20) not null;

      @Common.Label      : 'City'
      CityName                     :      String(40) not null;

      @Common.Label      : 'District'
      DistrictName                 :      String(40) not null;

      @Common.Label      : 'Different City'
      @Common.Heading    : 'City (Diff. from Postal City)'
      @Common.QuickInfo  : 'City (different from postal city)'
      VillageName                  :      String(40) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Postal Code'
      @Common.Heading    : 'Post. Code'
      @Common.QuickInfo  : 'City Postal Code'
      PostalCode                   :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Company Postal Code'
      @Common.Heading    : 'Postl Code'
      @Common.QuickInfo  : 'Company Postal Code (for Large Customers)'
      CompanyPostalCode            :      String(10) not null;

      @Common.Label      : 'Street'
      StreetName                   :      String(60) not null;

      @Common.Label      : 'Street 2'
      StreetPrefixName1            :      String(40) not null;

      @Common.Label      : 'Street 3'
      StreetPrefixName2            :      String(40) not null;

      @Common.Label      : 'Street 4'
      StreetSuffixName1            :      String(40) not null;

      @Common.Label      : 'Street 5'
      StreetSuffixName2            :      String(40) not null;

      @Common.Label      : 'House Number'
      @Common.Heading    : 'House No.'
      HouseNumber                  :      String(10) not null;

      @Common.Label      : 'Supplement'
      @Common.QuickInfo  : 'House number supplement'
      HouseNumberSupplementText    :      String(10) not null;

      @Common.Label      : 'Building Code'
      @Common.Heading    : 'Building'
      @Common.QuickInfo  : 'Building (Number or Code)'
      Building                     :      String(20) not null;

      @Common.Label      : 'Floor'
      @Common.QuickInfo  : 'Floor in building'
      Floor                        :      String(10) not null;

      @Common.Label      : 'Room Number'
      @Common.Heading    : 'Room No.'
      @Common.QuickInfo  : 'Room or Apartment Number'
      RoomNumber                   :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Country/Region Key'
      @Common.Heading    : 'C/R'
      Country                      :      String(3) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Region'
      @Common.Heading    : 'Rg'
      @Common.QuickInfo  : 'Region (State, Province, County)'
      Region                       :      String(3) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Title Key'
      @Common.Heading    : 'Key'
      @Common.QuickInfo  : 'Form-of-Address Key'
      FormOfAddress                :      String(4) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Tax Jurisdiction'
      TaxJurisdiction              :      String(15) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Transportation Zone'
      @Common.Heading    : 'TranspZone'
      @Common.QuickInfo  : 'Transportation zone to or from which the goods are delivered'
      TransportZone                :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'PO Box'
      POBox                        :      String(10) not null;

      @Common.Label      : 'PO Box w/o No.'
      @Common.Heading    : 'PO'
      @Common.QuickInfo  : 'Flag: PO Box Without Number'
      POBoxIsWithoutNumber         :      Boolean not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'PO Box Postal Code'
      @Common.Heading    : 'Postl Code'
      POBoxPostalCode              :      String(10) not null;

      @Common.Label      : 'PO Box Lobby'
      POBoxLobbyName               :      String(40) not null;

      @Common.Label      : 'PO Box City'
      @Common.QuickInfo  : 'PO Box city'
      POBoxDeviatingCityName       :      String(40) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'PO Box Region'
      @Common.Heading    : 'PO Region'
      @Common.QuickInfo  : 'Region for PO Box (Country/Region, State, Province, ...)'
      POBoxDeviatingRegion         :      String(3) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'PO Box Ctry/Region'
      @Common.Heading    : 'PO C/R'
      @Common.QuickInfo  : 'PO Box of Country/Region'
      POBoxDeviatingCountry        :      String(3) not null;

      @Common.Label      : 'c/o'
      @Common.Heading    : 'c/o name'
      @Common.QuickInfo  : 'c/o name'
      CareOfName                   :      String(40) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Delvry Serv Type'
      @Common.QuickInfo  : 'Type of Delivery Service'
      DeliveryServiceTypeCode      :      String(4) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Delivery Service No.'
      @Common.Heading    : 'Delivery Service Number'
      @Common.QuickInfo  : 'Number of Delivery Service'
      DeliveryServiceNumber        :      String(10) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Time Zone'
      @Common.Heading    : 'Zone'
      @Common.QuickInfo  : 'Address Time Zone'
      AddressTimeZone              :      String(6) not null;

      @Common.Label      : 'Email Address'
      EmailAddress                 :      String(241) not null;

      @Common.IsUpperCase: true
      @Common.Label      : 'Test Stat./City File'
      @Common.Heading    : 'Status'
      @Common.QuickInfo  : 'City File Test Status'
      RegionalStructureCheckStatus :      String(1) not null;
      SAP__Messages                : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous     : 'missing on condition?'
      _PurchaseOrderTP             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                            on _PurchaseOrderTP.PurchaseOrder = PurchaseOrder;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Item Delivery Address'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
  Property          : EmailAddress,
  AllowedExpressions: 'MultiValue'
}]
entity CE_PURCHASEORDER_0001.PurOrderItemDeliveryAddress {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
      @Common.Heading        : 'Pur. Doc.'
      @Common.QuickInfo      : 'Purchasing Document Number'
  key PurchaseOrder                :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Purchase Order Item'
      @Common.Heading        : 'Item Number of Purchase Order'
      @Common.QuickInfo      : 'Item Number of Purchase Order'
  key PurchaseOrderItem            :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Address'
      @Common.QuickInfo      : 'Manual address number in purchasing document item'
  key DeliveryAddressID            :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Address Number'
      @Common.Heading        : 'Addr. No.'
      AddressID                    :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Person Number'
      @Common.Heading        : 'Person'
      AddressPersonID              :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Address Version'
      @Common.Heading        : 'Version'
      @Common.QuickInfo      : 'Version ID for International Addresses'
      AddressRepresentationCode    :      String(1) not null;

      @Common.Label          : 'Language Key'
      @Common.Heading        : 'Language'
      CorrespondenceLanguage       :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Comm. Method'
      @Common.QuickInfo      : 'Communication Method (Key) (Business Address Services)'
      PrfrdCommMediumType          :      String(3) not null;

      @Common.Label          : 'Full Name'
      @Common.QuickInfo      : 'Full Name of Person'
      AddresseeFullName            :      String(80) not null;

      @Common.Label          : 'Name'
      @Common.QuickInfo      : 'Name 1'
      OrganizationName1            :      String(40) not null;

      @Common.Label          : 'Name 2'
      OrganizationName2            :      String(40) not null;

      @Common.Label          : 'Name 3'
      OrganizationName3            :      String(40) not null;

      @Common.Label          : 'Name 4'
      OrganizationName4            :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Search Term 1'
      AddressSearchTerm1           :      String(20) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Search Term 2'
      AddressSearchTerm2           :      String(20) not null;

      @Common.Label          : 'City'
      CityName                     :      String(40) not null;

      @Common.Label          : 'District'
      DistrictName                 :      String(40) not null;

      @Common.Label          : 'Different City'
      @Common.Heading        : 'City (Diff. from Postal City)'
      @Common.QuickInfo      : 'City (different from postal city)'
      VillageName                  :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Postal Code'
      @Common.Heading        : 'Post. Code'
      @Common.QuickInfo      : 'City Postal Code'
      PostalCode                   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Company Postal Code'
      @Common.Heading        : 'Postl Code'
      @Common.QuickInfo      : 'Company Postal Code (for Large Customers)'
      CompanyPostalCode            :      String(10) not null;

      @Common.Label          : 'Street'
      StreetName                   :      String(60) not null;

      @Common.Label          : 'Street 2'
      StreetPrefixName1            :      String(40) not null;

      @Common.Label          : 'Street 3'
      StreetPrefixName2            :      String(40) not null;

      @Common.Label          : 'Street 4'
      StreetSuffixName1            :      String(40) not null;

      @Common.Label          : 'Street 5'
      StreetSuffixName2            :      String(40) not null;

      @Common.Label          : 'House Number'
      @Common.Heading        : 'House No.'
      HouseNumber                  :      String(10) not null;

      @Common.Label          : 'Supplement'
      @Common.QuickInfo      : 'House number supplement'
      HouseNumberSupplementText    :      String(10) not null;

      @Common.Label          : 'Building Code'
      @Common.Heading        : 'Building'
      @Common.QuickInfo      : 'Building (Number or Code)'
      Building                     :      String(20) not null;

      @Common.Label          : 'Floor'
      @Common.QuickInfo      : 'Floor in building'
      Floor                        :      String(10) not null;

      @Common.Label          : 'Room Number'
      @Common.Heading        : 'Room No.'
      @Common.QuickInfo      : 'Room or Apartment Number'
      RoomNumber                   :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Country/Region Key'
      @Common.Heading        : 'C/R'
      Country                      :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Region'
      @Common.Heading        : 'Rg'
      @Common.QuickInfo      : 'Region (State, Province, County)'
      Region                       :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Title Key'
      @Common.Heading        : 'Key'
      @Common.QuickInfo      : 'Form-of-Address Key'
      FormOfAddress                :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Jurisdiction'
      TaxJurisdiction              :      String(15) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Transportation Zone'
      @Common.Heading        : 'TranspZone'
      @Common.QuickInfo      : 'Transportation zone to or from which the goods are delivered'
      TransportZone                :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PO Box'
      POBox                        :      String(10) not null;

      @Common.Label          : 'PO Box w/o No.'
      @Common.Heading        : 'PO'
      @Common.QuickInfo      : 'Flag: PO Box Without Number'
      POBoxIsWithoutNumber         :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PO Box Postal Code'
      @Common.Heading        : 'Postl Code'
      POBoxPostalCode              :      String(10) not null;

      @Common.Label          : 'PO Box Lobby'
      POBoxLobbyName               :      String(40) not null;

      @Common.Label          : 'PO Box City'
      @Common.QuickInfo      : 'PO Box city'
      POBoxDeviatingCityName       :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PO Box Region'
      @Common.Heading        : 'PO Region'
      @Common.QuickInfo      : 'Region for PO Box (Country/Region, State, Province, ...)'
      POBoxDeviatingRegion         :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'PO Box Ctry/Region'
      @Common.Heading        : 'PO C/R'
      @Common.QuickInfo      : 'PO Box of Country/Region'
      POBoxDeviatingCountry        :      String(3) not null;

      @Common.Label          : 'c/o'
      @Common.Heading        : 'c/o name'
      @Common.QuickInfo      : 'c/o name'
      CareOfName                   :      String(40) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Delvry Serv Type'
      @Common.QuickInfo      : 'Type of Delivery Service'
      DeliveryServiceTypeCode      :      String(4) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Delivery Service No.'
      @Common.Heading        : 'Delivery Service Number'
      @Common.QuickInfo      : 'Number of Delivery Service'
      DeliveryServiceNumber        :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Time Zone'
      @Common.Heading        : 'Zone'
      @Common.QuickInfo      : 'Address Time Zone'
      AddressTimeZone              :      String(6) not null;

      @Common.Label          : 'Email Address'
      EmailAddress                 :      String(241) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Test Stat./City File'
      @Common.Heading        : 'Status'
      @Common.QuickInfo      : 'City File Test Status'
      RegionalStructureCheckStatus :      String(1) not null;
      SAP__Messages                : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder               :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                            on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem           :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                            on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;
};

@cds.external                                                    : true
@cds.persistence.skip                                            : true
@Common.Label                                                    : 'Pricing Element'
@Common.Messages                                                 : SAP__Messages
@Capabilities.SearchRestrictions.Searchable                      : false
@Capabilities.InsertRestrictions.Insertable                      : false
@Capabilities.DeleteRestrictions.Deletable                       : false
@Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
  '_PurchaseOrder',
  '_PurchaseOrderItem'
]
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [
  {
    Property          : ConditionRateRatio,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ConditionQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : CndnRoundingOffDiffAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ConditionAmount,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ConditionAmountInLocalCrcy,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property          : ConditionAdjustedQuantity,
    AllowedExpressions: 'MultiValue'
  }
]
entity CE_PURCHASEORDER_0001.PurOrderItemPricingElement {
      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Purchasing Document'
      @Common.Heading        : 'Pur. Doc.'
      @Common.QuickInfo      : 'Purchasing Document Number'
  key PurchaseOrder                  :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.QuickInfo      : 'Item Number of Purchasing Document'
  key PurchaseOrderItem              :      String(5) not null;

      @Core.Immutable        : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Doc. Condition No.'
      @Common.Heading        : 'Doc.Cond.'
      @Common.QuickInfo      : 'Number of the Document Condition'
  key PricingDocument                :      String(10) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Item'
      @Common.Heading        : 'ItemNo'
      @Common.QuickInfo      : 'Condition item number'
  key PricingDocumentItem            :      String(6) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Step Number'
      @Common.Heading        : 'Step'
  key PricingProcedureStep           :      String(3) not null;

      @Core.Immutable        : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Counter'
      @Common.Heading        : 'Cntr'
      @Common.QuickInfo      : 'Condition Counter'
  key PricingProcedureCounter        :      String(3) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Application'
      @Common.Heading        : 'App'
      ConditionApplication           :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Type'
      @Common.Heading        : 'CnTy'
      ConditionType                  :      String(4) not null;

      @Core.Computed         : true
      @Common.Label          : 'Cndn Pricing Date'
      @Common.Heading        : 'CndnPrcgDt'
      @Common.QuickInfo      : 'Condition Pricing Date'
      PriceConditionDeterminationDte :      Date;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Calculation Type'
      @Common.Heading        : 'CalTy'
      @Common.QuickInfo      : 'Calculation Type for Condition'
      ConditionCalculationType       :      String(3) not null;

      @Measures.ISOCurrency  : TransactionCurrency
      @Common.Label          : 'Cndn Bs Amt'
      @Common.Heading        : 'Condition Basis Amount'
      @Common.QuickInfo      : 'Amount of the Condition Basis'
      ConditionBaseAmount            :      Decimal(24, 9) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Basis'
      ConditionBaseValue             :      Decimal(24, 9) not null;

      @Measures.ISOCurrency  : ConditionCurrency
      @Common.Label          : 'Condition Amount'
      ConditionRateAmount            :      Decimal(24, 9) not null;

      @Measures.Unit         : ConditionRateRatioUnit
      @Common.Label          : 'Ratio'
      @Common.QuickInfo      : 'Condition Ratio (in Percent or Per Mille)'
      ConditionRateRatio             :      Decimal(24, 9) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Internal UoM'
      @Common.Heading        : 'MU'
      @Common.QuickInfo      : 'Unit of Measurement'
      ConditionRateRatioUnit         :      String(3) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'Currency Key'
      ConditionCurrency              :      String(3) not null;

      @Core.Computed         : true
      @Common.Label          : 'Exchange Rate'
      @Common.Heading        : 'Exch.Rate'
      @Common.QuickInfo      : 'Exchange Rate for Price Determination'
      PriceDetnExchangeRate          :      Decimal(9, 5) not null;

      @Measures.Unit         : ConditionQuantityUnit
      @Common.Label          : 'Pricing Unit'
      @Common.Heading        : 'per'
      @Common.QuickInfo      : 'Condition Pricing Unit'
      ConditionQuantity              :      Decimal (precision : 5) not null;

      @Common.IsUnit         : true
      @Common.Label          : 'Condition Unit'
      @Common.Heading        : 'UoM'
      @Common.QuickInfo      : 'Condition Unit in the Document'
      ConditionQuantityUnit          :      String(3) not null;

      @Common.Label          : 'Numerator'
      @Common.QuickInfo      : 'Numerator for Converting to Base UoM'
      ConditionToBaseQtyNmrtr        :      Decimal (precision : 10) not null;

      @Common.Label          : 'Denominator'
      @Common.QuickInfo      : 'Denominator for Converting to Base UoM'
      ConditionToBaseQtyDnmntr       :      Decimal (precision : 10) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Category'
      @Common.Heading        : 'CdCat'
      @Common.QuickInfo      : 'Condition Category (Examples: Tax, Freight, Price, Cost)'
      ConditionCategory              :      String(1) not null;

      @Core.Computed         : true
      @Common.Label          : 'Statistical'
      @Common.Heading        : 'Stat'
      @Common.QuickInfo      : 'Condition is used for statistics'
      ConditionIsForStatistics       :      Boolean not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Scale Type'
      @Common.Heading        : 'S'
      PricingScaleType               :      String(1) not null;

      @Core.Computed         : true
      @Common.Label          : 'Accruals'
      @Common.Heading        : 'Accr.'
      @Common.QuickInfo      : 'Condition is Relevant for Accrual  (e.g. Freight)'
      IsRelevantForAccrual           :      Boolean not null;

      @Core.Computed         : true
      @Common.Label          : 'Invoice List Cond.'
      @Common.Heading        : 'InLiC'
      @Common.QuickInfo      : 'Condition for Invoice List'
      CndnIsRelevantForInvoiceList   :      Boolean not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Origin'
      @Common.Heading        : 'Orig'
      @Common.QuickInfo      : 'Origin of the Condition'
      ConditionOrigin                :      String(1) not null;

      @Core.Computed         : true
      @Common.Label          : 'Group Condition'
      @Common.Heading        : 'GrC'
      IsGroupCondition               :      Boolean not null;

      @Core.Computed         : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Access'
      @Common.Heading        : 'AcNo'
      @Common.QuickInfo      : 'Access sequence - Access number'
      AccessNumberOfAccessSequence   :      String(3) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Record No.'
      @Common.Heading        : 'CondRecNo.'
      @Common.QuickInfo      : 'Number of Condition Record'
      ConditionRecord                :      String(10) not null;

      @Core.Computed         : true
      @Common.IsDigitSequence: true
      @Common.Label          : 'Sequent.No. of Cond.'
      @Common.Heading        : 'No'
      @Common.QuickInfo      : 'Sequential Number of the Condition'
      ConditionSequentialNumber      :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Account Key'
      @Common.Heading        : 'ActKy'
      AccountKeyForGLAccount         :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'G/L Account'
      @Common.Heading        : 'G/L Acct'
      @Common.QuickInfo      : 'G/L Account Number'
      GLAccount                      :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Tax Code'
      @Common.Heading        : 'Tx'
      @Common.QuickInfo      : 'Tax on Sales/Purchases Code'
      TaxCode                        :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'AcctKey Accruals'
      @Common.Heading        : 'Accrls'
      @Common.QuickInfo      : 'Account Key - Accruals / Provisions'
      AcctKeyForAccrualsGLAccount    :      String(3) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Accruals Account'
      @Common.Heading        : 'Accrs.Acc.'
      @Common.QuickInfo      : 'Number of Accruals Account'
      AccrualsGLAccount              :      String(10) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'W/Tax Code'
      @Common.Heading        : 'WTx'
      @Common.QuickInfo      : 'Withholding Tax Code'
      WithholdingTaxCode             :      String(2) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Supplier'
      @Common.QuickInfo      : 'Account Number of Supplier'
      FreightSupplier                :      String(10) not null;

      @Measures.ISOCurrency  : TransactionCurrency
      @Common.Label          : 'Cond.Rounding Diff.'
      @Common.Heading        : 'CondDiff'
      @Common.QuickInfo      : 'Rounding-Off Difference of the Condition'
      CndnRoundingOffDiffAmount      :      Decimal (precision : 5) not null;

      @Core.Computed         : true
      @Measures.ISOCurrency  : TransactionCurrency
      @Common.Label          : 'Condition Value'
      ConditionAmount                :      Decimal (precision : 15) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Document Currency'
      @Common.Heading        : 'Crcy'
      @Common.QuickInfo      : 'SD Document Currency'
      TransactionCurrency            :      String(3) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Control'
      @Common.Heading        : 'Ctrl'
      ConditionControl               :      String(1) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Inactive Condition'
      @Common.Heading        : 'Inact'
      @Common.QuickInfo      : 'Condition is Inactive'
      ConditionInactiveReason        :      String(1) not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Class'
      @Common.Heading        : 'CCl'
      ConditionClass                 :      String(1) not null;

      @Common.IsDigitSequence: true
      @Common.Label          : 'Counter'
      @Common.Heading        : 'Cntr'
      @Common.QuickInfo      : 'Condition Counter (Header)'
      PrcgProcedureCounterForHeader  :      String(3) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Factor'
      @Common.Heading        : 'Factor'
      @Common.QuickInfo      : 'Factor for Condition Base Value'
      FactorForConditionBasisValue   :      Double not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Structure Condition'
      @Common.Heading        : 'StrucC'
      StructureCondition             :      String(1) not null;

      @Common.Label          : 'Condition Factor'
      @Common.Heading        : 'Factor'
      @Common.QuickInfo      : 'Factor for Condition Basis (Period)'
      PeriodFactorForCndnBasisValue  :      Double not null;

      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Scale Basis'
      @Common.Heading        : 'ScBas'
      @Common.QuickInfo      : 'Scale Basis Indicator'
      PricingScaleBasis              :      String(3) not null;

      @Core.Computed         : true
      @Common.Label          : 'Scale Base Val.'
      @Common.Heading        : 'Scale Base Value'
      @Common.QuickInfo      : 'Scale Base Value'
      ConditionScaleBasisValue       :      Decimal(24, 9) not null;

      @Common.IsUnit         : true
      @Core.Computed         : true
      @Common.Label          : 'Scale Unit of Meas.'
      @Common.Heading        : 'UoM'
      @Common.QuickInfo      : 'Condition Scale Unit of Measure'
      ConditionScaleBasisUnit        :      String(3) not null;

      @Common.IsCurrency     : true
      @Core.Computed         : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Scale Currency'
      @Common.Heading        : 'ScCur'
      ConditionScaleBasisCurrency    :      String(3) not null;

      @Common.IsCurrency     : true
      @Common.IsUpperCase    : true
      @Common.Label          : 'Condition Currency'
      @Common.Heading        : 'CnC'
      @Common.QuickInfo      : 'Condition Currency (for Cumulation Fields)'
      ConditionAlternativeCurrency   :      String(3) not null;

      @Measures.ISOCurrency  : ConditionAlternativeCurrency
      @Common.Label          : 'Condition Value'
      ConditionAmountInLocalCrcy     :      Decimal (precision : 15) not null;

      @Core.Computed         : true
      @Common.Label          : 'Intercomp.Billing'
      @Common.Heading        : 'ICB'
      @Common.QuickInfo      : 'Condition for Intercompany Billing'
      CndnIsRelevantForIntcoBilling  :      Boolean not null;

      @Core.Computed         : true
      @Common.Label          : 'Changed Manually'
      @Common.Heading        : 'Man'
      @Common.QuickInfo      : 'Condition Changed Manually'
      ConditionIsManuallyChanged     :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Price Source'
      @Common.Heading        : 'PrSc'
      BillingPriceSource             :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Jurisdiction level'
      @Common.QuickInfo      : 'Tax jurisdiction code level'
      TaxJurisdictionLevel           :      String(1) not null;

      @Common.Label          : 'BitEncryptFlags'
      @Common.Heading        : 'BFlg'
      @Common.QuickInfo      : 'Bit encrypted flags in Pricing'
      ConditionByteSequence          :      Binary(2) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Update'
      @Common.Heading        : 'CdUpd'
      CndnIsRelevantForLimitValue    :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Maximum Basis Value'
      @Common.Heading        : 'MxBV'
      @Common.QuickInfo      : 'Indicator for Maximum Condition Basis Value'
      ConditionBasisLimitExceeded    :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Maximum Amount'
      @Common.Heading        : 'MxAm'
      @Common.QuickInfo      : 'Indicator for Maximum Condition Amount'
      ConditionAmountLimitExceeded   :      String(1) not null;

      @Common.Label          : 'Condition Basis'
      CumulatedConditionBasisValue   :      Decimal(24, 9) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Customer'
      @Common.QuickInfo      : 'Customer number (rebate recipient)'
      CustomerRebateRecipient        :      String(10) not null;

      @Core.Computed         : true
      @Common.Label          : 'UsedforVariantConfig'
      @Common.Heading        : 'Var.'
      @Common.QuickInfo      : 'Condition Used for Variant Configuration'
      ConditionIsForConfiguration    :      Boolean not null;

      @Common.Label          : 'Variant Key'
      @Common.Heading        : 'Variant'
      @Common.QuickInfo      : 'Variant Condition Key'
      VariantCondition               :      String(26) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Rel. for Acct Assigt'
      @Common.Heading        : 'AcRel'
      @Common.QuickInfo      : 'Relevance for Account Assignment'
      ConditionAcctAssgmtRelevance   :      String(1) not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Matrix Maintenance'
      @Common.Heading        : 'MM'
      @Common.QuickInfo      : 'Indicator: Matrix Maintenance'
      ConditionMatrixMaintRelevance  :      String(1) not null;

      @Common.Label          : 'Form. ID in Document'
      @Common.Heading        : 'Formula. ID in Document'
      @Common.QuickInfo      : 'Identifier of CPF Formula in Document'
      ConfigblParametersAndFormulas  :      UUID;

      @Measures.Unit         : ConditionQuantityUnit
      @Common.Label          : 'Adjusted Qty.'
      @Common.Heading        : 'Adj. Qty.'
      @Common.QuickInfo      : 'Adjusted Quantity'
      ConditionAdjustedQuantity      :      Decimal(31, 14) not null;

      @Common.Label          : 'Description'
      ConditionTypeName              :      String(30) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Unit'
      @Common.Heading        : 'Unit'
      @Common.QuickInfo      : 'Condition Unit (Currency, Sales Unit, or %)'
      ConditionBaseValueIntlUnit     :      String(5) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Unit'
      @Common.Heading        : 'Unit'
      @Common.QuickInfo      : 'Condition Unit (Currency, Sales Unit, or %)'
      ConditionBaseValueUnit         :      String(5) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Unit'
      @Common.Heading        : 'Unit'
      @Common.QuickInfo      : 'Condition Unit (Currency, Sales Unit, or %)'
      ConditionRateValueIntlUnit     :      String(5) not null;

      @Core.Computed         : true
      @Common.Label          : 'Condition Unit'
      @Common.Heading        : 'Unit'
      @Common.QuickInfo      : 'Condition Unit (Currency, Sales Unit, or %)'
      ConditionRateValueUnit         :      String(5) not null;

      @Common.Label          : 'Tax Code Description'
      TaxCodeName                    :      String(50) not null;
      ConditionIsDeletable           :      Boolean not null;

      @Common.IsUpperCase    : true
      @Common.Label          : 'Procedure'
      @Common.Heading        : 'Proc.'
      @Common.QuickInfo      : 'Procedure (Pricing, Output Control, Acct. Det., Costing,...)'
      PricingProcedure               :      String(6) not null;
      SuperordinateDocument          :      String(32) not null;
      SuperordinateDocumentItem      :      String(70) not null;
      SAP__Messages                  : many CE_PURCHASEORDER_0001.SAP__Message not null;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrder                 :      Association to one CE_PURCHASEORDER_0001.PurchaseOrder
                                              on _PurchaseOrder.PurchaseOrder = PurchaseOrder;

      @cds.ambiguous         : 'missing on condition?'
      _PurchaseOrderItem             :      Association to one CE_PURCHASEORDER_0001.PurchaseOrderItem
                                              on _PurchaseOrderItem.PurchaseOrderItem = PurchaseOrderItem;
};
