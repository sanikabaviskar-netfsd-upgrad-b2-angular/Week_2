use Ecommdb;

CREATE TABLE stocks1 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT
);
............................................................................................................

INSERT INTO stocks1 VALUES (101,'Laptop',50);
INSERT INTO stocks1 VALUES (102,'Mouse',100);
INSERT INTO stocks1 VALUES (103,'Keyboard',80);
....................................................................................................................

CREATE TABLE order_items1 (
    order_item_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

CREATE TRIGGER trg_UpdateStock
ON order_items
AFTER INSERT
AS
BEGIN
BEGIN TRY

    -- Check if stock is enough
    IF EXISTS (
        SELECT 1
        FROM stocks s
        JOIN inserted i ON s.product_id = i.product_id
        WHERE s.quantity < i.quantity
    )
    BEGIN
        RAISERROR('Stock is insufficient for this product.',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Reduce stock
    UPDATE s
    SET s.quantity = s.quantity - i.quantity
    FROM stocks s
    JOIN inserted i ON s.product_id = i.product_id;

END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH

END;

.................................................................................................................

INSERT INTO order_items1 VALUES (1,101,5);

....................................................................................................................

INSERT INTO order_items1 VALUES (2,101,100);

...........................................................................