--Operatii CRUD pentru tabela Cafenele
GO
USE CoffeeToGo
GO

-- Procedura stocata insereaza o cafenea in tabel daca parametri de intrare sunt valizi

CREATE OR ALTER PROCEDURE insertCafenea
	@idCafenea int,
	@nume varchar(50),
	@adresa varchar(50),
	@dimensiuneMp int,
	@numarMese tinyint,
	@numarAngajati int,
	@numarClienti int
AS
BEGIN
	DECLARE @valid BIT = 1

	if exists (select * from dbo.Cafenele where IdCafenea = @idCafenea)
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
	
	if dbo.checkNumarPozitiv(@dimensiuneMp) = 0
	begin
		print 'Dimensiune invalida!'
		set @valid = 0
	end

	if dbo.checkNumarPozitiv(@numarMese) = 0
	begin
		print 'Numar mese invalid!'
		set @valid = 0
	end

	if dbo.checkNumarPozitiv(@numarAngajati) = 0
	begin
		print 'Numar angajati invalid!'
		set @valid = 0
	end

	if dbo.checkNumarPozitiv(@numarClienti) = 0
	begin
		print 'Numar clienti invalid!'
		set @valid = 0
	end
	
	if @valid=1
	begin
		--adaugam inregistrarea
		INSERT INTO Cafenele(IdCafenea, Nume, Adresa, DimensiuneMP, NumarMese, NumarAngajati, NumarClienti)
		VALUES(@idCafenea, @nume, @adresa, @dimensiuneMp, @numarMese, @numarAngajati, @numarClienti)
		print 'Inserare efectuata cu succes!' 
	end

END

----------------------------------------------------------------------------------------------
-- Procedura stocata sterge cafeneaua cu un anumit id dat ca parametru, daca id-ul exista in tabela Cefenele 
-- si daca nu se gaseste in tabela CafeneleFurnizori

GO
CREATE OR ALTER PROCEDURE deleteCafenea

	@id int

AS
BEGIN
	
	if not exists (select * from dbo.Cafenele where IdCafenea = @id)
	begin
		print 'Id-ul nu exista in tabela Cafenele'
		return
	end

	if exists (select * from dbo.CafeneleFurnizori where IdCafenea = @id)
	begin
		print 'Nu se poate sterge deoarece id-ul se gaseste in tabela CafeneleFurnizori'
		return
	end

	DELETE FROM Cafenele
	WHERE IdCafenea = @id
	print 'Stergere efectuata cu succes!'
END


----------------------------------------------------------------------------------------------
-- Procedura updateaza numarul de angajati al unei cafenele cu id dat
GO
CREATE OR ALTER PROCEDURE updateCafenea
	@id int,
	@nrAngajatiNou int

AS
BEGIN
	
	if not exists (select * from dbo.Cafenele where IdCafenea = @id)
	begin
		print 'Id-ul nu exista in tabela Cafenele'
		return
	end

	if dbo.checkNumarPozitiv(@nrAngajatiNou) = 0
	begin
		print 'Numar angajati invalid!'
		return
	end

	UPDATE Cafenele
	SET NumarAngajati = @nrAngajatiNou
	WHERE IdCafenea = @id
	print 'Update efectuat cu succes!'
	
END


----------------------------------------------------------------------------------------------
-- Procedura stocata selecteaza cafenelele cu mai putin de 4 angajati
GO
CREATE OR ALTER PROCEDURE selectCafenea
AS
BEGIN
	
	select * from Cafenele
	where NumarAngajati < 4
	print 'Select efectuat cu succes!'
END


----------------------------------------------------------------------------------------------
-- Procedura stocata principala care include operatiile CRUD pentru tabela Cafenele
GO
CREATE OR ALTER PROCEDURE mainCrudCafenele
AS
BEGIN
	
	EXEC insertCafenea 7, 'Coffee Corner', 'Miron Costin', 187, 11, 3, 52;
	EXEC selectCafenea;
	EXEC updateCafenea 7, 2;
	EXEC selectCafenea;
	EXEC deleteCafenea 7;
	EXEC selectCafenea;


	--exemplu insert invalid
	EXEC insertCafenea 10, 'Coffee Shop', 'AL**(89', -187, 11, -3, 52;
	--exemplu delete invalid
	EXEC deleteCafenea 1000 
	--exemplu update invalid
	EXEC updateCafenea 3, -8

END


GO
EXEC mainCrudCafenele;
SELECT * FROM Cafenele; 