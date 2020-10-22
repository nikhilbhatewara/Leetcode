with CTE1 as (
select session_id,
case when duration/60 < 5 then "[0-5>" 

when duration/60 >= 5  and  duration/60 < 10 then "[5-10>" 

when duration/60 >= 10  and  duration/60 < 15 then "[10-15>" 

when duration/60 >= 15 then "15 or more" end as bin

from sessions

)

,CTE2 as 
(
select "[0-5>" as bin
    union 
select "[5-10>" as bin
    union 

select "[10-15>" as bin
    union 

select "15 or more" as bin
)



select a.bin,ifnull(count(b.bin),0) as total
from CTE2 a
left join CTE1 b
on a.bin = b.bin
group by a.bin

