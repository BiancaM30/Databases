GO
USE CoffeeToGo
GO

--View 1
--Cream un index nonclustered filtred pe tabela Cafenele 
GO
IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Dimensiune_asc')
DROP INDEX N_idx_Dimensiune_asc ON Cafenele

CREATE NONCLUSTERED INDEX N_idx_Dimensiune_asc ON Cafenele
(DimensiuneMp ASC)  INCLUDE (Nume) WHERE DimensiuneMp > 110;


------------------------------------------------------------------------------------
--Se selecteaza toate cafenelele cu dimensiunea > 110 Mp
GO
CREATE OR ALTER VIEW vw_CafeneleDimensiune110
AS 
	SELECT Nume, DimensiuneMp FROM Cafenele
	WHERE DimensiuneMP > 110
GO

--se va face un Index Scan pe indexul NonClustered
SELECT * FROM vw_CafeneleDimensiune110
ORDER BY DimensiuneMP

------------------------------------------------------------------------------------
--Se selecteaza toate cafenelele cu dimensiunea > 150 Mp
GO
CREATE OR ALTER VIEW vw_CafeneleDimensiune150
AS 
	SELECT Nume, DimensiuneMp FROM Cafenele
	WHERE DimensiuneMP > 150
GO

--se va face un Index Seek pe indexul NonClustered pentru ca dimensiunea de 150 este inclusa in dimeniunea dupa care am facut filter in index (150>110)
SELECT * FROM vw_CafeneleDimensiune150
ORDER BY DimensiuneMP
------------------------------------------------------------------------------------
--Se selecteaza toate cafenelele cu dimensiunea < 100 Mp
GO
CREATE OR ALTER VIEW vw_CafeneleDimensiune100
AS 
	SELECT Nume, DimensiuneMp FROM Cafenele
	WHERE DimensiuneMP < 100
GO

--se va face un Index Scan pe indexul Clustered + Sortare in memorie => ineficient
--nu se foloseste indexul NonClustered pentru ca dimensiunea de <100 nu este inclusa in dimensiunea dupa care am facut filtrarea (>150)  
SELECT * FROM vw_CafeneleDimensiune100
ORDER BY DimensiuneMP
------------------------------------------------------------------------------------














--View 2

--stergere indecsi
IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_CafeneleFurnizori_idC')
DROP INDEX N_idx_CafeneleFurnizori_idC ON CafeneleFurnizori

IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_CafeneleFurnizori_idF')
DROP INDEX N_idx_CafeneleFurnizori_idF ON CafeneleFurnizori

IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Furnizori_id')
DROP INDEX N_idx_Furnizori_id ON Furnizori

IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Cafenele_id')
DROP INDEX N_idx_Cafenele_id ON Cafenele

GO
IF EXISTS (SELECT NAME FROM sys.indexes WHERE name='N_idx_Furnizor_asc_nume')
DROP INDEX N_idx_Furnizor_asc_nume ON Furnizori

--creare indecsi
CREATE NONCLUSTERED INDEX N_idx_CafeneleFurnizori_idC ON CafeneleFurnizori (IdCafenea)
CREATE NONCLUSTERED INDEX N_idx_CafeneleFurnizori_idF ON CafeneleFurnizori (IdFurnizor)
CREATE NONCLUSTERED INDEX N_idx_Furnizori_id ON Furnizori (IdFurnizor)
CREATE NONCLUSTERED INDEX N_idx_Cafenele_id ON Cafenele (IdCafenea)


--se vor selecta toti furnizorii cu toate cafenelele la care livreaza
GO
CREATE OR ALTER VIEW vw_FurnizoriCafenele
AS 
	SELECT F.Nume AS Furnizor, C.Nume AS Cafenea FROM Furnizori F INNER JOIN  CafeneleFurnizori CF ON F.IdFurnizor = CF.IdFurnizor
	INNER JOIN Cafenele C ON C.IdCafenea = CF.IdCafenea
	
GO

--ineficient => sortare in memorie
SELECT * FROM vw_FurnizoriCafenele
ORDER BY Furnizor


--index nonclustered pe campul Nume pentru tabela Furnizori
CREATE NONCLUSTERED INDEX N_idx_Furnizor_asc_nume ON Furnizori
(Nume ASC)


SELECT * FROM vw_FurnizoriCafenele
ORDER BY Furnizor ASC

