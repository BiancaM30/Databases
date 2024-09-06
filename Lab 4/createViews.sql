GO
USE CoffeeToGo
GO
 
--un view ce contine o comanda SELECT pe o tabela,
--Se selecteaza toate recenziile de 5 stele 
GO
CREATE VIEW vw_Recenzii
AS 
	SELECT * 
	FROM Recenzii
	WHERE NumarStele = 5
GO

SELECT * FROM vw_Recenzii

--un view ce contine o comanda SELECT aplicata pe cel putin doua tabele
--Se selecteaza toti furnizorii care furnizeaza produse cafenelelor cu dimensiunea mai mare de 150 mp 
--Se va afisa numele furnizorului, numele cafenelei, dimensiunea cafenelei
GO
CREATE VIEW vw_FurnizoriCafeneleMp
AS 
	SELECT F.Nume, C.IdCafenea, C.DimensiuneMP
	FROM Furnizori F INNER JOIN  CafeneleFurnizori CF ON F.IdFurnizor = CF.IdFurnizor
	INNER JOIN Cafenele C ON C.IdCafenea = CF.IdCafenea AND C.DimensiuneMP > 150
GO

SELECT * FROM vw_FurnizoriCafeneleMp
	
--un view ce contine o comanda SELECT aplicata pe cel putin doua tabele si 
--avand o clauza GROUP BY.
--Se va calcula numarul de furnizori pentru fiecare cafenea
--Se va afisa id-ul cafenelei, numele ei si numarul de furnizori ai acesteia
GO
CREATE VIEW vw_NrFurnizoriCafenele
AS
	SELECT C.IdCafenea, C.Nume,
	COUNT(F.IdFurnizor) AS [Numar Furnizori]
	FROM Furnizori F INNER JOIN  CafeneleFurnizori CF ON F.IdFurnizor = CF.IdFurnizor
	INNER JOIN Cafenele C ON C.IdCafenea = CF.IdCafenea 
	GROUP BY C.IdCafenea, C.Nume
GO

SELECT * FROM vw_NrFurnizoriCafenele


