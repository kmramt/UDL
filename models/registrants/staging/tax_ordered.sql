with tax_ordered as
( select b.acct_id,
             -- b.evt_stub,
             b.invitee_stub,
              sum(case
                                      when bd.bskt_dtl_jrn_entry_type_id in (2, 4) then IFNULL(bd.bskt_dtl_amt, 0.00)
                                      else 0 end) order_request,
              sum(case
                                      when bd.bskt_dtl_jrn_entry_type_id in (3, 5) then IFNULL(bd.bskt_dtl_amt, 0.00)
                                      else 0 end) refund_request,
              sum(case
                                      when p.prod_type_id = 60 then
                                          case
                                              when bd.bskt_dtl_jrn_entry_type_id in (2, 4)
                                                  then IFNULL(bd.bskt_dtl_amt, 0.00)
                                              when bd.bskt_dtl_jrn_entry_type_id in (3, 5)
                                                  then -1 * IFNULL(bd.bskt_dtl_amt, 0.00)
                                              else 0 end end) tax_ordered
      from DWH_UDL.UDL.BASKET_NA  b 
               join DWH_UDL.UDL.VW_CVII_BASKET_DETAIL bd 
                    on b.acct_id = bd.acct_id and b.bskt_stub = bd.bskt_stub
               join DWH_UDL.UDL.CVII_PRODUCT_NA  p 
                    on bd.acct_id = p.acct_id and bd.bskt_dtl_prod_stub = p.prod_stub
      where b.canceled_flag = 0
      GROUP BY b.acct_id, /* b.evt_stub,*/ b.invitee_stub
) Select * from tax_ordered