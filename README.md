# Data-Cleaning-and-Standardization-of-Global-Layoffs-Dataset

## Objective:
Improve data quality and reliability for analysis by cleaning and standardizing a global layoff dataset.

## Technologies used:
SQL, MySQL

## Description:
Undertook a comprehensive project to clean and standardize a global layoffs dataset, with a focus on enhancing its reliability and accuracy for analysis. The project involved removing duplicate entries, addressing missing values, and ensuring consistency across various attributes, including company information, employee layoff details, and financial metrics.

## Key Responsibility:
1. Created staging tables to preserve raw data and facilitate the cleaning process.
2. Identified and removed duplicate records using SQL Common Table Expressions (CTEs) and row numbering.
3. Standardized text fields, industry names, and country names to ensure consistency.
4. Converted date fields from text to date format and handled missing values by filling and correcting data based on existing records.
5. Removed redundant rows and columns to streamline the dataset.
6. Ensured the dataset was accurate, consistent, and ready for analysis.



<!-- ## **Steps**

1. Initial Setup: Switch to the target database world_layoffs. View the original layoffs table to understand the data structure.

2. Creating a Staging Table: Create a staging table layoff_staging to preserve the raw data. Insert all records from the original layoffs table into layoff_staging.

3. Deduplication: Use a Common Table Expression (CTE) to identify duplicates by assigning unique row numbers to potential duplicate records based on all columns. Create a new table layoff_staging_2 with an additional row_num column to facilitate deduplication. Copy data from layoff_staging to layoff_staging_2 while assigning row numbers. Remove duplicate records from layoff_staging_2.

4. Data Standardization: Trim whitespace from text fields (e.g., company, industry). Standardize industry names and country names to ensure consistency. Convert the date column datatype from TEXT to DATE for accurate date representation.

5. Handling Missing Values: Identify rows with NULL or blank values in key columns. Replace blank values with NULL for uniformity. Populate missing industry values based on other records with the same company and location.

6. Removing Redundant Rows and Columns: Delete rows where key columns (e.g., total_laid_off, percentage_laid_off) contain NULL values. Drop the row_num column as it is no longer needed after deduplication.

7. Final Data Review: Inspect the cleaned and standardized data in layoff_staging_2 to ensure all steps have been correctly implemented. -->
   
## **Conclusion**
Delivered a high-quality, consistent dataset, enhancing analysis accuracy and decision-making.
