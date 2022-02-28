

Use AdventureWorks;


--1. Show the first and last name, address, city and state, email address, phone number and phone type of people from the following 
---cities Yakima Washington, Birmingham England, Columbus Ohio, Cambridge England and Burbank California. Arrange the list alphabetically
---by city then last name then first name (351 rows returned)

Select  FirstName, LastName, EmailAddress, PhoneNumber, PPNT.[Name],  AddressLine1, City, PSP.[Name]
from Person.StateProvince PSP
inner join Person.Address PA
on PA.StateProvinceID = PSP.StateProvinceID
inner join Person.BusinessEntityAddress PBEA
on PBEA.AddressID = PA.AddressID
inner join Person.BusinessEntity PBE
on PBE.BusinessEntityID = PBEA.BusinessEntityID
inner join Person.Person PP
on PP.BusinessEntityID = PBE.BusinessEntityID
inner join Person.PersonPhone PPP
on PPP.BusinessEntityID = PP.BusinessEntityID
inner join Person.PhoneNumberType PPNT
on PPNT.PhoneNumberTypeID = PPP.PhoneNumberTypeID
inner join Person.EmailAddress PEA
on PEA.BusinessEntityID = PP.BusinessEntityID
where concat(City, ' ', PSP.[Name]) = 'Yakima Washington'
or concat(City, ' ', PSP.[Name]) ='Birmingham England'
or concat(City, ' ', PSP.[Name]) = 'Columbus Ohio'
or concat(City, ' ', PSP.[Name]) ='Cambridge England' 
or concat(City, ' ', PSP.[Name]) ='Burbank California'
order by City, LastName, FirstName;


 
--2. Show the first and last names of the employees, their job title, their birth date formatted as three character month two digit day 
---four digit year and shift name. Arrange the list by job title, last name then first name (296 rows returned)

	Select FirstName, LastName, PersonType, Format(BirthDate, 'dd/MM/yyyy') as Birthday, HRS.[Name]
	from Person.Person PP
	inner join HumanResources.Employee HRE
	on HRE.BusinessEntityID = PP.BusinessEntityID
	inner join HumanResources.EmployeeDepartmentHistory HRED
	on HRED.BusinessEntityID = HRE.BusinessEntityID
	inner join HumanResources.[Shift] HRS
	on HRS.ShiftID = HRED.ShiftID
	order by PersonType, LastName, FirstName;

	
--3. Show the names of the vendors and the products that they manufacture for those vendors who manufacture pedals. Order the list by vendors
---then by product name (11 rows returned)

select PV.[Name] , pp.[Name]
from Purchasing.Vendor PV
inner join Purchasing.ProductVendor PPV
on PPV.BusinessEntityID = PV.BusinessEntityID
inner join Production.Product PP
on pp.ProductID = PPV.ProductID
where pp.[Name] like '%Pedal%'
order by PV.[Name], pp.[Name];



--4. Show the product name, standard cost, list price, quantity and location name for products whose list price is greater than zero and
---located in Final Assembly where the quantity is between 200 and 500. Arrange the list by standard cost then quantity(13 rows returned)
 Select PP.[Name], CostRate as StandardPrice, PP.ListPrice, Quantity, PL.[Name]
 from Production.Product PP
 inner join Production.ProductInventory PPI
 on PPI.ProductID = PP.ProductID
 inner join Production.Location PL
 on PL.LocationID = PPI.LocationID
 where (PP.ListPrice > 0 ) and (PL.[Name] = 'Final Assembly') and (Quantity between 200 and 500)
 order by CostRate, PP.ListPrice;

--5. Show the products that have been scrapped and the reason they were scrapped problem with the drill size. Arrange the list by product
---then reason (86 rows returned)

