select b.unique_id,a.name
from employees a
left join employeeUNI b
on a.id = b.id
