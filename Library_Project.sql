-- Library System Management SQL Project

-- CREATE DATABASE library;

-- Create table "Branch"
--DROP TABLE IF EXISTS branch;
--CREATE TABLE branch
--(
--            branch_id VARCHAR(10) PRIMARY KEY,
--            manager_id VARCHAR(10),
--            branch_address VARCHAR(30),
--            contact_no VARCHAR(15)
--);


-- Create table "Employee"
--DROP TABLE IF EXISTS employees;
--CREATE TABLE employees
--(
--            emp_id VARCHAR(10) PRIMARY KEY,
--            emp_name VARCHAR(30),
--            position VARCHAR(30),
--            salary DECIMAL(10,2),
--            branch_id VARCHAR(10),
--            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
--);


---- Create table "Members"
--DROP TABLE IF EXISTS members;
--CREATE TABLE members
--(
--            member_id VARCHAR(30) PRIMARY KEY,
--            member_name VARCHAR(30),
--            member_address VARCHAR(30),
--            reg_date DATE
--);



-- Create table "Books"
--DROP TABLE IF EXISTS books;
--CREATE TABLE books
--(
--            isbn VARCHAR(50) PRIMARY KEY,
--            book_title VARCHAR(80),
--            category VARCHAR(30),
--            rental_price DECIMAL(10,2),
--            status VARCHAR(10),
--            author VARCHAR(30),
--            publisher VARCHAR(30)
--);



-- Create table "IssueStatus"
--DROP TABLE IF EXISTS issued_status;
--CREATE TABLE issued_status
--(
--            issued_id VARCHAR(10) PRIMARY KEY,
--            issued_member_id VARCHAR(30),
--            issued_book_name VARCHAR(100),
--            issued_date DATE,
--            issued_book_isbn VARCHAR(50),
--            issued_emp_id VARCHAR(10),
--            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
--            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
--            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
--);



---- Create table "ReturnStatus"
--DROP TABLE IF EXISTS return_status;
--CREATE TABLE return_status
--(
--            return_id VARCHAR(10) PRIMARY KEY,
--            issued_id VARCHAR(30),
--            return_book_name VARCHAR(80),
--            return_date DATE,
--            return_book_isbn VARCHAR(50),
--            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
--);

