# Write your MySQL query statement below


with details as 
(
select account, sum(amount) as balance
from transactions
group by account
having balance > 10000
)

select name,balance
from users 
join details
on users.account = details.account
