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


-- another approach


select p.project_id, p.employee_id
from Project p
left join Employee e
on p.employee_id = e.employee_id
where e.experience_years = (select max(experience_years) from Employee)


