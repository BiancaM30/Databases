GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE addDefault
AS
BEGIN 

ALTER TABLE MeniuCafele
ADD CONSTRAINT df_pahar DEFAULT 'Mediu' FOR Pahar

PRINT 'Am adaugat constrangerea default "Mediu" pentru pahar'
END

