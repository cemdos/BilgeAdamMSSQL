-- Global Deðiþkenler
--select @@CONNECTIONS
--select @@CPU_BUSY
--select @@LANGUAGE
--select @@MAX_CONNECTIONS
--select @@SERVERNAME
--select @@SERVICENAME

--Local Deðiþkenler
DECLARE @sayi INT = 25
DECLARE @veri VARCHAR(MAX) = 'merhaba dünya'
SET @sayi += 1
SET @veri += 'nasýlsýn'
select @sayi = 50, @veri = 'Ara verelim'

SELECT @sayi AS sayi,@veri AS metin

select CompanyName from Customers

DECLARE @Musteri VARCHAR(MAX)
select @Musteri = CompanyName from Customers where CompanyName='Alfreds Futterkiste'
select @Musteri

