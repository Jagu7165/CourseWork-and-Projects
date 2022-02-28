--------------------------------------------------------------------------------------------------------------------------------------------------------
-------Assignment 10b
--------------------------------------------------------------------------------------------------------------------------------------------------------
use AdventureWorks;


 -------1) List the name of each sales person and the sum total due of their sales orders (17 rows) 

 Select  FirstName , LastName, Sum(LineTotal) as SumTotal
 from Sales.SalesOrderDetail SOD
 inner join Sales.SalesOrderHeader SOH
 on SOH.SalesOrderID = SOD.SalesOrderID
inner join Sales.SalesPerson SP
on SOH.SalesPersonID = SP.BusinessEntityID
inner join HumanResources.Employee HRE
on HRE.BusinessEntityID = SP.BusinessEntityID
inner join Person.Person PP
on PP.BusinessEntityID = HRE.BusinessEntityID
group by FirstName, LastName;




--------2) What is the average standard cost of all products that are Gloves and the culture is listed as "Thai" Show
-------------the Product Name and the Culture Name (6 rows returned)
select PC.Name as Culture, PP.Name as Product, AVG(StandardCost) as AVGCOST
from Production.Culture PC
inner join Production.ProductModelProductDescriptionCulture PDC
on PDC.CultureID = PC.CultureID
inner join Production.ProductModel PM
on PM.ProductModelID = PDC.ProductModelID
inner join Production.Product PP
on PP.ProductModelID = PM.ProductModelID
inner join Production.ProductSubcategory PSC
on PSC.ProductSubcategoryID = PP.ProductSubcategoryID
where PSC.Name = 'Gloves' and PC.Name = 'Thai'
group by PP.Name, PC.Name;


 -------3) List the name of each department and how many current workers are in each department (16 rows) 

 Select D.Name, count(*) as NumOfWOrkers
 from HumanResources.Department D
 inner join HumanResources.EmployeeDepartmentHistory EDH
 on D.DepartmentID = EDH.DepartmentID
 inner join HumanResources.Employee E
 on E.BusinessEntityID = EDH.BusinessEntityID
 inner join Person.Person PP
 on PP.BusinessEntityID = E.BusinessEntityID
 group by D.Name;




 -------4) Show the average pay rate for each department name. Order the list by Average Pay Rate in descending order (16 rows) 

  Select D.Name, AVG(Rate) as AveragePayRate
 from HumanResources.Department D
 inner join HumanResources.EmployeeDepartmentHistory EDH
 on D.DepartmentID = EDH.DepartmentID
 inner join HumanResources.Employee E
 on E.BusinessEntityID = EDH.BusinessEntityID
 inner join HumanResources.EmployeePayHistory EP
 on EP.BusinessEntityID = E.BusinessEntityID
 group by D.Name
 Order by AveragePayRate DESC;




 -------5) Show the number of people who live in each zip code for those zip codes that have 100 or more people.
 ----------Arrange the list by number of people in descending order then zip code (52 rows) 

 
 select PostalCode, Count(*) as NumOfHumanBeings
 from Person.Address PA
 inner join Person.BusinessEntityAddress PBA
 on PBA.AddressID = PA.AddressID
 inner join Person.BusinessEntity PB
 on PB.BusinessEntityID = PBA.BusinessEntityID
 inner join Person.Person PP
 on PP.BusinessEntityID = PBA.BusinessEntityID
 group by PostalCode
 having Count(*)>=100
 order by NumOfHumanBeings DESC, PostalCode;


------- 6) What is the name of the person(s) who have the below average Sales Year to Date and what is the amount of sales (9 row)


Select FirstName, LastName, SalesYTD
from Sales.SalesPerson SP
inner join HumanResources.Employee HRE
on HRE.BusinessEntityID = SP.BusinessEntityID
inner join Person.Person PP
on PP.BusinessEntityID = HRE.BusinessEntityID
where SalesYTD< (Select Avg(SalesYTD) from Sales.SalesPerson);
 




 -------7) List the product name and scrap reason name and the total scrap quantity per product name and scrap reason name for those
 ----------products that have more than 100 total items scrapped. Arrange the list from highest to lowest quantity (25 rows) 
	Select PP.Name, SR.Name, SUM(ScrappedQTY)
	from Production.ScrapReason SR
	inner join Production.WorkOrder WO
	on WO.ScrapReasonID = SR.ScrapReasonID
	inner join Production.Product PP
	on PP.ProductID = WO.ProductID
	group by PP.Name, SR.Name
	having SUM(ScrappedQTY)>100
	order by SUM(ScrappedQTY) DESC;
 




 -------8) Show the number of employees per state province. Arrange the list by highest number of employees then by state province name (14 rows) 

 
 Select SP.Name as State_Provinance, Count(*) as NumOfEmployees
 from HumanResources.Employee E
 inner join Person.Person PP
 on PP.BusinessEntityID = E.BusinessEntityID
 inner join Person.BusinessEntity BE
 on BE.BusinessEntityID = pp.BusinessEntityID
 inner join Person.BusinessEntityAddress BEA
 on BEA.BusinessEntityID = BE.BusinessEntityID
 inner join Person.Address PA
 on PA.AddressID = BEA.AddressID
 inner join Person.StateProvince SP
 on SP.StateProvinceID = PA.StateProvinceID
 group by SP.Name
 order by NumOfEmployees DESC, State_Provinance;

 -------9) Per department, how many employees have over 50 hours of vacation (11 row) 

 select HRD.Name, Count(*) as Num_Of_Employees_With_50orMore_Vacahrs
 from HumanResources.Department HRD
 inner join HumanResources.EmployeeDepartmentHistory HRDE
 on HRDE.DepartmentID = HRD.DepartmentID
 inner join HumanResources.Employee HRE
 on HRE.BusinessEntityID = HRDE.BusinessEntityID
 where HRE.VacationHours > 50
 group by HRD.name;



 -------10) Show the location name, the scrap reason and the number of products that were scrapped per location and scrap
 ------------reason. Show only those that had 5 or more products scrapped. Order by the number of products highest to lowest,
 ------------then by scrap reason and location (34 row) 
 select PL.Name, SR.Name, Sum(ScrappedQTY) as NumOfProductsScrapped
 from Production.Location PL
 inner join Production.WorkOrderRouting WOR
 on WOR.LocationID = PL.LocationID
 inner join Production.WorkOrder WO
 on WO.ProductID = WOR.ProductID
 inner join Production.ScrapReason SR
 on SR.ScrapReasonID = WO.ScrapReasonID
 where ScrappedQty >= 5
 group by SR.Name, PL.Name
 order by NumOfProductsScrapped DESC, SR.Name, PL.Name;
