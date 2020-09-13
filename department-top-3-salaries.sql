# Write your MySQL query statement below

-- never name the rank results as rank since rank is mysql reserve word
-- department can be null

select Department,Employee,Salary
from 
(

select e.id,e.name as Employee,e.Salary, e.Departmentid, d.Name as Department, dense_rank() over (  partition by d.Name order by e.Salary desc  )  my_rank
from employee e
left join department d
on e.DepartmentId = d.Id
where d.Id is not null
) as T
where my_rank <= 3

