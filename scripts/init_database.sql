/*
===================================================================
Create Database and Schemas
===================================================================
Script Purpose:
  This script creates a new database names "DataWarehouse" after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
  within the database: 'bronze','silver','gold'.

Warning:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution and ensure proper backup 
  before running this script.
*/

USE master
GO

-- Drop and Recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO  

-- Create the DataWarehouse Database --
CREATE DATABASE DataWarehouse;

-- Use the DataWarehouse Database --
USE DataWarehouse;

-- Create Schemas --
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO
  
