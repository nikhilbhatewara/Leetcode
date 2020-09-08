# Since these are consecutive numbers, the difference between the ids should be 1 
# Hence we check if the next id has the same number or not 2 times 

select distinct a.num as ConsecutiveNums
from logs a
inner join logs b
on a.id + 1 = b.id and a.num = b.num
inner join logs c
on b.id + 1 = c.id and b.num = c.num


