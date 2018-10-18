# Write your MySQL query statement below


select Department, emp.Name as Employee, emp.Salary
from employee emp inner join (select Did,Max(Salary) as Salary, Department
from (select e.Name as Employee,e.Salary as Salary,d.Name as Department,d.Id as DId
from employee e left outer join department d on e.DepartmentId = d.Id) as temp
group by Did) as temp1 on emp.DepartmentId = temp1.Did and emp.Salary=temp1.Salary
