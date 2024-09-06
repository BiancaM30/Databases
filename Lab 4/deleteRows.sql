GO
USE CoffeeToGo
GO
/*Furnizori - 1PK, no FK
Recenzii - 1 PK, 1 FK
CafeneleFurnizori - 2 PK
*/

--Cream o procedura stocata care primeste ca si parametru numele unui tabel si va trebui sa sterga toate inregistrarile din acesta
GO
DROP PROCEDURE deleteTableRows;

GO
CREATE PROCEDURE deleteTableRows
	@tableName varchar(50)
AS
BEGIN

	IF @tableName = 'Furnizori'
			DELETE FROM Furnizori

	ELSE IF @tableName = 'CafeneleFurnizori'
		DELETE FROM CafeneleFurnizori

	ELSE IF @tableName = 'Recenzii'
		DELETE FROM Recenzii	
END;


SELECT * FROM Furnizori;
SELECT * FROM Recenzii;
SELECT * FROM CafeneleFurnizori;

EXEC deleteTableRows CafeneleFurnizori;
EXEC deleteTableRows Furnizori;
EXEC deleteTableRows Recenzii;
