with cont_type_name as(
Select distinct acct_id,cont_type_stub,cont_type_name from DWH_UDL.UDL.VW_CVII_CONTACT_TYPE
) select * from cont_type_name