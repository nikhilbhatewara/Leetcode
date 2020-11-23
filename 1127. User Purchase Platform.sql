Let's start with a simple preprocess:

SELECT
  spend_date,
  user_id,
  SUM(CASE platform WHEN 'mobile' THEN amount ELSE 0 END) mobile_amount,
  SUM(CASE platform WHEN 'desktop' THEN amount ELSE 0 END) desktop_amount
FROM Spending
GROUP BY spend_date, user_id
For each user in each day, we fetch its mobile_amount and desktop_amount respectively and output them into a single row. In this form, we can see a user belongs to which platform very clearly:

spend_date	user_id	mobile_amount	desktop_amount	->(platform)
2019-07-01	1	100	100	-> (both)
2019-07-01	2	100	0	-> (mobile)
2019-07-01	3	0	100	-> (desktop)
2019-07-02	2	100	0	-> (mobile)
2019-07-02	3	0	100	->(desktop)
Based on the above table, we use the following SQL to bind users to their platforms and calculate the amounts spent:

SELECT
    spend_date,
    user_id,
    IF(mobile_amount > 0, IF(desktop_amount > 0, 'both', 'mobile'), 'desktop') platform,
    (mobile_amount + desktop_amount) amount
FROM (
	...
) o
Result table:

spend_date	user_id	platform	amount
2019-07-01	1	both	200
2019-07-01	2	mobile	100
2019-07-01	3	desktop	100
2019-07-02	2	mobile	100
2019-07-02	3	desktop	100
We don't wanna miss any record which has ZERO total_amount and total_users. So we need to get all combinations of spend_date and platform:

SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
UNION
SELECT DISTINCT(spend_date), 'both' platform FROM Spending
The output:

spend_date	platform
2019-07-01	desktop
2019-07-01	mobile
2019-07-01	both
2019-07-02	desktop
2019-07-02	mobile
2019-07-02	both
After joinning this table to the previous one, we have our final answer:

SELECT 
    p.spend_date,
    p.platform,
    IFNULL(SUM(amount), 0) total_amount,
    COUNT(user_id) total_users
FROM 
(
    SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'both' platform FROM Spending
) p 
LEFT JOIN (
    SELECT
        spend_date,
        user_id,
        IF(mobile_amount > 0, IF(desktop_amount > 0, 'both', 'mobile'), 'desktop') platform,
        (mobile_amount + desktop_amount) amount
    FROM (
        SELECT
          spend_date,
          user_id,
          SUM(CASE platform WHEN 'mobile' THEN amount ELSE 0 END) mobile_amount,
          SUM(CASE platform WHEN 'desktop' THEN amount ELSE 0 END) desktop_amount
        FROM Spending
        GROUP BY spend_date, user_id
    ) o
) t
ON p.platform=t.platform AND p.spend_date=t.spend_date
GROUP BY spend_date, platform



--- my approach

**Query #1**

    with cte1 as 
    (
    
    select spend_date, platform, sum(amount) as total_amount,count(distinct user_id) as total_users
    from Spending
    group by spend_date, platform,user_id
    
    	union
    
    
    select spend_date, "both" as platform, sum(amount) as total_amount,count(distinct user_id) as total_users
    from Spending
    where (user_id,spend_date)
                in 
                (
                select   user_id,spend_date
                  from Spending
                  group by user_id,spend_date
                  having count(distinct platform) = 2
                ) 
    group by spend_date
    
    )
    
    
    ,cte2 as 
    (
    
    select *
    from
      (
      select "desktop" as platform
      union
      select "mobile" as platform
      union
      select "both" as platform
      ) as T1
    	join (select distinct spend_date from Spending) as T2
    )
    
    
    
    
    
    select a.spend_date,a.platform,ifnull(total_amount,0) as total_amount,ifnull(total_users,0) as total_users
    from cte2 a
    left join cte1 b
    on a.spend_date = b.spend_date and a.platform = b.platform;

| spend_date          | platform | total_amount | total_users |
| ------------------- | -------- | ------------ | ----------- |
| 2019-07-01 00:00:00 | desktop  | 200          | 2           |
| 2019-07-01 00:00:00 | mobile   | 200          | 2           |
| 2019-07-01 00:00:00 | both     | 200          | 1           |
| 2019-07-02 00:00:00 | desktop  | 100          | 1           |
| 2019-07-02 00:00:00 | mobile   | 100          | 1           |
| 2019-07-02 00:00:00 | both     | 0            | 0           |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/g3krvZCRzdhwSgHE4Sqo1X/0)
