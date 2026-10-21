@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View Entity For Order'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_ORDER_JP
  as select from zorder_jp

{

  key order_id              as OrderId,
      customer_name         as CustomerName,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      amount                as Amount,
      currency_code         as CurrencyCode,
      status                as Status,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
