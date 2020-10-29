select name as warehouse_name, sum(units*width*length*height)as volume
from warehouse
left join products
on warehouse.product_id = products.product_id
group by name
