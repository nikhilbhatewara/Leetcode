The idea here is to use row_number to get a unique grouping label for each continous sequence.
We can then easily find the min/max dates in each group

with a  as (
(select fail_date as date,
       'failed' as period_state
       from failed)
union all
 
 (select success_date as date,
         'succeeded' as period_state
         from succeeded)
    ),
    
  b as (    
select date,
       period_state,
       row_number() over (order by period_state, date asc) as seq
   from a where date between '2019-01-01' and '2019-12-31'
         ),

 c as (
select date, period_state,seq, dateadd(d, -seq, date) as seqStart from b
)

select period_state, min(date) as start_date, max(date) as end_date from c
group by seqStart,period_state
order by start_date asc

-- better approach

with a  as (
(select fail_date as date,
       'failed' as period_state
       from failed)
union all 
 (select success_date as date,
         'succeeded' as period_state
         from succeeded)
    ),
    
  b as (    
select date,
       period_state,
       row_number() over (order by period_state, date asc) as seq
   from a where date between '2019-01-01' and '2019-12-31'
         )

select period_state, min(date) as start_date, max(date) as end_date from b
group by dateadd(d, -seq, date),period_state
order by start_date asc
