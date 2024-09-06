GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE addColumn
AS
BEGIN 

ALTER TABLE Recenzii
ADD Descriere varchar(200)


PRINT 'Am adaugat coloana noua "Descriere" in tabelul Recenzii'
END
