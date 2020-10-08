# Write your MySQL query statement below


/*
1. Find first year of every product id sold .. min year
2. filter the sales table for each product id and first year sold


*/



with firstyearCTE as 
(
select product_id,min(year) as firstyear
    from sales
    group by product_id

)



select s.product_id, s.year as first_year, s.quantity,s.price
from sales s
inner join firstyearCTE f
on s.product_id = f.product_id and s.year = f.firstyear;
