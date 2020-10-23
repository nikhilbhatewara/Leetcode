
select customer_name,customer_id,order_id,order_date
from (



        select name as customer_name ,a.customer_id,order_id,order_date
        ,dense_rank() over(partition by customer_id order by order_date desc) as                recentorders
        from customers a
        join orders b
        on a.customer_id = b.customer_id
    
    ) as T
where recentorders < 4
order by customer_name,customer_id,order_date desc
