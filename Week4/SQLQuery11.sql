use demo;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock_quantity INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_status INT
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO products VALUES (1, 'Car Engine', 20);
INSERT INTO products VALUES (2, 'Brake Pad', 50);

INSERT INTO orders VALUES (101, 1);

INSERT INTO order_items VALUES (1, 101, 1, 5);
.............................................................................................................


BEGIN TRY

    BEGIN TRANSACTION;

    DECLARE @order_id INT = 101;

    -- Savepoint before restoring stock
    SAVE TRANSACTION StockRestorePoint;

    -- Restore stock quantities
    UPDATE p
    SET p.stock_quantity = p.stock_quantity + oi.quantity
    FROM products p
    JOIN order_items oi 
        ON p.product_id = oi.product_id
    WHERE oi.order_id = @order_id;

    -- Update order status to Rejected (3)
    UPDATE orders
    SET order_status = 3
    WHERE order_id = @order_id;

    COMMIT TRANSACTION;

    PRINT 'Order cancelled and stock restored successfully';

END TRY

BEGIN CATCH

    PRINT 'Error occurred during cancellation';

    -- Rollback only to savepoint
    ROLLBACK TRANSACTION StockRestorePoint;

    PRINT 'Stock restoration failed. Rolled back to savepoint';

END CATCH;