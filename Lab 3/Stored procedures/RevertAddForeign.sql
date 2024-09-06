GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE revertAddForeign
AS
BEGIN 

ALTER TABLE Recenzii
DROP CONSTRAINT fk_recenzii 


PRINT 'Am sters constrangerea de cheie straina din tabelul Recenzii'
END

