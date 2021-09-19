/*--=========== EXIST ========================================================== 
    --IN ile ayni seydr, ama daha hizli calisir. bir kere yazilanlari atlar, 
tekrar tekrar kontrol yapmaz. for each gibidir.
    -- not in ile kullanilamiyor, olumsuzu icin mecbur EXISTS kullanmaliyiz
    

CREATE TABLE mart_satislar
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
CREATE TABLE nisan_satislar
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
    INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
    INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');
    
    INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');
    
    SELECT * FROM mart_satislar;
    SELECT * FROM nisan_satislar;

------ORNEK1: MART VE NISAN aylarinda ayni URUN_ID ile satilan ürünlerin
--  URUN_ID’lerini listeleyen ve ayni zamanda bu ürünleri MART ayinda alan
--  MUSTERI_ISIM 'lerini listeleyen bir sorgu yaziniz..
    SELECT urun_id,musteri_isim FROM mart_satislar
    WHERE EXISTS (SELECT urun_id FROM nisan_satislar
                    WHERE mart_satislar.urun_id=nisan_satislar.urun_id);
                        
 /* SELECT urun_id,musteri_isim FROM mart_satislar
    WHERE urun_id IN (SELECT urun_id FROM nisan_satislar
                        WHERE mart_satislar.urun_id=nisan_satislar.urun_id)*/
                        
                        
------ORNEK2: Her iki ayda da satilan ortak ürünlerin URUN_ISIM'lerini ve bu ürünleri
--  NISAN ayinda satin alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaziniz.
    SELECT urun_isim, musteri_isim FROM nisan_satislar AS nisan
    WHERE EXISTS (SELECT urun_isim FROM mart_satislar AS mart
                    WHERE mart.urun_isim=nisan.urun_isim);
                    
------ORNEK3: Her iki ayda da ortak olarak SATILMAYAN ürünlerin URUN_ISIM'lerini
-- ve bu ürünleri NISAN ayinda sat?n alan MUSTERI_ISIM'lerini listeleyiniz.
    SELECT urun_isim, musteri_isim FROM mart_satislar n
    WHERE NOT EXISTS (SELECT urun_isim FROM mart_satislar m
                        WHERE m.urun_isim=n.urun_isim);
                        

/*===================== IS NULL, IS NOT NULL, COALESCE(birlesmek) ==============
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup
    olmadigini kontrol ederler.
==============================================================================*/
    CREATE TABLE insanlar
    (
        ssn CHAR(9),
        isim VARCHAR2(50),
        adres VARCHAR2(50)
    );
    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
    
    SELECT * FROM insanlar;
    
----- ORNEK 1: isim'i NULL olanlarin tum bilgilerini sorgulayiniz
    SELECT * FROM insanlar
    WHERE isim IS NULL;

    
------ ORNEK 2: isim'i NULL olmayanlari sorgula
    SELECT * FROM insanlar
    WHERE isim IS NOT NULL;
    
------ ORNEK 3: isim'i NULL olan kisilerin isim'ine NO NAME yazisini atayiniz
    UPDATE isim FROM insanlar
    SET isim='NO NAME'
    WHERE isim IS NULL;
    
    UPDATE insanlar
    SET adres='NO CITY'
    WHERE adres IS NULL
    
 /*   ============== COALESCE (birlesmek) ============================================
  --bir fonksiyondur ve her satirda içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi bize döndürür. Eger aldigi tüm ifadeler NULL ise NULL döndürürür.
   *** SELECT COALESCE (sütun1,sütun2,...) from tabloAdi;
    Birden fazla null kosuluna göre deger atamak istiyorsak COALESCE deyimini 
kullanabiliriz.
    COALESCE sonucuna baktigimizda anlariz ki; farkli kolonlara gecisler oluyorsa
gecis yapilan satirin aldinda NULL deger vardir.    
    COALESCE aslinda case mantiginda çalisir ve birden fazla kolon arasinda 
kontrol saglayabilirsiniz.
    Bir kosul gerçeklezmez ise digerine bakar, o da gerçeklesmez ise bir sonraki.
Deyim bitene kadar

   -- CASE
   WHEN (expression1 IS NOT NULL) THEN expression1
   WHEN (expression2 IS NOT NULL) THEN expression2
   ...
   ELSE expressionN
   END  --gibi
==============================================================================*/
    
------ NULL olmayanlari listeleyiniz... (cok kullanilmayan yazim):
    SELECT COALESCE (isim,ssn,adres) FROM insanlar; --Ali Can
                                                    --Veli Cem
                                                    --Mine Bulut
                                                    --456789012
                                                    --567890123
                                                    --Sakarya
                                                    --999111222                                         
    --sirayla asagi dogru bakar, her satirda NULL olmayan buldugu ilk veriyi bulup getirir
    --ilk kapiyi acana misafir olur.
    
