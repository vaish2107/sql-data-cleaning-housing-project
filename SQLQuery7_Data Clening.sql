select *
From Project..HousingData

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format


Select SaleDateConverted , CONVERT(Date,SaleDate)
From Project..HousingData


Update HousingData
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE HousingData
Add SaleDateConverted Date;

Update HousingData
SET SaleDateConverted = CONVERT(Date,SaleDate)


-- Populate Property Address data//Property address does not chnaged

select PropertyAddress
from Project..HousingData

Select *
From Project.dbo.HousingData
--Where PropertyAddress is null
order by ParcelID


--Self JOIN // way to distinguish sale date could be the same// join same table with each other where the parcel id is same but not same row 

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From Project.dbo.HousingData a
JOIN Project.dbo.HousingData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--when we want to do update then we used defined name of the table  i.e a not the excat tablename

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Project.dbo.HousingData a
JOIN Project.dbo.HousingData b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress
From Project.dbo.HousingData
--Where PropertyAddress is null
--order by ParcelID

--Substring character 

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From Project.dbo.HousingData

ALTER TABLE HousingData
Add PropertySplitAddress Nvarchar(255);

Update HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


Select *
From Project.dbo.HousingData


--------------------------------------------------------------------------------------------------------------------

Select OwnerAddress
From Project.dbo.HousingData

--Parse Name --delimited by specific value

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Project.dbo.HousingData


ALTER TABLE HousingData
Add OwnerSplitAddress Nvarchar(255);

Update HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE HousingData
Add OwnerSplitCity Nvarchar(255);

Update HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE HousingData
Add OwnerSplitState Nvarchar(255);

Update HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Project.dbo.HousingData
Group by SoldAsVacant
order by 2


SELECT
  SoldAsVacant,
  CASE
    WHEN SoldAsVacant = 1 THEN 'Yes'
    WHEN SoldAsVacant = 0 THEN 'No'
    ELSE 'Unknown'
  END AS SoldAsVacantText
FROM Project.dbo.HousingData;



UPDATE Project.dbo.HousingData
SET SoldAsVacant =
  CASE 
    WHEN SoldAsVacant = 1 THEN 1
    WHEN SoldAsVacant = 0 THEN 0
    ELSE SoldAsVacant  -- preserves NULLs
  END;


  -----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY ParcelID,
                            PropertyAddress,
                            SalePrice,
                            SaleDate,
                            LegalReference
               ORDER BY UniqueID
           ) AS row_num
    FROM Project.dbo.HousingData
    )
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


-----------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From Project.dbo.HousingData


ALTER TABLE Project.dbo.HousingData
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate