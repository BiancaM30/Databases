GO
USE CoffeeToGo
GO

DELETE FROM TestRuns
DBCC CHECKIDENT ('[TestRuns]', RESEED, 0); --resetare identity
DELETE FROM TestRunTables
DBCC CHECKIDENT ('[TestRunTables]', RESEED, 0); --resetare identity
DELETE FROM TestRunViews
DBCC CHECKIDENT ('[TestRunViews]', RESEED, 0); --resetare identity

GO
INSERT INTO Tables(Name) VALUES ('Furnizori'), ('CafeneleFurnizori'), ('Recenzii');
SELECT * FROM Tables;
-----------------------------------------------------------------------------

INSERT INTO Views(Name) VALUES ('vw_Recenzii'), ('vw_FurnizoriCafeneleMp'), ('vw_NrFurnizoriCafenele');
SELECT * FROM Views;

-----------------------------------------------------------------------------

INSERT INTO Tests VALUES ('delete_table'), ('insert_table'), ('select_view');
SELECT * FROM Tests;

-----------------------------------------------------------------------------

INSERT INTO TestViews VALUES (3,1), (3,2), (3,3);
SELECT * FROM TestViews;

-----------------------------------------------------------------------------

INSERT INTO TestTables(TestID, TableID, NoOfRows, Position) 
VALUES (1,1,1000,5), (1,2,1000,6), (1,3,1000,4), (2,1,1000,2), (2,2,1000,1), (2,3,1000,3);
SELECT * FROM TestTables;

-----------------------------------------------------------------------------

DROP PROCEDURE mainTest
GO
CREATE PROCEDURE mainTest
AS
BEGIN
  
	DECLARE @start_at DATETIME
	SET @start_at = GETDATE();

	DECLARE @delete_caf_furniz_start DATETIME
	SET @delete_caf_furniz_start = GETDATE()
	EXEC deleteTableRows CafeneleFurnizori;
	DECLARE @delete_caf_furniz_end DATETIME
	SET @delete_caf_furniz_end = GETDATE()

	DECLARE @delete_furniz_start DATETIME
	SET @delete_furniz_start = GETDATE()
	EXEC deleteTableRows Furnizori;
	DECLARE @delete_furniz_end DATETIME
	SET @delete_furniz_end = GETDATE()

	DECLARE @delete_recenzii_start DATETIME
	SET @delete_recenzii_start = GETDATE()
	EXEC deleteTableRows Recenzii;
	DECLARE @delete_recenzii_end DATETIME
	SET @delete_recenzii_end = GETDATE()

	DECLARE @insert_recenzii_start DATETIME
	SET @insert_recenzii_start = GETDATE()
	EXEC insertTableRows Recenzii
	DECLARE @insert_recenzii_end DATETIME
	SET @insert_recenzii_end = GETDATE()

	DECLARE @insert_furnizori_start DATETIME
	SET @insert_furnizori_start = GETDATE()
	EXEC insertTableRows Furnizori
	DECLARE @insert_furnizori_end DATETIME
	SET @insert_furnizori_end = GETDATE()

	DECLARE @insert_caf_furniz_start DATETIME
	SET @insert_caf_furniz_start = GETDATE()
	EXEC insertTableRows CafeneleFurnizori
	DECLARE @insert_caf_furniz_end DATETIME
	SET @insert_caf_furniz_end = GETDATE()

	DECLARE @view1_Recenzii_start DATETIME
	SET @view1_Recenzii_start = GETDATE()
	SELECT * FROM vw_Recenzii
	DECLARE @view1_Recenzii_end DATETIME
	SET @view1_Recenzii_end = GETDATE()

	DECLARE @view2_FurnizCafMp_start DATETIME
	SET @view2_FurnizCafMp_start = GETDATE()
	SELECT * FROM vw_FurnizoriCafeneleMp
	DECLARE @view2_FurnizCafMp_end DATETIME
	SET @view2_FurnizCafMp_end = GETDATE()

	DECLARE @view3_NrFurnizCaf_start DATETIME
	SET @view3_NrFurnizCaf_start = GETDATE()
	SELECT * FROM vw_NrFurnizoriCafenele
	DECLARE @view3_NrFurnizCaf_end DATETIME
	SET @view3_NrFurnizCaf_end = GETDATE()

	DECLARE @end_at DATETIME 
	SET @end_at = GETDATE() 

	DECLARE @description VARCHAR(100)
	SET @description = 'descriere'

	INSERT INTO TestRuns(Description, StartAt, EndAt)
	VALUES(@description, @start_at, @end_at);

	--id-ul testului curent
	DECLARE @crtTestRunId INT; 
	SET @crtTestRunId = (SELECT MAX(TestRunID) FROM TestRuns);

	INSERT INTO TestRunTables
	VALUES(@crtTestRunId, 1, @delete_caf_furniz_start, @insert_caf_furniz_end)

	INSERT INTO TestRunTables
	VALUES(@crtTestRunId, 2, @delete_furniz_start, @insert_furnizori_end)

	INSERT INTO TestRunTables
	VALUES(@crtTestRunId, 3, @delete_recenzii_start, @insert_recenzii_end)

	INSERT INTO TestRunViews
	VALUES(@crtTestRunId, 1, @view1_Recenzii_start, @view1_Recenzii_end)
	
	INSERT INTO TestRunViews
	VALUES(@crtTestRunId, 2, @view2_FurnizCafMp_start, @view2_FurnizCafMp_end)

	INSERT INTO TestRunViews
	VALUES(@crtTestRunId, 3, @view3_NrFurnizCaf_start, @view3_NrFurnizCaf_end)

END
GO

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
GO

EXEC mainTest

SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews

SELECT * FROM TestViews
SELECT * FROM TestTables