# Write your MySQL query statement below

/*

1. create 2 tables, one for transaction count and one for approved count
*/


with CTE1 as (
select date_format(trans_date,"%Y-%m") as month,country,count(*) as trans_count,
sum(amount) as trans_total_amount
from transactions
group by date_format(trans_date,"%y-%m"),country
)


, CTE2 as (

select date_format(trans_date,"%Y-%m") as month,country,count(*) as approved_count,
sum(amount) as approved_total_amount
from transactions
where state= "approved"
group by date_format(trans_date,"%y-%m"),country

)

select a.*,ifnull(b.approved_count,0) approved_count,ifnull(b.approved_total_amount,0) approved_total_amount
from CTE1 a
left join CTE2 b
on a.month = b.month and a.country = b.country;

-- better approach
SELECT 
LEFT(trans_date, 7) AS month, country, 
COUNT(id) AS trans_count, 
SUM(state = 'approved') AS approved_count, 
SUM(amount) AS trans_total_amount, 
SUM(CASE 
    WHEN state = 'approved' THEN amount 
    ELSE 0 
    END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
