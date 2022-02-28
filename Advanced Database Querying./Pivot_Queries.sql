

use AdventureWorks;


--1. Display the name of the day, the average online order sales subtotal and average
-----in-store order sales subtotal for each day of the week (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday).
-----You should have days of the week as headers across the top and Online vs In store down the side
-----(Complete both Static and Dynamic Pivot Query)


--------------------------------------------------------------------------------------------------------------------------------------------
------Static Query 
--------------------------------------------------------------------------------------------------------------------------------------------
Select ORDERTYPE, [SUNDAY], [MONDAY],[TUESDAY], [WEDNESDAY],[THURSDAY], [FRIDAY], [SATURDAY]
from
(
Select OnlineOrderFlag, SubTotal, DATENAME(weekday, OrderDate) as DAYOFWEEK,
case
	when OnlineOrderFlag = 1 Then 'Online Purchase'
	else 'In-Store Purchase'
	end as ORDERTYPE
from Sales.SalesOrderHeader 
)dateTable
Pivot
(AVG(SubTotal)
for  DAYOFWEEK in ([Sunday],[Monday],[TUESDAY],[WEDNESDAY], [THURSDAY], [FRIDAY], [SATURDAY] )
)
as PivotTable
order by OnlineOrderFlag DESC;





---------------------------------------------------------------------------------------------------------------------------------------------
-------Dynamic Query
---------------------------------------------------------------------------------------------------------------------------------------------



declare @columns nvarchar(MAX),
		@sql nvarchar(MAX);

set @columns = N'';

select @columns += N', ' + WEEKDAY
from 
(SELECT Distinct QUOTENAME(DATENAME(Weekday,OrderDate)) as WEEKDAY
from sales.SalesOrderHeader) t1

set @columns = STUFF(@columns, 1,1,'');

set @sql =
N'Select ORDERTYPE, '+ @columns + N'
from
(
Select OnlineOrderFlag, SubTotal, DATENAME(weekday, OrderDate) as DAYOFWEEK,
case
	when OnlineOrderFlag = 1 Then ''Online Purchase''
	else ''In-Store Purchase''
	end as ORDERTYPE
from Sales.SalesOrderHeader 
)dateTable
Pivot
(AVG(SubTotal)
for  DAYOFWEEK in (' + @columns + N' )
)
as PivotTable
order by OnlineOrderFlag DESC';


 execute sp_executesql @sql;





--2. List each product category and the total number of units sold by month.You should have names of the months as headers across the top
-----and product categories down the side (Complete both Static and Dynamic Pivot Query)

----------------------------------------------------------------------------------------------------------------------------------------------
-------Static Query
----------------------------------------------------------------------------------------------------------------------------------------------


Select CATEGORY, [JANUARY],[FEBRUARY], [MARCH],[APRIL], [MAY], [JUNE], [JULY], [AUGUST], [SEPTEMBER], [OCTOBER], [NOVEMBER], [DECEMBER]
from
(
Select pc.name as CATEGORY, sd.OrderQty, DATENAME(mm, sh.Orderdate) as ORDERMONTH
from Production.ProductCategory pc
inner join Production.ProductSubcategory sc
on pc.ProductCategoryID = sc.ProductCategoryID
inner join Production.Product pr
on sc.ProductSubcategoryID = pr.ProductSubcategoryID
inner join Sales.SalesOrderDetail sd
on sd.ProductID = pr.ProductID
inner join  Sales.SalesOrderHeader sh
on sh.SalesOrderID = sd.SalesOrderID
) dt
Pivot
(SUM(OrderQty)
for ORDERMONTH in ([JANUARY],[FEBRUARY], [MARCH],[APRIL], [MAY], [JUNE], [JULY], [AUGUST], [SEPTEMBER], [OCTOBER], [NOVEMBER], [DECEMBER] )
)
as PivotTable
order by Category;


---------------------------------------------------------------------------------------------------------------------------------------------
-------DYNAMIC QUERY
---------------------------------------------------------------------------------------------------------------------------------------------

set @columns = N'';

select @columns += N', ' + MONTHS
from (
select Distinct QUOTENAME(DATENAME(mm, Orderdate)) AS MONTHS
from Sales.SalesOrderHeader) t2

set @sql = N'';
set @columns = STUFF(@columns, 1,1,'');

set @sql = 
N'Select CATEGORY, ' + @columns + N'
from
(
Select pc.name as CATEGORY, sd.OrderQty, DATENAME(mm, sh.Orderdate) as ORDERMONTH
from Production.ProductCategory pc
inner join Production.ProductSubcategory sc
on pc.ProductCategoryID = sc.ProductCategoryID
inner join Production.Product pr
on sc.ProductSubcategoryID = pr.ProductSubcategoryID
inner join Sales.SalesOrderDetail sd
on sd.ProductID = pr.ProductID
inner join  Sales.SalesOrderHeader sh
on sh.SalesOrderID = sd.SalesOrderID
) dt
Pivot
(SUM(OrderQty)
for ORDERMONTH in (' +@columns + N' )
)
as PivotTable
order by Category';

execute sp_executesql @sql;


