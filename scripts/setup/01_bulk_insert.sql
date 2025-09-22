/*
===============================================================================
 Script: 01_bulk_insert.sql
 Project: Ride Sharing Data Analysis
 Purpose: Create staging tables and bulk load raw CSVs into SQL Server
 Author: Mohammad Junaid
 Assistant: ChatGPT
 Notes:
   - Update file paths before running (see placeholders).
   - Requires SQL Server 2019+ (2022 recommended for FORMAT='CSV').
   - SQL Server service account must have read access to CSV paths.
===============================================================================
*/

-- Create database (only if not exists)
IF DB_ID('ride_sharing_test') IS NULL
    CREATE DATABASE ride_sharing_test;
GO

USE ride_sharing_test;
GO

-------------------------------------------------------------------------------
-- 1) stg_users (users.csv)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.stg_users','U') IS NULL
BEGIN
  CREATE TABLE dbo.stg_users (
    user_id            NVARCHAR(100),
    name               NVARCHAR(4000),
    email              NVARCHAR(4000),
    phone_number       NVARCHAR(4000),
    registration_date  NVARCHAR(4000),
    age                NVARCHAR(100),
    gender             NVARCHAR(100),
    location           NVARCHAR(4000)
  );
END
GO

-- TODO: Replace <PATH_TO_DATASETS> with your local/UNC path
BULK INSERT dbo.stg_users
FROM '<PATH_TO_DATASETS>/users.csv'
WITH (
  FORMAT = 'CSV',
  FIRSTROW = 2,
  FIELDQUOTE = '"',
  CODEPAGE = '65001',
  ROWTERMINATOR = '0x0a',
  TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 2) stg_drivers (drivers.csv)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.stg_drivers','U') IS NULL
BEGIN
  CREATE TABLE dbo.stg_drivers (
    driver_id    NVARCHAR(100),
    name         NVARCHAR(4000),
    vehicle_id   NVARCHAR(100),
    rating       NVARCHAR(100),
    total_rides  NVARCHAR(100),
    available    NVARCHAR(100)
  );
END
GO

-- TODO: Replace <PATH_TO_DATASETS> with your local/UNC path
BULK INSERT dbo.stg_drivers
FROM '<PATH_TO_DATASETS>/drivers.csv'
WITH (
  FORMAT = 'CSV',
  FIRSTROW = 2,
  FIELDQUOTE = '"',
  CODEPAGE = '65001',
  ROWTERMINATOR = '0x0a',
  TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 3) stg_vehicles (vehicles.csv)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.stg_vehicles', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.stg_vehicles (
    vehicle_id NVARCHAR(100),
    make       NVARCHAR(4000),
    model      NVARCHAR(4000),
    year       NVARCHAR(4000),
    capacity   NVARCHAR(4000)
  );
END
GO

-- TODO: Replace <PATH_TO_DATASETS> with your local/UNC path
BULK INSERT dbo.stg_vehicles
FROM '<PATH_TO_DATASETS>/vehicles.csv'
WITH (
  FORMAT = 'CSV',
  FIRSTROW = 2,
  FIELDQUOTE = '"',
  CODEPAGE = '65001',
  ROWTERMINATOR = '0x0a',
  TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 4) stg_rides (rides.csv)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.stg_rides','U') IS NULL
BEGIN
  CREATE TABLE dbo.stg_rides (
    ride_id          NVARCHAR(100),
    user_id          NVARCHAR(100),
    start_location   NVARCHAR(4000),
    end_location     NVARCHAR(4000),
    ride_start_time  NVARCHAR(4000),
    ride_end_time    NVARCHAR(4000),
    distance_km      NVARCHAR(100),
    fare_amount      NVARCHAR(4000),
    driver_id        NVARCHAR(100)
  );
END
GO

-- TODO: Replace <PATH_TO_DATASETS> with your local/UNC path
BULK INSERT dbo.stg_rides
FROM '<PATH_TO_DATASETS>/rides.csv'
WITH (
  FORMAT = 'CSV',
  FIRSTROW = 2,
  FIELDQUOTE = '"',
  CODEPAGE = '65001',
  ROWTERMINATOR = '0x0a',
  TABLOCK
);
GO

-------------------------------------------------------------------------------
-- 5) stg_ratings (ratings.csv)
-------------------------------------------------------------------------------
IF OBJECT_ID('dbo.stg_ratings','U') IS NULL
BEGIN
  CREATE TABLE dbo.stg_ratings (
    rating_id     NVARCHAR(100),
    ride_id       NVARCHAR(100),
    user_id       NVARCHAR(100),
    rating_value  NVARCHAR(100),
    comments      NVARCHAR(MAX),
    rating_date   NVARCHAR(4000)
  );
END
GO

-- TODO: Replace <PATH_TO_DATASETS> with your local/UNC path
BULK INSERT dbo.stg_ratings
FROM '<PATH_TO_DATASETS>/ratings.csv'
WITH (
  FORMAT = 'CSV',
  FIRSTROW = 2,
  FIELDQUOTE = '"',
  CODEPAGE = '65001',
  ROWTERMINATOR = '0x0a',
  TABLOCK
);
GO
