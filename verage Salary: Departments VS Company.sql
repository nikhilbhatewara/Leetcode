# Write your MySQL query statement below

/*
For each month , calculate average salary for company
For each month for each department calculate average salary
use case statement for comparision


*/

with emp as 
(
select date_format(pay_date,"%Y-%m") as pay_month, id,a.employee_id,amount,department_id
from salary a
 join employee b
 on a.employee_id = b.employee_id
)


, avg_salaries as
(
select pay_month,
    department_id, 
avg(amount) over(partition by pay_month) as avg_company_salary,
avg(amount) over(partition by pay_month,department_id) as avg_dept_salary
from emp
)


select pay_month,department_id, 
case when avg_dept_salary > avg_company_salary then "higher"
 when avg_dept_salary < avg_company_salary then "lower"
 else "same" end as comparison
 from avg_salaries
 group by pay_month,department_id
 order by pay_month desc


