GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE revertAddDefault
AS
BEGIN 

ALTER TABLE MeniuCafele
DROP CONSTRAINT df_pahar

PRINT 'Am sters constrangerea default pentru pahar'
END

EXEC revertAddDefault
