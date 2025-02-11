
-- Creating PersonInfo Table --

CREATE TABLE PersonInfo ( 
PersonID INT PRIMARY KEY, 
PersonName VARCHAR(100) NOT NULL, 
Salary DECIMAL(8,2) NOT NULL, 
JoiningDate DATETIME NULL, 
City VARCHAR(100) NOT NULL, 
Age INT NULL, 
BirthDate DATETIME NOT NULL 
);

select * from PersonInfo
  drop table PersonLog
 drop table PersonInfo
---- Creating PersonLog Table --

CREATE TABLE PersonLog ( 
PLogID INT PRIMARY KEY IDENTITY(1,1), 
PersonID INT NOT NULL, 
PersonName VARCHAR(250) NOT NULL, 
Operation VARCHAR(50) NOT NULL, 
UpdateDate DATETIME NOT NULL
);
 select * from PersonLog

 ---1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display a message “Record is Affected.”  
CREATE TRIGGER TR_INSERT
ON PersonInfo
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	PRINT 'RECORD IS AFFECTED'
END;

-------------INSERT-----------
INSERT INTO PersonInfo VALUES(1,'PIYU',5000,'2021-04-10','RAJKOT',20,'2005-10-04')

----------------UPDATE------
UPDATE PersonInfo
SET PersonName ='PIHUU'
WHERE PersonID=2


---------------DELETE---------
DELETE FROM PersonInfo WHERE PersonID=2
SELECT * FROM PersonInfo

DROP TRIGGER TR_INSERT



---2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 
CREATE TRIGGER TR_INSERT_UPD_DEL
ON PersonInfo
AFTER INSERT
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM inserted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'inserted',GETDATE())
END;

-------------INSERT-----------
INSERT INTO PersonInfo VALUES(2,'sheeya',5000,'2021-04-10','RAJKOT',20,'2005-10-04')

----------------UPDATE------
UPDATE PersonLog
SET PersonName ='PIHUU'
WHERE PersonID=2


---------------DELETE---------
DELETE FROM PersonLog WHERE PersonID=2
SELECT * FROM PersonInfo
SELECT * FROM PersonLog


CREATE TRIGGER TR_UPD
ON PersonInfo
AFTER UPDATE
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM inserted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'UPDATED',GETDATE())
END;


----------------UPDATE------
UPDATE PersonLog
SET PersonName ='PIHUU'
WHERE PersonID=2


CREATE TRIGGER TR_DEL
ON PersonInfo
AFTER DELETE
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM deleted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'DELETED',GETDATE())
END;


---------------DELETE---------
DELETE FROM PersonLog WHERE PersonID=2
SELECT * FROM PersonInfo
SELECT * FROM PersonLog

DROP TRIGGER  TR_INSERT_UPD_DEL
DROP TRIGGER  TR_UPD
DROP TRIGGER  TR_DEL



---3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 
CREATE TRIGGER TR_INS
ON PersonInfo
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM inserted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'inserted',GETDATE())
END;

-------------INSERT-----------
INSERT INTO PersonInfo VALUES(2,'sheeya',5000,'2021-04-10','RAJKOT',20,'2005-10-04')



CREATE TRIGGER TR_UPDATE
ON PersonInfo
INSTEAD OF UPDATE
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM inserted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'UPDATED',GETDATE())
END;

----------------UPDATE------
UPDATE PersonLog
SET PersonName ='PIHUU'
WHERE PersonID=2


CREATE TRIGGER TR_DELETE
ON PersonInfo
INSTEAD OF DELETE
AS 
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(50);
	SELECT @PersonID=PersonID ,@PersonName= PersonName FROM deleted
	INSERT INTO PersonLog VALUES
	(@PersonID,@PersonName,'DELETED',GETDATE())
END;


---------------DELETE---------
DELETE FROM PersonLog WHERE PersonID=2
SELECT * FROM PersonInfo
SELECT * FROM PersonLog

DROP TRIGGER  TR_INS
DROP TRIGGER  TR_UPDATE
DROP TRIGGER  TR_DELETE



