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
('con', 3),
('er2', 1),
('azor', 2),
('coner', 3),
('suser', 1),
('worlo', 2),
('cio', 3),
('baise', 2);

CREATE TABLE MartBoss(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL,
king VARCHAR(50) NOT NULL,
base VARCHAR(50) NOT NULL);

INSERT INTO MartBoss("name", king, base)
VALUES
('mars1', 'MA', 'XX1'),
('mars2', 'MA', 'TT45'),
('mars3', 'MA', 'LI3');

CREATE TABLE Martien(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL,
base_id INT NOT NULL,
terrien_id INT NOT NULL,
CONSTRAINT FK_TerrienMartien FOREIGN KEY(terrien_id)
REFERENCES Terrien(id),
CONSTRAINT FK_MartBossMartien FOREIGN KEY (base_id)
REFERENCES MartBoss(id)
ON UPDATE CASCADE 
ON DELETE CASCADE);

INSERT INTO Martien ("name", terrien_id, base_id)
VALUES
('aha', 1, 1),
('bob', 2, 1),
('sas', 3, 3),
('puta', 4, 2),
('sos', 5, 1),
('aqe', 6, 2),
('ger', 7, 3),
('rez', 8, 2),
('koi', 9, 2),
('mu', 10, 3);

SELECT m.name AS Martien, t.name AS Terrien, c.name AS Continent, mb.name AS Base
FROM Martien AS m
INNER JOIN Terrien AS t ON m.terrien_id = t.id
INNER JOIN Continent AS c ON t.continent_id = c.id
INNER JOIN MartBoss AS mb ON m.base_id = mb.id;
