--Her bir kategoriye baglý ürün sayýsýný veren sorgu
select CategoryID,COUNT(*) as UrunSayisi from Products group by CategoryID

select COUNT(*) as UrunSayisi from Products

--Burda 91 kayýt cýkmamasýnýn nedeni fax numaraýs null olan verilerin olmasýndan kaynaklanmaktadýr.
select COUNT(Fax) from Customers

select AVG(UnitPrice) from Products
select MIN(UnitPrice) from Products
select MAX(UnitPrice) from Products
select SUM(UnitPrice) from Products
select CAST(ROUND(SUM(UnitPrice),0) AS float) from Products

--Her kategorideki ortalama birim fiyatý gösteren sorgu
select 
	CategoryID,
	CAST(ROUND(AVG(UnitPrice),2) as varchar) + ' $' as AverageUnitPrice 
from Products 
group by CategoryID

--Her kategorideki ortalama birim fiyatý gösteren sorgu
select 
	(select C.CategoryName from Categories AS C where C.CategoryID = P.CategoryID) AS KategoriAdi,
	CategoryID,
	CAST(ROUND(AVG(UnitPrice),2) as varchar) + ' $' as AverageUnitPrice 
from Products AS P 
group by CategoryID

--Her bir Musteriye ait olan sipariþ sayisiný veren sorgu
select 
	CustomerID,
	(select ContactTitle+' - '+ContactName from Customers as c where c.CustomerID=o.CustomerID) as MusteriBilgisi,
	COUNT(*) as SiparisSayisi 
from Orders AS o 
group by CustomerID

--Her bir Musteriye ait olan sipariþ sayisiný veren sorgu
select 
	CustomerID,
	(select ContactTitle from Customers as c where c.CustomerID=o.CustomerID) as ContactTitle,
	(select ContactName from Customers as c where c.CustomerID=o.CustomerID) as ContactName,
	COUNT(*) as SiparisSayisi 
from Orders AS o 
group by CustomerID

--Her bir personelin baglý oldugu yöneticisinin adýný ve soyadý gösteren sorgu
select 
	EmployeeID,
	LastName,
	FirstName,
	ReportsTo,
	(select FirstName +' '+ LastName from Employees AS e2 where e2.EmployeeID = e1.ReportsTo) AS Yoneticisi 
from Employees AS e1

--Her bir sipariþ için ne kadar bir ödeme alýndýgýný gosteren sorgu
select 
	OrderID,
	SUM(UnitPrice*Quantity) as ToplamUcret 
from [Order Details] 
group by OrderID
having SUM(UnitPrice*Quantity)>2000

--Her bir sipariþi kime ve ne kadar ücret alýndýgýný gösteren sorgu
SELECT 
	OrderID, 
    SUM(UnitPrice*Quantity) as Toplam,
       (SELECT 
      		(SELECT c.ContactName+' '+c.ContactTitle 
      			FROM Customers AS c 
      		 WHERE c.CustomerID=o.CustomerID) 
        FROM Orders AS o 
		WHERE o.OrderID=od.OrderID) as CustomerInfo
FROM [Order Details] as od
GROUP BY OrderID 
HAVING SUM(UnitPrice*Quantity)>2000

select 
	od.OrderID,
	SUM(od.UnitPrice*od.Quantity) as Toplam,
	c.ContactTitle+' ' +c.CompanyName as CustomerInfo
from [Order Details] as od
	 ,Orders as o
	 ,Customers as c
where 
	od.OrderID = o.OrderID
	AND o.CustomerID = c.CustomerID
group by od.OrderID,c.ContactTitle,c.CompanyName
having SUM(od.UnitPrice*od.Quantity)>2000

select * 
from Categories as c
RIGHT JOIN Products as p
	ON p.CategoryID = c.CategoryID
where CategoryName IN ('Elektrik','Elektronik') OR ProductName IN ('A1 Ürünü', 'A2 Ürünü')

select * 
from Categories as c
CROSS JOIN Products as p
where CategoryName IN ('Elektrik','Elektronik') OR ProductName IN ('A1 Ürünü', 'A2 Ürünü')