--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into uppercase whenever the record is inserted. 
CREATE TRIGGER TR__PERSON
ON PersonInfo
after INSERT
AS
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(100);
	DECLARE @Salary DECIMAL(8,2);
	DECLARE @JoiningDate DATETIME;
	DECLARE @City VARCHAR(100);
	DECLARE @Age INT;
	DECLARE @BirthDate DATETIME;
	SELECT @PersonName FROM inserted
	SELECT @PersonID = PersonID FROM inserted
	UPDATE PersonInfo
	set @PersonName=upper(@PersonName)
	where @PersonID=PersonID
end
---5. Create trigger that prevent duplicate entries of person name on PersonInfo table. 
CREATE TRIGGER TR_PERS_INS
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(100);
	DECLARE @Salary DECIMAL(8,2);
	DECLARE @JoiningDate DATETIME;
	DECLARE @City VARCHAR(100);
	DECLARE @Age INT;
	DECLARE @BirthDate DATETIME;
	SELECT @PersonID = PersonID ,@PersonName=PersonName,@Salary =Salary,@JoiningDate=JoiningDate,@City=City,@Age=Age,@BirthDate=@BirthDate FROM inserted
	WHERE PersonName NOT IN (SELECT PersonName FROM PersonInfo)
end;

DROP TRIGGER	TR_PERS_INS



---6. Create trigger that prevent Age below 18 years. 
CREATE TRIGGER TR_PERS_INSERT
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @PersonID INT;
	DECLARE @PersonName VARCHAR(100);
	DECLARE @Salary DECIMAL(8,2);
	DECLARE @JoiningDate DATETIME;
	DECLARE @City VARCHAR(100);
	DECLARE @Age INT;
	DECLARE @BirthDate DATETIME;
	SELECT @PersonID = PersonID ,@PersonName=PersonName,@Salary =Salary,@JoiningDate=JoiningDate,@City=City,@Age=Age,@BirthDate=@BirthDate FROM inserted
	IF @Age>=18
	insert into PersonInfo values (@PersonID,@PersonName,@Salary,@JoiningDate,@City,@Age,@BirthDate)
end;

DROP TRIGGER	TR_PERS_INSERT


----------------------Part – B --------


---7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update that age in Person table. 
CREATE OR ALTER TRIGGER TR_PER_INSERT
ON PersonInfo
aFter INSERT
AS
BEGIN  
declare @PersonID INT;  
DECLARE @BirthDate DATETIME;
declare @Age int;
select @PersonID=PersonId from inserted
select @BirthDate=BirthDate from inserted
set @Age=DATEDIFF(year,@BirthDate,GETDATE())
update PersonInfo
set Age=@Age
where PersonID=@PersonId
end;

--8. Create a Trigger to Limit Salary Decrease by a 10%.


CREATE OR ALTER TRIGGER TR_LIMITSALARY
ON PersonInfo
after update
as
begin
declare @PersonID int;
declare @oldsalary decimal(8,2),@Newsalary decimal(8,2);
select @oldsalary=d.Salary,@Newsalary=i.Salary
from deleted d
join inserted i on d.PersonID=i.PersonID;

if @Newsalary<@oldsalary*0.9
begin
update PersonInfo
set Salary=@oldsalary
where PersonID=@PersonID
end

end
-------------------------------------------------------------------Part – C----------------------------------------------------------------------------  
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL during an INSERT.

CREATE OR ALTER TRIGGER TR_PER_ins
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN  
update PersonInfo
set JoiningDate=GETDATE()
from PersonInfo p
join inserted i on p.PersonID=i.PersonID
where i.JoiningDate is null
end;

drop TRIGGER TR_PER_ins

--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’.

CREATE OR ALTER TRIGGER TR_PER_INS_UPD_DEL
ON PersonLog
AFTER delete
AS
BEGIN
PRINT 'Record deleted successfully from PersonLog'
end;

drop TRIGGER TR_PER_INS_UPD_DEL


























