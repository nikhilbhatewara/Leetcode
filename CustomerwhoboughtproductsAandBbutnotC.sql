# Write your MySQL query statement below


# Find customers who have not bought C



# Find customers from above population who has bought both A and B
with a_b as 
(

select customer_id,
sum(
case when product_name = "A" then 1 
 when product_name = "B" then 1 
else 0 end) as count_a_b 
from orders
where customer_id not in (
                        select customer_id
                            from orders
                            where product_name = "C"

)
    
    
group by customer_id
)


select T1.customer_id,T2.customer_name
from a_b T1
join customers T2
on T1.customer_id = T2.customer_id
where T1.count_a_b = 2


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








