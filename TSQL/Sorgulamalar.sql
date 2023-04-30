--Her bir kategoriye bagl� �r�n say�s�n� veren sorgu
select CategoryID,COUNT(*) as UrunSayisi from Products group by CategoryID

select COUNT(*) as UrunSayisi from Products

--Burda 91 kay�t c�kmamas�n�n nedeni fax numara�s null olan verilerin olmas�ndan kaynaklanmaktad�r.
select COUNT(Fax) from Customers

select AVG(UnitPrice) from Products
select MIN(UnitPrice) from Products
select MAX(UnitPrice) from Products
select SUM(UnitPrice) from Products
select CAST(ROUND(SUM(UnitPrice),0) AS float) from Products

--Her kategorideki ortalama birim fiyat� g�steren sorgu
select 
	CategoryID,
	CAST(ROUND(AVG(UnitPrice),2) as varchar) + ' $' as AverageUnitPrice 
from Products 
group by CategoryID

--Her kategorideki ortalama birim fiyat� g�steren sorgu
select 
	(select C.CategoryName from Categories AS C where C.CategoryID = P.CategoryID) AS KategoriAdi,
	CategoryID,
	CAST(ROUND(AVG(UnitPrice),2) as varchar) + ' $' as AverageUnitPrice 
from Products AS P 
group by CategoryID

--Her bir Musteriye ait olan sipari� sayisin� veren sorgu
select 
	CustomerID,
	(select ContactTitle+' - '+ContactName from Customers as c where c.CustomerID=o.CustomerID) as MusteriBilgisi,
	COUNT(*) as SiparisSayisi 
from Orders AS o 
group by CustomerID

--Her bir Musteriye ait olan sipari� sayisin� veren sorgu
select 
	CustomerID,
	(select ContactTitle from Customers as c where c.CustomerID=o.CustomerID) as ContactTitle,
	(select ContactName from Customers as c where c.CustomerID=o.CustomerID) as ContactName,
	COUNT(*) as SiparisSayisi 
from Orders AS o 
group by CustomerID

--Her bir personelin bagl� oldugu y�neticisinin ad�n� ve soyad� g�steren sorgu
select 
	EmployeeID,
	LastName,
	FirstName,
	ReportsTo,
	(select FirstName +' '+ LastName from Employees AS e2 where e2.EmployeeID = e1.ReportsTo) AS Yoneticisi 
from Employees AS e1

--Her bir sipari� i�in ne kadar bir �deme al�nd�g�n� gosteren sorgu
select 
	OrderID,
	SUM(UnitPrice*Quantity) as ToplamUcret 
from [Order Details] 
group by OrderID
having SUM(UnitPrice*Quantity)>2000

--Her bir sipari�i kime ve ne kadar �cret al�nd�g�n� g�steren sorgu
SELECT 
	OrderID,�
��� SUM(UnitPrice*Quantity) as Toplam,
������ (SELECT�
������		(SELECT c.ContactName+' '+c.ContactTitle�
������			FROM Customers AS c�
������		 WHERE c.CustomerID=o.CustomerID)�
������  FROM Orders AS o 
		WHERE o.OrderID=od.OrderID) as CustomerInfo
FROM [Order Details] as od
GROUP BY OrderID�
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
where CategoryName IN ('Elektrik','Elektronik') OR ProductName IN ('A1 �r�n�', 'A2 �r�n�')

select * 
from Categories as c
CROSS JOIN Products as p
where CategoryName IN ('Elektrik','Elektronik') OR ProductName IN ('A1 �r�n�', 'A2 �r�n�')
