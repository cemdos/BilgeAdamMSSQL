
--TRUNCATE KOMUTU
--T�m tablo icerisindeki kay�tlar� siler ancak identity contrait devam eder
-- dolay�s�yla ID'ler s�f�rlanmaz
delete from Dersler

-- Tablo icerisindeki t�m kay�tlar� siler. Identity s�f�rlan�r
-- Ancak farkl� bir tablonun referans� kullan�l�yorsa truncate veri tutarl�l�g�ndan dolay� islemi gerceklestirmez
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

--Except komutu 1.tabloda olup 2. tabloda olmayan ***kay�tlar�n*** listesini d�ner.
select ID,Ad from Table_1 
EXCEPT
select ID,Ad from Table_2

--Intersect komutu 1.  ve 2. tabloda olan ***kay�tlar�n** listesini d�ner
select ID,Ad from Table_1 
INTERSECT
select ID,Ad from Table_2