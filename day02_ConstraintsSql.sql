/*======================= CONSTRAINTS - KISITLAMALAR ======================================
               
    UNIQUE - Bir sütundaki tüm degerlerin BENZERSIZ(tekrarsiz) olmasini garanti eder. 
                null kabul eder, hatta birden fazla null deger girilebilir. 

    NOT NULL - Bir Sütunun  NULL icermemesini garanti eder. 
                yazildigi field'in bos birakilmasini engeller
    
    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSIZ(tekrarsiz) olmasini garanti eder.
                  (NOT NULL ve UNIQUE birlesimi gibi)

    FOREIGN KEY - Ba?ka bir tablodaki Primary Key’i referans göstermek için kullan?l?r. 
                Böylelikle, tablolar aras?nda iliski kurulmus olur.
                - Baska tablodaki Primary Key ile relation olusturmak icin kullanilir, 
                tablolari birbirine baglar
                - tanimlamak icin en alt satirda CONSTRAINT olusturulur. 
                - FK fieldini tek basina tanimlamak yetmez related oldugu PK de yazilmalidir
                CONSTRAINT fk_ismi FOREIGN KEY (field1,field2..) REFERENCES parent_tablo (PK)
                - PK ve FK data tipleri uyumlu olmalidir

    CHECK - Bir sutundaki tum verilerin belirlenen ozel bir sarti saglamasini garanti eder. 
    soldan tablo silerken tablonun kapali olmasi lazim.
*/    
--==============================================================================

    --ornek 1-> NOT NULL;
    --ogrenciler tablosu olusturalim ve ID field'ini bos birakilamaz yapalim:

    CREATE TABLE ogrenciler (
    id CHAR(4) NOT NULL,
    isim VARCHAR(50),
    not_ort NUMBER(4,2),    --98,55 gibi        
    kayit_tarihi DATE
    );

    INSERT INTO ogrenciler VALUES('1234','hasan',75.25,'01-01-2020');
    INSERT INTO ogrenciler VALUES('1234','ayse',null,null);
    INSERT INTO ogrenciler (id,isim) VALUES('3456','fatma');
    INSERT INTO ogrenciler VALUES(null,'osman',45.25,'5-01-2020');

    SELECT * FROM ogrenciler;

    DROP TABLE ogrenciler;
--==============================================================================

------ornek2 -> UNIQUE-----------------------------------------------
    -- tedarikciler olusturalim id unique olsun..

    CREATE TABLE tedarikciler (
    id char(4) UNIQUE,
    isim varchar(50),
    adres varchar(100),
    tarih DATE
    );

    INSERT INTO tedarikciler VALUES('1234','ayse','mehmet mah izmir','10-11-2020');
    INSERT INTO tedarikciler VALUES('1235','fatma','veli mah istanbul','05-11-2020');
    INSERT INTO tedarikciler VALUES(null,'cem','suveri mah denizli','5-03-1997');

    SELECT * FROM tedarikciler;
    --unique constraint tekrara izin vermez ancak istediginiz kadar null girebilirsiniz
    
--==============================================================================

------ornek3: PRIMARY KEY

    create table personel (
    id CHAR(5) PRIMARY KEY,
    isim VARCHAR(50) UNIQUE,
    maas NUMBER(5) NOT NULL,
    ise_baslama DATE
    );

    INSERT INTO personel VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO personel VALUES( '10001', 'Mehmet Yilmaz' ,12000, '14-04-18');
    INSERT INTO personel VALUES('10003', '', 5000, '14-04-18');    -- ismi bos girebiliriz '' seklinde.
    INSERT INTO personel VALUES('10004', 'Veli Han', 5000, '14-04-18');
    INSERT INTO personel VALUES('10005', 'Ahmet Aslan', 5000, '14-04-18');  --isim unique oldugu icin ayni isim kaydetmez
    INSERT INTO personel VALUES('NULL', 'Canan Yas', NULL, '12-04-19'); --maas not null oldugu icin null kabul etmez

    SELECT * FROM personel;

--==============================================================================

---- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim

    CREATE TABLE ogrenciler3
( 
ogrenci_id char(4) PRIMARY KEY, 
Isim_soyisim varchar2(50),                
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-01-2021
);

