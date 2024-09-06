--inseram inregistrari in CoffeeToGo

go
use CoffeeToGo
go

DELETE FROM ComenziDulciuri
DELETE FROM ComenziCafele
DELETE FROM MeniuDulciuri
DELETE FROM MeniuCafele
DELETE FROM CardFidelitate
DELETE FROM Comenzi
DELETE FROM Carti
DELETE FROM Clienti
DELETE FROM CafeneleFurnizori
DELETE FROM Furnizori
DELETE FROM Angajati
DELETE FROM Cafenele

--Cafenele
INSERT INTO Cafenele(IdCafenea, Nume, Adresa, DimensiuneMP, NumarMese, NumarAngajati, NumarClienti) VALUES
(1, '5ToGo', 'Str. Vasile Alecsandri 39', 115, 5, 2, 55),
(2, 'Santacruz', 'Str. Stefan cel Mare 28', 140, 6, 3, 40),
(3, 'Baristas', 'Str. 9 Mai 36', 210, 10, 4, 65),
(4, 'Coffee Point', 'Str. Nicolae Balcescu 2', 90, 4, 2, 33),
(5, 'Ritual Coffee', 'Str. Mihai Viteazul 24', 100, 7, 3, 52),
(6, 'Mau Cafe','Str. Alexandru cel Bun 4', 245, 12, 4, 75);

SELECT * FROM Cafenele;

--Furnizori
INSERT INTO Furnizori(IdFurnizor, Nume, Telefon, Adresa, SiteWeb, ProduseLivrate, PretLunar) VALUES
(1, 'Hendi', 0748123444, 'Str. Mioritei 5', 'www.hendi.ro', 'Cafea', 1100),
(2, 'ProfiPacking', 0733555278, 'Str. Oituz 34', 'www.profipack.com', 'Consumabile', 430),
(3, 'BarShaker', 0755091333, 'Str. Decebal 56', 'www.barshaker.ro', 'Expresoare', 2100),
(4, 'WePack', 0755043566, 'Str. Spiru Haret 10', 'www.wepack.ro', 'Consumabile', 280),
(5, 'Colombian', 0799156233, 'Str. Aeroportului 17', 'www.colombian.com', 'Cafea', 1155);

SELECT * FROM Furnizori;

--CafeneleFurnizori (pentru fiecare cafenea introducem cate un furnizor de cafea, unul de expresoare si unul consumabile)
INSERT INTO CafeneleFurnizori(IdCafenea, IdFurnizor) VALUES
(1, 1), (1, 3), (1, 4),
(2, 5), (2, 3), (2, 2),
(3, 5), (3, 3), (3, 4),
(4, 5), (4, 3), (4, 2),
(5, 5), (5, 3), (5, 2),
(6, 1), (6, 3), (6, 4);

SELECT * FROM CafeneleFurnizori;

--Angajati
INSERT INTO Angajati(IdCafenea, Nume, Prenume, Varsta, AniExperienta, Tura) VALUES
(1, 'Barbu', 'Ioana', 19, 1, 1),
(1, 'Pop', 'Alexandru', 25, 3, 2),
(2, 'Pintilie', 'Cosmin', 30, 7, 2),
(2, 'Ionescu', 'Claudia', 34, 10, 1),
(2, 'Barbu', 'Iulia', 19, 1, 1),
(3, 'Stan', 'Tudor', 22, 2, 1),
(3, 'Rusu', 'Victor', 30, 5, 2),
(3, 'Rusu', 'Ana', 21, 1, 2),
(3, 'Pop', 'Marius', 28, 8, 1),
(4, 'Lazar', 'Mihai', 25, 3, 2),
(4, 'Sandu', 'Lorena', 26, 2, 1),
(5, 'Florea', 'Ilinca', 21, 1, 1),
(5, 'Stan', 'Horatiu', 27, 5, 1),
(5, 'Cristea', 'Tudor', 19, 1, 2),
(6, 'Rusu', 'Valentina', 21, 1, 1),
(6, 'Stan', 'Iuliana', 32, 11, 2),
(6, 'Dumitrescu', 'Robert', 31, 10, 2),
(6, 'Pintilie', 'Rares', 24, 5, 1);

SELECT * FROM Angajati;

--Carti
INSERT INTO Carti(Titlu, Autor, NumarPagini, Gen, AnAparitie, IdCafenea) VALUES
('La rascruce de vanturi', 'Emily Brote', 170, 'Clasic', 1847, 1),
('Robinson Crusoe', 'Daniel Defoe', 223, 'Aventura', 1719, 2),
('Divina comedie', 'Dante Alighieri', 300, 'Comedie', 1472, 1),
('Mandrie si prejudecata', 'Jane Austen', 150, 'Clasic', 1813, 1),
('Aventurile lui Tom Sawyer', 'Mark Twain', 230, 'Aventura', 1876, 1),
('Razboi si pace', 'Lev Tolstoi', 200, 'Clasic', 1867, 3),
('Viata lui Pi', 'Yann Martel', 198, 'Aventura', 2001, 1),
('Mizerabilii', 'Victor Hugo', 160, 'Clasic', 1862, 2),
('Aventurile lui Huckleberry Finn', 'Mark Twain', 214, 'Aventura', 1884, 1),
('Alchimistul', 'Paulo Coelho', 190, 'Fictiune', 1988, 4);

SELECT * FROM Carti;

