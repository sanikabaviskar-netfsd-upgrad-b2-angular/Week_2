use ecommdb;

CREATE PROCEDURE sp_GetTotalSalesPerStore
AS
BEGIN
    SELECT 
        StoreID,
        SUM(ISNULL(TotalAmount,0)) AS TotalSales
    FROM Orders
    GROUP BY StoreID
    ORDER BY TotalSales DESC;
END;
...................................................................................................................

EXEC sp_GetTotalSalesPerStore;
...........................................................................

SELECT * 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Orders';
......................................................................................

EXEC sp_GetOrdersByDateRange '2024-01-01', '2024-12-31';
............................................................................................................

CREATE FUNCTION fn_CalculateDiscount
(
    @Price DECIMAL(10,2),
    @DiscountPercent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN

DECLARE @FinalPrice DECIMAL(10,2)

SET @FinalPrice = @Price - (@Price * @DiscountPercent / 100)

RETURN @FinalPrice

END

SELECT dbo.fn_CalculateDiscount(1000,10) AS FinalPrice;

............................................................................................................................

CREATE FUNCTION fn_Top5SellingProducts()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        ProductID,
        COUNT(ProductID) AS TotalSold
    FROM dbo.Orders
    GROUP BY ProductID
    ORDER BY COUNT(ProductID) DESC
);

CREATE TABLE Orders1 (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    OrderDate DATE
);

INSERT INTO Orders1 VALUES (1,101,5,'2024-01-01');
INSERT INTO Orders1 VALUES (2,102,3,'2024-01-02');
INSERT INTO Orders1 VALUES (3,101,2,'2024-01-03');
INSERT INTO Orders1 VALUES (4,103,6,'2024-01-04');
INSERT INTO Orders1 VALUES (5,102,4,'2024-01-05');
INSERT INTO Orders1 VALUES (6,104,8,'2024-01-06');
INSERT INTO Orders1 VALUES (7,101,7,'2024-01-07');

CREATE FUNCTION fn_Top5SellingProducts()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        ProductID,
        SUM(Quantity) AS TotalSold
    FROM Orders1
    GROUP BY ProductID
    ORDER BY SUM(Quantity) DESC
);

SELECT * FROM dbo.fn_Top5SellingProducts();