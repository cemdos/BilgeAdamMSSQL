--Database aras�nda ge�i� yapmak amac�yla kullan�l�r
use NORTHWND

--SupplierID'si 3ten farkl� olan �r�nlerin listesini veren sorgu
select * from Products where SupplierID!=3

-- Like operatorunu kullanma
-- % i�areti bir yada daha fazla herhangi bir karakter icin kullan�l�r
-- _ i�areti herhangi bir karakter icin kullan�l�r
-- ^ degilse ifadesi iciin kullan�l�r
-- [A-F] aral�k belirtmek icin kullan�lan patterndir.
SELECT * FROM Products WHERE ProductName NOT LIKE '[A]%'

--Tarih Zaman Fonksiyonlar�
--SQL sunucusu �zerindeki anl�k tarih degerini verir
select GETDATE()

--Belirtli bir tarihe g�n ay y�l gibi degerleri eklemek icin kullan�l�r
DECLARE @tarih DATETIME = '2000-08-25'
select DATEADD(WEEK,-2,@tarih)

--Son 2 haftan�n sat�slar�n� getiren sorgu
DECLARE @tarih DATETIME = '1998-04-21 00:00:00.000'
select * from Orders where OrderDate>DATEADD(WEEK,-2,@tarih)

--DATEDIFF Fonskiyonu
DECLARE @dogumTarihi DATE = '1991-08-09'
select DATEDIFF(WEEK,@dogumTarihi,GETDATE())

--BETWEEN Operatoru
select * from Products where UnitsInStock>=10 AND UnitsInStock<=20
select * from Products where UnitsInStock BETWEEN 10 and 20

--Belirli tarih �zerinden basl�ca k�s�mlar� almak amac�yla kullan�l�r
select DATEPART(WEEKDAY,GETDATE())

--KARAKTERSEL FONKSIYONLAR
select CHAR(90)
select ASCII(']')

DECLARE @veri varchar(max) = 'Bugun hava g�zel'
select CHARINDEX('Bugun',@veri) -- 1. indisten baslayarak arar
select CHARINDEX('Bugun',@veri,3) --3. indisten baslayarak arar 
select LEFT('Bugun hava g�zel',3)
select RIGHT('Bugun hava g�zel',3)
select SUBSTRING('Bugun hava g�zel',7,4)
select LOWER('Bugun hava g�zel')
select UPPER('Bugun hava g�zel')
select REVERSE('Bugun hava g�zel')
select 'CEM'+ LTRIM('                   MERHABA')
select RTRIM('MERHABA            ')+'CEM'
select 'CEM' +LTRIM(RTRIM('             MERHABA            '))+'CEM'
select LEN('MERHABA')

-- KOSUL IFADELERI
DECLARE @sayi INT = 9
IF @sayi>10
BEGIN
	print 'say� 10 dan b�y�kt�r'
END
ELSE
BEGIN
	print 'say� 10 dan kucuktur'
END

select 
	ProductName,
	UnitsInStock,
	IIF(UnitsInStock>20,'�ok Fazla',IIF(UnitsInStock>10,'Normal','Az Kald�')) AS Durum
from Products


select 
	ProductName,
	UnitsInStock,
	CASE 
	WHEN UnitsInStock>10 THEN  'Normal'
	WHEN UnitsInStock>20 THEN '�ok Fazla' ELSE 'AZ KALMIS'
	END AS Durum
from Products


select * from Products where ProductName='' OR 1=1 TRUNCATE TABLE Products--asdasd' AND UnitsInStock='5454'