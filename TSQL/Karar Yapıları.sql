--Database arasýnda geçiþ yapmak amacýyla kullanýlýr
use NORTHWND

--SupplierID'si 3ten farklý olan ürünlerin listesini veren sorgu
select * from Products where SupplierID!=3

-- Like operatorunu kullanma
-- % iþareti bir yada daha fazla herhangi bir karakter icin kullanýlýr
-- _ iþareti herhangi bir karakter icin kullanýlýr
-- ^ degilse ifadesi iciin kullanýlýr
-- [A-F] aralýk belirtmek icin kullanýlan patterndir.
SELECT * FROM Products WHERE ProductName NOT LIKE '[A]%'

--Tarih Zaman Fonksiyonlarý
--SQL sunucusu üzerindeki anlýk tarih degerini verir
select GETDATE()

--Belirtli bir tarihe gün ay yýl gibi degerleri eklemek icin kullanýlýr
DECLARE @tarih DATETIME = '2000-08-25'
select DATEADD(WEEK,-2,@tarih)

--Son 2 haftanýn satýslarýný getiren sorgu
DECLARE @tarih DATETIME = '1998-04-21 00:00:00.000'
select * from Orders where OrderDate>DATEADD(WEEK,-2,@tarih)

--DATEDIFF Fonskiyonu
DECLARE @dogumTarihi DATE = '1991-08-09'
select DATEDIFF(WEEK,@dogumTarihi,GETDATE())

--BETWEEN Operatoru
select * from Products where UnitsInStock>=10 AND UnitsInStock<=20
select * from Products where UnitsInStock BETWEEN 10 and 20

--Belirli tarih üzerinden baslýca kýsýmlarý almak amacýyla kullanýlýr
select DATEPART(WEEKDAY,GETDATE())

--KARAKTERSEL FONKSIYONLAR
select CHAR(90)
select ASCII(']')

DECLARE @veri varchar(max) = 'Bugun hava güzel'
select CHARINDEX('Bugun',@veri) -- 1. indisten baslayarak arar
select CHARINDEX('Bugun',@veri,3) --3. indisten baslayarak arar 
select LEFT('Bugun hava güzel',3)
select RIGHT('Bugun hava güzel',3)
select SUBSTRING('Bugun hava güzel',7,4)
select LOWER('Bugun hava güzel')
select UPPER('Bugun hava güzel')
select REVERSE('Bugun hava güzel')
select 'CEM'+ LTRIM('                   MERHABA')
select RTRIM('MERHABA            ')+'CEM'
select 'CEM' +LTRIM(RTRIM('             MERHABA            '))+'CEM'
select LEN('MERHABA')

-- KOSUL IFADELERI
DECLARE @sayi INT = 9
IF @sayi>10
BEGIN
	print 'sayý 10 dan büyüktür'
END
ELSE
BEGIN
	print 'sayý 10 dan kucuktur'
END

select 
	ProductName,
	UnitsInStock,
	IIF(UnitsInStock>20,'Çok Fazla',IIF(UnitsInStock>10,'Normal','Az Kaldý')) AS Durum
from Products


select 
	ProductName,
	UnitsInStock,
	CASE 
	WHEN UnitsInStock>10 THEN  'Normal'
	WHEN UnitsInStock>20 THEN 'Çok Fazla' ELSE 'AZ KALMIS'
	END AS Durum
from Products


select * from Products where ProductName='' OR 1=1 TRUNCATE TABLE Products--asdasd' AND UnitsInStock='5454'