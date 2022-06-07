
{{config(materialized='table')}}
with discount_name_list as 
(
    SELECT acct_id,invitee_stub,entity_stub, listagg(DISTINCT dscnt_code,',')discount_code_list,listagg( DISTINCT discount_name_list,',') discount_name_list
FROM
(
select   b.acct_id,b.invitee_stub,bda.entity_stub,d.dscnt_code,D.dscnt_name discount_name_list
                                                       from DWH_UDL.UDL.BASKET_NA  b 
                                                                 join DWH_UDL.UDL.BASKET_DISCOUNT_NA bd 
                                                                     on bd.acct_id = b.acct_id and bd.bskt_stub = b.bskt_stub
                                                                 join DWH_UDL.UDL.DISCOUNT_NA d
                                                                     on bd.acct_id = d.acct_id AND
                                                                        d.evt_stub = b.evt_stub and
                                                                        bd.bskt_dscnt_stub = d.dscnt_stub
                                                                 join DWH_UDL.UDL.BASKET_DISCOUNT_ATTENDEE_NA bda 
                                                                     on bda.acct_id = bd.acct_id and
                                                                        bda.bskt_stub = bd.bskt_stub AND
                                                                        bda.bskt_dscnt_stub = bd.bskt_dscnt_stub
                                                       where b.canceled_flag = 0 and bda.entity_type_id = 3 -- INVITEE
                                                       UNION ALL
                                                       select b.acct_id,b.invitee_stub,bda.entity_stub,d.dscnt_code,D.dscnt_name
                                                       from DWH_UDL.UDL.BASKET_NA b 
                                                                join DWH_UDL.UDL.BASKET_DISCOUNT_NA bd 
                                                                     on bd.acct_id = b.acct_id and bd.bskt_stub = b.bskt_stub
                                                                join DWH_UDL.UDL.ACCOUNT_DISCOUNT_NA d
                                                                     on bd.acct_id = d.acct_id and bd.bskt_dscnt_stub = d.acct_dscnt_stub
                                                                join DWH_UDL.UDL.BASKET_DISCOUNT_ATTENDEE_NA bda 
                                                                     on bda.acct_id = bd.acct_id and
                                                                        bda.bskt_stub = bd.bskt_stub AND
                                                                        bda.bskt_dscnt_stub = bd.bskt_dscnt_stub
                                                       where b.canceled_flag = 0
                                                     and bda.entity_type_id = 3 -- INVITEE
                                  ) ABC
                                 GROUP BY acct_id,invitee_stub,entity_stub
                                 ) Select * from discount_name_list