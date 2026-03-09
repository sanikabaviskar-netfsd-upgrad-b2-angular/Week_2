use Ecommdb;

CREATE TABLE orders2 (
    order_id INT PRIMARY KEY,
    store_id INT,
    order_status INT,
    shipped_date DATE
);

.........................................................................................................

CREATE TRIGGER trg_CheckOrderStatus
ON orders2
AFTER UPDATE
AS
BEGIN
BEGIN TRY

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE order_status = 4 AND shipped_date IS NULL
    )
    BEGIN
        RAISERROR('Shipped date cannot be NULL when order status is Completed.',16,1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH

END;

........................................................................................................

UPDATE orders2
SET order_status = 4,
    shipped_date = '2024-02-10'
WHERE order_id = 1;

.......................................................................................