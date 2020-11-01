# Write your MySQL query statement below

with details as 
(

SELECT    a.customer_id,
c.name,
MONTH(a.order_date)as orderMonth,
year(a.order_date) as orderYear,
(a.quantity * b.price)   as ordertotal  
from orders a
join product b
on a.product_id = b.product_id
join customers c
on a.customer_id = c.customer_id
)

, result as 
(
select customer_id,name,orderYear,orderMonth,sum(ordertotal) as totals
from details 
group by customer_id,name,orderYear,orderMonth
)



select distinct customer_id,name
from result
where orderYear = "2020" and orderMonth = 6 and totals >= 100 and customer_id in (

select distinct customer_id
from result
where orderYear = "2020" and orderMonth = 7 and totals >= 100


)


-- faster approach


# Write your MySQL query statement below

with details as 
(

SELECT    a.customer_id,
c.name,
MONTH(a.order_date)as orderMonth,
year(a.order_date) as orderYear,
(a.quantity * b.price)   as ordertotal  
from orders a
join product b
on a.product_id = b.product_id
join customers c
on a.customer_id = c.customer_id
)

, result as 
(
select customer_id,name, 
    SUM( CASE WHEN orderMonth = "6" then ordertotal else 0 end ) as JuneTotal,
    SUM( CASE WHEN orderMonth = "7" then ordertotal else 0 end ) as JulyTotal
    
from details 
where orderYear = "2020"
group by customer_id,name
)



select distinct customer_id,name
from result
where JuneTotal >= 100 and JulyTotal >= 100


-- MORE FAST

with details as 
(

SELECT    
a.customer_id,
c.name,
SUM(CASE WHEN MONTH(a.order_date) = "6" AND year(a.order_date) = "2020" THEN a.quantity * b.price ELSE 0 END ) AS JuneTotal,
SUM(CASE WHEN MONTH(a.order_date) = "7" AND year(a.order_date) = "2020" THEN a.quantity * b.price ELSE 0 END ) AS JuLYTotal  
from orders a
join product b
on a.product_id = b.product_id
join customers c
on a.customer_id = c.customer_id
GROUP BY 
a.customer_id,
c.name
)

select distinct customer_id,name
from details
where JuneTotal >= 100 and JulyTotal >= 100
