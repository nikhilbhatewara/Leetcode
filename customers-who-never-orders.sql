# Write your MySQL query statement below
SELECT  name as Customers
from customers c
left join orders o
on c.id = o.CustomerId 
where o.CustomerId is Null
