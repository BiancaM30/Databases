--DROP TABLE Versiune

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