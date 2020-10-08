# Write your MySQL query statement below


with expCTE as (
select p.project_id,p.employee_id,e.experience_years, dense_rank() over (partition by project_id order by experience_years desc) as exprank
from project p
left join employee e
on p.employee_id = e.employee_id
    )
    
select project_id,employee_id
from expCTE 
where exprank = 1;
