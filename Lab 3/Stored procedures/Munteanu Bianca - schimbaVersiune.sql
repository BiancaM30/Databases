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





GO
USE CoffeeToGo
GO   
CREATE PROCEDURE revertCreateTable
AS
BEGIN 

DROP TABLE Recenzii

PRINT 'Am sters tabelul "Recenzii"'
END




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



CREATE TABLE Versiune(
NrVersiune INT

CONSTRAINT ck_Versiune CHECK (NrVersiune >= 0 AND NrVersiune <=5 ),
);



DROP PROCEDURE schimbaVersiunea

GO
USE CoffeeToGo
GO
CREATE PROCEDURE schimbaVersiunea
@versNoua INT
AS
BEGIN
	DECLARE @versCrt INT
	SET @versCrt = (SELECT NrVersiune FROM Versiune)

	IF (CAST(@versNoua AS INT) < 0 OR CAST(@versNoua AS INT) > 5)
		RAISERROR ('Versiunea trebuie sa fie un numar intreg cuprins intre 0 si 5', 11, 1);

	ELSE
	BEGIN
		PRINT 'Versiunea curenta: ' + CAST(@versCrt AS nvarchar(2))
		PRINT 'Versiunea noua: ' +  CAST(@versNoua AS nvarchar(2))
		
		IF @versCrt < @versNoua
			BEGIN
				PRINT 'Mergem inainte de la versiunea ' + CAST(@versCrt AS nvarchar(2)) + ' la versiunea ' + CAST(@versNoua AS nvarchar(2))
				WHILE @versCrt <> @versNoua
					BEGIN
						IF @versCrt = 0
							EXEC modifyType
						ELSE IF @versCrt = 1
							EXEC addDefault
						ELSE IF @versCrt = 2
							EXEC createTable
						ELSE IF @versCrt = 3
							EXEC addColumn
						ElSE IF @versCrt = 4
							EXEC addForeign

						SET @versCrt = @versCrt + 1
					END
			END

		ELSE IF @versCrt > @versNoua
			BEGIN
				PRINT 'Mergem inapoi de la versiunea ' + CAST(@versCrt AS nvarchar(2)) + ' la versiunea ' + CAST(@versNoua AS nvarchar(2))
				WHILE @versCrt <> @versNoua
					BEGIN
						IF @versCrt = 1
							EXEC revertModifyType
						ELSE IF @versCrt = 2
							EXEC revertAddDefault
						ELSE IF @versCrt = 3
							EXEC revertCreateTable
						ELSE IF @versCrt = 4
							EXEC revertAddColumn
						ElSE IF @versCrt = 5
							EXEC revertAddForeign

						SET @versCrt = @versCrt - 1
					END
			END

			ELSE PRINT 'Baza de date este deja in versiunea ' + CAST(@versNoua AS nvarchar(2))
			UPDATE Versiune SET NrVersiune=@versNoua

	END

END


EXEC schimbaVersiunea 5