INSERT Tablo1(Ad,Soyad,DTarih)
VALUES ('Cem','DOS','1991-08-09')

INSERT Tablo1(Ad,DTarih)
VALUES ('Cem','1991-08-09')

INSERT Tablo1(Soyad,DTarih)
VALUES ('DOS','1991-08-09')

INSERT Tablo1(Ad,Soyad,DTarih)
VALUES ('Ali','Yener','1991-08-09')

INSERT Tablo1(ID,Ad,Soyad,DTarih)
VALUES ((select MAX(ID)+1 from Tablo1),'Yaþar','KARA','1991-08-09')

INSERT INTO Tablo1 
VALUES('Ayþe',NULL,'1990-01-01',500)

INSERT INTO Tablo1_Cem_20230429
select * from Tablo1 where Maas is null

--Kayýt Silmek icin kullanýlan sorgu
select * from Tablo1_Cem_20230429 where ID=1
delete from Tablo1_Cem_20230429 where  ID=1

--Kayýt Güncelleme icin kullanýlan sorgu
select * from Tablo1_Cem_20230429 where ID=2
update Tablo1_Cem_20230429 set Maas = 5000 where ID=2

