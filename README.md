Project Title: Data Cleaning in SQL Server

Project Description

This project showcases the end-to-end data cleaning and preprocessing of a real estate dataset using SQL Server. The goal was to prepare the raw housing data for further analysis and visualization by handling common data quality issues such as duplicates, inconsistent formats, missing values, and unstructured text.

Key Steps & Techniques 

	Used Standardized Date Formats Converted inconsistent SaleDate column into a proper DATE format using the CONVERT() function. Created a new column SaleDateConverted where necessary.
	Handled Missing Property Addresses Used self-joins on ParcelID to fill missing PropertyAddress fields based on duplicate entries with valid data.
	Split Address Strings Parsed PropertyAddress into individual components (Street, City) using SUBSTRING() and CHARINDEX(). Used PARSENAME() to break down OwnerAddress into Address, City, and State.
	Standardized Categorical Fields Cleaned up the SoldAsVacant field by mapping values like Y, N, 1, 0 to standardized 'Yes' and 'No'.
	Removed Duplicate Records Identified duplicates using ROW_NUMBER() with PARTITION BY on business-relevant fields and filtered out rows where row_num > 1.
	Dropped Irrelevant Columns Removed unused or redundant columns such as OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate to streamline the dataset.
Tools & Skills :
•	SQL Server (T-SQL) 
•	Data Cleaning 
•	Window Functions (ROW_NUMBER) 
•	String Functions (SUBSTRING, CHARINDEX, PARSENAME) 
•	Joins & Conditional Updates 
•	Schema Alteration (ALTER TABLE)

Outcome 

The cleaned dataset is now consistent, standardized, and ready for advanced analytics or dashboarding in tools like Power BI, Tableau or Python. This preprocessing stage is crucial to ensure accurate insights and avoid misleading conclusions during analysis.




Some Snapshots of the output: 

![image](https://github.com/user-attachments/assets/ee222a4f-129c-4278-a5bf-0d51ca911072)
