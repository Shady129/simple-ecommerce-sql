-- =========================
-- Tables
-- =========================



CREATE TABLE Users
(
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE
)


CREATE TABLE Products
(
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);


CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    OrderDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Orders_Users
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE OrderItems
(
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,

    CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



-- =========================
-- Seed Data
-- =========================


INSERT INTO Users (Name, Email)
VALUES 
('Ahmed', 'ahmed@gmail.com'),
('Sara', 'sara@gmail.com');


-- Products
INSERT INTO Products (Name, Price, Stock)
VALUES 
('Laptop', 15000, 10),
('Phone', 8000, 20),
('Headphones', 500, 50);


-- Orders
INSERT INTO Orders (UserID)
VALUES (1), (2);


-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1);


-- =========================
-- Products Procedures
-- =========================



-- =========================
--SP: Get All Products
-- =========================


CREATE PROCEDURE GetAllProducts
AS

BEGIN 

SELECT * FROM Products

END;

EXEC GetAllProducts;


-- =========================
--SP: Get Products By Price
-- =========================


CREATE PROCEDURE GetProductsByPrice

  @MinPrice DECIMAL(10,2)
AS
BEGIN 
    SELECT * FROM Products
    WHERE Price > @MinPrice
END;


EXEC GetProductsByPrice @MinPrice = 1000;

-- =========================
--SP: Update Product
-- =========================


CREATE PROCEDURE UpdateProduct
    @ProductID INT,
    @Name NVARCHAR(100),
    @Price DECIMAL(10,2),
    @Stock INT
AS
BEGIN

UPDATE Products
SET 
        Name = @Name,
        Price = @Price,
        Stock = @Stock 

WHERE   ProductID = @ProductID
END;



EXEC UpdateProduct 
    @ProductID = 1,
    @Name = 'Laptop Pro',
    @Price = 20000,
    @Stock = 5;



-- =========================
--SP: Delete Product
-- =========================


CREATE PROCEDURE  DeleteProduct

@ProductID INT 

AS
BEGIN 
    DELETE FROM OrderItems
    WHERE ProductID = @ProductID;

    DELETE FROM Products
    WHERE ProductID = @ProductID;
END;



EXEC  DeleteProduct 

    @ProductID = 1;



-- =========================
-- Orders Procedures
-- =========================


-- =========================
-- SP: Get Order Details
-- =========================


CREATE PROCEDURE GetOrderDetails

    @OrderID INT
AS
BEGIN 

SELECT  o.OrderID,
        u.Name AS CustomerName,
        p.Name AS ProductName,
        p.Price,
        oi.Quantity,
        (p.Price * oi.Quantity) AS TotalPrice
FROM OrderItems oi
JOIN Orders o ON oi.OrderID = o.OrderID 
JOIN Users u ON o.UserID = u.UserID
JOIN  Products p ON oi.ProductID = p.ProductID
WHERE o.OrderID = @OrderID
END;



EXEC GetOrderDetails @OrderID = 1;


-- =========================
--SP: Get Order Total
-- =========================


ALTER PROCEDURE GetOrderTotal


    @OrderID INT
AS
BEGIN 

IF NOT EXISTS(SELECT 1 FROM Orders WHERE OrderID = @OrderID)


BEGIN

    PRINT 'Order Not Found';
    RETURN
END

SELECT  o.OrderID,
        u.Name AS CustomerName,
        SUM(p.Price * oi.Quantity) AS TotalPrice
FROM OrderItems oi
JOIN Orders o ON oi.OrderID = o.OrderID 
JOIN Users u ON o.UserID = u.UserID
JOIN  Products p ON oi.ProductID = p.ProductID
WHERE o.OrderID = @OrderID
GROUP BY o.OrderID, u.Name
END;


EXEC GetOrderTotal @OrderID = 100;




-- =========================
--SP: Check Order Status
-- =========================


CREATE PROCEDURE CheckOrderItemStatus


    @OrderID INT
AS
BEGIN 

IF NOT EXISTS(SELECT 1 FROM OrderItems WHERE OrderID = @OrderID)


BEGIN

    PRINT 'Order Has No item';
    RETURN
END

SELECT  o.OrderID,
        u.Name AS CustomerName,
        SUM(p.Price * oi.Quantity) AS TotalPrice
FROM OrderItems oi
JOIN Orders o ON oi.OrderID = o.OrderID 
JOIN Users u ON o.UserID = u.UserID
JOIN  Products p ON oi.ProductID = p.ProductID
WHERE o.OrderID = @OrderID
GROUP BY o.OrderID, u.Name
END;


EXEC CheckOrderItemStatus @OrderID  = 1;



-- =========================
-- SP: Create Order
-- =========================
-- Check Product Exists
-- Create Order
-- Get New Order ID
-- Insert Order Item
-- Return ID


ALTER PROCEDURE CreateOrder

    @UserID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN 
IF NOT EXISTS(SELECT 1 FROM Products WHERE ProductID = @ProductID)
BEGIN
    PRINT 'Product Not Found';
    RETURN;
END
    INSERT INTO Orders(UserID)
    VALUES (@UserID);

    DECLARE @NewOrderID INT;
    SET @NewOrderID = SCOPE_IDENTITY();


    INSERT INTO OrderItems (OrderID, ProductID, Quantity)
    VALUES (@NewOrderID, @ProductID, @Quantity);

    
SELECT @NewOrderID AS NewOrderID

END;


EXEC CreateOrder 
    @UserID = 1,
    @ProductID = 2,
    @Quantity = 3;




-- =========================
--SP: Get Orders By User
-- =========================


CREATE PROCEDURE GetOrdersByUser
    @UserID INT
AS
BEGIN

    SELECT *
    FROM Orders
    WHERE UserID = @UserID;

END;


EXEC GetOrdersByUser 1;