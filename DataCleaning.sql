SELECT *
FROM PortfoloioProject.dbo.[NashvilleHousing ]
--WHERE PropertyAddress is  null 
order by UniqueID


--Finding duplicate pacelID
SELECT ParcelID, COUNT(*) AS count
FROM PortfoloioProject.dbo.[NashvilleHousing ]
GROUP BY ParcelID
HAVING COUNT(*) > 1

--Copying value of propertyAddress from another row of same parcelID
SELECT A.UniqueID, A.ParcelID,A.PropertyAddress,B.UniqueID,B.ParcelID,B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM PortfoloioProject.dbo.[NashvilleHousing ] A
JOIN PortfoloioProject.dbo.[NashvilleHousing ] B
ON   A.ParcelID = B.ParcelID
   AND A.UniqueID <> B.UniqueID
   Where A.PropertyAddress is null

-- Now we will update Table A
Update A
Set PropertyAddress = ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM PortfoloioProject.dbo.[NashvilleHousing ] A
JOIN PortfoloioProject.dbo.[NashvilleHousing ] B
ON   A.ParcelID = B.ParcelID
   AND A.UniqueID <> B.UniqueID
   Where A.PropertyAddress is null

-- Breaking out address into individual columns(Address,city,state)
SELECT PropertyAddress
FROM PortfoloioProject.dbo.[NashvilleHousing ]


SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',' ,PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress,CHARINDEX(',' ,PropertyAddress) +1, LEN(PropertyAddress) ) as Address
FROM PortfoloioProject.dbo.[NashvilleHousing ]

--ADDing two new coulumns in table
--1--
ALTER TABLE PortfoloioProject.dbo.[NashvilleHousing ]
Add HouseAddress Nvarchar(255);

Update PortfoloioProject.dbo.[NashvilleHousing ]
SET HouseAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',' ,PropertyAddress) -1) 

--2--
ALTER TABLE PortfoloioProject.dbo.[NashvilleHousing ]
Add City Nvarchar(255);

Update PortfoloioProject.dbo.[NashvilleHousing ]
SET City = SUBSTRING(PropertyAddress,CHARINDEX(',' ,PropertyAddress) +1,LEN(PropertyAddress)) 

-- Delete Unused Columns
Select *
From PortfoloioProject.dbo.[NashvilleHousing ]

ALTER TABLE PortfoloioProject.dbo.[NashvilleHousing ]
DROP COLUMN  TaxDistrict, PropertyAddress, SaleDate,OwnerAddress