Select PP.[Name] , SR.[Name]
from Production.ScrapReason SR
inner join Production.WorkOrder WO
on WO.ScrapReasonID = SR.ScrapReasonID
inner join Production.Product PP
on PP.ProductID = WO.ProductID
where SR.[Name] like '%Drill size%'
order by PP.[Name], SR.[Name];

    
--6.  Show the vendor name, the product name, the ship date, the difference between the order quantity and the received quantity for those
---products where the received quantity was at least 50 less than the order quantity. Show the difference. Arrange the list by the greatest
---difference. (514 rows returned)

Select *
from Purchasing.ProductVendor PPV
inner join Production.Product PP
on pp.ProductID = ppv.ProductID
inner join Purchasing.Vendor PV
on pv.BusinessEntityID = PPV.BusinessEntityID
inner join Purchasing.PurchaseOrderHeader PPOH
on PPOH.VendorID = PV.BusinessEntityID
inner join Purchasing.PurchaseOrderDetail PPOD
on PPOD.PurchaseOrderID = PPOH.PurchaseOrderID
where OrderQty >= ReceivedQty + 50;



 

--7. Show the product name, the product subcategory name, the product category name, the product model name for subcategories of Road Bikes
---or Mountain Bikes. Order the list by product name, the category, then the subcategory. (75 rows returned)

select PP.[Name] as Product, PSC.[Name] as SubCategory, PC.[Name] as Category, PM.[Name] as Model
from production.ProductCategory PC
inner join Production.ProductSubcategory PSC
on PSC.ProductCategoryID = PC.ProductCategoryID
inner join Production.Product PP
on PP.ProductSubcategoryID = PSC.ProductSubcategoryID
inner join production.ProductModel PM
on PM.ProductModelID = PP.ProductModelID
where (PSC.[Name] Like '%Mountain Bike%')  or( PSC.[Name] Like '%Road Bike%')
order by PP.[Name],PC.[Name], PSC.[Name] ;


--8.  Show the name of the product, the sales order quantity, the sales order date, the sales due date and whether the product was ordered
---online (Show as Yes)  Tire Products and were ordered in June of 2011 or August of 2013 Arrange the list by order date. (2948 rows returned)

select *
from Production.Product PP
inner join Sales.SpecialOfferProduct SSOP
on SSOP.ProductID = PP.ProductID
inner join Sales.SalesOrderDetail SSOD
on SSOD.ProductID = SSOP.ProductID and SSOD.SpecialOfferID = SSOP.SpecialOfferID
inner join Sales.SalesOrderHeader SSOH
on SSOH.SalesOrderID = SSOD.SalesOrderID
Where OnlineOrderFlag = 1
and (
OrderDate Between '2011-06-01' and '2011-06-30'
or OrderDate between '2013-08-01' and '2013-08-31'
)
and pp.Name like '%Tire%'

--9. Show the name of the sales person who had orders in the month of January of any year. Show the name only once (16 rows returned)
Select distinct concat( FirstName, ' ', LastName) as SalesPerson
from Sales.SalesOrderHeader SOH
inner join Sales.SalesPerson SP
on SOH.SalesPersonID = SP.BusinessEntityID
inner join HumanResources.Employee HRE
on HRE.BusinessEntityID = SP.BusinessEntityID
inner join Person.Person PP
on PP.BusinessEntityID = HRE.BusinessEntityID
where month(OrderDate) = 1;




---10. Show the name of the sales people. their sales territory name, the sales year to date, their bonus, commission percentage and
---sales last year. Order the list by sales territory name, then sales person last and first name. (14 rows returned)

Select FIrstName, LastName, ST.[Name], ST.SalesYTD, Bonus, CommissionPct, SP.SalesLastYear
from Sales.SalesTerritory ST
inner join Sales.SalesPerson SP
on SP.TerritoryID = ST.TerritoryID
inner join HumanResources.Employee HRE
on HRE.BusinessEntityID = SP.BusinessEntityID
inner join Person.Person PP
on PP.BusinessEntityID = HRE.BusinessEntityID
order by ST.[Name], LastName, FirstName;
