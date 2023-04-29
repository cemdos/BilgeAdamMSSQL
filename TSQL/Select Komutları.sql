--M�steri tablosundaki t�m kay�tlar� listeleyen sorgu
select * from Customers

--Kac farkl� �lkeden m�steri oldugunu listeleyen sorgu
select distinct Country,City from Customers order by Country desc,City

--Her bir �lkeden kac tane m�sterim oldugunu g�steren sorgu
select 
	Country,
	City,
	COUNT(*) as MusteriSayisi
from Customers group by Country,City
order by MusteriSayisi desc