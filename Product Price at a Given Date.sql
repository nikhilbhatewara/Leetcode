# Write your MySQL query statement below


/*
1. if change date is 2019-8-16 then return price
2. first change data(min change) is > 2019-8-16 then price is 10
3. if max(change_date) is < 2019-8-16 then return pri e of max(change_date
*/

select product_id,10 as price
from products
group by product_id
having min(change_date) > "2019-08-16"

union


select product_id, new_price as price
from products
where (product_id,change_date) 
in (

select product_id, max(change_date)
from products
where change_date <= "2019-08-16"
group by product_id
)
