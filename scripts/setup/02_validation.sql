/*
===============================================================================
 Script: 02_validation.sql
 Project: Ride Sharing Data Analysis
 Purpose: Data validation & quality checks on staging tables
 Author: Mohammad Junaid
 Assistant: ChatGPT
 Notes:
   - Run after 01_bulk_insert.sql has populated staging tables.
   - These queries check for row counts, nulls, duplicates, and bad values.
===============================================================================
*/

USE ride_sharing_test;
GO

-------------------------------------------------------------------------------
-- 1) Row Counts (basic sanity check)
-------------------------------------------------------------------------------
SELECT 'stg_users'   AS table_name, COUNT(*) AS row_count FROM dbo.stg_users
UNION ALL
SELECT 'stg_drivers', COUNT(*) FROM dbo.stg_drivers
UNION ALL
SELECT 'stg_vehicles', COUNT(*) FROM dbo.stg_vehicles
UNION ALL
SELECT 'stg_rides', COUNT(*) FROM dbo.stg_rides
UNION ALL
SELECT 'stg_ratings', COUNT(*) FROM dbo.stg_ratings;
GO

-------------------------------------------------------------------------------
-- 2) Check for NULLs in key columns
-------------------------------------------------------------------------------
-- Users: user_id
SELECT COUNT(*) AS null_user_ids
FROM dbo.stg_users
WHERE user_id IS NULL OR LTRIM(RTRIM(user_id)) = '';

-- Drivers: driver_id
SELECT COUNT(*) AS null_driver_ids
FROM dbo.stg_drivers
WHERE driver_id IS NULL OR LTRIM(RTRIM(driver_id)) = '';

-- Vehicles: vehicle_id
SELECT COUNT(*) AS null_vehicle_ids
FROM dbo.stg_vehicles
WHERE vehicle_id IS NULL OR LTRIM(RTRIM(vehicle_id)) = '';

-- Rides: ride_id, user_id, driver_id
SELECT COUNT(*) AS null_ride_keys
FROM dbo.stg_rides
WHERE ride_id IS NULL OR user_id IS NULL OR driver_id IS NULL;

-- Ratings: rating_id, ride_id, user_id
SELECT COUNT(*) AS null_rating_keys
FROM dbo.stg_ratings
WHERE rating_id IS NULL OR ride_id IS NULL OR user_id IS NULL;
GO

-------------------------------------------------------------------------------
-- 3) Duplicate Checks
-------------------------------------------------------------------------------
-- Users
SELECT user_id, COUNT(*) AS cnt
FROM dbo.stg_users
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Drivers
SELECT driver_id, COUNT(*) AS cnt
FROM dbo.stg_drivers
GROUP BY driver_id
HAVING COUNT(*) > 1;

-- Vehicles
SELECT vehicle_id, COUNT(*) AS cnt
FROM dbo.stg_vehicles
GROUP BY vehicle_id
HAVING COUNT(*) > 1;

-- Rides
SELECT ride_id, COUNT(*) AS cnt
FROM dbo.stg_rides
GROUP BY ride_id
HAVING COUNT(*) > 1;

-- Ratings
SELECT rating_id, COUNT(*) AS cnt
FROM dbo.stg_ratings
GROUP BY rating_id
HAVING COUNT(*) > 1;
GO

-------------------------------------------------------------------------------
-- 4) Format / Range Checks
-------------------------------------------------------------------------------
-- Age in users: should be numeric and reasonable (between 10 and 100)
SELECT TOP 20 user_id, age
FROM dbo.stg_users
WHERE TRY_CAST(age AS INT) IS NULL OR TRY_CAST(age AS INT) NOT BETWEEN 10 AND 100;

-- Rating value: should be between 1 and 5
SELECT TOP 20 rating_id, rating_value
FROM dbo.stg_ratings
WHERE TRY_CAST(rating_value AS INT) IS NULL
   OR TRY_CAST(rating_value AS INT) NOT BETWEEN 1 AND 5;

-- Ride times: check invalid date conversions
SELECT TOP 20 ride_id, ride_start_time, ride_end_time
FROM dbo.stg_rides
WHERE TRY_CAST(ride_start_time AS DATETIME) IS NULL
   OR TRY_CAST(ride_end_time AS DATETIME) IS NULL;

-- Fare amount: should be numeric
SELECT TOP 20 ride_id, fare_amount
FROM dbo.stg_rides
WHERE TRY_CAST(fare_amount AS DECIMAL(10,2)) IS NULL;
GO
