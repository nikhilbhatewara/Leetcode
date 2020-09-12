# Write your MySQL query statement below


select email from 
(

select email,count(email) as counts
from person
group by email
    ) as T
    where counts > 1
