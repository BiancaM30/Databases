/*
 Functia verifica daca stringul produseLivrate, ce urmeaza sa fie adaugat in tabela Furnizori este valid
 Returneaza { 1 daca e valid, 
            { 0 altfel
*/

GO
USE CoffeeToGo
GO

CREATE OR ALTER FUNCTION checkFormatProduseLivrate
(
	@produseLivrate varchar(50)
)
RETURNS BIT

AS
BEGIN
	IF (@produseLivrate != 'Expresoare' AND @produseLivrate != 'Cafea' AND @produseLivrate != 'Consumabile')
		RETURN 0

    RETURN 1
END


-----testare
GO
PRINT dbo.checkFormatProduseLivrate ('Expres') 
PRINT dbo.checkFormatProduseLivrate ('Expresoare') 
PRINT dbo.checkFormatProduseLivrate ('Cafea') 
PRINT dbo.checkFormatProduseLivrate ('Consumabile') 
