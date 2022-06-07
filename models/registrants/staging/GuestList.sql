with GuestList
as
(
    SELECT acct_id,
             evt_stub,
             invitee_stub,listagg( concat(free_first_name ,
                                                                                  case
                                                                                      when free_first_name > '' then ' '
                                                                                      else '' end , free_last_name 
                                                                                 ),',') GuestList,
              count(1) guest_count,
               sum(free_participant_flag) participant_guest,
              SUM(case free_participant_flag when 0 THEN 1 ELSE 0 END) no_show_guest
      FROM DWH_UDL.UDL.VW_CVII_FREELOADER  
--   WHERE INVITEE_STUB ='98E3518B-E831-41C7-A052-98C01F5EBD88'
      GROUP BY acct_id, evt_stub, invitee_stub
) Select * from GuestList