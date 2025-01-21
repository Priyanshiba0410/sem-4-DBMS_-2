
CREATE TABLE PRODUCT(
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(250),
	PRICE DECIMAL(10,2),
);

INSERT INTO PRODUCT (PRODUCT_ID,PRODUCT_NAME,PRICE) VALUES
(1,'SMATPHONE',35000),
(2,'LAPTOP',65000),
(3,'HEADPHONES',5500),
(4,'TELEVISION',85000),
(5,'GAMING CONSOLE',32000);

SELECT * FROM PRODUCT
	

-------------------------------------------------Part - A-------------------------------------------------------


--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

DECLARE @ID INT,@NAME VARCHAR(250),@PRICE DECIMAL(10,2);

DECLARE Product_Cursor CURSOR 
FOR
	SELECT * FROM PRODUCT;
OPEN Product_Cursor;
FETCH NEXT FROM Product_Cursor
INTO @ID,@NAME,@PRICE;
WHILE @@FETCH_STATUS=0
BEGIN
	SELECT @ID,@NAME,@PRICE
	FETCH NEXT FROM Product_Cursor
	INTO @ID,@NAME,@PRICE
END
CLOSE Product_Cursor;
DEALLOCATE Product_Cursor;


--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName. (Example: 1_Smartphone)

DECLARE @ProductID INT,@ProductName VARCHAR(250),@ProductID_ProductName VARCHAR(250);

DECLARE Product_Cursor_Fetch CURSOR 
FOR
	SELECT CAST(PRODUCT_ID AS VARCHAR) + '_' + PRODUCT_NAME
	FROM PRODUCT;

OPEN Product_Cursor_Fetch;

FETCH NEXT FROM Product_Cursor_Fetch INTO @ProductID_ProductName;

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH NEXT FROM Product_Cursor_Fetch INTO @ProductID_ProductName;
END
CLOSE Product_Cursor_Fetch;
DEALLOCATE Product_Cursor_Fetch;


--3. Create a Cursor to Find and Display Products Above Price 30,000.

DECLARE @Product_ID INT, @Product_Name VARCHAR(250), @_Price DECIMAL(10,2);

DECLARE Product_Cursor_Above30000 CURSOR FOR
	SELECT PRODUCT_ID, PRODUCT_NAME, PRICE
	FROM PRODUCT
	WHERE Price > 30000;

OPEN Product_Cursor_Above30000;

FETCH NEXT FROM Product_Cursor_Above30000 
INTO @Product_ID, @Product_Name, @_Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'PRODUCT_ID: ' + CAST(@Product_ID AS VARCHAR) + ', PRODUCT_NAME: ' + @Product_Name + ', PRICE: ' + CAST(@_Price AS VARCHAR);

    FETCH NEXT FROM Product_Cursor_Above30000 INTO @Product_ID, @Product_Name, @_Price;
END

CLOSE Product_Cursor_Above30000;
DEALLOCATE Product_Cursor_Above30000;

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table. 

DECLARE Product_CursorDelete CURSOR FOR
SELECT * FROM PRODUCT;

OPEN Product_CursorDelete;

FETCH NEXT FROM Product_CursorDelete;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM PRODUCT WHERE CURRENT OF Product_CursorDelete;
    FETCH NEXT FROM Product_CursorDelete;
END

CLOSE Product_CursorDelete;
DEALLOCATE Product_CursorDelete;


-------------------------------------------------Part – B------------------------------------------------------- 
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%. 

DECLARE @P_ID INT,@P_PRICE DECIMAL(10,2);

DECLARE Product_CursorUpdate CURSOR FOR
	SELECT PRODUCT_ID, PRICE FROM PRODUCT;

OPEN Product_CursorUpdate;

FETCH NEXT FROM Product_CursorUpdate INTO @P_ID, @P_Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE PRODUCT
    SET PRICE = @P_Price * 1.10
    WHERE PRODUCT_ID = @P_ID;

    FETCH NEXT FROM Product_CursorUpdate INTO @P_ID, @P_Price;
