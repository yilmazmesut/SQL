--------UPDATE - SET-------------------------

-- SYNTAX
    ----------
    -- UPDATE tablo_adi
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
    -- WHERE kosul;
    
    /*Asagidaki gibi tedarikciler adinda bir tablo olusturunuz ve vergi_no
   sutununu primary key yapiniz. 
    Sonrasinda asagidaki gibi urunler adinda bir baska tablo olusturunuz ve bu
    tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
    iliskilendiriniz. Verileri giriniz.*/
--==============================================================================

    CREATE TABLE tedarikciler (
    vergi_no NUMBER(3) PRIMARY KEY,
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50)
    );
    DROP TABLE tedarikciler;
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
    SELECT * FROM tedarikciler;
    
    create table urunler1 (
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
    CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES tedarikciler1 (vergi_no)
    );
    -- Foreign Key sayesinde urunler1 tablosundaki ted_vergino'sunu 
    --tedarikciler tablosunun PRIMARY KEY olan vergi_no'suna bagladik.
    
    DROP TABLE urunler1;
    INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ayse Can');
    INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Yilmaz');
    SELECT * FROM urunler1;

--==============================================================================    
-----Ornek 1: vergi_no su 101 olan tedarikcinin firma ismini 'LG' olarak guncelleyin

    UPDATE tedarikciler    --tablo/guncellenecek tablo (tedarikcileri1 tablosunu update et)
    SET firma_ismi='LG'     --sutun/yapilacak islem (firma_ismi'ni 'LG' yap)
    WHERE vergi_no=101;     --satir/islem yapilacak yer (vergi_no'su 101 olan)

--==============================================================================    
-----Ornek 2: tedarikciler tablosundaki tum firma isimlerini Samsung olarak guncelleyin
    UPDATE tedarikciler
    SET firma_ismi='Samsung';
        
-----Ornek 3: vergi_no’su 102 olan tedarikcinin ismini 'Lenovo' ve irtibat_ismi’ni 
--'Ali Veli' olarak güncelleyeniz.
    UPDATE tedarikciler
    SET firma_ismi='Lenovo', irtibat_ismi='Ali Veli'
    WHERE vergi_no=102;

--==============================================================================        
-----Ornek 4: firma_ismi Samsung olan tedarikcinin irtibat_ismini 'Ayse Yilmaz' 
--olarak güncelleyiniz.
    UPDATE tedarikciler
    SET irtibat_ismi='Ayse Yilmaz'
    WHERE firma_ismi='Samsung';
        
-----Ornek 5: urunler tablosundaki urun_id degeri 1004'ten büyük olanlarin urun_id 
--degerlerini bir arttiriniz
    UPDATE urunler1
    SET urun_id= urun_id+1
    WHERE urun_id>1004;
    
-----Ornek 6: urunler tablosundaki tüm ürünlerin urun_id degerini ted_vergino 
--sutun degeri ile toplayarak güncelleyiniz.
    UPDATE urunler1
    SET urun_id=urun_id+ted_vergino;

--==============================================================================        
-----Ornek 7: urunler tablosundan Ali Bak’in(Ayse Yilmaz) aldigi urunun ismini, 
--TEDARIKCI TABLOSUNDA IRTIBAT_ISMI 'Adam Eve' OLAN FIRMANIN ISMI (FIRMA_ISMI) ile degistiriniz.
    UPDATE urunler1
    SET urun_ismi=(SELECT firma_ismi FROM tedarikciler
                    WHERE irtibat_ismi='Adam Eve')
    WHERE musteri_ismi='Ali Bak';
    
--==============================================================================    
-----ornek 8: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile degistirin
    UPDATE urunler1
    SET musteri_isim= (SELECT irtibat_ismi FROM tedarikciler
                        WHERE firma_ismi='Apple')
    WHERE urun_isim='Laptop';
                