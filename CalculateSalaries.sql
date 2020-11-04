# Write your MySQL query statement below

with maxsal as 
(

select company_id, case when max(salary) < 1000 then "0per"
    when max(salary) between 1000 and 10000 then "24per"
    else "49per" end as taxbracket 
    from salaries
    group by company_id
)


select a.company_id,a.employee_id,a.employee_name,
round(
case when b.taxbracket = "24per" then (a.salary - a.salary*(0.24))
when b.taxbracket = "49per" then (a.salary - a.salary*(0.49))
else a.salary end) as salary
from salaries a
join maxsal b
on a.company_id = b.company_id
