with hotel_travel_cnt as (
SELECT tr.acct_id,
             tr.evt_stub,
             hrd.entity_stub,
             tr.invitee_stub,
             hrd.entity_type_id,
              count(1) hotel_travel_cnt,
              'H' travel_type
      FROM DWH_UDL.UDL.VW_CVII_TRAVEL_RESERVATION_NA  tr  
               JOIN DWH_UDL.UDL.VW_CVII_HOTEL_RESERVATION_DETAIL_NA  hrd 
                    on tr.acct_id = hrd.acct_id and tr.evt_stub = hrd.evt_stub and
                       tr.trvl_rsvn_stub = hrd.trvl_rsvn_stub
      where tr.trvl_rsvn_canceled_flag = 0
        and hrd.htl_rsvn_dtl_canceled_flag = 0
      group by tr.acct_id, tr.evt_stub, tr.invitee_stub, hrd.entity_stub, hrd.entity_type_id
) select * from hotel_travel_cnt