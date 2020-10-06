/* Write your T-SQL query statement below */


/*

1. Find the number of order for each customer
2. Find the customer number with maximum no of order
*/

-- Takes 953 ms
with orderCTE as
(
select customer_number, count(order_number) as num_orders
from orders
group by customer_number
) 

select customer_number
from orderCTE 
where num_orders = (select max(num_orders) from orderCTE);

/*
-- takes 1073 ms
select customer_number
from (
select customer_number,
dense_rank() over (order by count(order_number) desc) as r
from orders
group by customer_number
)t
where r=1
*/
