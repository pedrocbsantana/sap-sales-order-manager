CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.


    METHODS validateAmount FOR VALIDATE ON SAVE
       keys FOR Order~validateAmount.

ENDCLASS.

CLASS lhc_order IMPLEMENTATION.
  METHOD validateAmount.

    READ ENTITIES OF zi_order_jp IN LOCAL MODE
      ENTITY Order
      FIELDS ( Amount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_orders).

    LOOP AT lt_orders INTO DATA(ls_order).

      IF ls_order-Amount <= 0.
        APPEND VALUE #( %tky = ls_order-%tky )
    TO failed-order.
        APPEND VALUE #(
      %tky = ls_order-%tky
      %msg = new_message(
        id       = 'ZORDER_MSG_JP'
        number   = '001'
        severity = if_abap_behv_message=>severity-error
      )
      %element-Amount = if_abap_behv=>mk-on
    ) TO reported-order.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

