with attendee_entity as
(
Select  acct_id,evt_stub,entity_stub,prod_stub from  DWH_UDL.UDL.CVII_ATTENDEE_ENTITY_NA where prod_type_id = 10  group by acct_id,evt_stub,entity_stub,prod_stub
) Select * from attendee_entity