GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE revertModifyType
AS
BEGIN 

ALTER TABLE Cafenele
ALTER COLUMN NumarMese int

PRINT 'Coloana "numarMese" din tabela "Cafenele" si-a schimbat tipul din tinyint in int'
END

