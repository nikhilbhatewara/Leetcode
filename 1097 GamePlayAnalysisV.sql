SELECT install_dt, COUNT(player_id) AS installs,
ROUND(COUNT(next_day) / COUNT(player_id), 2) AS Day1_retention
FROM (
    SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day
    FROM
    (
        SELECT player_id, MIN(event_date) AS install_dt 
        FROM Activity
        GROUP BY player_id
    ) AS a1 
    LEFT JOIN Activity AS a2
    ON a1.player_id = a2.player_id
    AND a2.event_date = a1.install_dt + 1
) AS t
GROUP BY install_dt;







-- another approach

select A.event_date as install_dt, count(A.player_id) as installs, round(count(B.player_id)/count(A.player_id),2) as Day1_retention
from (select player_id, min(event_date) AS event_date from Activity group by player_id) AS A
left join Activity B
ON A.player_id = B.player_id
and A.event_date + 1 = B.event_Date
group by A.event_date

-- my approach

/*
For each user find first login day (min event_date)
For each first login day, count no of users(group by)
For each login day, find no of users who logged in on day1(left join with activity table based of datediff = 1, then group by and count)
Compute the ratio
*/


with firstloginCTE as
(
SELECT player_id,min(event_date) as first_login
FROM Activity
group by player_id
)

,totalPlayersday0 as
(
  
  
  select first_login,count(*) as day0_count
  from firstloginCTE
  group by first_login
)


,loginday1 as 
(
  select a.first_login,a.player_id,count(ifnull(b.player_id,0)) as day1_count
  from firstloginCTE a
  left join Activity b
  on datediff(b.event_date,a.first_login) = 1 and a.player_id = b.player_id
group by a.first_login,a.player_id
)
  
select distinct a.first_login,a.day0_count as installs , round(b.day1_count/a.day0_count,2) as Day1_retention
from  totalPlayersday0 a
join loginday1 b
on a.first_login = b.first_login

  
  
  
  
  