-----ORNEK 4: tablodaki butun null verileri guzel birer cumlecikle degistirin
    UPDATE insanlar
    SET isim=COALESCE(isim, 'henuz isim girilmedi'),  
        adres=COALESCE(adres, 'henuz adres girilmedi'),
        ssn=COALESCE(ssn, 'no ssn');    --isim sutununa bak, eger null ise degistir.
        
    SELECT * FROM insanlar;    
    
/* ================================ ORDER BY  ==================================
   ORDER BY cümlecigi bir SORGU deyimi içerisinde belli bir SUTUN’a göre
   SIRALAMA yapmak için kullanilir.
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN (Ascending) (yazmasak da default bulunur)
      ORDER BY sutun_adi DESC  -- AZALAN (Descending)
============================================================================= */

CREATE TABLE kisiler
    (
        ssn CHAR(9) PRIMARY KEY,
        isim VARCHAR2(50),
        soyisim VARCHAR2(50),
        maas NUMBER,
        adres VARCHAR2(50)
    );
    INSERT INTO kisiler VALUES('123456789', 'Ali', 'Can', 3000, 'Istanbul');
    INSERT INTO kisiler VALUES('234567890', 'Veli', 'Cem',2890, 'Ankara');
    INSERT INTO kisiler VALUES('345678901', 'Mine', 'Bulut', 4200 'Ankara');
    INSERT INTO kisiler VALUES('456789012', 'Mahmut', 'Bulut', 3150, 'Bursa');
    INSERT INTO kisiler VALUES('567890123', 'Mine', 'Yasa', 3150, 'Denizli');
    INSERT INTO kisiler VALUES('567890144','Veli','Yilmaz',7000,'Istanbul');
   

-----ORNEK1: kisiler tablosunu adres'e göre siralayarak sorgulay?n?z.
    SELECT * FROM kisiler
    ORDER BY adres;
    
-----ORNEK 2: kisiler tablosunu maas'a gore ters (azalan) suralayarak sorgulayiniz
    SELECT * FROM kisiler
    ORDER BY maas DESC;
    
-----ORNEK 3: ismi Mine olanlari, SSN'e göre AZALAN(DESC) sirada sorgulayiniz.
     SELECT * FROM kisiler
     WHERE isim='Mine'
     ORDER BY ssn DESC;

-----ORNEK 4: soyismi 'i Bulut olanlari isim sirali olarak sorgulayiniz.
    SELECT * FROM kisiler
    WHERE soyisim='Bulut'
    ORDER BY 2 DESC;    --sutun'un ismi yerine kacinci sutun oldugunu da yazabilirz.
    

/*====================== FETCH NEXT, OFFSET ====================================
    (12C VE ÜSTÜ oracle larda çalisir, daha altsaniz çalismaz) 
   FETCH cümlecigi ile listelenecek kayitlari sinirlandirabiliriz. istersek
   satir sayisina göre istersek de toplam satir sayisinin belli bir yüzdesine
   göre sinirlandirma koymak mümkündür. (su kadar satiri getir)
   Syntax=
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   ----------
   OFFSET --> listenecek olan satirlardan sirasiyla istedigimiz
   kadarini atlayabiliriz.
   Syntax=   
   OFFSET (satir sayisi) ROWS;
==============================================================================*/
*/
-----ORNEK1: MAAS'i en yüksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz.
    SELECT * FROM kisiler
    ORDER BY maas DESC  --Azalan oranli sirala
    FETCH NEXT 3 ROWS ONLY; --ilk uc satiri getir  
    --yeni surumlerde calisiyor, ogrenmemiz gereken de bu kod..
   
   --2. YOL: (eski surumlerde calisir)
    SELECT * FROM (SELECT * FROM kisiler
                    ORDER BY maas)-- (1) kisilerde maasa gore ters sirala
    WHERE ROWNUM < 4;   --1.2. ve 3. satiri getirir 
   
   
------ORNEK 2: MAAS'i en DÜSÜK 2 kisinin bilgilerini listeleyen sorguyu yaziniz.
    SELECT * FROM kisiler
    ORDER BY maas
    FETCH NEXT 2 ROWS ONLY;
    
    SELECT * FROM (SELECT * FROM kisiler
    ORDER BY maas)
    WHERE ROWNUM < 3;   -- 2. VE ESKI YOL
    
------ORNEK3: MAAS'a göre AZALAN siralamada 4. 5. ve 6. kisilerin bilgilerini listeleyen
--  sorguyu yaziniz    
    SELECT * FROM kisiler   --tablonun tamamini getir
    ORDER BY maas DESC  --maas'lari azalan oranda sirala
    OFFSET 3 ROWS   -- ilk 3 taneyi atla
    FETCH NEXT 3 ROWS ONLY; --geri kalanlari sirala
    
    --2. ve eski yol=
    SELECT * FROM
   (SELECT * FROM
        (SELECT * FROM kisiler
        ORDER BY maas DESC)
        WHERE ROWNUM <=6)
    WHERE  ROWNUM <=3;
    
    
    
    
    
                    
                    
    