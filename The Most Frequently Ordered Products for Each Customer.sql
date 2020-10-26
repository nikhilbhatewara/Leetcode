
with freq_orders as 
(
select customer_id,product_id,dense_rank() over(partition by customer_id order by count(product_id) desc) productrank
from orders
group by customer_id,product_id
)

select a.customer_id, b.product_id, b.product_name  
from freq_orders a
join products b
on a.product_id = b.product_id
where a.productrank = 1

