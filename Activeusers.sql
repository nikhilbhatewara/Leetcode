# Write your MySQL query statement below
/*

 self join on login date for 5 consecutive dates , use datediff with differences

*/


select  l1.id,a.name
from logins l1
join logins l2
on l1.id = l2.id and datediff(l1.login_date,l2.login_date) = 1

join logins l3
on l2.id = l3.id and datediff(l2.login_date,l3.login_date) = 1

join logins l4
on l3.id = l4.id and datediff(l3.login_date,l4.login_date) = 1

join logins l5
on l4.id = l5.id and datediff(l4.login_date,l5.login_date) = 1

join accounts a
on l1.id = a.id
group by l1.id
order by l1.id
;


---- Island and Gap problem ----


WITH temp0 AS 
( 
         SELECT   id, 
                  login_date, 
                  Dense_rank() OVER(partition BY id ORDER BY login_date) AS row_num 
         FROM     logins ) 

/*

{"headers": ["id", "login_date", "row_num"], 
 "values": 
 [[1, "2020-05-30", 1], 
 [1, "2020-06-07", 2], 
 [7, "2020-05-30", 1], 
 [7, "2020-05-31", 2], 
 [7, "2020-06-01", 3], 
 [7, "2020-06-02", 4], 
 [7, "2020-06-02", 4], 
 [7, "2020-06-03", 5], 
 [7, "2020-06-10", 6]]}


*/

, temp1 AS 

( 
       SELECT id, 
              login_date, 
              row_num, 
              date_add(login_date, interval -row_num day) AS groupings 
       FROM   temp0 )
/*


{"headers": ["id", "login_date", "row_num", "groupings"], 
 "values": 
 [[1, "2020-05-30", 1, "2020-05-29"], 
 [1, "2020-06-07", 2, "2020-06-05"], 
 [7, "2020-05-30", 1, "2020-05-29"], 
 [7, "2020-05-31", 2, "2020-05-29"], 
 [7, "2020-06-01", 3, "2020-05-29"], 
 [7, "2020-06-02", 4, "2020-05-29"], 
 [7, "2020-06-02", 4, "2020-05-29"], 
 [7, "2020-06-03", 5, "2020-05-29"], 
 [7, "2020-06-10", 6, "2020-06-04"]]}


*/

 , answer_table AS 
( 
         SELECT   id, 
                  groupings, 
                  min(login_date) AS startdate, 
                  max(login_date) AS enddate, 
                  row_num, 
                  
                  count(id), 
                  datediff(max(login_date), min(login_date)) AS duration 
         FROM     temp1 
         GROUP BY id, 
                  groupings 
         HAVING   datediff(max(login_date), min(login_date)) >= 4 
         ORDER BY id, 
                  startdate ) 

/*
Without having clause 
{"headers": ["id", "groupings", "startdate", "enddate", "row_num", "count(id)", "duration"], 
 "values": 
[[1, "2020-05-29", "2020-05-30", "2020-05-30", 1, 1, 0], 
 [1, "2020-06-05", "2020-06-07", "2020-06-07", 2, 1, 0], 
 [7, "2020-05-29", "2020-05-30", "2020-06-03", 1, 6, 4], 
 [7, "2020-06-04", "2020-06-10", "2020-06-10", 6, 1, 0]]}
                           
                           
                           With Having clause
{"headers": ["id", "startdate", "enddate", "row_num", "groupings", "count(id)", "duration"], 
 "values": [[7, "2020-05-30", "2020-06-03", 1, "2020-05-29", 6, 4]]}




*/

SELECT DISTINCT a.id, 
                NAME 
FROM            answer_table a 
JOIN            accounts acc 
ON              acc.id = a.id 
ORDER BY        a.id

/*

{"headers": ["id", "NAME"], 
 "values": [[7, "Jonathan"]]}

*/

