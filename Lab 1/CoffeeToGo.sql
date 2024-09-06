DROP DATABASE CoffeeToGo

Create database CoffeeToGo

go
use CoffeeToGo
go

CREATE TABLE Cafenele
(
 IdCafenea INT PRIMARY KEY,
 Nume varchar(50) NOT NULL,
 Adresa varchar(50) NOT NULL,
 DimensiuneMP int NOT NULL,
 NumarMese int,
 NumarAngajati int NOT NULL,
 NumarClienti int,
)

CREATE TABLE Angajati
(
 IdCafenea INT FOREIGN KEY REFERENCES Cafenele(IdCafenea),
 Nume varchar(50),
 Prenume varchar(50),
 Varsta int NOT NULL,
 AniExperienta int,
 Tura int NOT NULL,

 CONSTRAINT pk_Angajati PRIMARY KEY(Nume, Prenume),
 CONSTRAINT ck_Varsta CHECK (Varsta > 18),
 CONSTRAINT ck_Tura CHECK (Tura = 1 OR Tura = 2)
)

CREATE TABLE Furnizori
(
 IdFurnizor INT PRIMARY KEY,
 Nume varchar(50) NOT NULL,
 Telefon int NOT NULL,
 Adresa varchar(50),
 SiteWeb varchar(50),
 ProduseLivrate varchar(50) NOT NULL,
 PretLunar float,

 CONSTRAINT ck_ProduseLivrate CHECK (ProduseLivrate IN ('Consumabile', 'Cafea', 'Expresoare'))
)

CREATE TABLE CafeneleFurnizori
(
 IdCafenea INT FOREIGN KEY REFERENCES Cafenele(IdCafenea),
 IdFurnizor INT FOREIGN KEY REFERENCES Furnizori(IdFurnizor),

 CONSTRAINT pk_CafeneleFurnizori PRIMARY KEY(IdCafenea, IdFurnizor)
)

CREATE TABLE Clienti
(IdClient INT PRIMARY KEY,
 Nume varchar(50) NOT NULL, 
 Prenume varchar(50) NOT NULL,

 IdCafenea INT FOREIGN KEY REFERENCES Cafenele(IdCafenea)
)

CREATE TABLE Carti
(
 Titlu varchar(50) NOT NULL,
 Autor varchar(50) NOT NULL,
 NumarPagini int,
 Gen varchar(10),
 AnAparitie int,
 IdCafenea int FOREIGN KEY REFERENCES Cafenele(IdCafenea),

 CONSTRAINT pk_Carti PRIMARY KEY (Titlu, Autor),
 CONSTRAINT ck_Gen CHECK (Gen IN ('Clasic', 'Aventura', 'Comedie', 'Fictiune', 'Romantic'))
)
CREATE TABLE Comenzi
(IdComanda INT PRIMARY KEY,
 IdClient INT FOREIGN KEY REFERENCES Clienti(IdClient),
 Ora DATETIME DEFAULT GETDATE(),

)


CREATE TABLE CarduriFidelitate
(IdClient INT PRIMARY KEY,
 Email varchar(50),
 Telefon varchar(11),
 NumarStickere int,

 CONSTRAINT ck_NumarStickere CHECK(NumarStickere >= 0 AND NumarStickere <= 5),
 CONSTRAINT fk_CardFidelitate FOREIGN KEY (IdClient) REFERENCES Clienti (IdClient) 
)

CREATE TABLE MeniuCafele
(CodProdus INT PRIMARY KEY,
 Nume varchar(50) NOT NULL,
 Pahar varchar(10) NOT NULL,
 TipCafea varchar(50) DEFAULT 'Arabica',
 Aroma varchar(10),
 TipLapte varchar(10) DEFAULT 'Normal',
 Pret float NOT NULL,

 CONSTRAINT ck_NumeCafea CHECK (Nume IN ('Expresso', 'Latte', 'Cappuccino', 'Frappe')),
 CONSTRAINT ck_Pahar CHECK (Pahar IN ('Mic', 'Mediu', 'Mare')),
 CONSTRAINT ck_TipCafea CHECK (TipCafea IN ('Arabica', 'Robusta')),
 CONSTRAINT ck_Aroma CHECK (Aroma IN ('Ciocolata', 'Vanilie', 'Cocos', 'Alune', 'Oreo', 'Caramel')),
 CONSTRAINT ck_TipLapte CHECK (TipLapte IN ('Normal', 'Soia'))
)

CREATE TABLE MeniuDulciuri
(CodProdus INT PRIMARY KEY,
 Nume varchar(50) NOT NULL,
 Gramaj int DEFAULT 80,
 Calorii int,
 Pret float NOT NULL,

 CONSTRAINT ck_NumeDulciuri CHECK (Nume IN ('Croissant', 'Brownie', 'Cookie', 'Tiramisu')),
)




CREATE TABLE ComenziCafele
(IdComanda INT FOREIGN KEY REFERENCES Comenzi(IdComanda),
 CodProdus INT FOREIGN KEY REFERENCES MeniuCafele(CodProdus),

 CONSTRAINT pk_ComenziCafele PRIMARY KEY (IdComanda, CodProdus)

)

CREATE TABLE ComenziDulciuri
(IdComanda INT FOREIGN KEY REFERENCES Comenzi(IdComanda),
 CodProdus INT FOREIGN KEY REFERENCES MeniuDulciuri(CodProdus),

 CONSTRAINT pk_ComenziDulciuri PRIMARY KEY (IdComanda, CodProdus)

)








