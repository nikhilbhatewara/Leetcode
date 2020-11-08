select distinct s1.id as id,s1.date as date, s1.people as people
from stadium s1,stadium s2, stadium s3
where s1.people > 99 and s2.people > 99 and s3.people > 99 and ((s1.id = s2.id - 1 and s2.id = s3.id -1) or (s2.id = s1.id - 1 and s2.id = s3.id - 2) or (s1.id = s3.id + 2 and s2.id = s3.id + 1))
order by s1.id;

-- another approach

with details as 
(
select id,visit_date,people,datediff( nextdate,visit_date) as day1,datediff( nextnextdate,nextdate) as day2
from
(

SELECT id,visit_date,people,lead(visit_date,1) over() as nextdate,lead(visit_date,2) over() as nextnextdate
FROM stadium
where people > 100
) as T 
)

select id,visit_date,people
from details
where (day1 = 1 or day1 is Null) and (day2 = 1 or day2 is null)
