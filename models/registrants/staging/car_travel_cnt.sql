with car_travel_cnt as
(
SELECT tr.acct_id, /* tr.evt_stub,*/ tr.invitee_stub,  count(1) car_travel_cnt
      FROM DWH_UDL.UDL.VW_CVII_TRAVEL_RESERVATION_NA  tr 
               JOIN DWH_UDL.UDL.VW_CVII_CAR_RESERVATION_DETAIL_NA  crd 
                    on tr.acct_id = crd.acct_id and tr.trvl_rsvn_stub = crd.trvl_rsvn_stub
      where tr.trvl_rsvn_canceled_flag = 0
        and crd.car_rsvn_dtl_canceled_flag = 0
              group by tr.acct_id, tr.invitee_stub
) select * from car_travel_cnt