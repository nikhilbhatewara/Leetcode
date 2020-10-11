# Write your MySQL query statement below
/*
In order to get each team's tournament score, We have to calculate the total points they earned as host team as well as guest team. Thus, we need to create two temporary tables then UNION them.

For host team, create a new column that records the point each host team earned in that particular match using CASE statements.
For guest team, create a new column that records the point each guest team earned in that particular match using CASE statements.
Now, We can use UNION to join the two tables vertically. One column is team_id, the other is the points each team earned from every game as either host or guest team.
Join teams table with the SUB table we just created. Using LEFT JOIN because there are teams did not participate in any match and we want to include them in our result.
Finally, GROUP BY team_id and calculate the total points each team earned during the tournament; use IFNULL function and assign 0 point to teams did not participate in the tournament.

*/




with CTE as (
    

select team,sum(num_points) as num_points    
    from (
    
    
select host_team as team, sum(case when host_goals > guest_goals then 3
when host_goals = guest_goals then 1
when host_goals < guest_goals then 0 else 0 end) as num_points
from matches
group by host_team
    
union all
    
select guest_team as team, sum(case when guest_goals > host_goals then 3
when guest_goals = host_goals then 1
when guest_goals < host_goals then 0 else 0 end) as num_points
from matches
group by guest_team
    
) as T

group by team
)    


select team_id,team_name, ifnull(num_points,0) as num_points
from teams t
left join CTE c
on t.team_id = c.team
group by team_id
order by num_points desc,team_id;


-- Better solution

# Write your MySQL query statement below
SELECT team_id,team_name,
SUM(CASE WHEN team_id=host_team AND host_goals>guest_goals THEN 3 ELSE 0 END)+
SUM(CASE WHEN team_id=guest_team AND guest_goals>host_goals THEN 3 ELSE 0 END)+
SUM(CASE WHEN team_id=host_team AND host_goals=guest_goals THEN 1 ELSE 0 END)+
SUM(CASE WHEN team_id=guest_team AND guest_goals=host_goals THEN 1 ELSE 0 END)
as num_points
FROM Teams
LEFT JOIN Matches
ON team_id=host_team OR team_id=guest_team
GROUP BY team_id
ORDER BY num_points DESC, team_id ASC;



