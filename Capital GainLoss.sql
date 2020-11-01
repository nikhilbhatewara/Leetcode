# Write your MySQL query statement below
/*
Find total buy for each stock
find total sell for each stock
*/

with totals as
(
select stock_name,
    sum(case when operation = "Buy" then price else 0 end) as buytotals,
    sum(case when operation = "Sell" then price else 0 end) as selltotals
    from Stocks
    group by stock_name
)

select stock_name, (selltotals-buytotals) as capital_gain_loss
from totals
group by stock_name



