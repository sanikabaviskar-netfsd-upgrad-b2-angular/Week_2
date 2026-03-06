use Ecommdb;

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

CREATE TABLE Brands (
BrandID INT PRIMARY KEY,
BrandName VARCHAR(50)
);

CREATE TABLE Store (
StoreID INT PRIMARY KEY,
StoreName VARCHAR(50),
City VARCHAR(50)
);

CREATE TABLE Produc (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
BrandID INT,
CategoryID INT,
Price DECIMAL(10,2),

FOREIGN KEY (BrandID) REFERENCES Brands(BrandID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Custome (
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(100),
City VARCHAR(50),
Phone VARCHAR(15)
);

INSERT INTO Produc VALUES
(1,'Toyota Corolla',1,1,20000),
(2,'Honda Civic',2,1,22000),
(3,'BMW X5',3,1,60000),
(4,'Tesla Model S',4,4,80000),
(5,'Ford Ranger',5,3,35000);


INSERT INTO Custome VALUES
(1,'Rahul Sharma','Mumbai','9876543210'),
(2,'Sneha Patil','Pune','9876543211'),
(3,'Kunal Verma','Nagpur','9876543212'),
(4,'Anita Joshi','Mumbai','9876543213'),
(5,'Rohit Singh','Delhi','9876543214');

INSERT INTO Categories VALUES
(1,'Cars'),
(2,'Bikes'),
(3,'Trucks'),
(4,'Electric Vehicles'),
(5,'Accessories');

INSERT INTO Brands VALUES
(1,'Toyota'),
(2,'Honda'),
(3,'BMW'),
(4,'Tesla'),
(5,'Ford');

INSERT INTO Store VALUES
(1,'AutoHub','Mumbai'),
(2,'CarPoint','Pune'),
(3,'DriveWorld','Nagpur'),
(4,'AutoZone','Delhi'),
(5,'SpeedMotors','Bangalore');


SELECT 
p.ProductName,
b.BrandName,
c.CategoryName
FROM Produc p
INNER JOIN Brands b 
ON p.BrandID = b.BrandID
INNER JOIN Categories c 
ON p.CategoryID = c.CategoryID;

................................................................................

SELECT *
FROM Custome
WHERE City = 'Nagpur';

////////////////////////////////////////////////////////////////////////////////////////////

SELECT 
c.CategoryName,
COUNT(p.ProductID) AS TotalProduct
FROM Categories c
LEFT JOIN Produc p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;