-- Global De�i�kenler
--select @@CONNECTIONS
--select @@CPU_BUSY
--select @@LANGUAGE
--select @@MAX_CONNECTIONS
--select @@SERVERNAME
--select @@SERVICENAME

--Local De�i�kenler
DECLARE @sayi INT = 25
DECLARE @veri VARCHAR(MAX) = 'merhaba d�nya'
SET @sayi += 1
SET @veri += 'nas�ls�n'
select @sayi = 50, @veri = 'Ara verelim'

SELECT @sayi AS sayi,@veri AS metin

select CompanyName from Customers

DECLARE @Musteri VARCHAR(MAX)
select @Musteri = CompanyName from Customers where CompanyName='Alfreds Futterkiste'
select @Musteri

