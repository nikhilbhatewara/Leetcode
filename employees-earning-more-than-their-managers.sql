# Write your MySQL query statement below


select a.name as Employee
from employee a
left join employee b
on a.ManagerId = b.Id
where a.Salary > b.Salary
