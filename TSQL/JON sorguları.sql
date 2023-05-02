select 
	C.CategoryID,
	C.CategoryName,
	COUNT(*) AS UrunSayisi
from Categories AS C
INNER JOIN Products AS P
	ON C.CategoryID = P.CategoryID
group by C.CategoryID,C.CategoryName


select 
*
from Categories AS C
LEFT JOIN Products AS P
	ON C.CategoryID = P.CategoryID
where C.CategoryID = 9

select 
	C.CategoryID,
	C.CategoryName,
	COUNT(P.ProductID) AS UrunSayisi
from Categories AS C
LEFT JOIN Products AS P
	ON C.CategoryID = P.CategoryID
group by C.CategoryID,C.CategoryName

select 
	C.CategoryID,
	C.CategoryName,
	COUNT(P.ProductID) AS UrunSayisi
from Products AS P
LEFT JOIN Categories AS C
	ON C.CategoryID = P.CategoryID
group by C.CategoryID,C.CategoryName

--2 ve daha az sipariþ veren müsterilerin listesini veren sorgu 
--(CustomerID, ContactTitle, ContactName, SiparisSayisi)

select 
	C.CustomerID,
	C.ContactTitle,
	C.ContactName,
	COUNT(O.OrderID) AS SiparisSayisi
from Customers AS C
LEFT JOIN Orders AS O 
	ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID,
	C.ContactTitle,
	C.ContactName
HAVING COUNT(O.OrderID) <=2

--En Deðerli çalýþaný bulan sorgu
select TOP 1 E.FirstName, E.LastName,SUM(OD.Quantity*OD.UnitPrice) from Employees AS E
INNER JOIN Orders AS O
	ON O.EmployeeID =E.EmployeeID
INNER JOIN [Order Details] AS OD
	ON OD.OrderID = O.OrderID
GROUP BY  E.FirstName, E.LastName
ORDER BY SUM(OD.Quantity*OD.UnitPrice) DESC

-- Ayýn Personelini gösteren sorgu
DECLARE @Yil INT = 1997;
DECLARE @Ay INT = DATEPART(MONTH,GETDATE())
select 
	TOP 1
	E.FirstName, 
	E.LastName,
	DATEPART(YEAR,O.OrderDate) AS YIL,
	DATEPART(MONTH,O.OrderDate) AS AY,
	SUM(OD.Quantity*OD.UnitPrice) AS CIRO
from Employees AS E
INNER JOIN Orders AS O
	ON O.EmployeeID =E.EmployeeID
INNER JOIN [Order Details] AS OD
	ON OD.OrderID = O.OrderID
WHERE 
	DATEPART(YEAR,O.OrderDate) = @Yil 
	AND DATEPART(MONTH,O.OrderDate) = @Ay
GROUP BY  FirstName,LastName,DATEPART(YEAR,O.OrderDate),DATEPART(MONTH,O.OrderDate)
order by CIRO DESC

--Session bazlý sanal Tablo olusturma
--WITH AS Yönetemi
WITH sanalTablo AS (
	select 
		E.FirstName, 
		E.LastName,
		DATEPART(YEAR,O.OrderDate) AS YIL,
		DATEPART(MONTH,O.OrderDate) AS AY,
		SUM(OD.Quantity*OD.UnitPrice) AS CIRO
	from Employees AS E
	INNER JOIN Orders AS O
		ON O.EmployeeID =E.EmployeeID
	INNER JOIN [Order Details] AS OD
		ON OD.OrderID = O.OrderID
	GROUP BY  FirstName,LastName,DATEPART(YEAR,O.OrderDate),DATEPART(MONTH,O.OrderDate)
)

select * from sanalTablo
where YIL = 1997

-- INTO Yonetimi
	select 
		E.EmployeeID,
		E.FirstName, 
		E.LastName,
		DATEPART(YEAR,O.OrderDate) AS YIL,
		DATEPART(MONTH,O.OrderDate) AS AY,
		SUM(OD.Quantity*OD.UnitPrice) AS CIRO
	INTO #sanalTablo
	from Employees AS E
	INNER JOIN Orders AS O
		ON O.EmployeeID =E.EmployeeID
	INNER JOIN [Order Details] AS OD
		ON OD.OrderID = O.OrderID
	GROUP BY  E.EmployeeID,FirstName,LastName,DATEPART(YEAR,O.OrderDate),DATEPART(MONTH,O.OrderDate)

	DROP TABLE #sanalTablo

	select * from #sanalTablo

