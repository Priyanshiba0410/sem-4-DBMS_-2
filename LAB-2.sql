

---------------Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

---------------------- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

---------------- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);
---------------------------------------------PART-A-------------


--------------------INSERT------------------


CREATE PROCEDURE PR_Designation_INSERT
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	INSERT INTO Designation (DesignationID,DesignationName) 
	VALUES(@DesignationID,@DesignationName)
END
EXEC PR_Designation_INSERT 11,'JOBBER'
EXEC PR_Designation_INSERT 12,'WELDER'
EXEC PR_Designation_INSERT 13,'CLERK'
EXEC PR_Designation_INSERT 14,'MANAGER'
EXEC PR_Designation_INSERT 15,'CEO'

SELECT * FROM Designation


-------------DEPARTMENT--------


CREATE PROCEDURE PR_Department_INSERT
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	INSERT INTO Department (DepartmentID,DepartmentName) 
	VALUES(@DepartmentID,@DepartmentName)
END
EXEC PR_Department_INSERT 1,'ADMIN'
EXEC PR_Department_INSERT 2,'IT'
EXEC PR_Department_INSERT 3,'HR'
EXEC PR_Department_INSERT 4,'ACCOUNT'

SELECT * FROM Department

------------PERSON--------

CREATE PROCEDURE PR_PERSON_INSERT
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary  DECIMAL(8,2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
AS
BEGIN
	INSERT INTO PERSON (FirstName,LastName,Salary,JoiningDate,DepartmentID,DesignationID) 
	VALUES(@FirstName,@LastName,@Salary,@JoiningDate,@DepartmentID,@DesignationID)
END
EXEC PR_PERSON_INSERT 'RAHUL','ANSHU',56000,'1990-01-01',1,12
EXEC PR_PERSON_INSERT 'HARDIK','HINSU',18000,'1990-09-25',2,11
EXEC PR_PERSON_INSERT 'BHAVIN','KAMANI',25000,'1991-05-1',NULL,11
EXEC PR_PERSON_INSERT 'BHOOMI','PATEL',39000,'2014-02-20',1,13
EXEC PR_PERSON_INSERT 'ROHIT','RAJGOR',17000,'1990-07-23',2,15
EXEC PR_PERSON_INSERT 'PRIYA','MEHTA',25000,'1990-10-18',2,NULL
EXEC PR_PERSON_INSERT 'NEHA','TRIVEDI',18000,'2014-02-20',3,15

SELECT * FROM PERSON




------------------UPDATE---------


CREATE PROCEDURE PR_Designation_UPDATE
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	UPDATE Designation  
	SET DesignationID = @DesignationID
	WHERE DesignationName = @DesignationName

END
EXEC PR_Designation_INSERT 11,'JOBBER'

SELECT * FROM Designation

-----------------------------------------------------


CREATE PROCEDURE PR_Department_UPDATE
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	update Department  
	set DepartmentID = @DepartmentID
	where DepartmentName = @DepartmentName
END
EXEC PR_Department_update 1,'ADMINISTRATOR'

 SELECT * FROM Department

 -----------------------------------------------------------

 CREATE PROCEDURE PR_PERSON_UPDATE
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary  DECIMAL(8,2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
AS
BEGIN
	UPDATE PERSON 
	SET LastName =@LastName
	 WHERE FirstName = @FirstName
END
EXEC PR_PERSON_UPDATE 'KRISH','ANSH',20000,'05-05-2015',2,14

SELECT * FROM PERSON

-----------------DELETE--------------

CREATE PROCEDURE PR_Designation_DELETE
	@DesignationID INT,
	@DesignationName VARCHAR(100)
AS
BEGIN
	DELETE Designation
	 WHERE DesignationID =@DesignationID
END
EXEC PR_Designation_DELETE ,'JOBBER'

SELECT * FROM Designation

-----------------------------------------


CREATE PROCEDURE PR_Department_DELETE
	@DepartmentID INT,
	@DepartmentName VARCHAR(100)
AS
BEGIN
	DELETE Department  
	WHERE DepartmentID =@DepartmentID
END
EXEC PR_Department_DELETE 1,'ADMIN'

 SELECT * FROM Department

 ---------------------------------------


 CREATE PROCEDURE PR_PERSON_DELETE
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary  DECIMAL(8,2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
AS
BEGIN
	DELETE PERSON 
	WHERE LastName =@LastName
END
EXEC PR_PERSON_DELETE 'RAHUL','ANSHU',56000,'1990-01-01',1,12

SELECT * FROM PERSON

-- 2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY------------

CREATE OR ALTER PROCEDURE PR_Person_INSERT 
	@PersonId int,
	@FirstName varchar(100)=Null,
	@LastName VARCHAR(100)=Null, 
	@Salary DECIMAL(8, 2), 
	@JoiningDate DATETIME, 
	@DEPARTMENTID INT, 
	@DESIGNATIONID INT
AS
BEGIN
		INSERT INTO Person 
		values(@PersonId,@FirstName,@LastName,@Salary,@JoiningDate,@DESIGNATIONID,@DEPARTMENTID)
end

exec PR_Person_INSERT  15000,'1990-02-05',11,1


--3.Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list)
 
create or alter proc pr_PersonDetails
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
end


--4. Create a Procedure that shows details of the first 3 persons. 

create or alter proc pr_Person
as
begin
		select top 3 * from Person
end

--------------------Part – B -----------------------


--5. Create a Procedure that takes the department name as input and returns a table with all workers  working in that department.
 
create or alter proc pr_PersonDetails
		@DEPARTMENTNAME VARCHAR(100)
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end


--6. Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name. 

create or alter proc pr_PersonDetails
		@DEPARTMENTNAME VARCHAR(100),
		@DESIGNATIONNAME varchar(100)
as
begin
	select Person.FirstName,Person.Salary,Person.JoiningDate from 
	Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where DEPARTMENTNAME=@DEPARTMENTNAME and
		  DESIGNATIONNAME=@DESIGNATIONNAME
end

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
 
create or alter proc pr_PersonDetails
		@FirstName VARCHAR(100)
as
begin
	select * from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where FirstName=@FirstName
end

--8. Create Procedure which displays department wise maximum, minimum & total salaries.

create or alter proc pr_PersonDetails
as
begin
	select DEPARTMENT.DEPARTMENTNAME,max(Person.Salary),min(Person.Salary),sum(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	group by DEPARTMENT.DEPARTMENTNAME
end

--9. Create Procedure which displays designation wise average & total salaries. 

create or alter proc pr_PersonDetails
as
begin
	select DESIGNATION.DESIGNATIONNAME,avg(Person.Salary),sum(Person.Salary)
	from Person join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	group by DESIGNATION.DESIGNATIONNAME
end

--------------------Part – C ---------------


--10. Create Procedure that Accepts Department Name and Returns Person Count.

create or alter proc pr_PersonDetails
	@DEPARTMENTNAME VARCHAR(100)
as
begin
	select COUNT(Person.PersonID)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end

--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.
 
create or alter proc pr_PersonDetails
	@Salary decimal(8,2)
as
begin
	select *
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where Salary>@Salary
end

--12. Create a procedure to find the department(s) with the highest total salary among all departments.

create or alter proc pr_PersonDetails
	@DEPARTMENTNAME VARCHAR(100)
as
begin
	select sum(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where DEPARTMENTNAME=@DEPARTMENTNAME
end

--13. Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department. 

create or alter proc pr_PersonDetails
	@DESIGNATIONNAME VARCHAR(100)
as
begin
	select Person.JoiningDate,DEPARTMENT.DEPARTMENTNAME
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	join DESIGNATION
	on Person.DESIGNATIONID=DESIGNATION.DESIGNATIONID
	where DESIGNATIONNAME=@DESIGNATIONNAME and Person.JoiningDate>'2014'
end

--14. Create a procedure to list the number of workers in each department who do not have a designation assigned. 

create or alter proc pr_PersonDetails
as
begin
	select COUNT(Person.PersonID)
	from Person join DESIGNATION
	on Person.DEPARTMENTID=DESIGNATION.DESIGNATIONID
	where DESIGNATIONNAME != null
end

--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.
 

 create or alter proc pr_PersonDetails
as
begin
	select avg(Person.Salary)
	from Person join DEPARTMENT
	on Person.DEPARTMENTID=DEPARTMENT.DEPARTMENTID
	where avg(Person.Salary)>12000
end












