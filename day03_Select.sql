------------SELECT - WHERE-----------------------------------------
CREATE TABLE ogrenciler1
(
id NUMBER(9),
isim VARCHAR2(50),
adres VARCHAR2(100),
sinav_notu NUMBER(3)
);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Ankara',75);
INSERT INTO ogrenciler1 VALUES(124, 'Merve Gul', 'Ankara',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Yasa', 'Istanbul',85);

SELECT * FROM ogrenciler1;
DROP TABLE ogrenciler1;

--------Ornek1: sinav notu 80'den buyuk olan tum ogrencilerin bilgilerini listeleyin
SELECT isim FROM ogrenciler1
WHERE sinav_notu >80;


-------Ornek2: adresi ankara olan ogrencilerin isim ve adres bilgilerini listele
SELECT isim,adres FROM ogrenciler1
WHERE adres='Ankara';

-------Ornek3: ID si 124 olan ogrencilerin butun bilgilerini silelim
DELETE FROM ogrenciler1
WHERE id=124;

---------------SELECT - BETWEEN-----------------------------

CREATE TABLE personel
(
id CHAR(5),
isim VARCHAR2(50),
maas NUMBER(5)
);
INSERT INTO personel VALUES('10001', 'Ahmet Aslan', 7000);
INSERT INTO personel VALUES('10002', 'Mehmet Yilmaz',12000);
INSERT INTO personel VALUES('10003', 'Meryem', 7215);
INSERT INTO personel VALUES('10004', 'Veli Han', 5000);
INSERT INTO personel VALUES('10005', 'Mustafa Ali', 5500);
INSERT INTO personel VALUES('10005', 'Ayse Can', 4000);

SELECT * FROM personel;
DROP TABLE personel;

-------Ornek 4: id'si 1002 ile 1005 arasinda olan personelin bilgilerini listele
----1. yontem------
SELECT * FROM personel
WHERE id BETWEEN '10002' AND '10005';  --bu iki sayi da dahildir..

----2. yontem------
SELECT * FROM personel
WHERE id >='10002' AND id<='10005';

-------Ornek 5: Mehmet Yilmaz ile Veli Han arasinda olan personel bilgilerini listele
SELECT * FROM personel
WHERE isim BETWEEN 'Mehmet Yilmaz' AND 'Veli Han';

------Ornek 6: id'si 10002-10004 arasinda olmayan personelin maas'ini listele
SELECT * FROM personel
WHERE id NOT BETWEEN '10002' AND '10004';

/* 
======================= SELECT - IN ======================================
    IN birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari 
    tek komutla yazabilme imkâni verir

    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_adi
    WHERE sutun_adi IN (deger1, deger2, ...);
 ========================================================================== 
 */

----Ornek: maasi 4000, 5000, 7000 olan personelin bilgilerini listele
SELECT * FROM personel
WHERE maas IN(4000, 5000, 7000);

--WHERE isim IN('Veli Han','Ahmet Aslan');


/*======================= SELECT - LIKE ======================================
    NOT:LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri
    kullanabilmemize olanak sa?lar.
    SYNTAX:
    -------
    SELECT sutün1, sutün2,…
    FROM  tablo_ad? WHERE sütun LIKE pattern
    PATTERN ?Ç?N
    -------------
    %    ---> 0 veya daha fazla karakteri belirtir.(0 dan sonsuza giden basamak sayisi)
    _    ---> Tek bir karakteri temsil eder.
    --------
    buyuk kucuk harf duyarlidir.
==============================================================================*/

------ ORNEK 1: ismi A harfi ile baslayanlari listeleyin
    SELECT * FROM personel
    WHERE isim LIKE 'A%';
    
----- ORNEK 2: ismi n harfi ile bitenleri listeleyiniz
    SELECT * FROM personel
    WHERE isim LIKE '%n';   --n den once harf alabilecegi icin % yazariz
    
------ORNEK 3: isminin 2. harfi e olanlari listeleyiniz
    SELECT * FROM personel
    WHERE isim LIKE '_e%';   --e den sonra harf alabilecegi icin % yazariz
    
-----ORNEK12:  isminin 2. harfi e olup di?er harflerinde y olanlar? listeleyiniz
    SELECT * FROM personel
    WHERE isim LIKE '_e%y%';    
    
-----ORNEK13:  ismi A ile ba?lamayanlar? listeleyiniz
    SELECT * FROM personel
    WHERE isim NOT LIKE 'A%';

-----ORNEK15:  isminde a harfi olmayanlar? listeleyiniz
    SELECT * FROM personel
    WHERE isim NOT LIKE '%a%';
    
-----ORNEK16:  maasinin son 2 hanesi 00 olmayanlari listeleyiniz
    SELECT * FROM personel
    WHERE maas NOT LIKE '%00';
    
----ORNEK17:  maa?? 4000 olmayanlar? listeleyiniz
    SELECT * FROM personel
    WHERE maas NOT LIKE 4000;
 
----ORNEK18: maa?? 5 haneli olanlar? listeleyiniz
    SELECT * FROM personel
    WHERE maas LIKE '_____';
    
-----ORNEK20: 1. harfi A ve 7.harfi A olan personeli listeleyiniz.
    SELECT * FROM personel
    WHERE maas LIKE 'A_____A%';
    
    
/*======================= SELECT - REGEXP_LIKE ================================
    Daha karma??k pattern ile sorgulama i?lemi için REGEXP_LIKE kullan?labilir.
    Syntax:
    --------
    REGEXP_LIKE(sutun_ad?, ‘pattern[] ‘, ‘c’ ] )
             -- 'c' => case-sentisitive demektir ve default case-sensitive aktiftir.
     -- 'i' => incase-sentisitive demektir.
/* ========================================================================== */
    CREATE TABLE kelimeler
    (
        id NUMBER(10) UNIQUE,
        kelime VARCHAR2(50) NOT NULL,
        harf_sayisi NUMBER(6)
    );
    INSERT INTO kelimeler VALUES (1001, 'hot', 3);
    INSERT INTO kelimeler VALUES (1002, 'hat', 3);
    INSERT INTO kelimeler VALUES (1003, 'hit', 3);
    INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
    INSERT INTO kelimeler VALUES (1005, 'hct', 3);
    INSERT INTO kelimeler VALUES (1006, 'adem', 4);
    INSERT INTO kelimeler VALUES (1007, 'selim', 5);
    INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
    INSERT INTO kelimeler VALUES (1009, 'hip', 3);
    INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
    INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
    INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
    INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
    INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
    DROP TABLE kelimeler;    
    
-----ORNEK21: ?çerisinde 'hi' bulunan kelimeleri listeleyeniz 
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime,'hi');
    
    /* Eski yol:
    SELECT * FROM kelimeler
    WHERE kelime LIKE %hi%; */
    
