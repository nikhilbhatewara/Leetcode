# Write your MySQL query statement below

/*
For each product find the most recent order
join the output from above to product table
*/

with recent_orders as 
(
select product_id,order_id,order_date,dense_rank() over(partition by product_id order by order_date desc) orderrank
from orders
)


select a.product_name , a.product_id , b.order_id , b.order_date
from products a
join recent_orders b
on a.product_id = b.product_id
where b.orderrank = 1
order by a.product_name , a.product_id , b.order_id

--better approach

select b.product_name, a.product_id, a.order_id, a.order_date from Orders a
join Products b
on a.product_id = b.product_id
where (a.product_id, a.order_date) in (
select product_id, max(order_date) as order_date
from Orders
group by product_id)
order by b.product_name, a.product_id, a.order_id
