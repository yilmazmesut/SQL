/*============================ GROUP BY =====================================
    GROUP BY cümlecigi, bir SELECT ifadesinde satirlari, sutunlarin degerlerine
    göre özet olarak gruplamak için kullanilir.
    GROUP BY cümlecigi her grup basina bir satir döndürür.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlari ile birlikte kullanilir. 
==============================================================================*/


CREATE TABLE manav
(
    isim varchar2(50),
    urun_adi varchar2(50),
    urun_miktari number(9)
);
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
    
------ORNEK1: kisi ismine göre, sat?lan toplam meyve miktarlar?n? gösteren sorguyu
--  yaz?n?z. ali=>5+2+2+2 sum= meyve say?lar?n? toplucak    --veli 9
                                                            --ayse 10
                                                            --...
    SELECT isim, SUM(urun_miktari) AS toplam_urun from manav 
    GROUP BY isim;  -- isme gore grupladiklarinin urun_miktarlari'ni topladik
                    --isim isim grupla, her ismi bir kere yaz, 
                    -- o isimdeki meyve sayilarini topla, ilgili ismin satirinda goster


------ORNEK2: satilan meyve türüne (urun_adi) göre urun alan kisi sayisini 
--gösteren sorguyu yaz?n?z. NULL olarak girilen meyveyi listelemesin.
--count= elma alan kisileri sayacak. hangi elmadan kac kisi almis?
    SELECT urun_adi, COUNT(isim) AS toplam_kisi FROM manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi;

   
-----ORNEK3: satilan meyve türüne (URUN_ADI) göre satilan (urun_miktari )MIN ve
 -- MAX urun miktarlarini, MAX urun miktarina göre SIRALAYARAK listeyen sorguyu
 -- yaz?n?z.    
                -- elma 2 5
                -- armut 2 3
                -- ....
    SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) from manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi
    ORDER BY MAX(urun_miktari) DESC;   
     
    
/*====================SIRALAMA ASAGIDAKI GIBI OLMALI============================
  =>SELECT FROM
  =>WHERE       1)gruplamadan bazi sartlara göre bazilarini ele
  =>GROUP BY    2)özelliklerine göre grupla
  =>HAVING      3)grup özelliklerine göre sartla ele. ya where ya having yani
  =>ORDER BY    4)bu gruplari istenilen özellige göre sirala
==============================================================================*/  
  
------ORNEK4: kisi ismine ve urun adina (select) göre satilan ürünlerin  
 -- (sum)toplamini gruplandiran ve önce isme göre sonra urun_adi na göre 
 -- ters sirayla (order by) listeyen sorguyu yaziniz.
 -- önce isme göre sonra meyvelere=
    SELECT isim,urun_adi,SUM(urun_miktari) FROM manav
    GROUP BY isim,urun_adi
    ORDER BY isim,urun_adi DESC;    --isim'i dogal sirala, urun_adi'ni ters sirala
 
 
/*===================== HAVING =================================================
    Kod icinde kendimiz olusturdugumuz sutun icin WHERE yerine kullanilir. 
Cunku tablomuz kendisi orjinalinde bu veriye sahip degil
    -- AGGREGATE (toplama sum, count vs)fonksiyonlari ile ilgili bir kosul koymak
--için GROUP BY'dan sonra HAVING cümlecigi kullan?l?r.
==============================================================================*/

 /*------ORNEK5: kisi ISMINE ve URUN ADINA göre, satilan ürünlerin toplamini bulan
  ve bu toplam degeri 3 ve fazlasi olan kayitlari toplam urun miktarlarina göre
  ters siralayarak listeyen sorguyu yaziniz.  veli elma 5
                                              ali elma 5
                                              ali armut 4...    */                                                                 
    SELECT isim,urun_adi,SUM(urun_miktari) AS toplam_urun FROM manav
    GROUP BY isim,urun_adi
    HAVING SUM(urun_miktari)>=3             -- Kod icinde kendimiz olusturdugumuz 
                                            -- satirlar icin WHERE yerine kullanilir.
    ORDER BY SUM(urun_miktari) DESC;


/*-----ORNEK6: satilan urun_adi'na göre GRUPLAYIP, 
MAX urun sayilarini,(yine max ürün sayisina göre) SIRALAYARAK listeleyin. 
NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarina esit olmayan kayitlari 
(where gibi kosul var) listelemelidir. */
    SELECT urun_adi, MAX(urun_miktari) AS esit_olmayan_urunler FROM manav
    GROUP BY urun_adi
    HAVING MAX(urun_miktari)!= MIN(urun_miktari)    ----!= yerine <> de yazabilirz
    ORDER BY MAX(urun_miktari);
  
/*============================= DISTINCT =====================================
    DISTINCT cümleci?i bir SORGU ifadesinde benzer olan sat?rlar? flitrelemek
    için kullan?l?r. Dolay?s?yla seçilen sutun yada sutunlar için benzersiz veri
    içeren (uniq)sat?rlar olu?turmaya yarar.
    SYNTAX
    -------*/
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_adi;
--==============================================================================

------ORNEK1: sat?lan farkl? meyve türlerinin say?s?n? listeyen sorguyu yaz?n?z.
-- (kaç farkl? meyve türü var, elma armut üzüm=3)

    SELECT DISTINCT urun_adi, COUNT urun_miktari FROM manav
    
    GROUP BY urun_adi, 
    

















    SELECT COUNT (DISTINCT urun_adi) AS urun_cesit_sayisi FROM manav;
    --tekrarsiz olan urun ad larini listeledi..
    
-----ORNEK2: sat?lan meyve ve isimlerin (totalde )farkl? olanlar?n? listeyen sorguyu yaz?n?z.
    SELECT DISTINCT urun_adi, isim FROM manav;
    
------ORNEK3: sat?lan meyvelerin urun_mikarlarinin benzersiz  olanlar?n?n
--  toplamlarini listeyen sorguyu yaz?n?z.2+3+4+5=14    
    SELECT SUM (DISTINCT urun_miktari) AS benzersiz_urun_sayisi_toplam FROM manav;
    
    
    
    
    