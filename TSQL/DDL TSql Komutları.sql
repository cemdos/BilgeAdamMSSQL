--Veritaban� olusturmak icin kullan�lan sorgu
create database Veritabani

--�lgili session'in cal�st�g� aktif veritaban�n� de�i�tirmek icin kullan�lan sorgu
use Veritabani

--Tablo olusturmak icin kullan�lan sorgu
create table Tablo1(
	ID INT PRIMARY KEY IDENTITY(1,1),
	Ad VARCHAR(50) NOT NULL,
	Soyad VARCHAR(MAX),
	DTarih DATE ,
	Maas MONEY
)

--Tablo Silmek icin kullan�lan sorgu
DROP TABLE Tablo1

--Tablo icerisine yeni bir alan eklemek icin kullan�lan sorgu
ALTER TABLE Tablo1 ADD SigortaNo CHAR(10) DEFAULT('0000000000')

--Tablo icerisinde bir alan� degistirme icin kulla n�lan sorgu
ALTER TABLE Tablo1 ALTER COLUMN SigortaNo VARCHAR(10)

--Tablo icerisinde bir kolon silmek icin kullan�lan sorgu
ALTER TABLE Tablo1 DROP COLUMN SigortaNo

DROP TABLE Tablo2
--Foreign Key'e sahip tablo olusturmak icin kullan�lan sorgu
CREATE TABLE Tablo2 (
	ID INT PRIMARY KEY IDENTITY(1,1),
	ID_Tablo1 INT  FOREIGN KEY (ID) REFERENCES Tablo1(ID)
)



