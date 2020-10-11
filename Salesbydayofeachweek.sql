# Write your MySQL query statement below


/*

1. join table to get category name
Since we want all categories irrespective of weather there was a sale or not, join orders to item and not vice versa
2. get day of week from order date 
3. use case statement to get total quantity based on day of week




*/

# day of week starts from sunday 
with CTE as 
(
select o.order_date, i.item_id,o.quantity, i.item_category,dayofweek(o.order_date) as dayofweek
from items i 
left join orders o
on i.item_id = o.item_id 
    )
    
    
select item_category as CATEGORY, sum(case when dayofweek = 2 then quantity else 0 end) as "MONDAY",
sum(case when dayofweek = 3 then quantity else 0 end) as "TUESDAY",
sum(case when dayofweek = 4 then quantity else 0 end) as "WEDNESDAY",
sum(case when dayofweek = 5 then quantity else 0 end) as "THURSDAY",
sum(case when dayofweek = 6 then quantity else 0 end) as "FRIDAY",
sum(case when dayofweek = 7 then quantity else 0 end) as "SATURDAY",
sum(case when dayofweek = 1 then quantity else 0 end) as "SUNDAY"
from CTE
group by item_category
order by item_category;
