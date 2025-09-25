/*
===============================================================================
Ride & Revenue Performance
===============================================================================
Purpose:
    - Analyze ride & revenue metrics to answer key business questions:
        1. Total revenue generated
        2. Average fare per ride and per km
        3. Month with the highest total revenue
        4. Top 10 drivers by revenue

Table Used:
    - clean_rides

Relevant Columns:
    - fare, distance_km, dropoff_time, driver_id
===============================================================================
*/

-- Total Revenue Generated
SELECT
    SUM(fare) AS total_revenue
FROM dbo.clean_rides;


-- Average Fare per Ride and per Km
SELECT
    ROUND(AVG(fare), 2) AS avg_fare_per_ride,
    ROUND(SUM(fare) * 1.0 / SUM(distance_km), 2) AS avg_fare_per_km
FROM dbo.clean_rides;


-- Month with Highest Total Revenue
SELECT TOP 1
    FORMAT(dropoff_time, 'yyyy-MM') AS month_ym,
    SUM(fare) AS total_revenue_monthly
FROM dbo.clean_rides
GROUP BY FORMAT(dropoff_time, 'yyyy-MM')
ORDER BY total_revenue_monthly DESC;


-- Top 10 Drivers by Revenue
SELECT TOP 10
    driver_id,
    SUM(fare) AS drivers_revenue
FROM dbo.clean_rides
GROUP BY driver_id
ORDER BY drivers_revenue DESC;
