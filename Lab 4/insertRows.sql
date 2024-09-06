GO
USE CoffeeToGo
GO
/*Furnizori - 1PK, no FK
Recenzii - 1 PK, 1 FK
CafeneleFurnizori - 2 PK
*/
 
--Cream o procedura stocata care primeste ca si parametru numele unui tabel si va trebui sa insereze 1000 de inregistrari in acesta
GO
DROP PROCEDURE insertTableRows;

GO
CREATE PROCEDURE insertTableRows 
	@tableName VARCHAR(50)
AS
BEGIN
	
	DECLARE @table VARCHAR(100)
	SET @table = ('[' + @tableName + ']')

	DECLARE @contor INT
	SET @contor = 1

	WHILE @contor <= 1000
	BEGIN		
		IF @tableName = 'Furnizori'
		BEGIN
			DECLARE @idFurnizor INT
			DECLARE @nume VARCHAR(50)
			DECLARE @telefon INT
			DECLARE @adresa VARCHAR(50)
			DECLARE @siteWeb VARCHAR(50)
			DECLARE @produseLivrate VARCHAR(50)
			DECLARE @pretLunar FLOAT

			SET @idFurnizor = @contor
			SET @nume = 'furnizor' + convert(VARCHAR(7), @contor)

			DECLARE @telefonString VARCHAR(10)
			SET @telefonString = '0'
			DECLARE @contorTelefon INT 
			SET @contorTelefon = 1
			WHILE @contorTelefon <= 10
				BEGIN
				DECLARE @cifra INT
				SET @cifra = RAND()*10;
				SET @telefonString = @telefonString + CONVERT(VARCHAR(7), @cifra)
				SET @contorTelefon = @contorTelefon + 1
				END
            SET @telefon = CONVERT(VARCHAR(50), @telefonString)

			SET @adresa = 'adresa' + convert(VARCHAR(7), @contor)
			SET @siteWeb = 'www.furnizor' + convert(VARCHAR(7), @contor) + '.com'
			SET @produseLivrate = 'Cafea'
			SET @pretLunar = RAND()*(9000-1000+1)+1000;

			INSERT INTO Furnizori(IdFurnizor, Nume, Telefon, Adresa, SiteWeb, ProduseLivrate, PretLunar) 
			VALUES (@idFurnizor, @nume, @telefon, @adresa, @siteWeb, @produseLivrate, @pretLunar)
	   END
		
		ELSE IF @tableName = 'Recenzii'
		BEGIN
			DECLARE @id INT
			DECLARE @numeAutor VARCHAR(50)
			DECLARE @prenumeAutor VARCHAR(50)
			DECLARE @nrStele INT
			DECLARE @idCafenea INT
			DECLARE @descriere VARCHAR(200)
			
			SET @id = @contor
			SET @numeAutor = 'nume' + convert(VARCHAR(7), @contor)
			SET @prenumeAutor = 'prenume' + convert(VARCHAR(7), @contor)
			SET @nrStele = RAND()*(5-1+1)+1
			SELECT TOP 1 @idCafenea = idCafenea FROM Cafenele ORDER BY NEWID()
			SET @descriere = 'descriere' + convert(VARCHAR(7), @contor)
			INSERT INTO Recenzii(Id, NumeAutor, PrenumeAutor, NumarStele, IdCafenea, Descriere)
			VALUES (@id, @numeAutor, @prenumeAutor, @nrStele, @idCafenea, @descriere)
		END;

		ELSE IF @tableName = 'CafeneleFurnizori'
		BEGIN
		   --validare   
		   IF((SELECT COUNT(*) FROM Cafenele) = 0 OR (SELECT COUNT(*) FROM Furnizori)=0)
				BEGIN
					RAISERROR ('Ambele tabele (Cafenele si Furnizori) trebuie sa contina cel putin o inregistrare!', 11, 1);
					RETURN 1
				END
			DECLARE @idCaf INT
			DECLARE @idFurniz INT
			DECLARE cursorFurnizori CURSOR FAST_FORWARD FOR

			SELECT IdFurnizor FROM Furnizori;
			OPEN cursorFurnizori
			FETCH NEXT FROM cursorFurnizori INTO @idFurniz;
			WHILE @@FETCH_STATUS=0	
			BEGIN
			    SELECT TOP 1 @idCaf = idCafenea FROM Cafenele ORDER BY NEWID()
				INSERT INTO CafeneleFurnizori(IdCafenea, IdFurnizor)
			    VALUES (@idCaf, @idFurniz)
				SET @contor = @contor + 1
				FETCH NEXT FROM cursorFurnizori INTO @idFurniz;
			END
			CLOSE cursorFurnizori;
			DEALLOCATE cursorFurnizori
			
		END
		SET @contor = @contor + 1
	END
	
END


EXEC insertTableRows Furnizori;
EXEC insertTableRows CafeneleFurnizori;
EXEC insertTableRows Recenzii;

SELECT * FROM Cafenele;
SELECT * FROM Furnizori;
SELECT * FROM Recenzii;
SELECT * FROM CafeneleFurnizori
ORDER BY IdFurnizor