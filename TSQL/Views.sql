
--Global sanal tablolar sql sunucusu restart edildiginde sistemden silinir.
select * into ##Musteriler from NORTHWND..Customers
select * from ##Musteriler

--Viewler global sanal tablolara benzer ancak sunucu restart edildiginde sistemden silinmez
CREATE VIEW v_Musteriler
AS
select * from Customers

select * from v_Musteriler

-- 1 den 100'e kadar olan sayýlarý view icerisinde gösteren sorguyu yazýnýz.
-- Calýsmayan yöntem 
--create view v_Sayilar
--as
--BEGIN
--	DECLARE @min INT = 1;
--	DECLARE @tablo TABLE (deger INT);
--	WHILE @min <= 100
--	BEGIN
--		INSERT INTO @tablo VALUES (@min)
--		SET @min+=1
--	END
--	select * from @tablo
--END

create view v_KategoriyeGoreUrun
as
select c.CategoryID,CategoryName,COUNT(P.ProductID) as UrunSayisi from Categories AS C
left join Products AS P
	ON C.CategoryID = P.CategoryID
group by  c.CategoryID,CategoryName

--Ýcerisinde join bulunduran viewlere insert update yada delete komutlarý kullanýlamaz.Sadece listeleme yapýlýr
select * from v_KategoriyeGoreUrun

insert into v_KategoriyeGoreUrun (CategoryID,CategoryName,UrunSayisi)
values (20,'Kategori 1',50)

update v_KategoriyeGoreUrun set CategoryName = 'Kategori 1' where CategoryID = 3

--------------------------------------------
create view v_Kategori
as
select CategoryName from Categories

select * from v_Kategori
select * from Categories

insert into v_Kategori values('Kategori 2')