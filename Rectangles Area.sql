select p1,p2,area
from 
(


    select p1.id p1
    ,p2.id p2
    , abs( (p1.x_value - p2.x_value) * (p1.y_value - p2.y_value) ) as area
    from points p1
    cross join points p2
    on p1.id < p2.id


) as T
where area > 0
order by area desc ,p1,p2