END

CLOSE Product_CursorUpdate;
DEALLOCATE Product_CursorUpdate;


--6. Create a Cursor to Rounds the price of each product to the nearest whole number. 

DECLARE @Prod_ID INT;
DECLARE @Prod_Price DECIMAL(10, 2);

DECLARE Product_CursorRound CURSOR FOR
SELECT PRODUCT_ID, PRICE FROM PRODUCT;

OPEN Product_CursorRound;

FETCH NEXT FROM Product_CursorRound INTO @Prod_ID,@Prod_Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE PRODUCT
    SET PRICE = ROUND(@Prod_Price, 0)
    WHERE PRODUCT_ID = @Prod_ID;

    FETCH NEXT FROM Product_CursorRound INTO @Prod_ID, @Prod_Price;
END

CLOSE Product_CursorRound;
DEALLOCATE Product_CursorRound;


-------------------------------------------------Part – C------------------------------------------------------- 
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” (Note: Create NewProducts table first with same fields as Products table) 

CREATE TABLE NEWPRODUCT(
	PRODUCT_ID INT,
	NEWPRODUCT_NAME VARCHAR(250),
	PRICE DECIMAL(10,2),
);

DECLARE @PRODUCT_ID INT;
DECLARE @NEWPRODUCT_NAME VARCHAR(250);
DECLARE @PRICE DECIMAL(10,2);

DECLARE PRODUCT_CURSORNAME CURSOR FOR
	SELECT  PRODUCT_ID,PRODUCT_NAME,PRICE FROM PRODUCT WHERE PRODUCT_NAME='Laptop';

OPEN PRODUCT_CURSORNAME;

FETCH NEXT FROM PRODUCT_CURSORNAME INTO @PRODUCT_ID, @NEWPRODUCT_NAME, @PRICE;

WHILE @@FETCH_STATUS=0
BEGIN

		INSERT INTO NEWPRODUCT VALUES( @PRODUCT_ID, @NEWPRODUCT_NAME, @PRICE);

	FETCH NEXT FROM PRODUCT_CURSORNAME
	INTO  @PRODUCT_ID, @NEWPRODUCT_NAME, @PRICE;
END

CLOSE PRODUCT_CURSORNAME;

DEALLOCATE PRODUCT_CURSORNAME;

SELECT * FROM NEWPRODUCT


--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products with a price above 50000 to an archive table, removing them from the original Products table.
CREATE TABLE ARCHIVEDPRODUCTS(
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(250),
	PRICE DECIMAL(10,2),
);

DECLARE @PRODUCT_ID INT;
DECLARE @PRODUCT_NAME VARCHAR(250);
DECLARE @PRICE DECIMAL(10,2);

DECLARE PRODUCT_CURSORPRICE CURSOR FOR
	SELECT  PRODUCT_ID,PRODUCT_NAME,PRICE FROM PRODUCT WHERE PRICE>50000;

OPEN PRODUCT_CURSORPRICE;

FETCH NEXT FROM PRODUCT_CURSORPRICE INTO @PRODUCT_ID, @PRODUCT_NAME, @PRICE;

WHILE @@FETCH_STATUS=0
BEGIN

	INSERT INTO ARCHIVEDPRODUCTS VALUES( @PRODUCT_ID, @PRODUCT_NAME, @PRICE);
	DELETE FROM PRODUCT WHERE PRODUCT_ID=@Product_ID;
	FETCH NEXT FROM PRODUCT_CURSORPRICE
	INTO  @PRODUCT_ID, @PRODUCT_NAME, @PRICE;
END

CLOSE PRODUCT_CURSORPRICE;

DEALLOCATE PRODUCT_CURSORPRICE;

SELECT * FROM PRODUCT
SELECT * FROM ARCHIVEDPRODUCTS