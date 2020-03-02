DROP DATABASE IF EXISTS SectTracking
GO
CREATE DATABASE SectTracking
GO

USE SectTracking

CREATE TABLE Address(address_id INT PRIMARY KEY IDENTITY(1,1),
                     street_number INT,
                     street_name VARCHAR(120) NOT NULL)
CREATE TABLE Sect(sect_id INT PRIMARY KEY IDENTITY(1,1),
                  name VARCHAR(60) NOT NULL)
CREATE TABLE Adherent(adherent_id INT PRIMARY KEY IDENTITY(1,1),
                      name VARCHAR(60))
CREATE TABLE SectAdherent(sect_adherent_id INT PRIMARY KEY IDENTITY(1,1),
                          FK_adherent_id INT NOT NULL,
                          FOREIGN KEY (FK_adherent_id) REFERENCES Adherent(adherent_id),
                          FK_sect_id INT NOT NULL,
                          FOREIGN KEY (FK_sect_id) REFERENCES Sect(sect_id))
GO

INSERT INTO Sect(name) VALUES ('Le Concombre Sacré'), ('Tomatologie'), ('Les abricots volant')
GO

DECLARE Sect_Cursor CURSOR SCROLL FOR
   SELECT sect_id FROM Sect
DECLARE @LastAdherentId INT
DECLARE @SectId INT
WHILE (SELECT COUNT(*) FROM SectAdherent) < 30
   BEGIN
      OPEN Sect_Cursor
      FETCH FIRST FROM Sect_Cursor INTO @SectId
      WHILE @@FETCH_STATUS = 0
         BEGIN
            INSERT INTO Adherent(name) VALUES(NULL)
            SET @LastAdherentId = (SELECT TOP(1) adherent_id FROM Adherent ORDER BY adherent_id DESC)
            INSERT INTO SectAdherent(FK_adherent_id, FK_sect_id) VALUES (@LastAdherentId, @SectId)
            FETCH NEXT FROM Sect_Cursor INTO @SectId
         END
      CLOSE Sect_Cursor
   END
DEALLOCATE Sect_Cursor
GO

DROP PROCEDURE IF EXISTS uspNrAdherentSect
GO
CREATE PROCEDURE uspNrAdherentSect
@Sect_name VARCHAR(60)
AS
BEGIN
	SELECT
		@Sect_name AS 'sectname',
		COUNT(*) AS 'number'
	FROM
		SectAdherent
	INNER JOIN Sect ON SectAdherent.FK_sect_id = Sect.sect_id
	WHERE
		Sect.name = @Sect_name
END

GO
DECLARE @NrAdherentSect INT
EXECUTE @NrAdherentSect = uspNrAdherentSect 'Le Concombre Sacré'
PRINT @NrAdherentSect
GO

DROP PROCEDURE IF EXISTS uspEachAdherentSect
GO
CREATE PROCEDURE uspEachAdherentSect
AS
BEGIN
	DECLARE @adherent_id INT

	DECLARE @Aderent_id_Cursor AS CURSOR
		SET @Aderent_id_Cursor = CURSOR FOR		
	SELECT adherent_id FROM Adherent
	OPEN @Aderent_id_Cursor
	FETCH NEXT FROM @Aderent_id_Cursor INTO @adherent_id

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @SectName VARCHAR(60) = (SELECT Sect.name FROM SectAdherent
										INNER JOIN Sect ON SectAdherent.FK_sect_id = Sect.sect_id
										INNER JOIN Adherent ON SectAdherent.FK_adherent_id = Adherent.adherent_id
										WHERE Adherent.adherent_id = @adherent_id)

		SELECT Adherent.adherent_id, Sect.name FROM SectAdherent
		INNER JOIN Sect ON SectAdherent.FK_sect_id = Sect.sect_id
		INNER JOIN Adherent ON SectAdherent.FK_adherent_id = Adherent.adherent_id
		WHERE Adherent.adherent_id = @adherent_id
		FETCH NEXT FROM @Aderent_id_Cursor INTO @adherent_id
   END
	CLOSE @Aderent_id_Cursor
	DEALLOCATE @Aderent_id_Cursor
END

GO
DECLARE @AdherentSect INT
EXECUTE @AdherentSect = uspEachAdherentSect
PRINT @AdherentSect
GO

DROP PROCEDURE IF EXISTS uspNrSect
GO
CREATE PROCEDURE uspNrSect
@NrSects INT OUTPUT
AS
BEGIN
	SELECT
		@NrSects = COUNT(*)
	FROM
		Sect
END

GO
DECLARE @NrSect INT
	EXECUTE uspNrSect
	@NrSects = @NrSect OUTPUT
PRINT @NrSect
GO