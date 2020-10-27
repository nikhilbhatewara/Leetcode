
select 
round(
ifnull(
count(distinct requester_id , accepter_id) / 

(
select count(distinct sender_id , send_to_id)
from friend_request
)
,0)
,2) as accept_rate
from request_accepted
