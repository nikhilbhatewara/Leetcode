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
