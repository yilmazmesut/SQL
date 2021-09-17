--------SUBQUERY---------------------
--SORGU icinde calisan sorgudur.(ALt sorgu)

CREATE TABLE personel
(
    id NUMBER(9),
    isim VARCHAR2(50),
    sehir VARCHAR2(50),
    maas NUMBER(20),
    sirket VARCHAR2(20)
);
    INSERT INTO personel VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
    INSERT INTO personel VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');
    
     CREATE TABLE sirketler
(
    sirket_id NUMBER(9),
    sirket_adi VARCHAR2(20),
    personel_sayisi NUMBER(20)
);
    INSERT INTO sirketler VALUES(100, 'Honda', 12000);
    INSERT INTO sirketler VALUES(101, 'Ford', 18000);
    INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
    INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
    INSERT INTO sirketler VALUES(104, 'Mazda', 17000);
    
    SELECT *FROM sirketler;
    SELECT * FROM personel;
    
-----ORNEK1: PERSONEL SAYISI 15.000’den COK OLAN SIRKETLERDEKI (alt sorgu sirketler), 
--calisan personelin isimlerini ve maaslarini (asil sorgu personel) listeleyin
    SELECT isim,maas,sirket from personel                --personel tablosundan isim,maas,sirket'i (sutunlarini) listele
    WHERE sirket IN (SELECT sirket_adi FROM sirketler    --sirket = sirket_adi>15000 olanlardan 
                    WHERE personel_sayisi>15000);                 --(personel sayisi 15000 un uzerinde olanlarin, sirket_adi'larini sec)

                     
-----ORNEK2: sirket_id’si 101’den büyük olan sirket çalisanlarinin isim, maas ve sehirlerini listeleyiniz.
    SELECT isim,maas,sehir FROM personel
    WHERE sirket IN (SELECT sirket_adi FROM sirketler   --baglama yapacagimiz yer burasi, sirket ile sirket_adi iki tabloda da ortak sutunlar.
                    WHERE sirket_id>101);
    
    
-----ORNEK3: Ankara’da personeli olan sirketlerin sirket id'lerini ve personel sayilarini listeleyiniz
    SELECT sirket_id,personel_sayisi FROM sirketler
    WHERE sirket_adi IN (SELECT sirket FROM personel    --birden fazla veriyi esitleyeceksek = yerine IN yaziyoruz.
                            WHERE sehir='Ankara');
  
  
    
/* =====================  AGGREGATE METOT  =====================================
    Aggregate Metotlari(SUM, COUNT, MIN,MAX, AVG) Subquery içinde kullanilabilir.
    Ancak, Sorgu tek bir deger döndürüyor olmalidir.
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz--SELECT id,isim,maas
                                                                                                        --FROM personel
                                                                                                      --WHERE sirket='Honda';
--- Bir tablodan tek deger getirebilmek icin ortalama=AVG , toplam=SUM, adet=COUNT, MIN, MAX  gibi
--fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir
==============================================================================*/   

-----ORNEK4: Her sirketin ismini, personel sayisini ve o sirkete ait personelin
--toplam maasini listeleyen bir Sorgu yaziniz.
    SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas) FROM personel
                                            WHERE sirketler.sirket_adi=personel.sirket) AS toplam_maas  --AS keyword'u ile istedigimiz sutuna istedigimiz adi verebilirz
        FROM sirketler;

    
    
    
    
-----ORNEK5: Her sirketin ismini, personel sayisini ve o sirkete ait personelin
--ortalama maassini listeleyen bir Sorgu yaziniz.
    SELECT sirket_adi, personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel
                                            WHERE sirketler.sirket_adi=personel.sirket) AS maas_ortalama
    FROM sirketler;

    
-----ORNEK6: Her sirketin ismini, personel sayisini ve o sirkete ait personelin
--maksimum ve minumum maasini listeleyen bir Sorgu yaziniz.
    SELECT sirket_adi, personel_sayisi, (SELECT MAX(maas) FROM personel
                                            WHERE sirketler.sirket_adi=personel.sirket) AS max_maas,
                                        (SELECT MIN(maas) FROM personel
                                            WHERE sirketler.sirket_adi=personel.sirket) AS min_maas
    FROM sirketler;                                        
                                            



    
-----ORNEK7: Her sirketin id’sini, ismini ve toplam kaç sehirde bulundugunu
--listeleyen bir SORGU yaziniz.
    SELECT sirket_id,sirket_adi, (SELECT COUNT(sehir) FROM personel
                                    WHERE personel.sirket = sirketler.sirket_adi) AS sehir_sayisi   -- veya sirket=sirket_adi seklindede olur--)
        FROM sirketler;
        
                        
    
    
    
    