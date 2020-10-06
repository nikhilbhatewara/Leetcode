/* Write your T-SQL query statement below */

/*

FOR EACH PLAYER AND FOR EACH EVENT DATE CREATE A RUNNING TOTAL/CUMULATIVE SUM

over clause determines that sum should be calculated as a running total
partition by determines that running total should be calculated for each player by player id
*/



select player_id, event_date, sum(games_played) over ( partition by player_id order by player_id,event_date ) as games_played_so_far
from activity;
