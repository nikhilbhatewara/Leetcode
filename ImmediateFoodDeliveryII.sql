# Write your MySQL query statement below
/*
Find first order of all customers
Find categorize the first orders as scheduled/immediate
Find % of first orders which are immediate
*/


with orders as (
select *,dense_rank() over(partition by customer_id order by order_date) orderrank
from delivery
)

, ordertypes as (
select *,case when order_date = customer_pref_delivery_date then "immediate" else "schedule" end as ordertype 
from orders
where orderrank = 1
)

select 
round(
    100 *
    (
        sum(case when ordertype = "immediate" then 1 else 0 end)/count(*)
    )
    ,2) as immediate_percentage
from ordertypes

-- better approach

SELECT
    ROUND(100*SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1
    ELSE 0 END)/ COUNT(distinct customer_id) ,2) AS immediate_percentage
FROM
    Delivery
WHERE
    (customer_id, order_date)
IN
(SELECT
    customer_id, min(order_date) as min_date
FROM
    Delivery
GROUP BY
    customer_id
);
