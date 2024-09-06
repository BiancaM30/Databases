/*
 Functia verifica daca un numar intreg este pozitiv
 Returneaza { 1 daca e valid, 
            { 0 altfel
*/

GO
USE CoffeeToGo
GO

CREATE OR ALTER FUNCTION checkNumarPozitiv
(
	@nr int
)
RETURNS BIT

AS
BEGIN
	
	if @nr <= 0
			return 0;

    RETURN 1
END


-----testare
GO
PRINT dbo.checkNumarPozitiv (-1000) 
PRINT dbo.checkNumarPozitiv (2003)  