-----ORNEK22: ?çerisinde 'ot' veya 'at' bulunan kelimeleri listele
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime,'ot | at','i');   -- | --> veya anlamina gelir
                                            -- 'i' --> buyuk-kucuk harf duyarsiz
                                            
-----ORNEK24: 'ho' veya 'hi' ile ba?layan kelimeleri büyük-küçük harfe dikkat
--  etmeksizin listeleyeniz
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime,'^ho | ^hi','i');     -- ^ --> ile baslayan demek 
    
-----ORNEK25: Sonu 't' veya 'm' ile bitenleri büyük-küçük harfe dikkat
-- etmeksizin listeleyeniz    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime,'t$ | m$','i');   -- $ --> ile biten demek
    
-----ORNEK26: h ile ba?lay?p t ile biten 3 harfli kelimeleri büyük-küçük harfe
-- dikkat etmeksizin listeleyeniz
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'h[a-z A-Z 0-9]t)');  
    /*[a-z A-Z 0-9] --> ikinci harf olarak kucuk-buyuk harfler ve rakamlar gelebilir.
    icerisinde olmasini istedgimiz herhangi bir sey de yazabilirz [dg..]    */
    
-----ORNEK29: a veya s ile ba?layan kelimelerin tüm bilgilerini listeleyiniz.
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'a|s');
    
-----ORNEK28: ?çinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'm|i|e');

    