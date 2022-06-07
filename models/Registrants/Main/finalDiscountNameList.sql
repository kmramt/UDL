
-- {{config(materialized='table')}}
with finalDiscountNameList as 
(
 Select * from {{ref('discount_name_list')}}
) Select * from finalDiscountNameList limit 10