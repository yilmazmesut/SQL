/* ============================== DELETE ===================================
-----> DELETE FROM tablo_adi;  Tablonun tüm içergini siler. 
geriye bos bir tablo kalir. 
    -- Bu komut bir (DML) komutudur. Dolayisiyla devaminda WHERE gibi cümlecikler
    -- kullanilabilir. 
    -- DELETE FROM tablo_adi
    -- WHERE sutun_adi = veri;  
    -- DROP'ta ise tablonun kendisi de yok olur. */
    
    CREATE TABLE ogrenciler
    (
        id CHAR(3),
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3)
    );
    INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
	INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
  SAVEPOINT ABC; --ROLLBACK kisminda açiklamasi var
  
    SELECT * FROM ogrenciler;
    DROP TABLE ogrenciler;
/* =============================================================================
      Seçerek silmek için WHERE Anahtar kelimesi kullanilabilir.
===============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE id = 124;
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan sat?r?n? siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Kemal Yasa';
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kay?tlar? silelim.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak'; 
      -- bu ikisi farkli satirlarda da olsa siler.
                --IN('Nesibe Yilmaz','Mustafa Bak') -- seklinde de yazabiliriz...ayni sey..
                
/* ----------------------------------------------------------------------------
  ORNEK4: ismi Ali Can ve id'si 123 olan kaydi siliniz.
 -----------------------------------------------------------------------------*/
     DELETE FROM ogrenciler
     WHERE isim = 'Ali Can' AND id = 123;   -- ikisi de mutlaka ayni satirda ise siler
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kay?tlar? silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id>126;
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanlari silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id IN(123,125,126);
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKI TÜM KAYITLARI S?LEL?M..
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler;
    
--*************************************************
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir

/* ======================== DELETE - TRUCATE - DROP ============================
    1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler.
Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML degil (DDL) komutudur.
    TRUNCATE TABLE ogrenciler;  --dogru yazim
    2-) DELETE komutu beraberinde WHERE cümlecigi kullanilabilir. TRUNCATE ile
kullanilmaz.
        TRUNCATE TABLE ogrenciler.....yanlis yazim
        WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yapisini degistirmeden,tablo içinde yer alan 
tüm verileri tek komutla silmenizi sglar.
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylikla geri
alinabilir.
    4-) Truncate ile silinen veriler geri alinmasi daha zordur. 
Ancak Transaction yöntemi ile geri alinmasi mümkün olabilir.
    5-) DROP komutu da bir DDL komutudur. Ancak DROP, veriler ile tabloyu da
siler. Silinen tablo Veritabaninin geri dönüsüm kutusuna gider. Silinen
tablo asagidaki komut ile geri alinabilir. Veya SQL GUI'den geri alinabilir. */
     FLASHBACK TABLE tablo_adi TO BEFORE DROP;  --> tabloyu geri alir.
     PURGE TABLE tablo_adi;        --> Geri dönüsümdeki tabloyu siler.
     DROP TABLE tablo_adi PURGE;  --> Tabloyu tamamen siler
/*  Connections da table'i sag tikla =>table=>drop, purge isaretle, çöp kutusuna
atilmaksizin direk siler.
    connections recyle bin sag tikla, purge=>tabloyu tamamen siler. 
    flashback=> tabloyu geri getirir
    
==============================================================================*/
    --INSERT veri girisinden sonra SAVEPOINT ABC; ile verileri buraya sakla
    --(yanlislik yapma olasiligina karsi önlem gibi, AYNI ISIMDE BASKA TABLO VARSA)
    --sonra istedigini sil (ister tümü ister bir kismi)
    --sonra savepoint yaptigin yerden alttaki gibi rollback ile verileri geri getir
    drop table ogrenciler;
    DELETE FROM ogrenciler;  -- Tüm verileri sil.
    ROLLBACK TO ABC;         -- Silinen Verileri geri getir.
    SELECT * FROM ogrenciler;
    DROP TABLE ogrenciler;   -- Tabloyu siler ve Veritabaninin Çöp kutusuna
                             -- gönderir. (DDL komutudur.)
    -- Çöp kutusundaki tabloyu geri getirir.
    
    FLASHBACK TABLE ogrenciler TO BEFORE DROP;
    -- Tabloyu tamamen siler (Çöp kutusuna atmaz.)
   
    DROP TABLE ogrenciler PURGE;
    -- PURGE sadece DROP ile silinmis tablolar icin kullanilir
    -- DROP kullanmadan PURGE komutu kullanmak isterseniz
    -- ORA-38302: invalid PURGE option hatasi alirsiniz
    -- Tüm veriler hassas bir sekilde siler. rollback ile geri alinamaz
    -- PURGE yapmak icin 2 yontem kullanabiliriz
    --1 tek satirda DROP ve PURGE beraber kullanabiliriz
    DROP TABLE ogrenciler7 PURGE;
-- bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
-- ORA-38305: object not in RECYCLE BIN hatasini alirsiniz
-- 2 daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz
--Tabloyu yeniden olusturalim
    DROP TABLE ogrenciler7;
-- bu asamada istersek FLASHBACK ile tablomuzu geri getirebiliriz
    PURGE TABLE ogrenciler7;
-- bu asamada istesem de tabloyu geri getiremem

/* =============================================================================
    Tablolar arasinda iliski var ise veriler nasil silinebilir?
============================================================================= */

/*============================== ON DELETE CASCADE =============================
  Her defas?nda önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelligini aktif hale getirebiliriz.
  Bunun için FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmak yeterli
==============================================================================*/
    CREATE TABLE talebeler
    (
        id CHAR(3),  --PK
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3),
        CONSTRAINT talebe_pk PRIMARY KEY (id)
    );
    INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO talebeler VALUES(126, 'Nesibe Y?lmaz', 'Ayse',95);
	INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
     
     CREATE TABLE notlar
    (
        talebe_id char(3), --FK
        ders_adi varchar2(30),
        yazili_notu number (3),
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
        REFERENCES talebeler(id) ON DELETE CASCADE
           );
       --ON DELETE CASCADE sayesinde;
       --parent'taki silinen bir kayit ile iliskili olan tüm child kayitlarini siler
        DELETE FROM talebeler WHERE id = 124; -- yaparsak child daki 124 lerde silinir.
       --mesela bir hastane silindi o hastanedeki bütün kay?tlar silinmeli, oda böyle olur.
       --cascade yoksa önce child temizlenir sonra parent
       --baglama yaptigimiz kodun sonuna yazariz
 
    
    INSERT INTO notlar VALUES ('123','kimya',75);
    INSERT INTO notlar VALUES ('124', 'fizik',65);
    INSERT INTO notlar VALUES ('125', 'tarih',90);
	INSERT INTO notlar VALUES ('126', 'Matematik',90);
    SELECT * FROM TALEBELER;
    SELECT * FROM NOTLAR;
    DELETE FROM notlar
    WHERE talebe_id = 124;
    DELETE FROM talebeler
    WHERE id = 124;