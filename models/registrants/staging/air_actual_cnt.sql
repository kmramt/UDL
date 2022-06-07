with air_actual_cnt as(
SELECT tr.acct_id,
                --tr.evt_stub,
                tr.invitee_stub,
                ara.entity_stub,
                count(1) as air_actual_cnt
         FROM DWH_UDL.UDL.VW_CVII_TRAVEL_RESERVATION_NA  tr 
                  INNER JOIN DWH_UDL.UDL.VW_CVII_AIR_RESERVATION_ACTUAL_NA  ara 
                             ON tr.acct_id = ara.acct_id AND tr.trvl_rsvn_stub = ara.trvl_rsvn_stub
                  INNER JOIN DWH_UDL.UDL.VW_CVII_AIR_RESERVATION_ACTUAL_DETAIL_NA  arad 
                             On ara.acct_id = arad.acct_id and ara.air_rsvn_actual_stub = arad.air_rsvn_actual_stub
         where tr.trvl_rsvn_canceled_flag = 0
           and arad.canceled_flag = 0
         GROUP BY tr.acct_id, /* tr.evt_stub,*/ tr.invitee_stub, ara.entity_stub
) Select * from air_actual_cnt