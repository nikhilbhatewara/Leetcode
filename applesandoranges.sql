select sale_date, apples-oranges as diff
from 
(

select sale_date,
sum(case when fruit = "apples" then sold_num else 0 end) as "apples",
sum(case when fruit = "oranges" then sold_num else 0 end) as "oranges"
from sales
group by sale_date
) as T;

-- smart way


select sale_date, sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from sales
group by sale_date
