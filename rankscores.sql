# Write your MySQL query statement below
select d.score, c.rank
from scores d left join (select b.score, 
				(select count(*) 
				from (select distinct score from scores) as a 
				where a.score >= b.score) as rank
			from (select distinct score from scores) as b
			order by b.score desc) as c
    on c.score = d.score
order by 1 desc


-- Use dense rank to avoid gaps

select score,myrank  as `rank`
from
(

SELECT id,score,dense_rank() over(order by score desc) as myrank
FROM Scores
) as t
order by myrank 
