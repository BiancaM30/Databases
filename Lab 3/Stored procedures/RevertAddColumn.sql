GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE revertAddColumn
AS
BEGIN 

ALTER TABLE Recenzii
DROP COLUMN Descriere 


PRINT 'Am sters coloana "Descriere" din tabelul Recenzii'
END

