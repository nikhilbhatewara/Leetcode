# Write your MySQL query statement below

select Day, ROUND(ifnull((count_cancelled_trip/count_complete_trip),0),2) AS 'Cancellation Rate'

From
(
select * 
From (select request_at as Day,count(Id) as count_complete_trip
from (select *
from trips T left join users U on T.Client_Id = U.Users_Id 
where Banned='No' and request_at between '2013-10-01' and '2013-10-03') as T1
group by request_at) as COMT left outer join 

(select request_at,count(Id) as count_cancelled_trip
from (select *
from trips T left join users U on T.Client_Id = U.Users_Id 
where Banned='No' and request_at between '2013-10-01' and '2013-10-03') as T2
where status !='completed'
group by request_at) as CNCT on Day = CNCT.request_at
) as BigO

group by Day
