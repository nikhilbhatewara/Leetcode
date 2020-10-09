with cte as (
select s.product_id,p.product_name,s.sale_date
from sales s
left join product p
on s.product_id = p.product_id
   
)


select product_id,product_name
from cte 
group by product_id,product_name
having min(sale_date) >= "2019-01-01" and max(sale_date) <= "2019-03-31";
