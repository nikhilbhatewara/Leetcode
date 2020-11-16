# Write your MySQL query statement below
select  a.customer_id
from Customer a
join product b
on a.product_key = b.product_key
group by a.customer_id
having count(distinct a.product_key) = (

    select count(*) from product

 )

-- can be done without joining

/*
count the no of distinct product in product table 
for each custoemr count the no of distinct products they have purchased
filter table
*/



select customer_id
from Customer 
group by customer_id
having count(distinct product_key) in (

SELECT count(distinct product_key) as pcount
FROM Product
  
  )
