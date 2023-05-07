-- TRIGGER KONUSU
CREATE OR ALTER TRIGGER tg_OrtalamaHesapla
ON Notlar
FOR UPDATE
AS
BEGIN
	update Notlar set Ortalama = Vize*0.4 + Final*0.6
	WHERE ID IN (select ID from inserted)

	update Notlar set Durum = 
	CASE
		WHEN Ortalama >90 THEN 'A'
		WHEN Ortalama >80 THEN 'B'
		WHEN Ortalama >70 THEN 'C'
		WHEN Ortalama >60 THEN 'D'
		WHEN Ortalama >50 THEN 'E'
		ELSE 'F' 
	END
	WHERE ID IN (select ID from inserted)
END

CREATE TRIGGER tg_DurumHesapla
ON Notlar
FOR UPDATE
AS
BEGIN
	update Notlar set Durum = 
	CASE
		WHEN Ortalama >90 THEN 'A'
		WHEN Ortalama >80 THEN 'B'
		WHEN Ortalama >70 THEN 'C'
		WHEN Ortalama >60 THEN 'D'
		WHEN Ortalama >50 THEN 'E'
		ELSE 'F' 
	END
	WHERE ID IN (select ID from inserted)
END

DROP TRIGGER tg_DurumHesapla

select * from Notlar
update Notlar set Vize = 40 where ID=3

CREATE DATABASE Okul_Log
CREATE TABLE Okul_Log.[dbo].[Bolum](
	[ID] [int]  NOT NULL,
	[Adi] [varchar](50) NULL
)

CREATE TRIGGER tg_LOG_DEL
ON Bolum
FOR DELETE
AS
BEGIN
	INSERT INTO Okul_log.dbo.Bolum
	select *,'DELETE' from deleted
END

select * from Okul_log.dbo.Bolum

--Verilerin tutarlýlýgýný koruyarak kayýt silme islemini,n yapýlmasýný saglama
select * from Categories
delete from Categories where CategoryID=1
select * from Products where CategoryID=1
delete from Products where CategoryID=1
select * from [Order Details] where ProductID IN
(select ProductID from Products where CategoryID=1)

--------------------------
CREATE OR ALTER TRIGGER tg_DEL_PRODUCT
ON Products
INSTEAD OF DELETE
AS
BEGIN
	delete from [Order Details] where ProductID IN (
		select ProductID from deleted
	)
	delete from Products where ProductID IN (
		select ProductID from deleted
	)

END

select * from Products where ProductID=1
select * from [Order Details] where ProductID=1

delete from Products where ProductID=1

--INSTEAD OF Anahtar kelimesi Gönderilecek event yerine calýsan sorgudur
-- FOR kelimesi ise event gerceklestikten sonra calýsan sorgular icin kullanýlýr

CREATE TRIGGER tg_DEL_CATEGORY
ON Categories
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Products WHERE CategoryID IN (
		select CategoryID FROM deleted
	)

	DELETE FROM Categories where CategoryID IN (
		SELECT CategoryID from deleted
	)
END

select * from Categories where CategoryID = 2
select * from Products where CategoryID = 2

BEGIN TRAN
delete from Categories where CategoryID = 2
ROLLBACK -- Ýþlemi Geri almak
COMMIT TRAN


-- Okul database'inde Bir kayýt silindiginde silme islemi yerine update islemi calýstýrma
ALTER TRIGGER [dbo].[tg_LOG_DEL]
ON [dbo].[Bolum]
INSTEAD OF DELETE
AS
BEGIN
	INSERT INTO Okul_log.dbo.Bolum
	select * from deleted

	UPDATE Bolum set 
		DELETED = 1,
		DELDATE = GETDATE(),
		DELUSER = 25
	WHERE ID IN (
		select ID from inserted
	)
END

select * from Bolum
select * from Okul_Log..Bolum
delete from Bolum where ID=1
