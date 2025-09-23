1. BULK INSERT maqsadini aniqlang va tushuntiring
-- BULK INSERT fayldan (masalan, .csv yoki .txt) SQL Server jadvaliga katta hajmdagi ma'lumotlarni tezda yuklash uchun ishlatiladi.
-- Bu qator-qator qo'shimchalarga qaraganda tezroq va tekis fayllarni import qilish uchun foydalidir.

2. SQL Serverga import qilinadigan to'rtta fayl formatini sanab o'ting
1. CSV (.csv)
2. Matn fayllari (.txt)
3. Excel fayllari (.xls, .xlsx)
4. XML fayllar (.xml)

3. Mahsulotlar jadvalini yaratish
JADVAL YARATING Mahsulotlar (
ProductID INT ASOSIY KEY,
Mahsulot nomi VARCHAR(50),
Narxi DECIMAL(10,2)
);

4. Uchta yozuvni kiriting
INSERT INTO mahsulotlar (mahsulot identifikatori, mahsulot nomi, narxi)
QIMMATLAR
(1, "noutbuk", 1000.00),
(2, “Klaviatura”, 50.00),
(3, “Sichqoncha”, 25.00);

5. NULL va NOT NULL o'rtasidagi farq
-- NULL ustunda etishmayotgan yoki noma'lum qiymatlarga ega bo'lishi mumkinligini bildiradi.
-- NOT NULL ustun har doim qiymatga ega bo'lishini ta'minlaydi (bo'sh bo'lishi mumkin emas).

6. ProductName ga UNIQUE cheklov qo'shing
ALTER TABLE mahsulotlari
QO'SHISH UQ_Mahsulot nomi UNIQUE (Mahsulot nomi);

7. SQL so'rovida sharh yozing
-- Bu soʻrov narxi 100 dan yuqori boʻlgan barcha mahsulotlarni tanlaydi
Narxi > 100 bo'lgan mahsulotlardan * TANLANING;

8. CategoryID ustunini qo'shing
ALTER TABLE mahsulotlari
CategoryID INT qo'shish;

9. PK va UNIQUE bilan Categories jadvalini yarating
JADVAL toifalarini yaratish (
CategoryID INT ASOSIY KEY,
CategoryName VARCHAR(50) UNIQUE
);

10. IDENTITY ustunining maqsadi
-- IDENTITY ko'pincha asosiy kalitlar uchun ishlatiladigan ustun uchun ketma-ket qiymatlarni avtomatik ravishda yaratadi.
-- Misol: IDENTITY(1,1) 1 dan boshlanadi va 1 ga ortadi.

✅ 🟠 O'rta darajadagi vazifalar (10)
1. Ma'lumotlarni import qilish uchun BULK INSERT dan foydalaning
-- Fayl yo'li ochiq va ishonchli ekanligiga ishonch hosil qiling.
BULK INSERT Mahsulotlar
"C:\Data\products.txt" dan
BILAN (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2 -- Sarlavha qatorini o'tkazib yuborish
);

2. Kategoriyalarga havola qiluvchi mahsulotlarda EXT KALİT yarating
ALTER TABLE mahsulotlari
CHEKLASH FK_Mahsulotlar_Kategoriyalarini QO'SHING
FOREIGN KALİT (CategoryID)
ADABIYOTLAR Kategoriyalar(CategoryID);

3. ASOSIY KALIT va UNİKAL KALIT o'rtasidagi farq
-- ASOSIY KALT: Har bir satrni o'ziga xos tarzda aniqlaydi, NULLlarni o'z ichiga olmaydi, har bir jadvalda faqat bitta.
-- UNIQUE KEY: Shuningdek, o'ziga xoslikni ta'minlaydi, lekin bitta NULLga ruxsat berishi mumkin va jadvalda bir nechta noyob cheklovlar bo'lishi mumkin.

4. Narx > 0 uchun CHECK cheklovini qo'shing
ALTER TABLE mahsulotlari
CHEKLAVCHI CHK_NARX_Ijobiy TEKSHIRISHNI QO'SHISH (Narx > 0);

5. Birja ustunini qo'shing (NULL EMAS)
ALTER TABLE mahsulotlari
ADD Stock INT NOT NULL DEFAULT 0;

6. Narxdagi NULLni almashtirish uchun ISNULL dan foydalaning
Mahsulot identifikatori, Mahsulot nomi, ISNULL(Narx, 0) NI Narx sifatida tanlang
Mahsulotlardan;

7. FOREIGN KEY ning maqsadi va qo'llanilishi
-- FOREIGN KALİT ikkita jadval o'rtasida havolalar yaxlitligini ta'minlaydi.
-- U bir jadvaldagi ustunni boshqasidagi asosiy kalit bilan bog'laydi va ma'lumotlarning noto'g'ri kiritilishini oldini oladi.

✅ 🔴 Qiyin darajadagi vazifalar (10)
1. Yosh >= 18 uchun CHECK cheklovi bilan mijozlar jadvalini yarating
Jadval yaratish mijozlar (
Mijoz ID INT ASOSIY KEY,
Ismi VARCHAR(50),
Yosh INT CHECK (Yosh >= 18)
);

2. 100 dan boshlanib, 10 ga ortib, IDENTITY ustunli jadval tuzing
JADVAL YARATISH Invoys Numbers (
InvoiceID INT IDENTITY(100,10) ASOSIY KALT,
InvoiceSana DATE
);

3. OrderDetails-da kompozit PRIMARY KEY yarating
JADVAL YARATISH Buyurtma tafsilotlari (
Buyurtma identifikatori INT,
Mahsulot ID INT,
INT miqdori,
ASOSIY KALT (Buyurtma identifikatori, mahsulot identifikatori)
);

4. COALESCE va ISNULLni tushuntiring
-- ISNULL(ifoda, almashtirish): NULLni almashtirish qiymati bilan almashtiradi (faqat 2 ta argument)
-- COALESCE(expr1, expr2, ..., exprN): Ro'yxatdagi birinchi NULL bo'lmagan qiymatni qaytaradi

-- Misol:
SELECT ISNULL(NULL, 'Standart'); -- "Standart"ni qaytaradi
SELECT COALESCE(NULL, NULL, 'X'); -- 'X' qaytaradi

5. PRIMARY va UNIQUE kalitlari bilan Xodimlar jadvalini yarating
JADVAL YARATISH Xodimlar (
EmpID INT ASOSIY kalit,
Ismi VARCHAR(50),
Elektron pochta VARCHAR(100) UNIQUE
);

6. ON DELETE/UPDATE CASCADE bilan FOREIGN KEY
-- Birinchidan, ota-ona jadvali
JADVAL bo'limlarini yaratish (
DeptID INT ASOSIY KEY,
DeptName VARCHAR(50)
);

-- Keyin, bolalar stoli
JADVAL YARATISH Xodimlar (
Xodimlar ID INT ASOSIY kalit,
Xodim nomi VARCHAR(50),
DeptID INT,
CHEKLASH FK_Staff_Departments EXT KALİT (DeptID)
ADABIYOTLAR Bo'limlar (DeptID)
CASKADNI O‘CHIRIShDA
YANGILANISHDA CASKAD
);
