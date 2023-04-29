--Müsteri tablosundaki tüm kayýtlarý listeleyen sorgu
select * from Customers

--Kac farklý ülkeden müsteri oldugunu listeleyen sorgu
select distinct Country,City from Customers order by Country desc,City

--Her bir ülkeden kac tane müsterim oldugunu gösteren sorgu
select 
	Country,
	City,
	COUNT(*) as MusteriSayisi
from Customers group by Country,City
order by MusteriSayisi desc