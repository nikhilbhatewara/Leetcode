# Write your MySQL query statement below

/*
1. Join tables to bring item_brand and favorite brand
2.  left join to users so that we retain all users
3. For sellers from step 2, since no seller sold more than 1 item a day; sort by date and take the send value. => use dense rank 
Since there could be users who did not sell, use a union to include those sellers as well
4. check if item_brand is equal to favorite brand => case statement
5. return yes/no
*/

with CTE as (
select u.user_id,u.favorite_brand, o.order_date,o.seller_id,o.item_id,i.item_brand
from users u
left join orders o
on u.user_id = o.seller_id
left join items i
on o.item_id = i.item_id
order by u.user_id, o.order_date
    ),
    
rankCTE as 
(
select *, dense_rank() over(partition by user_id order by order_date asc) orderrank
from CTE
    
)


,


itemCTE as
(
    # When sold 2 times, create a flag to identify if item is the second item sold or not 
select user_id,item_brand,favorite_brand,"yes" as flag
from rankCTE
where orderrank = 2

    union
    
    # when sold 0 time
select user_id,item_brand,favorite_brand,"no" as flag 
from rankCTE
where orderrank = 1 and seller_id is null    
    
    union
    
# sold 1 item
select user_id,item_brand,favorite_brand,"no" as flag
from rankCTE
where orderrank < 2 and seller_id is not null   
    
    )
    
    # only for second item sold, check if item_brank = favorite brand
select user_id as seller_id, case when flag = "yes" and item_brand = favorite_brand then "yes" else "no" end as 2nd_item_fav_brand
from itemCTE
group by user_id
order by user_id;


-- better solution


select user_id as seller_id, 
        (case 
            when favorite_brand = (
                            select i.item_brand
                            from Orders o left join Items i
                            on o.item_id = i.item_id
                            where o.seller_id = u.user_id 
                            order by o.order_date
                            limit 1 offset 1
                                  ) then "yes" else "no" end
         ) as "2nd_item_fav_brand"   
from Users u   
