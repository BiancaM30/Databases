--Operatii CRUD pentru tabela CafeneleFurnizori
GO
USE CoffeeToGo
GO

-- Procedura stocata insereaza o inregistrate in tabela, daca parametri de intrare sunt valizi

CREATE OR ALTER PROCEDURE insertCafeneaFurnizor
	@idCafenea int,
	@idFurnizor int
AS
BEGIN
	DECLARE @valid BIT = 1

	if exists (select * from dbo.CafeneleFurnizori where IdCafenea = @idCafenea AND IdFurnizor = @idFurnizor)
	begin
		print 'Id duplicat'
	    set @valid = 0
	end

	--verificam daca id-ul cafenelei exista in tabela Cafenele
	if not exists (select * from dbo.Cafenele where IdCafenea = @idCafenea) 
	begin
		print 'Id cafenea invalid'
	    set @valid = 0
	end

	--verificam daca id-ul furnizorului exista in tabela Furnizori
	if not exists (select * from dbo.Furnizori where IdFurnizor = @idFurnizor) 
	begin
		print 'Id furnizor invalid'
	    set @valid = 0
	end
    
	if @valid=1
	begin
		--adaugam inregistrarea
		INSERT INTO CafeneleFurnizori(IdCafenea, IdFurnizor)
		VALUES(@idCafenea, @idFurnizor)
		print 'Inserare efectuata cu succes!' 
	end

END

----------------------------------------------------------------------------------------------
-- Procedura stocata sterge inregistrarea cu un anumit id dat ca parametru, daca id-ul exista in tabela CefeneleFurnizori

GO
CREATE OR ALTER PROCEDURE deleteCafeneaFurnizor

	@idCafenea int,
	@idFurnizor int

AS
BEGIN
	
	if not exists (select * from dbo.CafeneleFurnizori where IdCafenea = @idCafenea AND IdFurnizor = @idFurnizor)
	begin
		print 'Id-ul nu exista in tabela CafeneleFurnizori'
		return
	end

	DELETE FROM CafeneleFurnizori
	WHERE IdCafenea = @idCafenea AND IdFurnizor = @idFurnizor
	print 'Stergere efectuata cu succes!'
END


----------------------------------------------------------------------------------------------
-- Procedura afiseaza un mesaj (nu putem updata nimic pentru ca avem doar cheie primara compusa in tabela)
GO
CREATE OR ALTER PROCEDURE updateCafeneaFurnizor

	@idCafenea int,
	@idFurnizor int

AS
BEGIN
	
	if not exists (select * from dbo.CafeneleFurnizori where IdCafenea = @idCafenea AND IdFurnizor = @idFurnizor)
	begin
		print 'Id-ul nu exista in tabela CafeneleFurnizori'
		return
	end


	print 'OK'
	
END


----------------------------------------------------------------------------------------------
-- Procedura stocata selecteaza inregistrarile cu id-ul de furnizor mai mic ca 4
GO
CREATE OR ALTER PROCEDURE selectCafeneaFurnizor
AS
BEGIN
	
	select * from CafeneleFurnizori
	where IdFurnizor < 4
	print 'Select efectuat cu succes!'
END


----------------------------------------------------------------------------------------------
-- Procedura stocata principala care include operatiile CRUD pentru tabela CafeneleFurnizori
GO
CREATE OR ALTER PROCEDURE mainCrudCafeneleFurnizori
AS
BEGIN
	
	EXEC insertCafeneaFurnizor 4, 3; 
	EXEC selectCafeneaFurnizor;
	EXEC updateCafeneaFurnizor 4, 3;
	EXEC selectCafeneaFurnizor;
	EXEC deleteCafeneaFurnizor 4, 3;
	EXEC selectCafeneaFurnizor;

	--exemplu insert invalid
	EXEC insertCafeneaFurnizor 4, 200; 
	--exemplu delete invalid
	EXEC deleteCafeneaFurnizor 3, 4; 
	--exemplu update invalid
	EXEC updateCafeneaFurnizor 4, 3; 
END


GO
EXEC mainCrudCafeneleFurnizori;
SELECT * FROM CafeneleFurnizori; 

