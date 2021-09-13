    --TABLO OLUSTURMA
-- parantez icinde field isimleri, data type, size yazilmalidir.    
CREATE TABLE student
(
id CHAR(4),
name VARCHAR(20),
age NUMBER
);
--==============================================================================
    --VERI GIRISI= 
--veri girisi yaparken 
--1-Constraint(kisitlamalar) a uymaliyiz. 
--2-field sirasina ve data type'ina uygun bilgi eklemeliyiz
INSERT INTO student VALUES('1001','MEHMET ALA',25);
INSERT INTO student VALUES ('1002','AYSE',12);

--==============================================================================

--TABLODAN VERI SORGULAMA(TABLOYU GORUNTULEME)
SELECT * FROM student;

--==============================================================================

--TABLO SILME
DROP TABLE student;

--==============================================================================

--PARCALI VERI GIRISI
INSERT INTO student(id,name) VALUES('1003','FATMA');

--==============================================================================

---SORU: veri tabaninizda urunler adinda bir tablo olusturun-----
DROP TABLE urunler;

CREATE TABLE urunler
(
urun_id NUMBER,
urun_adi VARCHAR(50),
fiyat NUMBER
);

INSERT INTO urunler VALUES(100,'cips',5);
INSERT INTO urunler VALUES('200','kola',6);

SELECT * FROM urunler;