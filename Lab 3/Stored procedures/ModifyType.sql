GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE modifyType
AS
BEGIN 

ALTER TABLE Cafenele
ALTER COLUMN NumarMese tinyint

PRINT 'Coloana "numarMese" din tabela "Cafenele" si-a schimbat tipul din int in tinyint'
END
