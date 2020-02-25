CREATE DATABASE Agregation;
USE Agregation;

CREATE TABLE Category(
"name" VARCHAR(50) PRIMARY KEY);

INSERT INTO Category("name")
VALUES
('xxx'),
('yyy'),
('zzz');

CREATE TABLE Product(
"name" VARCHAR(50) PRIMARY KEY,
price DECIMAL(5,2) NOT NULL,
category VARCHAR(50) NOT NULL,
CONSTRAINT FK_CategoryProduct FOREIGN KEY (category)
REFERENCES Category("name")
ON UPDATE CASCADE 
ON DELETE CASCADE);

INSERT INTO Product (price, "name", category)
VALUES
(2.45, 'aaa', 'xxx'),
(10.23, 'bbb', 'xxx'),
(6.41, 'ccc', 'xxx'),
(345.67, 'ddd', 'yyy'),
(34.99, 'eee', 'yyy'),
(0.01, 'fff', 'yyy'),
(245.50, 'ggg', 'zzz'),
(99.99, 'hhh', 'zzz'),
(0.99, 'iii', 'zzz');

CREATE TABLE Purchase(
id INT PRIMARY KEY  IDENTITY (1,1),
"name" VARCHAR(50) NOT NULL,
purchaseDate DATE,
CONSTRAINT FK_ProductPurchase FOREIGN KEY ("name")
REFERENCES Product("name")
ON UPDATE CASCADE
ON DELETE CASCADE);

INSERT INTO Purchase("name", purchaseDate)
VALUES
('aaa','2019-04-05'),
('ccc','2019-01-27'),
('aaa','2019-03-15'),
('ddd','2019-07-01'),
('aaa','2019-09-05'),
('aaa','2019-10-10'),
('eee','2019-11-11'),
('bbb','2019-11-11'),
('aaa','2020-01-01'),
('ddd','2020-02-12'),
('iii','2020-03-23'),
('ggg','2020-05-25'),
('fff','2020-06-16'),
('aaa','2020-07-27'),
('hhh','2020-08-28'),
('ddd','2020-09-29'),
('eee','2020-10-05'),
('fff','2020-11-01'),
('ggg','2020-12-31');

SELECT p.category, COUNT(ps.name) as number_Product, SUM(p.price) AS sum
FROM Purchase AS ps
INNER JOIN Product AS p ON p.name = ps.name
GROUP BY p.category;

SELECT COUNT(ps.name) as number_Product, YEAR(ps.purchaseDate) AS year
FROM Purchase AS ps
INNER JOIN Product AS p ON p.name = ps.name
GROUP BY YEAR(ps.purchaseDate);
