/*
===============================================================================
Ratings & Satisfaction
===============================================================================
Purpose:
    - Analyze ratings and satisfaction to answer key questions:
        1. What is the average rider rating given to drivers?
        2. Which riders give the most ratings (top 10 by count)?
        3. What are the distribution patterns of ratings (1–5)?
        4. Which drivers received the most ratings (top 10 by count)?
        5. What is the trend of average ratings over time (month-by-month, 2024)?

Tables Used:
    - clean_ratings
    - clean_rides
    - clean_drivers
    - clean_riders

Relevant Columns:
    - rating_value, rated_at, ride_id, user_id, name, driver_id
Notes:
    - Some questions from the original brief (ride_type, wait_time) are omitted because
      the dataset does not contain ride_type or wait_time columns.
===============================================================================
*/

-- 1) Average rider rating given to drivers
SELECT
    AVG(rating_value) AS avg_rider_rating
FROM dbo.clean_ratings;


-- 2) Which riders give the most ratings (top 10 by count of ratings submitted)?
SELECT TOP 10
    user_id,
    COUNT(rating_value) AS rating_submission_count
FROM dbo.clean_ratings
GROUP BY user_id
ORDER BY rating_submission_count DESC;


-- 3) Distribution patterns of ratings (1-5)
SELECT
    rating_value,
    COUNT(rating_value) AS rating_distribution_count
FROM dbo.clean_ratings
GROUP BY rating_value
ORDER BY rating_value DESC;


-- 4) Which drivers received the most ratings (top 10 by count of ratings received)?
SELECT TOP 10
    d.driver_id,
    d.name AS driver_name,
    COUNT(rat.rating_value) AS ratings_count
FROM dbo.clean_ratings rat
INNER JOIN dbo.clean_rides r
    ON rat.ride_id = r.ride_id
INNER JOIN dbo.clean_drivers d
    ON r.driver_id = d.driver_id
GROUP BY d.driver_id, d.name
ORDER BY ratings_count DESC;


-- 5) Trend of average ratings over time (month-by-month)
SELECT
    FORMAT(rated_at, 'yyyy-MM') AS month,
    AVG(rating_value) AS avg_rating
FROM dbo.clean_ratings
GROUP BY FORMAT(rated_at, 'yyyy-MM')
ORDER BY month;
