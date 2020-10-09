select seller_id
from 
(
   
select seller_id,  dense_rank() over (order by sum(price) desc) bestseller
from sales
group by seller_id

) as temp
where bestseller = 1;

