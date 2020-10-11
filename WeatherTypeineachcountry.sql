with weatherCTE as (

select country_id, (sum(weather_state)/ count(*)) as avg_weather_state
from weather
where month(day) = 11 and year(day) = 2019
group by country_id
    )
    
    
    
    select b.country_name, case when a.avg_weather_state <= 15 then "Cold"
    when a.avg_weather_state >= 25 then "Hot" 
    else "Warm" end as weather_type
    from weatherCTE a
    left join countries b
    on a.country_id = b.country_id;
