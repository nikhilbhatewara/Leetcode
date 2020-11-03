# Write your MySQL query statement below
select  a.customer_id
from Customer a
join product b
on a.product_key = b.product_key
group by a.customer_id
having count(distinct a.product_key) = (

    select count(*) from product

 )
