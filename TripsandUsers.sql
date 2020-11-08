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



--


/*
Find unbanned driver and user
- Filter table users for unbanned
- Join users with Trips based on ClientID and DriverID


Compute cancellations - Count the trip if it's cancelled


Compute cancellation rate - cancelled/total request(count(*))
Filter table for dates oct1 to oct3
*/




with clientdetails as 
(
select a.id,a.client_id,a.driver_id,a.city_id,a.status,a.request_at
  from Trips a
  inner join Users b
  on a.client_id = b.Users_Id  
  where a.request_at between '2013-10-01' and '2013-10-03'
  and b.Banned = 'No'
)

,driverdetails as 
(
 
  select a.id,a.client_id,a.driver_id,a.city_id,a.status,a.request_at
  from clientdetails a
  inner join Users b
  on a.driver_id = b.Users_Id  
  where a.request_at between '2013-10-01' and '2013-10-03'
  and b.Banned = 'No'
)
,details as (
  
  select * 
  from clientdetails
  union all 
  select *
  from driverdetails
  )
  

, cancelledtable as
(
	Select 
  	request_at as Day,
  case when status in ('cancelled_by_driver','cancelled_by_client') then 1 else 0 end as CancellationFlag
  	from details

 )
 
 
 
 select Day,round(avg(ifnull(CancellationFlag,0)),2) as CancellationRate
 from cancelledtable
 group by Day
  
  

  

  
