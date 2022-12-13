/*This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below containing information on user transactions for particular products. Write a query to obtain the year-on-year growth rate for the total spend of each product for each year.

Output the year (in ascending order) partitioned by product id, current year's spend, previous year's spend and year-on-year growth rate (percentage rounded to 2 decimal places).

Link: https://datalemur.com/questions/yoy-growth-rate

*/

-- My Answer

WITH qry1 as
(
SELECT extract(year from transaction_date) as year,product_id,spend as curr_year_spend, 
lag(spend,1) over(partition by product_id order by transaction_date) as prev_year_spend
FROM user_transactions
)
select year, product_id, curr_year_spend, prev_year_spend, 
round(100*(curr_year_spend-prev_year_spend)/prev_year_spend,2)
from qry1
