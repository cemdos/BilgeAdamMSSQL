--Parametre olarak gönderilen puan'a göre harf notunu hesaplayan sorgu
DECLARE @Puan INT = 75
DECLARE @HarfNotu CHAR(1);
SELECT CASE 
	WHEN @Puan>89 THEN 'A'
	WHEN @Puan>79 THEN 'B'
	WHEN @Puan>59 THEN 'C'
	WHEN @Puan>49 THEN 'D'
	WHEN @Puan>39 THEN 'E'
	WHEN @Puan>0 THEN 'F'
END
print 'Harf Notu :' + @HarfNotu

--Döngü Deyimleri
--1-10 arasý sayýlarý ekrana yazan sorgu
DECLARE @sayac INT = 1
WHILE @sayac <= 10
BEGIN
	print @sayac
	SET @sayac += 1
END

-- Min ve Max degerler arasýndaki sayýlarýn toplamýný bulan sorgu
DECLARE @min INT = 10
DECLARE @max INT = 50
DECLARE @toplam INT = 0
WHILE @min <= @max
BEGIN
 SET @toplam += @min
 SET @min += 1
END
--print 'Sonuc:'+CONVERT(VARCHAR(10),@toplam)
print 'Sonuc:'+CAST(@toplam AS VARCHAR)

-- Tip Dönüsüm Ýþlemleri
select CAST ('13.12.2000' AS DATE) --Hata Döndürür
select CONVERT(DATE,'13.12.2000',104)

-- Parametre olarak gönderilen sayýnýn asal olup olmadýgýný gösteren sorgu
DECLARE @sayi INT = 6
DECLARE @bolen INT = 2
DECLARE @asaldir BIT = 1
WHILE @bolen <= @sayi/2
BEGIN
	IF @sayi % @bolen = 0 --Tam bolunuyorsa bloga gir
	BEGIN
		SET @asaldir = 0
		BREAK
	END
	SET @bolen +=1
END
print 'Durum:'+IIF(@asaldir=1,'Asaldir','Asal Deðildir')
--print 'Durum:'+CAST(@asaldir AS VARCHAR)

--Min -Max arasýndaki asal sayýlarý bulan sorgu
DECLARE @min INT = 10
DECLARE @max INT = 100
WHILE @min <=@max
BEGIN
	DECLARE @sayi INT = @min
	DECLARE @bolen INT = 2
	DECLARE @asaldir BIT = 1
	WHILE @bolen <= @sayi/2
	BEGIN
		IF @sayi % @bolen = 0 --Tam bolunuyorsa bloga gir
		BEGIN
			SET @asaldir = 0
			BREAK
		END
		SET @bolen +=1
	END
	IF @asaldir = 1
	BEGIN
		print @sayi
	END
	SET @min+=1
END