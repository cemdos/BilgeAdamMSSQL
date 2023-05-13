
--TRUNCATE KOMUTU
--Tüm tablo icerisindeki kayýtlarý siler ancak identity contrait devam eder
-- dolayýsýyla ID'ler sýfýrlanmaz
delete from Dersler

-- Tablo icerisindeki tüm kayýtlarý siler. Identity sýfýrlanýr
-- Ancak farklý bir tablonun referansý kullanýlýyorsa truncate veri tutarlýlýgýndan dolayý islemi gerceklestirmez
--truncate table Notlar
--truncate table Dersler

select * from Dersler

--SCOPE_IDENTITY Komutu
insert into Dersler values('Bilim Tarihi')
DELETE FROM Dersler where ID = 3
UPDATE Dersler set DersAdi = 'Bilim' where ID = 1
DECLARE @DersID INT = SCOPE_IDENTITY()
select @DersID

-- UNION Komutu
select 'Cem' AS AD
UNION ALL
select 'Ali' AS Adi

select CategoryName,Description from Categories
UNION ALL
select ProductName,CAST(UnitPrice AS nvarchar(MAX)) from Products

select ID,Ad from Table_1 
UNION ALL
select ID,Ad from Table_2

--Except komutu 1.tabloda olup 2. tabloda olmayan ***kayýtlarýn*** listesini döner.
select ID,Ad from Table_1 
EXCEPT
select ID,Ad from Table_2

--Intersect komutu 1.  ve 2. tabloda olan ***kayýtlarýn** listesini döner
select ID,Ad from Table_1 
INTERSECT
select ID,Ad from Table_2