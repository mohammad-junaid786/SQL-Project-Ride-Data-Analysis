/*
===============================================================================
Trends & Patterns
===============================================================================
Purpose:
    - Analyze temporal and behavioral patterns to answer key questions:
        1. Daily and monthly trend of rides
        2. Peak hours of demand
        3. Which days of the week see the most rides
        4. Relationship between ride distance and rating

Tables Used:
    - clean_rides
    - clean_ratings

Relevant Columns:
    - pickup_time, ride_id, distance_km, fare, ride_end_time
Notes:
    - Analysis limited to available columns; ride_type and wait_time are not present in dataset.
===============================================================================
*/

-- 1) Daily trend of rides
SELECT 
    CAST(pickup_time AS DATE) AS ride_date,
    COUNT(*) AS total_rides
FROM dbo.clean_rides
GROUP BY CAST(pickup_time AS DATE)
ORDER BY ride_date;


-- 2) Monthly trend of rides
SELECT 
    FORMAT(pickup_time, 'yyyy-MM') AS ride_month,
    COUNT(*) AS total_rides
FROM dbo.clean_rides
GROUP BY FORMAT(pickup_time, 'yyyy-MM')
ORDER BY ride_month;


-- 3) Peak hours of demand
SELECT
    FORMAT(pickup_time, 'HH') AS hour_of_day,
    COUNT(*) AS ride_bookings
FROM dbo.clean_rides
GROUP BY FORMAT(pickup_time, 'HH')
ORDER BY ride_bookings DESC;


-- 4) Which days of the week see the most rides?
SELECT
    DATENAME(WEEKDAY, pickup_time) AS weekday_name,
    COUNT(*) AS rides_count
FROM dbo.clean_rides
GROUP BY DATENAME(WEEKDAY, pickup_time)
ORDER BY rides_count DESC;


-- 5) Is there a relationship between ride distance and rating?
SELECT
    CASE 
        WHEN r.distance_km < 2 THEN '0-2 km'
        WHEN r.distance_km < 5 THEN '2-5 km'
        WHEN r.distance_km < 10 THEN '5-10 km'
        ELSE '10+ km'
    END AS distance_bucket,
    AVG(ra.rating_value) AS avg_rating,
    COUNT(*) AS ride_count
FROM dbo.clean_rides r
LEFT JOIN dbo.clean_ratings ra
    ON r.ride_id = ra.ride_id
GROUP BY 
    CASE 
        WHEN r.distance_km < 2 THEN '0-2 km'
        WHEN r.distance_km < 5 THEN '2-5 km'
        WHEN r.distance_km < 10 THEN '5-10 km'
        ELSE '10+ km'
    END
ORDER BY ride_count DESC;
