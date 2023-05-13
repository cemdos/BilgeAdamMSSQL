--FUNCTIONS
--1 den 10 a kadar olan sayýlarý toplayan function olusturalým
CREATE FUNCTION f_Topla()
RETURNS INT
AS
BEGIN
	DECLARE @min INT = 1
	DECLARE @toplam INT = 0
	WHILE @min<= 10
	BEGIN
		SET @toplam+=@min
		SET @min+=1
	END
	RETURN @toplam
END
--Cagýrma Sekli
select dbo.f_Topla()

--KAtegoriye gore urun sayýsýný veren fonksiyonu olusturalým
CREATE FUNCTION f_KategoriyeGoreUrun()
RETURNS TABLE
AS
RETURN 
(
	select C.CategoryID,CategoryName,COUNT(P.ProductID) AS UrunSayisi 
	from Categories AS C
	LEFT JOIN Products AS P
		ON C.CategoryID = P.CategoryID
	GROUP BY C.CategoryID,CategoryName
)

select 
	KGU.*,
	C.Description
from dbo.f_KategoriyeGoreUrun() AS KGU
INNER JOIN Categories AS C
	ON C.CategoryID = KGU.CategoryID

-- 1 den 100 e kadar olan sayýlarý tablo olarak geriye döndüren fonksiyonu yazýnýz
CREATE FUNCTION f_SayiListesi()
RETURNS @sayilar TABLE (deger INT)
AS 
BEGIN
	DECLARE @min INT = 1;
	WHILE @min <= 100
	BEGIN
		INSERT INTO @sayilar VALUES (@min)
		SET @min+=1
	END
	RETURN
END

select * from f_SayiListesi()

--Ciro Hesaplama iþlemi yapan fonksiyonu olusturalým
CREATE FUNCTION f_CiroHesapla(@BirimFiyat float, @Miktar INT, @Indirim REAL)
RETURNS MONEY
AS
BEGIN
	DECLARE @Ciro MONEY = 0;
	SET @Ciro = @BirimFiyat*@Miktar*(1-@Indirim)
	RETURN @Ciro
END

select *,dbo.f_CiroHesapla(UnitPrice,Quantity,Discount) AS Ciro from [Order Details]

--Rastgele kelime olusturan bir fonksiyon olusturalým

select FLOOR(65+RAND()*25)
select ASCII('A')
select ASCII('Z')
select CHAR(65)

CREATE VIEW RastgeleSayi
AS
select RAND() as Sayi 

CREATE FUNCTION f_RastgeleKelimeUret(@HarfSayisi INT = NULL)
RETURNS VARCHAR(MAX)
AS
BEGIN
	IF @HarfSayisi IS NULL
	BEGIN
		SET @HarfSayisi = ROUND(1+(select Sayi from RastgeleSayi)*10,0)
	END

	DECLARE @RastgeleKelime VARCHAR(MAX) = ''
	WHILE @HarfSayisi>0
	BEGIN
		--A ile Z arasýndaki harflerin ASCII kodunu almak icin asagýdaki kodu yazdýk
		DECLARE @RastgeleSayi INT = FLOOR(65+(select Sayi from RastgeleSayi)*25)
		DECLARE @RastgeleHarf CHAR(1) = CHAR(@RastgeleSayi)
		SET @RastgeleKelime+=@RastgeleHarf
		SET @HarfSayisi-=1
	END
	RETURN @RastgeleKelime
END

select dbo.f_RastgeleKelimeUret(NULL)

-- Rastgele cümle olusturan bir fonksiyon yapalým
CREATE FUNCTION f_RastgeleCumleUret(@KelimeSayisi INT = NULL)
RETURNS VARCHAR(MAX)
AS
BEGIN
	IF @KelimeSayisi IS NULL
	BEGIN
		SET @KelimeSayisi = ROUND(1+(select Sayi from RastgeleSayi)*10,0)
	END
	DECLARE @Cumle VARCHAR(MAX) = ''
	WHILE @KelimeSayisi>0
	BEGIN
		SET @Cumle += dbo.f_RastgeleKelimeUret(NULL) + ' '
		SET @KelimeSayisi-=1
	END
	RETURN @Cumle
END

select  dbo.f_RastgeleCumleUret(NULL)

-- Rastgele Cumlelerden olusan ve geriye tablo olarak geriye dönüþ yapan fonksiyon olusturunuz