SELECT * FROM ogrenciler3;

INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-01-2020');
INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-01-2020'); -- id null olamaz
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-06-2020'); -- id benzersiz olmali, daha önceverilen id kullanilamaz
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ('Veli Cem'); -- id vermeden ba?ka ?eyler vermeye geçemezsin, default null atar, buda primary ye uymaz
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');  -- 

SELECT * FROM ogrenciler3;

--==============================================================================

----PRIMARY KEY alternatif yontem:
--Tum fieldlar yazildiktan sonra alt satira gecip CONSTRAINT olarak tanimliyoruz
--bu yontemde kisitlamaya istedigimiz ISMI atayabiliriz
CREATE table calisanlar (
id char(5), --asagida primary key yaptik
isim VARCHAR(50) UNIQUE,
maas number(5) NOT NULL,
CONSTRAINT id_primary PRIMARY KEY(id)
);

INSERT INTO calisanlar VALUES('10001', 'Ahmet Aslan',7000);
INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yilmaz' ,12000);
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000);

SELECT * FROM calisanlar;

-- bir tabloya data eklerken constraint 'lere dikkat etmeliyiz..

--==============================================================================
-----ornek4 FOREIGN KEY
CREATE TABLE adresler(
adres_id CHAR(5),
sokak VARCHAR(30),
cadde VARCHAR(30),
sehir VARCHAR(15),
CONSTRAINT id_foreign FOREIGN KEY(adres_id) REFERENCES calisanlar(id)   -- adres_id yi id ye bagladik.
);

INSERT INTO adresler VALUES('10001','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10001','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','A?a Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES('','A?a Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES('','A?a Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van');    -- parent (calisanlar) tablosunda olmayan id (10004) ile veri giremeyiz.  

--foreign key'e null degeri atanabilir..
SELECT * FROM adresler;

drop table calisanlar; -- child silinmeden parent silinmez..

--==============================================================================
-----ogrenciler5 tablosunu olusturun ve id, isim hanelerinin birlesimini PRIMARY KEY yapin..
CREATE TABLE ogrenciler5 (
id CHAR(4),
isim VARCHAR(20),
not_ort NUMBER(5,2),
adres VARCHAR(20),
kayit_tarihi DATE,
CONSTRAINT ogrenciler5_primary PRIMARY KEY (id,isim)
);

INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,'Ankara','15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'Ankara','15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'Ankara','15-05-2019'); -- PK= 1234Ali Can
INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'Ankara','15-05-2019'); -- PK=1234Veli Cem
INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'Ankara','15-05-2019');

SELECT * from ogrenciler5;

--==============================================================================
-----ornek----------------
--“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
--“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--“urunler2” isminde baska bir tablo olusturun. Icinde “tedarikci_id” ve “urun_id” fieldlari olsun.
--“tedarikci_id” ve “urun_id” fieldlarini birlestirerek FOREIGN KEY olusturun

CREATE TABLE tedarikciler4 (
tedarikci_id CHAR(4),
tedarikci_ismi VARCHAR(20),
iletisim_ismi VARCHAR(20),
CONSTRAINT tedarikciler4_pk PRIMARY KEY(tedarikci_id,tedarikci_ismi)
);

CREATE TABLE urunler2 (
tedarikci_id char(4),
urun_id VARCHAR(5),
CONSTRAINT urunler2_fk  FOREIGN KEY(tedarikci_id,urun_id) REFERENCES tedatikciler4(tedarikci_id,tedarikci_ismi)
);

--==============================================================================
-----Ornek: sehirler2 tablosu olusturalim, nufusun negatif deger girilmemesi icin
--sinirlandirma (Constraint) koyalim
CREATE TABLE sehirler2 (	
    alan_kodu CHAR(3 ),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
    );
    INSERT INTO sehirler2 VALUES ('312','Ankara',5750000);
    INSERT INTO sehirler2 VALUES ('232','izmir',375); -- ORA-02290: check constraint (HR.SYS_C007028) violated
    INSERT INTO sehirler2 VALUES ('232','izmir',3750000);
    INSERT INTO sehirler2 VALUES ('436','Maras',null);

