select f1.follower, count( distinct f2.follower) as num
from follow f1
left join follow f2
on f1.follower = f2.followee
group by f1.follower
having num > 0
