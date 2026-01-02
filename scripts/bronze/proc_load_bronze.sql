/*
================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:

    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @bronze_start_time DATETIME,
			@bronze_end_time DATETIME
	BEGIN TRY
		SET @bronze_start_time = GETDATE()
		PRINT '==================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================';

		PRINT '----------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------';

		--TABLE 1--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;
	
		PRINT '>> Inserting Data Into: crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		--TABLE 2--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		--TABLE 3--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
	
		PRINT '>> Inserting Data Into: crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		PRINT '----------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------';

		--TABLE 4--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;
	
		PRINT '>> Inserting Data Into: erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		--TABLE 5-
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;
	
		PRINT '>> Inserting Data Into: erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		--TABLE 6--
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	
		PRINT '>> Inserting Data Into: erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\japjo\OneDrive\Desktop\SQL DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';

		SET @bronze_end_time = GETDATE();
		PRINT '>>Load Duration for bronze layer: ' + CAST(DATEDIFF(second, @bronze_start_time, @bronze_end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------';
	END TRY
	BEGIN CATCH
		PRINT '==================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==================================';
	END CATCH
END
