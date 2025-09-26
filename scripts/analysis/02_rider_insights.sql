/*
===============================================================================
Rider Insights
===============================================================================
Purpose:
    - Analyze rider behavior and spending patterns to answer key questions:
        1. How many unique riders are there?
        2. What is the average number of rides per rider?
        3. Who are the top 10 riders by total spending?
        4. What is the repeat rate (riders who booked more than once)?

Tables Used:
    - clean_rides
    - clean_riders

Relevant Columns:
    - user_id, fare, name
===============================================================================
*/

-- 1) How many unique riders are there?
SELECT 
    COUNT(DISTINCT user_id) AS unique_riders
FROM dbo.clean_rides;


-- 2) What is the average number of rides per rider?
SELECT
    COUNT(user_id) * 1.0 / COUNT(DISTINCT user_id) AS average_rides_per_rider
FROM dbo.clean_rides;


-- 3) Who are the top 10 riders by total spending?
SELECT TOP 10
    r1.user_id,
    r1.name,
    SUM(r2.fare) AS total_spent
FROM dbo.clean_riders r1
LEFT JOIN dbo.clean_rides r2
    ON r1.user_id = r2.user_id
GROUP BY r1.user_id, r1.name
ORDER BY total_spent DESC;


-- 4) What is the repeat rate (riders who booked more than once)?
SELECT 
    ROUND(
        CAST(SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*),
        2
    ) AS repeat_rate
FROM (
    SELECT 
        user_id,
        COUNT(user_id) AS total_orders
    FROM dbo.clean_rides
    GROUP BY user_id
) t;
