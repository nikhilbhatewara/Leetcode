# Write your MySQL query statement below
# Since the chargeback month could be different then transaction date, earliar approach did not work

with CTE as (
select *
from transactions

union all

select a.id,a.country, "chargeback" as state,a.amount,b.trans_date
from transactions a
join Chargebacks b
on a.id = b.trans_id
)



select date_format(trans_date,"%Y-%m") as month,
country,
sum(case when state="approved" then 1 else 0 end) as approved_count,
sum(case when state="approved" then amount else 0 end) as approved_amount,
sum(case when  state="chargeback"  then 1 else 0 end) as chargeback_count,
sum(case when  state="chargeback"  then amount else 0 end) as chargeback_amount
from CTE
group by month,country;





