/*
 Functia verifica daca stringul 'adresa', ce urmeaza sa fie adaugat in tabela Furnizori este valid
 Returneaza { 1 daca e valid, 
            { 0 altfel
*/

GO
USE CoffeeToGo
GO

CREATE OR ALTER FUNCTION checkAdresa
(
	@adresa varchar(50)
)
RETURNS BIT

AS
BEGIN
	declare @lungime int
	set @lungime = LEN(@adresa)

	declare @contor int
	set @contor = 1

	while @contor <= @lungime
	begin
		if not SUBSTRING(@adresa, @contor, 1) like '%[a-zA-Z ,0-9]'
			return 0

		set @contor = @contor + 1
	end

    RETURN 1
END


-----testare
GO
PRINT dbo.checkAdresa ('Primaverii 10') 
PRINT dbo.checkAdresa ('9 Mai 105') 
PRINT dbo.checkAdresa ('Floril$l@') 
