----Her bir �lkeden kac tane fatura olusturuldugunu g�steren sorgu
--WITH UlkeBazliSatislar AS (
--	SELECT C.Country ,
--		   COUNT(O.OrderID) AS FaturaSayisi,
--		   ROUND(SUM((OD.Quantity*OD.UnitPrice*(1-Discount))),2) AS ToplamCiro,
--		   ROUND(SUM((OD.Quantity*OD.UnitPrice*(Discount))),2) AS ToplamIndirim
--	FROM Customers AS C
--	INNER JOIN Orders AS O
--		ON C.CustomerID = O.CustomerID
--	INNER JOIN [Order Details] AS OD
--		ON OD.OrderID = O.OrderID
--	GROUP BY  C.Country
--)
--SELECT * from UlkeBazliSatislar


WITH FaturaBazliSatislar AS (
	SELECT C.Country ,
		   O.OrderID,
		   (SELECT ROUND(SUM((OD.Quantity*OD.UnitPrice*(1-Discount)))
			,2) FROM [Order Details] AS OD WHERE OD.OrderID = 
			O.OrderID)  AS ToplamCiro,
		   (SELECT ROUND(SUM(OD.Quantity*OD.UnitPrice*(Discount)),2) 
		   FROM [Order Details] AS OD WHERE OD.OrderID = O.OrderID) 
		   AS ToplamIndirim
	FROM Customers AS C
	INNER JOIN Orders AS O
		ON C.CustomerID = O.CustomerID
)
SELECT 
	F.Country AS Ulke,
	SUM(F.ToplamCiro) AS ToplamCiro,
	SUM(F.ToplamIndirim) AS ToplamIndirim,
	COUNT(F.OrderID) AS ToplamSatislar
INTO #UlkeBazliSatislar
from FaturaBazliSatislar AS F
GROUP BY Country 

--Aktif Sanal Tablolar�n listesini veren sorgu
select * from tempdb..sysobjects where xtype='U'

-- Session ba��ms�z sanal tablo olu�turmak icin ## �eklinde yap�lmal�d�r.
select *  
INTO ##UlkeBazliSatislar
from #UlkeBazliSatislar

--Sorgu bekletmek amac�yla waitfor kullan�l�r.
WAITFOR DELAY '00:00:50';
select * from Customers

--Her bir personele bagl� cal�san say�lar�n�n listesini veren sorgu
select e1.EmployeeID,
e1.FirstName,
e1.LastName,
Count(e2.ReportsTo) as Bagl�Cal�san 
into ##sanalTablo from Employees e1
left join Employees e2 
on e1.EmployeeID=e2.ReportsTo
group by e1.EmployeeID,e1.FirstName,e1.LastName
 
select * from ##sanalTablo
drop table ##sanalTablo

-- Her bir musterimin siparislerini getiren kargo firmlar�n�n say�s�n� veren sorgu
-- (CustomerID, ContactTitle,ContactName,KargoFirmaSayisi)
SELECT 
	C.CustomerID, 
	C.ContactTitle,
	C.ContactName, 
	COUNT(DISTINCT S.ShipperID) as KargoFirmaSayisi
FROM Customers as C�
LEFT JOIN Orders AS O 
	ON C.CustomerID = O.CustomerID�
LEFT JOIN Shippers AS S 
	ON O.ShipVia=S.ShipperID
GROUP BY C.CustomerID, C.ContactTitle,C.ContactName
ORDER BY KargoFirmaSayisi

-- En fazla Siparis tas�yan kargo firmam hangisi oldugunu g�steren sorgu
-- ShipperID, CompanyName, SiparisSayisi
SELECT 
	TOP 30 PERCENT� 
	s.shipperID, 
	s.CompanyName, 
	COUNT(s.ShipperID) AS siparis�
FROM Shippers AS S
inner join ORDERS AS O
��� ON o.ShipVia = s.ShipperID
GROUP BY� s.shipperID, s.CompanyName
ORDER BY siparis DESC

--Her bir kargo firmas� kac farkl� Sehre �r�n tas�m�s
--(ShipperID, CompanyName, UrunSayisi)
SELECT 
	s.ShipperID,
	s.CompanyName,
	COUNT(distinct ShipCity) 
FROM Shippers s
JOIN Orders o
ON o.ShipVia=s.ShipperID
GROUP BY s.ShipperID,s.CompanyName
ORDER BY 3

select * from sys.all_objects where [type]='U' 