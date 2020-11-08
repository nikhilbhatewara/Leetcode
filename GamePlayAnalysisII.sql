SELECT a.player_id,a.device_id
FROM Activity a
join 
( select player_id, min(event_date) as firstlogindate
 from Activity
 group by player_id
 ) as b
where a.player_id = b.player_id and a.event_date = b.firstlogindate
