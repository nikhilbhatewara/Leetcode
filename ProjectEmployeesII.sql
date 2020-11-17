# Write your MySQL query statement below



select project_id
from 
(
select project_id,dense_rank() over (order by count(employee_id) desc)  emprank
from project
group by project_id
) as t
where emprank = 1;


-- 

select project_id
from Project p
left join Employee e
on p.employee_id = e.employee_id
group by project_id
order by count(p.employee_id) desc limit 1
;
