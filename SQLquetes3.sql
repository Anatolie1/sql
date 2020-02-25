CREATE DATABASE Stock;
USE Stock;


CREATE TABLE Category(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50));

INSERT INTO Category("name")
VALUES
('xxx'),
('yyy'),
('zzz');

CREATE TABLE Product(
id INT PRIMARY KEY IDENTITY(1,1),
"name" VARCHAR(50) NOT NULL,
price DECIMAL(5,2) NOT NULL,
FK_CategoryID INT FOREIGN KEY REFERENCES Category(id)
ON UPDATE CASCADE 
ON DELETE CASCADE);

INSERT INTO Product(price, "name", FK_CategoryID)
VALUES
(2.45, 'aaa', 1),
(10.23, 'bbb', 2),
(6.41, 'ccc', 3),
(345.67, 'ddd', 2),
(34.99, 'eee', 3),
(0.01, 'fff', 1),
(245.50, 'ggg', 3),
(99.99, 'hhh', 1),
(0.99, 'iii', 2);

CREATE TABLE Purchase(
id INT PRIMARY KEY  IDENTITY (1,1),
purchaseDate DATE,
FK_ProductID INT FOREIGN KEY REFERENCES Product(id)
ON UPDATE CASCADE
ON DELETE CASCADE);

INSERT INTO Purchase(FK_ProductID, purchaseDate)
VALUES
(1,'2019-04-05'),
(2,'2019-01-27'),
(3,'2019-03-15'),
(4,'2019-07-01'),
(5,'2019-09-05'),
(6,'2019-10-10'),
(7,'2019-11-11'),
(8,'2019-11-11'),
(9,'2020-01-01'),
(8,'2020-02-12'),
(7,'2020-03-23'),
(5,'2020-05-25'),
(6,'2020-06-16'),
(4,'2020-07-27'),
(3,'2020-08-28'),
(2,'2020-09-29'),
(1,'2020-10-05'),
(6,'2020-11-01'),
(9,'2020-12-31');

CREATE TABLE Stock(
id INT PRIMARY KEY IDENTITY(1,1),
"amount" INT,
FK_ProductID INT FOREIGN KEY REFERENCES Product(id)
ON UPDATE CASCADE
ON DELETE CASCADE);

INSERT INTO Stock(FK_ProductID, "amount")
VALUES
(1, 0),
(2, 10),
(3, 3),
(4, 1),
(5, 0),
(6, 4),
(7, 5),
(8, 10),
(9, 2);

SELECT Category.name, SUM(Stock.amount) AS Number FROM Stock
INNER JOIN Product ON Stock.FK_ProductID = Product.id
INNER JOIN Category ON Product.FK_CategoryID = Category.id
GROUP BY Category.name;









