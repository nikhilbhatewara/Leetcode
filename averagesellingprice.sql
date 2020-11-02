# Write your MySQL query statement below
with cte1 as 
(
select a.product_id,a.purchase_date,a.units,(a.units * b.price) as unittotal
from UnitsSold a
join Prices b
on a.product_id = b.product_id 
and a.purchase_date between b.start_date and b.end_date
)

, totalstable as (
select product_id, sum(units) as unitsold, sum(unittotal )as producttotal
from cte1
group by product_id
)

select product_id, round(producttotal/unitsold,2) as average_price
from totalstable
order by product_id


-- better approach
# Write your MySQL query statement below
SELECT a.product_id,ROUND(SUM(b.units*a.price)/SUM(b.units),2) as average_price
FROM Prices as a
JOIN UnitsSold as b
ON a.product_id=b.product_id AND (b.purchase_date BETWEEN a.start_date AND a.end_date)
GROUP BY product_id;
