/*=============================== ALTER TABLE ==================================
    --i� kaporta i�in UPDATE (DML), d?? kaporta i�in ALTER (DDL)
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin
    kullanilir.
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de
    kullanilir.
=============================================================================*/

    CREATE TABLE personel
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    SELECT * FROM personel;
/* -----------------------------------------------------------------------------
  ORNEK1: personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan
  yeni bir sutun ekleyiniz. */
    ALTER TABLE personel
    ADD ulke_isim varchar2(20) DEFAULT 'Turkiye';
    
    
------ORNEK2: personel tablosuna cinsiyet Varchar2(20) ve yas Number(3) seklinde
--  yeni sutunlar ekleyiniz.    
    ALTER TABLE personel
    ADD (cinsiyet2 VARCHAR2(7), yas2 NUMBER(3));


-----ORNEK3: personel tablosundan yas sutununu siliniz.
    ALTER TABLE personel
    DROP COLUMN yas;


-----ORNEK4: personel tablosundaki ulke_isim sutununun adini ulke_adi olarak
--degistiriniz.
    ALTER TABLE personel
    RENAME COLUMN ulke_isim TO ulke_adi;
    
-----ORNEK5: personel tablosunun adini isciler olarak degistiriniz.
    ALTER TABLE personel
    RENAME TO insan_kaynaklari;
    SELECT * FROM insan_kaynaklari;
    
-----ORNEK6: isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ekleyiniz.
    ALTER TABLE insan_kaynaklari
    MODIFY ulke_adi VARCHAR2(30) NOT NULL;
    
-----ORNEK 7: maasa UNIQUE kisitlamasi ekle
    ALTER TABLE insan_kaynaklari
    MODIFY maas UNIQUE; --tekrarli maaslar oldugu icin UNIQUE modify yapamayiz
    
-----ORNEK 8: CHECK kisitlamasi ekle
    ALTER TABLE insan_kaynaklari
    MODIFY maas CHECK(maas>3000);   
    --artik bundan sonra 3000 den asagi maas veremeyz