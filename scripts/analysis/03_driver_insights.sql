/*
===============================================================================
Driver Insights
===============================================================================
Purpose:
    - Analyze driver activity, ratings, and risk signals to answer:
        1. How many active drivers are there?
        2. Who are the top 10 drivers by average rating?
        3. Do drivers with more rides tend to have higher or lower ratings?
        4. Identify drivers at risk (low ratings)

Tables Used:
    - clean_drivers

Relevant Columns:
    - driver_id, name, avg_rating, total_rides, available
===============================================================================
*/

-- 1) How many active drivers are there?
SELECT
    COUNT(*) AS active_drivers
FROM dbo.clean_drivers
WHERE available = 'True';


-- 2) Top 10 drivers by average rating
SELECT TOP 10
    driver_id,
    name,
    avg_rating
FROM dbo.clean_drivers
ORDER BY avg_rating DESC;


-- 3) Do drivers with more rides tend to have higher or lower ratings?
SELECT 
    CASE 
        WHEN total_rides BETWEEN 0 AND 50 THEN '0-50 rides'
        WHEN total_rides BETWEEN 51 AND 100 THEN '51-100 rides'
        WHEN total_rides BETWEEN 101 AND 200 THEN '101-200 rides'
        ELSE '200+ rides'
    END AS ride_bucket,
    COUNT(*) AS num_drivers,
    AVG(avg_rating) AS avg_rating_per_bucket
FROM dbo.clean_drivers
GROUP BY 
    CASE 
        WHEN total_rides BETWEEN 0 AND 50 THEN '0-50 rides'
        WHEN total_rides BETWEEN 51 AND 100 THEN '51-100 rides'
        WHEN total_rides BETWEEN 101 AND 200 THEN '101-200 rides'
        ELSE '200+ rides'
    END
ORDER BY ride_bucket;


-- 4) Identify drivers at risk (low ratings only; cancellations not available)
SELECT
    driver_id,
    name,
    avg_rating,
    total_rides,
    available
FROM dbo.clean_drivers
WHERE avg_rating < 2.0
ORDER BY avg_rating ASC;
