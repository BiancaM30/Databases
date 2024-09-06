GO
USE CoffeeToGo
GO
     
CREATE PROCEDURE createTable
AS
BEGIN 

CREATE TABLE Recenzii(
Id int NOT NULL PRIMARY KEY,
NumeAutor varchar(50),
PrenumeAutor varchar(50),
NumarStele int NOT NULL,
IdCafenea int NOT NULL,


 CONSTRAINT ck_NumarStele CHECK(NumarStele >= 0 AND NumarStele <= 5),
);

PRINT 'Am creat tabelul "Recenzii"'
END
