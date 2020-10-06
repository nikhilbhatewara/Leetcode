/* Write your T-SQL query statement below */

/*
Find the person who sold to company red
then output the persons who is not in first list that we we will exlude to person who sold it to company red atleast once
*/


with soldtoRED as (
select s.name
from salesperson s
left join orders o
on s.sales_id = o.sales_id
left join company c
on o.com_id = c.com_id 
where c.name = 'RED'
)

select name
from salesperson
where name not in (select name from soldtoRED)
;



