With a as 
(select
v.user_id, 
v.visit_date,
count(t.transaction_date) as transactions_count
from visits v
left join transactions t
on v.user_id = t.user_id
and v.visit_date = t.transaction_date
group by v.user_id, v.visit_date), 

b as
(select 0 as transactions_count, max(transactions_count) as m
 from a
 union all
 select transactions_count +1, m
 from b
 where transactions_count < m)


select b.transactions_count, isnull(count(a.transactions_count), 0) as visits_count
from b left join a
on b.transactions_count = a.transactions_count
group by b.transactions_count
order by b.transactions_count
