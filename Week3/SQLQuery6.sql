use Ecommdb;

CREATE VIEW vw_ProductDetails AS
SELECT 
p.ProductName,
b.BrandName,
c.CategoryName,
p.Price AS ListPrice
FROM Produc p
JOIN Brands b
ON p.BrandID = b.BrandID
JOIN Categories c
ON p.CategoryID = c.CategoryID;
..................................................................................................................

SELECT * FROM vw_ProductDetails;
..................................................................................................

CREATE INDEX idx_produc_brandid
ON Produc(BrandID);

......................................................................................................

CREATE INDEX idx_produc_categoryid
ON Produc(CategoryID);

......................................................................................................

SELECT 
p.ProductName,
b.BrandName,
c.CategoryName
FROM Produc p
JOIN Brands b
ON p.BrandID = b.BrandID
JOIN Categories c
ON p.CategoryID = c.CategoryID;