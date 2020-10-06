/* Write your T-SQL query statement below */
/*
Since bonus could be null, if we just use the first condition of bonus < 1000 then null will get exluded from results, hence use bonus is null
or ifnull(bonus,0) < 1000
*/

select a.name,b.bonus
from employee a
left join bonus b
on a.empId = b.empId
where b.bonus < 1000 or b.bonus is null
;
