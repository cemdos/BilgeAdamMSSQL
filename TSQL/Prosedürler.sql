--PROSEDURLER
-- 1-10 arasý sayýlarý mesaj bolumunda yazan prosedürü olusturun ve cagýrýn
CREATE PROC sp_EkranaYaz
AS
BEGIN
	DECLARE @sayac INT = 1
	WHILE @sayac<=10
	BEGIN
		print @sayac
		SET @sayac+=1
	END
END
--Cagýrma Sekli
EXEC sp_EkranaYaz

--Min ve max degerler arasýndaki sayýlarý ekrana yazan proc
CREATE OR ALTER PROC sp_MinMaxYaz @min INT = 0, @max INT=10
AS
BEGIN
	WHILE @min <= @max
	BEGIN
		PRINT @min
		SET @min+=1
	END
END

EXEC sp_MinMaxYaz 5

--Min Max arasýndaki sayýlarýn toplamýný geriye döndüren proc
CREATE PROC sp_Topla @min INT, @max INT
AS
BEGIN
	DECLARE @toplam INT = 0;
	WHILE @min<=@max
	BEGIN
		SET @toplam+=@min
		SET @min+=1
	END
	RETURN @toplam
END

DECLARE @sonuc INT
EXEC @sonuc = sp_Topla 1,10
select @sonuc

-- min - max arasýndaki sayýlarý tablo üzerinde döndüren proc
CREATE PROC sp_MinMaxTablo @min INT, @max INT
AS
BEGIN
	DECLARE @tablo TABLE(deger INT)
	WHILE @min<=@max
	BEGIN
		INSERT INTO @tablo (deger)
		VALUES (@min)
		SET @min+=1
	END
	select * from @tablo
END
--ÇAgýrma Sekli
EXEC sp_MinMaxTablo 10,20

--Her bir kategoriye baglý ürün sayýsýný veren sp_KategoriyeUrun isimli prosedürü olusturun
CREATE PROC sp_KategoriyeUrun 
AS
BEGIN
	SELECT C.CategoryName,COUNT(P.ProductID) AS UrunSayisi FROM Categories AS C 
	LEFT JOIN Products AS P ON P.CategoryID=C.CategoryID 
	GROUP BY C.CategoryName
END

EXEC sp_KategoriyeUrun


CREATE OR ALTER PROC sp_KategoriyeUrun @CategoryID INT = NULL
AS
BEGIN
	IF @CategoryID IS NULL
	BEGIN
		SELECT C.CategoryID,C.CategoryName,COUNT(P.ProductID) AS UrunSayisi FROM Categories AS C 
		LEFT JOIN Products AS P ON P.CategoryID=C.CategoryID 
		GROUP BY  C.CategoryID,C.CategoryName
	END
	ELSE
	BEGIN
		SELECT * FROM Products where CategoryID = @CategoryID
	END
END

EXEC sp_KategoriyeUrun 3
DROP PROC sp_KategoriyeUrun

-- Kalaný geriye döndüren bölme islemi prosedür ile yapalým
CREATE PROC sp_Bolme @Bolunen INT, @Bolen INT, @Kalan INT OUTPUT
AS
BEGIN
	DECLARE @Bolum INT = @Bolunen / @Bolen
	SET @Kalan = @Bolunen % @Bolen
	RETURN @Bolum
END

DECLARE @Sonuc INT
DECLARE @SonucKalan INT
EXEC @Sonuc = sp_Bolme 185,7,@SonucKalan OUTPUT
select @Sonuc,@SonucKalan

DECLARE @Username VARCHAR(MAX) = 'asdhashd--'
DECLARE @Password VARCHAR(MAX) = 'asdhashd--'
select * from User where Username=@Username AND Password = @Password