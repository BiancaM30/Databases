/* 
 Functia verifica daca stringul siteWeb, ce urmeaza sa fie adaugat in tabela Furnizori este valid
 Returneaza { 1 daca e valid, 
            { 0 altfel
*/
GO
USE CoffeeToGo
GO

CREATE OR ALTER FUNCTION checkFormatSiteWeb
(
	@siteWeb varchar(50)
)
RETURNS BIT

AS
BEGIN
	
	--verificam prima parte a sirului
	if (not SUBSTRING(@siteWeb, 1, 12) like 'https://www.')
			RETURN 0
	
	
	--verificam a doua parte a sirului
	declare @lungime int
	set @lungime = LEN(@siteWeb)

	declare @contor int
	set @contor = 13

	while @contor <= @lungime
	begin
		if not SUBSTRING(@siteWeb, @contor, 1) like '%[a-zA-Z_0-9@\.]'
			RETURN 0

		set @contor = @contor + 1
	end
    
	RETURN 1
END


-----testare
GO
PRINT dbo.checkFormatSiteWeb ('https://www.cafe10.ro') 
PRINT dbo.checkFormatSiteWeb ('https://www.c$%.com') 

