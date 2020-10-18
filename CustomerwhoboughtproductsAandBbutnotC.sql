
with a_b as 
(
select customer_id,
sum(
case when product_name = "A" then 1 
 when product_name = "B" then 1 
    when product_name = "C" then -1
else 0 end) as count_a_b 
from orders
    group by customer_id


)


select customer_id,customer_name
from customers
where customer_id in
(
select distinct customer_id
    from a_b
    where count_a_b = 2


)
    

-- simple approach

select distinct customer_id, customer_name
from Customers
where customer_id in
(
    select customer_id
    from Orders
    where product_name='A'
) and customer_id in
(
    select customer_id
    from Orders
    where product_name='B'
) and customer_id not in
(
    select customer_id
    from Orders
    where product_name='C'
) 








