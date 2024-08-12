-- Data Cleaning Project

select *
from ProjectPortfolio..HouseHolds;

--   Date Format Standardizing


select SaleDate
from ProjectPortfolio..HouseHolds;

select SaleDate, convert(Date,SaleDate)
from ProjectPortfolio..HouseHolds;

--update HouseHolds
--set SaleDate = convert(date,SaleDate);

alter table HouseHolds
add ConvertedSalesDate date;

update HouseHolds
set ConvertedSalesDate = convert(date,SaleDate);



-- Property Address


select PropertyAddress
from ProjectPortfolio..HouseHolds;

select PropertyAddress
from ProjectPortfolio..HouseHolds
where PropertyAddress is null;

select *
from ProjectPortfolio..HouseHolds
where PropertyAddress is null;

select *
from ProjectPortfolio..HouseHolds
--where PropertyAddress is null;
order by ParcelID;

select *
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ];

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ];

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) as PropAdd
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) as PropAdd
from ProjectPortfolio..HouseHolds a
Join ProjectPortfolio..HouseHolds b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ];

-- Break down the address into address,city,state

select PropertyAddress, SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)) as Property_Address
from ProjectPortfolio..HouseHolds;

select PropertyAddress, SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Property_Address
from ProjectPortfolio..HouseHolds

select SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Property_Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as City
from ProjectPortfolio..HouseHolds


alter table HouseHolds
add Property_Address nvarchar(255);

update HouseHolds
set Property_Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1);

alter table HouseHolds
add Property_City nvarchar(255);

update HouseHolds
set Property_City = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));

select PropertyAddress, Property_Address, Property_City
from ProjectPortfolio..HouseHolds
order by 3 asc;

select OwnerAddress
from ProjectPortfolio..HouseHolds;

select OwnerAddress, PARSENAME(OwnerAddress,1)
from ProjectPortfolio..HouseHolds;

select OwnerAddress, PARSENAME(Replace(OwnerAddress,',','.'),1)
from ProjectPortfolio..HouseHolds;

select OwnerAddress, 
PARSENAME(Replace(OwnerAddress,',','.'),1),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),3)
from ProjectPortfolio..HouseHolds;

select OwnerAddress, 
PARSENAME(Replace(OwnerAddress,',','.'),3) as Address,
PARSENAME(Replace(OwnerAddress,',','.'),2) as City,
PARSENAME(Replace(OwnerAddress,',','.'),1) as State
from ProjectPortfolio..HouseHolds;

alter table HouseHolds
add Owner_Address nvarchar(255);

update HouseHolds
set Owner_Address = PARSENAME(Replace(OwnerAddress,',','.'),3);

alter table HouseHolds
add Owner_City nvarchar(255);

update HouseHolds
set Owner_City = PARSENAME(Replace(OwnerAddress,',','.'),2);

alter table HouseHolds
add Owner_State nvarchar(255);

update HouseHolds
set Owner_State = PARSENAME(Replace(OwnerAddress,',','.'),1);

select OwnerAddress, Owner_Address, Owner_City, Owner_State
from HouseHolds;

--   Sold as vacant or not (yes/no)

select distinct(SoldAsVacant),count(SoldAsVacant)
from HouseHolds
group by SoldAsVacant
order by 2;

select SoldAsVacant,
case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end
from HouseHolds

update HouseHolds
set
SoldAsVacant = case
	when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
end
;

-- Removing Duplicates  (note: do not remove any data from original raw data, always use temp tables or make a copy first)

select *,
ROW_NUMBER() Over(
					partition by ParcelID,
								 PropertyAddress,
								 SaleDate,
								 SalePrice,
								 LegalReference
								 order by 
									UniqueID
) Row_num
from HouseHolds
order by ParcelID;

with RowNum as
(
select *,
ROW_NUMBER() Over(
					partition by ParcelID,
								 PropertyAddress,
								 SaleDate,
								 SalePrice,
								 LegalReference
								 order by 
									UniqueID
) Row_num
from HouseHolds
)
select * from RowNum;

with RowNum as
(
select *,
ROW_NUMBER() Over(
					partition by ParcelID,
								 PropertyAddress,
								 SaleDate,
								 SalePrice,
								 LegalReference
								 order by 
									UniqueID
) Row_num
from HouseHolds
)
select * from RowNum
where Row_num > 1;

with RowNum as
(
select *,
ROW_NUMBER() Over(
					partition by ParcelID,
								 PropertyAddress,
								 SaleDate,
								 SalePrice,
								 LegalReference
								 order by 
									UniqueID
) Row_num
from HouseHolds
)
delete from RowNum
where Row_num > 1;



-- Removing Unnecessary Columns

select * 
from ProjectPortfolio.dbo.HouseHolds;

alter table ProjectPortfolio.dbo.HouseHolds
drop column PropertyAddress,OwnerAddress,TaxDistrict;

