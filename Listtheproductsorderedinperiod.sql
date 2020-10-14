# Write your MySQL query statement below

/*
1. compute total no of unis by each product, filter data for the month of february 2020

2. join the output from #1 to table products where total unites > 100

3. display product name and no of unit

*/


with allunits as 
(
select product_id,sum(unit) as totalunits
from orders
where year(order_date) = 2020 and month(order_date) = 02
group by product_id
)

select a.product_name, b.totalunits as unit
from products a
inner join allunits b
on a.product_id = b.product_id
and totalunits >= 100;

-- better approach
select product_name,sum(unit) as unit
from Products a
left join Orders b on a.product_id = b.product_id
where month(order_date) = 2 and year(order_date) = '2020'
group by a.product_id
Having unit >=100
