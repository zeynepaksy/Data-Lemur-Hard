/* Write a query to update the Facebook advertiser's status using the daily_pay table. Advertiser is a two-column table containing the user id and their payment status based on the last payment and daily_pay table has current information about their payment. Only advertisers who paid will show up in this table.

Output the user id and current payment status sorted by the user id.

Link: https://datalemur.com/questions/updated-status */

My Answer:

WITH PS AS 
(
SELECT A.user_id, A.status, D.paid
FROM advertiser A
LEFT JOIN daily_pay D on A.user_id=D.user_id

UNION

SELECT D.user_id, A.status, D.paid
FROM daily_pay D
LEFT JOIN advertiser A on A.user_id=D.user_id
)

SELECT user_id, 
CASE WHEN paid is null then 'CHURN'
     WHEN status!='CHURN' and paid is not null then 'EXISTING'
     WHEN status='CHURN' and paid is not null then 'RESURRECT'
     WHEN status is null then 'NEW'
  END AS new_status
FROM PS
ORDER BY user_id
     

