IF DB_ID('PandemyAlert') IS NOT NULL
 DROP DATABASE PandemyAlert
GO
CREATE DATABASE PandemyAlert
GO

USE PandemyAlert

CREATE TABLE Country(country_id INT PRIMARY KEY IDENTITY(1,1),
                     name VARCHAR(60) NOT NULL)
CREATE TABLE City(city_id INT PRIMARY KEY IDENTITY(1,1), 
                  name VARCHAR(60) NOT NULL, 
                  FK_country_id INT NOT NULL, 
                  FOREIGN KEY (FK_country_id) REFERENCES Country(country_id))
CREATE TABLE Person(person_id INT PRIMARY KEY IDENTITY(1,1), 
                    name VARCHAR(60),
                    is_infected BIT NOT NULL,
                    FK_city_id INT NOT NULL,
                    FOREIGN KEY (FK_city_id) REFERENCES City(city_id))
CREATE TABLE Pharmaceutical(pharmaceutical_id INT PRIMARY KEY IDENTITY(1,1), 
                            disease VARCHAR(60) NOT NULL, 
                            count INT NOT NULL)

INSERT INTO Country (name) VALUES ('France'),
                                  ('Allemagne'),
                                  ('Italie'),
                                  ('Etats-Unis'),
                                  ('Chine'),
                                  ('Russie')
INSERT INTO City(name, FK_Country_id) VALUES ('Paris', 1),('Strasbourg',1),
                                             ('Berlin', 2),('Cologne', 2),
                                             ('Rome', 3),('Florence', 3),
                                             ('Washington', 4),('New York', 4),
                                             ('Pékin', 5),('Shangaï', 5),
                                             ('St-Pétersbourg', 6),('Moscou', 6)
INSERT INTO Pharmaceutical(disease, count) VALUES ('Triméthylaminurie', 50);
GO
DECLARE @number_persons INT = 0
DECLARE @name_suffix INT = 0
DECLARE @FK_city_id INT = 1

WHILE (@number_persons <= 10 )
BEGIN
	DECLARE @name VARCHAR(60) = 'john' + CONVERT(VARCHAR, @name_suffix)
	INSERT INTO Person ("name", is_infected, FK_city_id) VALUES (@name, @number_persons % 2,  @FK_city_id)
	
	SET @name_suffix = @name_suffix + 1 
	SET @number_persons = (SELECT COUNT(person_id) FROM Person WHERE FK_city_id = @FK_city_id)


	IF (@number_persons = 10 AND @FK_city_id < 12 )
		SET @FK_city_id = @FK_city_id + 1
END

GO
DECLARE @mean_inf_country INT
SELECT @mean_inf_country = COUNT(is_infected)/(SELECT COUNT(Country.country_id) FROM Country) FROM Person
WHERE is_infected = 1

DECLARE @country_id INT

DECLARE @Country_Cursor as CURSOR;
	SET @Country_Cursor = CURSOR FOR
SELECT country_id FROM Country;
OPEN @Country_Cursor
FETCH NEXT FROM @Country_Cursor INTO @country_id
WHILE @@FETCH_STATUS = 0
	BEGIN
	DECLARE @inf_country INT
	SET @inf_country = (SELECT COUNT(*) FROM Person
						INNER JOIN City ON Person.FK_city_id = City.city_id
						INNER JOIN Country ON City.FK_country_id = Country.country_id
						WHERE is_infected = 1 AND country_id = @country_id
						GROUP BY Country.country_id)

	IF (@inf_country = @mean_inf_country)
		BEGIN
		SELECT City.name, COUNT(is_infected) FROM Person
		INNER JOIN City ON Person.FK_city_id = City.city_id
		INNER JOIN Country ON City.FK_country_id = Country.country_id
		WHERE is_infected = 1 AND country_id = @country_id
		GROUP BY City.name
		END   
   FETCH NEXT FROM @Country_Cursor INTO @country_id
   END
CLOSE @Country_Cursor
DEALLOCATE @Country_Cursor