--Clienti
INSERT INTO Clienti(IdClient, Nume, Prenume, IdCafenea) VALUES
(1, 'Popa', 'Andreea', 1),
(2, 'Muresan', 'Matei', 2),
(3, 'Dumitru', 'Ioana', 3),
(4, 'Ionescu', 'Vlad', 2),
(5, 'Popa', 'Lorena', 2),
(6, 'Dragomir', 'Raluca', 5),
(7, 'Ungureanu', 'Ioana', 5),
(8, 'Cojocaru', 'Mihai', 6),
(9, 'Muresan', 'Alexandra', 1),
(10, 'Ionescu', 'Valentin', 1),
(11, 'Sandu', 'George', 3),
(12, 'Popa', 'Casandra', 2),
(13, 'Neagu', 'Tudor', 4),
(14, 'Muresan', 'David', 2),
(15, 'Rusu', 'Andrei', 3),
(16, 'Stan', 'Iulian', 1),
(17, 'Lazar', 'Ilinca', 3);

SELECT * FROM Clienti;

--CardFidelitate
INSERT INTO CardFidelitate(IdClient, Email, Telefon, NumarStickere) VALUES
(1, 'pandreea@yahoo.com', '0745111111', 1),
(2, 'mmatei@gmail.com', '0745222222', 2),
(3, 'dioana@gmail.com', '07459333333', 3),
(4, 'ivlad@yahoo.com', '07459444444', 2),
(5, 'plorena@yahoo.com', '07459555555', 2),
(6, 'draluca@gmail.com', '0745666666', 5),
(7, 'uioana@gmail.com', '0745777777', 5),
(8, 'cmihai@yahoo.com', '0745888888', 2),
(9, 'malexandra@gmail.com','0745999999', 1),
(10, 'ivalentin@yahoo.com','0746123123', 1),
(11, 'sgeorge@yahoo.com', '0746451321', 3),
(12, 'pcasandra@gmail.com', '0745900839', 2),
(13, 'ntudor@yahoo.com', '07459003467', 4),
(14, 'mdavid@yahoo.com', '0745178292', 2),
(15, 'randrei@gmail.com', '07459738298', 3),
(16, 'siulian@yahoo.com', '0746728191', 1),
(17, 'lilinca@yahoo.com', '0745967567', 3);

SELECT * FROM CardFidelitate;

--Comenzi
INSERT INTO Comenzi (IdComanda, IdClient) VALUES
(1, 3),
(2, 1),
(3, 13),
(4, 4),
(5, 3),
(6, 1),
(7, 5),
(8, 12),
(9, 2),
(10, 4),
(11, 2),
(12, 12),
(13, 3),
(14, 13),
(15, 7);

SELECT * FROM Comenzi;

--MeniuCafele
INSERT INTO MeniuCafele(CodProdus, Nume, Pahar, TipCafea, Aroma, TipLapte, Pret) VALUES
(1, 'Expresso', 'Mediu', 'Arabica', 'Ciocolata', 'Normal', 10),
(2, 'Cappuccino', 'Mic', 'Arabica', 'Cocos', 'Soia', 11),
(3, 'Latte', 'Mare', 'Robusta', 'Vanilie', 'Normal', 9),
(4, 'Expresso', 'Mic', 'Arabica', 'Ciocolata', 'Normal', 13),
(5, 'Cappuccino', 'Mediu', 'Robusta', 'Cocos', 'Soia', 14),
(6, 'Latte', 'Mare', 'Arabica', 'Alune', 'Normal', 10),
(7, 'Expresso', 'Mic', 'Robusta', 'Oreo', 'Normal', 13),
(8, 'Frappe', 'Mediu', 'Arabica', 'Caramel', 'Soia', 15),
(9, 'Frappe','Mare', 'Robusta', 'Ciocolata', 'Soia', 10),
(10, 'Latte', 'Mare', 'Arabica', 'Vanilie', 'Normal', 18),
(11, 'Expresso', 'Mare', 'Robusta', 'Cocos', 'Soia', 12),
(12,'Cappuccino', 'Mediu', 'Robusta', 'Cocos', 'Normal', 9),
(13, 'Latte', 'Mare', 'Arabica', 'Ciocolata', 'Soia', 13),
(14, 'Frappe', 'Mic', 'Robusta', 'Cocos', 'Normal', 7);

SELECT * FROM MeniuCafele;

--ComenziCafele
INSERT INTO ComenziCafele(IdComanda, CodProdus) VALUES
(1, 1), (1,8),
(2, 5),
(3, 1), (3,5), (3,4),
(4, 2), (4, 6),
(5, 9),
(6, 8),
(11, 5),
(12, 9),
(15, 1);

SELECT * FROM ComenziCafele;

--Meniu Dulciuri
INSERT INTO MeniuDulciuri(CodProdus, Nume, Gramaj, Calorii, Pret) VALUES
(1, 'Croissant', 70, 90, 5.5),
(2, 'Brownie', 80, 150, 7),
(3, 'Cookie', 40, 75, 3.5),
(4, 'Tiramisu', 120, 200, 12.5);

SELECT * FROM MeniuDulciuri;

--ComenziDulciuri
INSERT INTO ComenziDulciuri(IdComanda, CodProdus) VALUES
(1, 1), (1,3),
(2, 4),
(3, 1), (3,2), (3,4),
(7, 2),
(10, 3), (10, 4),
(15, 1);

SELECT * FROM ComenziDulciuri;

SELECT * FROM Cafenele;
SELECT * FROM Furnizori;
SELECT * FROM CafeneleFurnizori;
SELECT * FROM Angajati;
SELECT * FROM Carti;
SELECT * FROM Clienti;
SELECT * FROM CardFidelitate;
SELECT * FROM Comenzi;
SELECT * FROM MeniuCafele;
SELECT * FROM ComenziCafele;
SELECT * FROM MeniuDulciuri;
SELECT * FROM ComenziDulciuri;