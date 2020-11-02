# Write your MySQL query statement below



select trim(lower(product_name)) as product_name,
DATE_FORMAT(sale_date,"%Y-%m") as sale_date,
count(*) as total
from sales
group by trim(lower(product_name)),DATE_FORMAT(sale_date,'%Y-%m')
order by product_name,sale_date
