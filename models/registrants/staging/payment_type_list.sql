with payment_type_list as
(
 select  j.ACCT_ID ,j.INVITEE_STUB, listagg(DISTINCT pmnt_method_name ,',')payment_type_list
                                                  from DWH_UDL.UDL.VW_CVII_JOURNAL_NA  j 
                                                           join DWH_UDL.UDL.VW_CVII_LU_PAYMENT_METHOD_NA  l 
                                                                on j.pmnt_method_id = l.pmnt_method_id
                                                                GROUP BY j.ACCT_ID ,j.INVITEE_STUB
) Select * from payment_type_list