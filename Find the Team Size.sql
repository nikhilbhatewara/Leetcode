

with teamsize as 
(
select team_id, count(distinct employee_id) as team_size
    from employee
group by team_id

)

select employee_id,team_size
from employee a
join teamsize b
on a.team_id = b.team_id

-- better approach
select employee_id,count(*) over (partition by team_id) team_size
from employee