-- Data Modeling
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members (member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books (isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees (emp_id);


ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch (branch_id);

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id);


-- While solving above query I got this error 
-- The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "fk_issued_status". The conflict occurred in database "Library_Project_DB", table "dbo.issued_status", column 'issued_id'

-- Then We found there are return_status.issued_id are not present in issued_status.issued_id so I removed it by Delete query as done below

--SELECT issued_id
--FROM return_status
--WHERE issued_id NOT IN (SELECT issued_id FROM issued_status);

--DELETE FROM return_status
--WHERE issued_id NOT IN (SELECT issued_id FROM issued_status);


SELECT * FROM branch


SELECT * FROM books


SELECT * FROM employees


SELECT * FROM members


SELECT * FROM return_status;


SELECT * FROM issued_status


-- Project TASK

-- ### 2. CRUD Operations


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

SELECT TOP (1000) [isbn]
      ,[book_title]
      ,[category]
      ,[rental_price]
      ,[status]
      ,[author]
      ,[publisher]
  FROM [Library_Project_DB].[dbo].[books]
-- Before we have 35 records

INSERT INTO books([isbn], [book_title], [category], [rental_price], [status], [author], [publisher])
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main st'
Where member_id= 'C101'

SELECT * FROM members

-- Task 3: Delete a Record from the Issued Status Table
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
Select * from issued_status-- There were 35 rows 

DELETE FROM issued_status
WHERE issued_id = 'IS121';

Select * from issued_status-- Now there are 34 Rows


-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'

-- Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT * FROM (
SELECT issued_member_id, COUNT(*) AS Total_book_Issued FROM issued_status
Group by issued_member_id
)t
WHERE Total_book_Issued >1 

-- CTAS (Create Table As Select)

-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
--CREATE TABLE AS 

-- CREATE TABLE Total_Books_Issued_by_Each_book AS 
SELECT 
b.isbn, 
b.book_title, 
COUNT(isst.issued_id) AS Total_book_Issued 
INTO Total_Books_Issued_by_Each_book
FROM books as b
JOIN issued_status as isst
ON isst.issued_book_isbn = b.isbn
Group by b.isbn, b.book_title

Select * from Total_Books_Issued_by_Each_book

-- Data Analysis & Findings

-- Task 7. Retrieve All Books in a Specific Category:
-- Objective Category is Classic
SELECT 
category,
book_title FROM books
WHERE category = 'Classic'

-- Task 8: Find Total Rental Income by Category:
SELECT 
b.category, 
SUM(b.rental_price) AS Rental_Income,
COUNT(*) No_of_items_sold
FROM books AS b
JOIN issued_status as isst
ON isst.issued_book_isbn = b.isbn
GROUP BY category
ORDER BY Rental_Income DESC


-- Task 9. List Members Who Registered in the Last 300 Days:
SELECT * 
FROM members
WHERE reg_date > DATEADD(DAY, -300, GETDATE());

-- Task 10: List Employees with Their Branch Manager's Name and their branch details**:

SELECT
e1.*,
br.manager_id,
e2.emp_name as Manager
FROM employees as e1
JOIN branch br
ON e1.branch_id = br.branch_id
JOIN employees e2
ON e2.emp_id = br.manager_id

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7 USD
SELECT * INTO Books_Price_Greater_than_Seven
FROM books
WHERE rental_price > 7

SELECT * FROM Books_Price_Greater_than_Seven


-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT 
DISTINCT isst.issued_book_name 
FROM issued_status isst
LEFT JOIN [return_status ] rs    
ON isst.issued_id = rs.issued_id
WHERE rs.return_id IS NULL
-------------------------------------------------------------------------------------------------------

-- Inserting records into issued_status table
INSERT INTO issued_status (issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', DATEADD(DAY, -144, GETDATE()), '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', DATEADD(DAY, -133, GETDATE()), '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', DATEADD(DAY, -127, GETDATE()), '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', DATEADD(DAY, -152, GETDATE()), '978-0-375-50167-0', 'E101');

SELECT * FROM issued_status
-- Adding a new column to return_status table
ALTER TABLE return_status
ADD book_quality VARCHAR(15) DEFAULT 'Good';

-- Updating the book_quality column for specific issued IDs
UPDATE [return_status ]
SET book_quality = 'Damaged'
WHERE issued_id IN ('IS112', 'IS117', 'IS118');

-- Selecting all records from return_status table
SELECT * FROM [return_status ];

-------------------------- ADVANCE SQL OPERTIONS
SELECT * FROM books --36 Records
SELECT * FROM branch -- 5 Records
SELECT * FROM employees -- 11 records
SELECT * FROM issued_status --38 Records
SELECT * FROM members -- 12 Records
SELECT * FROM [return_status ] -- 15 Records


--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's name, book title, issue date, and days overdue.

-- First  I need to join issue_status with members table so that I can get each member name then I will
--join it with book table so that I can get book title as well,  then we also want days overdue for that we need return_status table
-- We need to filter books which are return
-- if the book is not return in 30 days then we need to return overdue


SELECT CONVERT(date, DATEADD(MONTH, -4, GETDATE())) Todays_date_Using_Convert_and_DateADD;
-- OR
SELECT CAST(DATEADD(MONTH,-4,GETDATE()) AS date) Todays_date_Cast_and_DateADD

SELECT 
isst.issued_member_id,
m.member_name,
b.book_title,
isst.issued_date,
--rs.return_date,
CAST(DATEADD(MONTH,-4,GETDATE())AS date) Todays_date,
DATEDIFF(DAY,isst.issued_date,CAST(DATEADD(MONTH,-4,GETDATE()) AS date)) as Over_due_days
FROM issued_status isst
JOIN members  m
	ON isst.issued_member_id = m.member_id
JOIN  books b
	ON isst.issued_book_isbn = b.isbn
LEFT JOIN [return_status ] rs
	ON isst.issued_id = rs.issued_id
WHERE 
	rs.return_date is NULL AND
	DATEDIFF(DAY,isst.issued_date,CAST(DATEADD(MONTH,-4,GETDATE()) AS date)) >30
ORDER BY 1


--Task 14: Update Book Status on Return
--Write a query to update the status of books in the books table to "available" when they are returned (based on entries in the return_status table).
--DROP PROCEDURE add_return_records

GO
CREATE PROCEDURE add_return_records
    @p_return_id VARCHAR(10),
    @p_issued_id VARCHAR(10),
    @p_book_quality VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @v_isbn VARCHAR(50);
    DECLARE @v_book_name VARCHAR(100);

    -- Retrieve book details from issued_status
    SELECT 
        @v_isbn = issued_book_isbn, 
        @v_book_name = issued_book_name
    FROM 
        issued_status
    WHERE 
        issued_id = @p_issued_id;

    -- Validate that book details are retrieved
    IF @v_isbn IS NULL OR @v_book_name IS NULL
    BEGIN
        PRINT 'Error: Invalid issued_id. No matching book details found.';
        RETURN;
    END

    -- Insert into return_status with @v_book_name
    INSERT INTO [return_status ] (return_id, issued_id, return_book_name, return_date, return_book_isbn, book_quality)
    VALUES 
    (@p_return_id, @p_issued_id, @v_book_name, CAST(GETDATE() AS DATE), @v_isbn, @p_book_quality);

    -- Update the book status in books table
    UPDATE books
    SET status = 'yes'
    WHERE isbn = @v_isbn;

    -- Success message
    PRINT 'Thank you for returning the book "' + @v_book_name + '".';

END;


SELECT * FROM issued_status
SELECT * FROM [return_status ]

-- Below is the Verification that this isbn 978-0-307-58837-1 book is issued by IS135 issue_id which has 'no' status as It is not available
SELECT * FROM books
WHERE isbn ='978-0-307-58837-1'
-- Here you can see book is not returned yet

-- By whom this book is issued
SELECT * FROM issued_status
WHERE issued_book_isbn ='978-0-307-58837-1'
-- Issued_id IS135

-- Here as You can see that no return records is there by issue_id IS135 so book is still with IS135 person
SELECT * FROM [return_status ]
WHERE issued_id = 'IS135'

-- TESTING FUNCTION add_return_records
EXEC add_return_records 'R119', 'IS135', 'Good';

-- Testing of add_return_records procedure

--UPDATE books
--SET status ='no'
--WHERE isbn = '978-0-330-25864-8'


SELECT * FROM books
WHERE isbn ='978-0-330-25864-8'
-- Here you can see book is not returned yet

-- By whom this book is issued
SELECT * FROM issued_status
WHERE issued_book_isbn ='978-0-330-25864-8'
-- Issued_id IS140

SELECT * FROM [return_status ]
WHERE issued_id = 'IS140'

--As You can see there is no Return records of IS140

-- TESTING FUNCTION add_return_records 
EXEC add_return_records 'RS120', 'IS140', 'Good';


--Task 15: Branch Performance Report
--Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

SELECT * FROM branch
SELECT * FROM employees
SELECT * FROM [return_status ]
SELECT * FROM books

SELECT 
	br.branch_id,
	br.manager_id,
	COUNT(isst.issued_id) Number_of_Books_Issued,
	COUNT(rs.return_id) Number_of_Books_Returned,
	SUM(b.rental_price) Total_Revenue
INTO Branch_Report
FROM issued_status isst
JOIN employees e
	ON isst.issued_emp_id = e.emp_id 
JOIN branch br
	ON br.branch_id = e.branch_id
LEFT JOIN [return_status ] as rs
	ON rs.issued_id = isst.issued_id
JOIN books b
	ON isst.issued_book_isbn = b.isbn
Group by br.branch_id, br.manager_id

SELECT * FROM Branch_Report

--Task 16: CTAS: Create a Table of Active Members
--Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
-- Todaysdate which I consider as Present date
SELECT DATEADD(MONTH,-7,CAST(GETDATE() AS date)) Todaysdate

SELECT *,
DATEADD(MONTH,-7,CAST(GETDATE() AS date)) Todaysdate 
FROM issued_status
WHERE issued_date > DATEADD(MONTH,-7,CAST(GETDATE()as date)) 

SELECT DISTINCT issued_member_id
FROM issued_status
WHERE issued_date > DATEADD(MONTH,-7,CAST(GETDATE()as date)) 


SELECT * INTO Active_Members FROM members
WHERE member_id IN
	(
	SELECT  DISTINCT issued_member_id
	FROM issued_status
	WHERE issued_date > DATEADD(MONTH,-7,CAST(GETDATE()as date)) 
	)

SELECT * FROM Active_Members
--Task 17: Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

SELECT * FROM branch

SELECT TOP 3
e.emp_name, 
br.branch_id,
br.manager_id, 
branch_address,
contact_no, 
COUNT(isst.issued_id) Number_of_book_issued 
FROM issued_status isst
JOIN employees e
	ON e.emp_id = isst.issued_emp_id
JOIN branch br
	ON e.branch_id = br.branch_id
GROUP BY
		emp_name,
		br.branch_id,
		br.manager_id, 
		branch_address,
		contact_no
ORDER BY COUNT(isst.issued_id) DESC

--Task 18: Identify Members Issuing High-Risk Books
--Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    
SELECT 
	m.member_name,
	isst.issued_book_name, 
	COUNT(isst.issued_id) Number_of_time_issued_book 
FROM issued_status isst
JOIN members m
	ON isst.issued_member_id = m.member_id
LEFT JOIN [return_status ] rs
	ON rs.issued_id = isst.issued_id
WHERE 
	rs.book_quality = 'Damaged'
GROUP BY
		m.member_name, 
		isst.issued_book_name

SELECT * FROM issued_status


--Task 19: Stored Procedure
--Objective: Create a stored procedure to manage the status of books in a library system.
--    Description: Write a stored procedure that updates the status of a book based on its issuance or return. Specifically:
--    If a book is issued, the status should change to 'no'.
--    If a book is returned, the status should change to 'yes'.


GO
CREATE PROCEDURE issue_book
    @p_issued_id VARCHAR(10),
    @p_issued_member_id VARCHAR(30),
    @p_issued_book_isbn VARCHAR(50),
    @p_issue_emp_id VARCHAR(10)
AS
BEGIN
    DECLARE @v_status VARCHAR(10);
    DECLARE @v_book_title VARCHAR(100);

    -- Check if the book is available
    SELECT @v_status = status, 
           @v_book_title = book_title
    FROM books
    WHERE isbn = @p_issued_book_isbn;

    -- Handle case where the book is not found
    IF @v_status IS NULL
    BEGIN
        PRINT 'No book found with the provided ISBN: ' + CAST(@p_issued_book_isbn AS VARCHAR);
        RETURN;
    END;

    -- Check if the book is available
    IF @v_status = 'yes'
    BEGIN
        -- Insert the issued book record
        INSERT INTO issued_status (issued_id, issued_member_id, issued_date, issued_book_name, issued_book_isbn, issued_emp_id)
        VALUES (@p_issued_id, @p_issued_member_id, CAST(GETDATE() AS DATE), @v_book_title, @p_issued_book_isbn, @p_issue_emp_id);

        PRINT 'Book record added successfully for book ISBN: ' + CAST(@p_issued_book_isbn AS VARCHAR);

        -- Update the book status to 'no'
        UPDATE books
        SET status = 'no'
        WHERE isbn = @p_issued_book_isbn;
    END
    ELSE
    BEGIN
        PRINT 'Sorry to inform you, the book you have requested is currently unavailable. Book ISBN: ' + CAST(@p_issued_book_isbn AS VARCHAR);
    END
END;
GO


SELECT * FROM books
WHERE isbn = '978-0-06-112008-4' -- status yes

SELECT * FROM books

SELECT * FROM issued_status

EXEC issue_book 'IS155','C108','978-0-06-112008-4','E104' 

-- Now this book is issued for some now if we another book or suppose this book is issued by some one then

EXEC issue_book 'IS155','C108','978-0-06-112008-4','E104' 
/*
Task 20: Create Table As Select (CTAS)
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.

    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines

*/

SELECT 
	m.member_id,
	m.member_name,
	COUNT(isst.issued_id) AS Number_of_Overdue_books,
	COUNT(isst.issued_id) * 0.50 AS Total_Fines
INTO Overdue_books_And_Fines
FROM issued_status isst
JOIN members m
	ON isst.issued_member_id =m.member_id
LEFT JOIN [return_status ] rs
	ON rs.issued_id = isst.issued_id
JOIN books b
	ON b.isbn = isst.issued_book_isbn
WHERE 
	return_date > DATEADD(DAY,30,issued_date)
GROUP BY
		m.member_id, 
		m.member_name

SELECT * FROM Overdue_books_And_Fines