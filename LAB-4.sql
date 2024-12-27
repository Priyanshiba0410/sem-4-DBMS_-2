


--------Part – A ------




---1. Write a function to print "hello world". 
create or ALTER FUNCTION FN_HELLO_WORLD()
RETURNS VARCHAR(20)
AS 
BEGIN
	RETURN 'HELLO WORLD'
END
SELECT dbo.FN_HELLO_WORLD()


---2. Write a function which returns addition of two numbers. 
CREATE OR ALTER FUNCTION FN_ADDITION(
		@NUM1 INT,
		@NUM2 INT
)
RETURNS INT
AS
BEGIN
	RETURN @NUM1+@NUM2
END
SELECT dbo.FN_ADDITION(10,20)
	

---3. Write a function to check whether the given number is ODD or EVEN. 
CREATE OR ALTER FUNCTION FN_ODD_EVEN(
	@NO INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @MSG VARCHAR(50)
	IF @NO%2=0
	SET @MSG='NUMBER IS EVEN'
	ELSE 
	SET @MSG='NUMBER IS ODD'
	RETURN @MSG
END
SELECT dbo.FN_ODD_EVEN(5)

---4. Write a function which returns a table with details of a person whose first name starts with B. 
CREATE OR ALTER FUNCTION FN_FIRSTNAME()
RETURNS TABLE
AS
	RETURN(SELECT * FROM Person WHERE FirstName LIKE 'B%')

SELECT * FROM dbo.FN_FIRSTNAME()
SELECT * FROM Person
	

---5. Write a function which returns a table with unique first names from the person table. 
CREATE OR ALTER FUNCTION FN_PERSON()
RETURNS TABLE
AS
	RETURN(SELECT DISTINCT FirstName FROM Person)
SELECT * FROM dbo.FN_PERSON()
SELECT * FROM Person

---6. Write a function to print number from 1 to N. (Using while loop) 
CREATE OR ALTER FUNCTION FN_1TO_N(@NO INT)
RETURNS VARCHAR(200)
AS
BEGIN
	DECLARE @MSG VARCHAR(20),@COUNT INT
	SET @MSG =' '
	SET @COUNT =1
	WHILE(@COUNT<=@NO)
	BEGIN
	SET @MSG = @MSG+''+CAST(@COUNT AS VARCHAR(20))
	SET @COUNT=@COUNT +1
	END
	RETURN @MSG
END
SELECT dbo.FN_1TO_N(10)


---7. Write a function to find the factorial of a given integer. 
CREATE OR ALTER FUNCTION FN_FACTORIAL(@NO INT)
RETURNS INT
AS
BEGIN
	DECLARE @FAC INT
	SET @FAC=1
	WHILE(@NO>1)
	BEGIN
	SET @FAC = @FAC*@NO
	SET @NO=@NO-1
	END
	RETURN @FAC
END
SELECT dbo.FN_FACTORIAL(5)


----------Part – B-------



---8. Write a function to compare two integers and return the comparison result. (Using Case statement) 
CREATE OR ALTER FUNCTION FN_COMPARISON(
		@N1 INT,
		@N2 INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @MSG VARCHAR(100)
	SET @MSG=CASE
				wheN (@N1=@N2) THEN 'BOATH ARE SAME'
				wheN (@N1>@N2) THEN 'N1 IS MAX'
				wheN (@N1<@N2) THEN 'N2 IS MAX'
				ELSE 'INVALID NUMBER'
				END
	RETURN @MSG
END
SELECT dbo.FN_COMPARISON(10,10)


---9. Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_SUM_OF_ODD_OR_EVEN()
RETURNS INT
AS
BEGIN
	DECLARE @SUM INT,@I INT
	SET @SUM=0
	SET @I=1
	WHILE (@I<=20)
	BEGIN
		IF(@I%2=0)
			SET @SUM=@SUM+@I
		SET @I=@I+1
	END
	RETURN @SUM
END

SELECT dbo.FN_SUM_OF_ODD_OR_EVEN()



---10. Write a function that checks if a given string is a palindrome 
CREATE OR ALTER FUNCTION FN_PALINDROM_CHECK(
		@NO INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @TEMP INT,@REVERSE INT
	SET @REVERSE=0
	SET @TEMP=@NO
	WHILE @TEMP>0
	BEGIN
		SET @REVERSE=@REVERSE*10+@TEMP%10
		SET @TEMP=@TEMP/10
	END
	IF(@NO=@REVERSE)
		RETURN 'GIVEN NUMBER IS PALINDROM'
	ELSE
		RETURN 'GIVEN NUMBER IS NOT PALINDROM'
	RETURN 'NOT VALID'
END

SELECT dbo.FN_PALINDROM_CHECK(121)



------Part – C --------------


---11. Write a function to check whether a given number is prime or not. 
CREATE OR ALTER FUNCTION FN_PRIME_CHECK(
		@NO INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @MSG VARCHAR(50),@COUNT INT
	SET @COUNT=1
	IF @NO%2=0
		SET @COUNT=@COUNT+1
	ELSE IF @COUNT>2
		SET @MSG='NUMBER IS NOT PRIME'
	ELSE
		SET @MSG='NUMBER IS PRIME'
RETURN @MSG
END

SELECT dbo.FN_PRIME_CHECK(5)

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days. 

CREATE OR ALTER FUNCTION FN_DATE_DIFF(
	@STARTDATE VARCHAR(20),
	@ENDDATE VARCHAR(20) 
)
RETURNS VARCHAR(50)
AS
BEGIN
	RETURN DATEDIFF(DAY,@STARTDATE,@ENDDATE)
END

SELECT dbo.FN_DATE_DIFF(12-01-1995,13-02-2000)

--13. Write a function which accepts two parameters year & month in integer and returns total days each year.

CREATE or alter FUNCTION FN_TotalDaysInMonth (
				@Year INT, 
				@Month INT
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalDays INT;
    SET @TotalDays = DAY(EOMONTH(CONCAT(@Year, '-', @Month, '-01')));
    RETURN @TotalDays;
END;

select dbo.FN_TotalDaysInMonth(2024,12)

--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons. 

CREATE or alter FUNCTION FN_getPerson (
				@DEPARTMENTID INT
)
RETURNS TABLE
AS

    RETURN (SELECT * FROM Person where DEPARTMENTID=@DEPARTMENTID)

SELECT * from dbo.FN_getPerson(12)

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991. 

CREATE or alter FUNCTION FN_getPerson ()
RETURNS TABLE
AS

    RETURN (SELECT * FROM Person where JoiningDate>'1991-01-01')

SELECT * from dbo.FN_getPerson(1991-01-01)