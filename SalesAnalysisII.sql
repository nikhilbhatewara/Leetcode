# Write your MySQL query statement below



with cte as (
select s.buyer_id,p.product_name
from sales s
left join product p
on s.product_id = p.product_id
)


select distinct buyer_id
from cte 
where product_name = "S8" and buyer_id not in (select buyer_id from cte where product_name = 'iPhone');
