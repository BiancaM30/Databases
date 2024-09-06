--Operatii CRUD pentru tabela Furnizori
GO
USE CoffeeToGo
GO

-- Procedura stocata insereaza un furnizor in tabel daca parametri de intrare sunt valizi

CREATE OR ALTER PROCEDURE insertFurnizor
	@idFurnizor int,
	@nume varchar(50),
	@telefon int,
	@adresa varchar(50),
	@siteWeb varchar(50),
	@produseLivrate varchar(50),
	@pretLunar float
AS
BEGIN
	DECLARE @valid BIT = 1

	if exists (select * from dbo.Furnizori where IdFurnizor = @idFurnizor)
	begin
		print 'Id duplicat'
	    set @valid = 0
	end

	--verifcam validitatea parametrilor de intrare
	if dbo.checkFormatAdresa(@adresa) = 0
	begin
		print 'Adresa invalida'
		set @valid = 0
	end
	
	if dbo.checkFormatSiteWeb(@siteWeb) = 0
	begin
		print 'Site Web invalid'
		set @valid = 0
	end

	if dbo.checkFormatProduseLivrate(@produseLivrate) = 0
	begin
		print 'Produsele livrate invalide! Adaugati una din valorile: Cafea, Consumabile, Expresoare'
		set @valid = 0
	end

	if dbo.checkNumarPozitiv(@pretLunar) = 0
	begin
		print 'Pret lunar invalid'
		set @valid = 0
	end

	if @valid=1
	begin
		--adaugam inregistrarea
		INSERT INTO Furnizori(IdFurnizor, Nume, Telefon, Adresa, SiteWeb, ProduseLivrate, PretLunar)
		VALUES(@idFurnizor, @nume, @telefon, @adresa, @siteWeb, @produseLivrate, @pretLunar)
		print 'Inserare efectuata cu succes!' 
	end

END

----------------------------------------------------------------------------------------------
-- Procedura stocata sterge furnizorul cu un anumit id dat ca parametru, daca id-ul exista in tabela Furnizori 
-- si daca nu se gaseste in tabela CafeneleFurnizori

GO
CREATE OR ALTER PROCEDURE deleteFurnizor

	@id int

AS
BEGIN
	
	if not exists (select * from dbo.Furnizori where IdFurnizor = @id)
	begin
		print 'Id-ul nu exista in tabela Furnizori'
		return
	end

	if exists (select * from dbo.CafeneleFurnizori where IdFurnizor = @id)
	begin
		print 'Nu se poate sterge deoarece id-ul se gaseste in tabela CafeneleFurnizori'
		return
	end

	DELETE FROM Furnizori
	WHERE IdFurnizor = @id
	print 'Stergere efectuata cu succes!'
END

----------------------------------------------------------------------------------------------
-- Procedura updateaza pretul lunar al unui furnizor cu id dat
GO
CREATE OR ALTER PROCEDURE updateFurnizor
	@id int,
	@pretNou float

AS
BEGIN
	
	if not exists (select * from dbo.Furnizori where IdFurnizor = @id)
	begin
		print 'Id-ul nu exista in tabela Furnizori'
		return
	end

	if dbo.checkNumarPozitiv(@pretNou) = 0
	begin
		print 'Pret invalid'
		return
	end

	UPDATE Furnizori
	SET PretLunar = @pretNou
	WHERE IdFurnizor = @id
	print 'Update efectuat cu succes!'
	
END


----------------------------------------------------------------------------------------------
-- Procedura stocata selecteaza furnizorii care livreaza cafea
GO
CREATE OR ALTER PROCEDURE selectFurnizor
AS
BEGIN
	
	select * from Furnizori
	where ProduseLivrate = 'Cafea'
	print 'Select efectuat cu succes!'
END



----------------------------------------------------------------------------------------------
-- Procedura stocata principala care include operatiile CRUD pentru tabela Furnizori
GO
CREATE OR ALTER PROCEDURE mainCrudFurnizori
AS
BEGIN
	
	EXEC insertFurnizor 5, 'Colombian', 0799156233, 'Aeroportului 17', 'https://www.colombian.com', 'Cafea', 1155;
	EXEC selectFurnizor;
	EXEC updateFurnizor 5, 900;
	EXEC selectFurnizor;
	EXEC deleteFurnizor 5;
	EXEC selectFurnizor;

	--exemplu insert invalid
	EXEC insertFurnizor 15, 'Arabic', 0799159033, '&*e', 'arabic17', 'aa', -11;
	--exemplu update invalid
	EXEC updateFurnizor 1, -100
	--exemplu delete invalid
	EXEC deleteFurnizor 100
END


GO
EXEC mainCrudFurnizori;
