
/*
 	   | 1 | 2.name
1.name | 2 | 3.name
2.name | 3 | 4.name
3.name | 4 | 5.name
4.name | 5 | 

For every odd number do a next name
for every even number do a prev name

*/

with details as (
SELECT id ,student,
lead(student,1,0) over() as next_value,
lag(student, 1,0) over() as prev_value
FROM seat
 )
 
 
 
 select id,
 case when id % 2 != 0 and id != counts  then next_value 
 when id % 2 != 0 and  id = counts then student
 else prev_value end as student
 from details, (select count(*) as counts from details) as scounts


-- alternate way

# MYSQL Query Accepted
SELECT ( CASE
            WHEN id%2 != 0 AND id != counts THEN id+1
            WHEN id%2 != 0 AND id = counts THEN id
            ELSE id-1
        END) AS id, student
FROM seat, (select count(*) as counts from seat) 
AS seat_counts
ORDER BY id ASC

