CREATE DATABASE Jointure;
USE Jointure;

CREATE TABLE Continent(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL);

INSERT INTO Continent("name")
VALUES
('EuroAsia'),
('Africa'),
('Australia');

CREATE TABLE Terrien(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL,
continent_id INT NOT NULL,
CONSTRAINT FK_Continent FOREIGN KEY (continent_id)
REFERENCES Continent (id)
ON UPDATE CASCADE 
ON DELETE CASCADE);

INSERT INTO Terrien ("name", continent_id)
VALUES
('x001', 1),
('azer', 2),
('con', 3);

CREATE TABLE MartBoss(
id INT PRIMARY KEY IDENTITY(1,1),
king VARCHAR(50) NOT NULL,
base VARCHAR(50) NOT NULL);

INSERT INTO MartBoss( king, base)
VALUES
('MA', 'XX1'),
('MA', 'TT45'),
('MA', 'LI3');

CREATE TABLE Martien(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL,
base_id INT NOT NULL,
terrien_id INT NOT NULL,
boss_id INT NOT NULL,
CONSTRAINT FK_TerrienMartien FOREIGN KEY(terrien_id)
REFERENCES Terrien(id),
CONSTRAINT FK_MartBossMartien FOREIGN KEY (base_id)
REFERENCES MartBoss(id)
ON UPDATE CASCADE 
ON DELETE CASCADE);

INSERT INTO Martien ("name", terrien_id, base_id, boss_id)
VALUES
('aha', 1, 1, 2),
('bob', 2, 1, 1),
('sas', 3, 3, 2),
('puta', 3, 2, 1),
('sos', 2, 1, 3),
('aqe', 1, 2, 2),
('ger', 3, 3, 1),
('rez', 2, 2, 2),
('koi', 1, 2,1),
('mu', 2, 3, 4),
('li', 3, 3, 5),
('wo', 2, 1, 3),
('hui', 1, 2, 4),
('frant', 1, 3, 4);


SELECT m.name AS Martien, t.name AS Terrien, c.name AS Continent, mb.name AS Base
FROM Martien AS m
INNER JOIN Terrien AS t ON m.terrien_id = t.id
INNER JOIN Continent AS c ON t.continent_id = c.id
INNER JOIN MartBoss AS mb ON m.base_id = mb.id;
