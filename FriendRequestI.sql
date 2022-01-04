# Write your MySQL query statement below

with requests as 
(
select count(1) as req_count
    from
    (
select distinct sender_id,send_to_id
    from FriendRequest
    ) r    
)
,

accepts as 
(

select count(1) as acpts_count
    from
    (
select distinct requester_id,accepter_id
    from RequestAccepted
    ) a

)


select coalesce(round(acpts_count/req_count,2),0.0) as accept_rate
from requests,accepts
