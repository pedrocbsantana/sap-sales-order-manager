@EndUserText.label: 'Sales Order'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_ORDER_JP
  provider contract transactional_query
  as projection on ZI_ORDER_JP
{
  @UI.facet: [
    {
      id: 'OrderInfo',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Order Information',
      position: 10
    }
  ]

  @EndUserText.label: 'Order ID'
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key OrderId,

  @EndUserText.label: 'Customer Name'
  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  CustomerName,

  @EndUserText.label: 'Amount'
  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  @Semantics.amount.currencyCode: 'CurrencyCode'
  Amount,

  @EndUserText.label: 'Currency'
  @UI.identification: [{ position: 40 }]
  CurrencyCode,

  @EndUserText.label: 'Status'
  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 50 }]
  Status,

  CreatedAt,
  LastChangedAt,
  LocalLastChangedAt
}
