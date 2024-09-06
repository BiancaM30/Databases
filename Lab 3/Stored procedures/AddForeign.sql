GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE addForeign
AS
BEGIN 

ALTER TABLE Recenzii
ADD CONSTRAINT fk_recenzii FOREIGN KEY (IdCafenea) REFERENCES Cafenele(IdCafenea)


PRINT 'Am adaugat constrangerea de cheie straina coloanei IdCafenea in tabelul Recenzii'
END


