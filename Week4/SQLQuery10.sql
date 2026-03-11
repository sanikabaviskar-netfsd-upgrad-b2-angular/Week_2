create database demo;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock_quantity INT
);
.......................................................................................................................................

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE
);
..................................................................................................................................
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
...........................................................................................................................

BEGIN TRANSACTION;

DECLARE @product_id INT = 1;
DECLARE @qty INT = 5;
DECLARE @stock INT;

SELECT @stock = stock_quantity 
FROM products 
WHERE product_id = @product_id;

IF (@stock >= @qty)
BEGIN
    INSERT INTO orders(order_id, order_date)
    VALUES (101, GETDATE());

    INSERT INTO order_items(order_item_id, order_id, product_id, quantity)
    VALUES (1, 101, @product_id, @qty);

    COMMIT;
    PRINT 'Order placed successfully';
END
ELSE
BEGIN
    ROLLBACK;
    PRINT 'Insufficient stock. Transaction rolled back';
END
........................................................................................................................................

CREATE TRIGGER trg_reduce_stock
ON order_items
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.stock_quantity = p.stock_quantity - i.quantity
    FROM products p
    JOIN inserted i
    ON p.product_id = i.product_id;

    IF EXISTS (SELECT * FROM products WHERE stock_quantity < 0)
    BEGIN
        RAISERROR ('Stock cannot be negative',16,1);
        ROLLBACK TRANSACTION;
    END
END