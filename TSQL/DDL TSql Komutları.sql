--Veritabaný olusturmak icin kullanýlan sorgu
create database Veritabani

--Ýlgili session'in calýstýgý aktif veritabanýný deðiþtirmek icin kullanýlan sorgu
use Veritabani

--Tablo olusturmak icin kullanýlan sorgu
create table Tablo1(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Ad VARCHAR(50) NOT NULL,
	Soyad VARCHAR(MAX),
	DTarih DATE ,
	Maas MONEY
)

--Tablo Silmek icin kullanýlan sorgu
DROP TABLE Tablo1

--Tablo icerisine yeni bir alan eklemek icin kullanýlan sorgu
ALTER TABLE Tablo1 ADD SigortaNo CHAR(10) DEFAULT('0000000000')

--Tablo icerisinde bir alaný degistirme icin kulla nýlan sorgu
ALTER TABLE Tablo1 ALTER COLUMN SigortaNo VARCHAR(10)

--Tablo icerisinde bir kolon silmek icin kullanýlan sorgu
ALTER TABLE Tablo1 DROP COLUMN SigortaNo

DROP TABLE Tablo2
--Foreign Key'e sahip tablo olusturmak icin kullanýlan sorgu
CREATE TABLE Tablo2 (
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_Tablo1 INT  FOREIGN KEY (ID) REFERENCES Tablo1(ID)
)



