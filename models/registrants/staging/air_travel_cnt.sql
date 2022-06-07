with air_travel_cnt as
(SELECT tr.acct_id, tr.invitee_stub, ard.entity_stub,  count(1) air_travel_cnt
      FROM DWH_UDL.UDL.VW_CVII_TRAVEL_RESERVATION_NA  tr 
               JOIN DWH_UDL.UDL.VW_CVII_AIR_RESERVATION_DETAIL_NA  ard 
                    on tr.acct_id = ard.acct_id and tr.trvl_rsvn_stub = ard.trvl_rsvn_stub
      where tr.trvl_rsvn_canceled_flag = 0
        and ard.air_rsvn_dtl_canceled_flag = 0
      group by tr.acct_id, tr.invitee_stub, ard.entity_stub) select * from air_travel_cnt