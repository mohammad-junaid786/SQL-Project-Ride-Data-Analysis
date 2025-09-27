/*
===============================================================================
 Script: 03_clean_views.sql
 Project: Ride Sharing Data Analysis
 Purpose: Create cleaned views from staging tables for analysis
 Author: Mohammad Junaid
 Assistant: ChatGPT
 Notes:
   - Run after 02_validation.sql to ensure staging data is valid.
   - Views standardize datatypes and handle minor data cleaning.
===============================================================================
*/

USE ride_sharing_test;
GO

-------------------------------------------------------------------------------
-- Clean Users View
-------------------------------------------------------------------------------
CREATE OR ALTER VIEW dbo.clean_users AS
SELECT
  user_id,
  name,
  email,
  phone_number,
  TRY_CAST(LEFT(registration_date,19) AS DATETIME2) AS signup_date,
  TRY_CAST(age AS INT) AS age,
  gender,
  location
FROM dbo.stg_users;
GO

-------------------------------------------------------------------------------
-- Clean Drivers View
-------------------------------------------------------------------------------
CREATE OR ALTER VIEW dbo.clean_drivers AS
SELECT
  driver_id,
  name,
  vehicle_id,
  TRY_CAST(rating AS DECIMAL(3,2)) AS avg_rating,
  TRY_CAST(total_rides AS INT)     AS total_rides,
  REPLACE(LTRIM(RTRIM(available)), CHAR(13), '') AS available
FROM dbo.stg_drivers;
GO

-------------------------------------------------------------------------------
-- Clean Vehicles View
-------------------------------------------------------------------------------
CREATE OR ALTER VIEW dbo.clean_vehicles AS
SELECT
  LTRIM(RTRIM(vehicle_id)) AS vehicle_id,
  LTRIM(RTRIM(REPLACE(make, '"', ''))) AS make,
  LTRIM(RTRIM(REPLACE(model, '"', ''))) AS model,

  -- clean year: prefer direct cast; if missing, try left part of capacity when it's "2009,3"
  COALESCE(
    TRY_CAST(LTRIM(RTRIM(year)) AS INT),
    TRY_CAST(
      LTRIM(RTRIM(
        CASE 
          WHEN CHARINDEX(',', cleaned_capacity) > 0 
            THEN LEFT(cleaned_capacity, CHARINDEX(',', cleaned_capacity) - 1)
          ELSE ''
        END
      )) AS INT)
  ) AS year,

  -- capacity: remove quotes & common invisible chars then take the number after last comma (or whole string if no comma)
  TRY_CAST(
    LTRIM(RTRIM(
      CASE 
        WHEN CHARINDEX(',', cleaned_capacity) = 0 
          THEN cleaned_capacity
        ELSE RIGHT(cleaned_capacity, CHARINDEX(',', REVERSE(cleaned_capacity)) - 1)
      END
    )) AS INT) AS capacity

FROM
(
  SELECT
    vehicle_id,
    make,
    model,
    year,
    capacity,

    -- cleaned_capacity: remove double quotes, NBSP, tabs, CR/LF, zero-width-space and normalize fullwidth comma
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(LTRIM(RTRIM(capacity)), '"',''),
              CHAR(160),''),   -- NBSP
            CHAR(9),''),       -- tab
          CHAR(13),''),        -- CR
        CHAR(10),''),          -- LF
      NCHAR(8203),''),         -- zero-width space
    NCHAR(65292),',')          -- fullwidth comma -> normal comma
    AS cleaned_capacity

  FROM dbo.stg_vehicles
) AS x;
GO

-------------------------------------------------------------------------------
-- Clean Rides View
-------------------------------------------------------------------------------
CREATE OR ALTER VIEW dbo.clean_rides AS
SELECT
  ride_id,
  user_id,
  driver_id,
  start_location,
  end_location,
  TRY_CAST(LEFT(ride_start_time,19) AS DATETIME2) AS pickup_time,
  TRY_CAST(LEFT(ride_end_time,19)   AS DATETIME2) AS dropoff_time,
  TRY_CAST(distance_km AS DECIMAL(10,3)) AS distance_km,
  TRY_CAST(fare_amount AS DECIMAL(12,2)) AS fare
FROM dbo.stg_rides;
GO

-------------------------------------------------------------------------------
-- Clean Ratings View
-------------------------------------------------------------------------------
CREATE OR ALTER VIEW dbo.clean_ratings AS
SELECT
  rating_id,
  ride_id,
  user_id,
  TRY_CAST(rating_value AS INT) AS rating_value,
  TRY_CAST(LEFT(rating_date,19) AS DATETIME2) AS rated_at
FROM dbo.stg_ratings;
GO
