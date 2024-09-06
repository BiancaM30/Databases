/*
 Functia verifica daca pretul este valid 
 Returneaza { 1 daca e valid, 
            { 0 altfel
*/

GO
USE CoffeeToGo
GO

CREATE OR ALTER FUNCTION checkPret
(
	@pret float
)
RETURNS BIT

AS
BEGIN
	
	if @pret < 0
			return 0;

    RETURN 1
END


-----testare
GO
PRINT dbo.checkPret (-1000) 
PRINT dbo.checkPret (2003.2) 
PRINT dbo.checkPret (2) 
