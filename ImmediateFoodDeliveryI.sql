
select
round(
100 * count(delivery_id) / (select count(delivery_id) from delivery )
    ,2)  as immediate_percentage
from delivery
where order_date  = customer_pref_delivery_date;

-- oneliner
select round(100 * sum(order_date = customer_pref_delivery_date) / count(*), 2) as immediate_percentage from Delivery;
