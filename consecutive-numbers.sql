# Since these are consecutive numbers, the difference between the ids should be 1 
# Hence we check if the next id has the same number or not 2 times 

select distinct a.num as ConsecutiveNums
from logs a
inner join logs b
on a.id + 1 = b.id and a.num = b.num
inner join logs c
on b.id + 1 = c.id and b.num = c.num





with cte1 as 

(

SELECT l1.id,l1.num as cnum,l1.num - l2.num as diff

FROM Logs l1
join Logs l2

on l1.id + 1 = l2.id

)
select distinct cnum
from cte1

where diff = 0

group by cnum

having count(cnum) > 1
