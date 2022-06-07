with transaction_count as
(
select j.acct_id,
             --j.evt_stub,
             j.invitee_stub,
              sum(case j.jrn_entry_type_id
                                         when 2 then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         else 0.00 end) online_payment,
              sum(case j.jrn_entry_type_id
                                         when 4 then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         else 0.00 end) offline_payment,
              sum(case j.jrn_entry_type_id
                                         when 3 then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         else 0.00 end) online_refund,
              sum(case j.jrn_entry_type_id
                                         when 5 then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         else 0.00 end) offline_refund,
              sum(case
                                         when j.jrn_entry_type_id in (2, 4) then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         when j.jrn_entry_type_id in (3, 5) then -1 * IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                         else 0.00
                 end) amount_paid,
              sum(case
                                         when IFNULL(p.prod_type_id, 0) = 60 then case
                                                                                      when j.jrn_entry_type_id in (2, 4)
                                                                                          then IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                                                                      when j.jrn_entry_type_id in (3, 5)
                                                                                          then -1 * IFNULL(bdj.bskt_dtl_jrn_amt, 0.00)
                                                                                      else 0.00
                                             end
                                         else 0.00 end) tax_paid,
             count(DISTINCT (j.jrn_stub)) transaction_count
      from DWH_UDL.UDL.VW_CVII_JOURNAL_NA  j 
               left join DWH_UDL.UDL.JOURNAL_DETAIL_NA jd 
                         ON jd.acct_id = j.acct_id and jd.jrn_stub = j.jrn_stub
               join DWH_UDL.UDL.VW_CVII_BASKET_DETAIL_JOURNAL_NA  bdj 
                    ON j.acct_id = bdj.acct_id AND j.jrn_stub = bdj.jrn_stub
               join DWH_UDL.UDL.VW_CVII_BASKET_DETAIL  bd 
                    ON bd.acct_id = bdj.acct_id AND bd.bskt_dtl_stub = bdj.bskt_dtl_stub
               join DWH_UDL.UDL.CVII_PRODUCT_NA  p 
                    ON bd.acct_id = p.acct_id and bd.bskt_dtl_prod_stub = p.prod_stub
      where jd.jrn_dtl_cc_success_flag = 1
      GROUP by j.acct_id, /* j.evt_stub,*/ j.invitee_stub
) select * from transaction_count