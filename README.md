# **Library System Management SQL Project - Task-Wise Summary**

![Library_Image](https://github.com/user-attachments/assets/2dfb80e2-ded0-4848-aef4-2c3d5a955105)


This library system management project, executed on **SQL Server**, integrates advanced SQL concepts crucial for a **Data Analyst** to efficiently manage, analyze, and automate database operations. Below are the **advanced concepts** used throughout the project:

1. ### **SQL Operations for Data Manipulation**:
    - **INSERT**, **UPDATE**, **DELETE**: These basic operations were used to manipulate records in tables (e.g., adding books, updating member information, and removing issued records). This fundamental knowledge is vital for a data analyst to modify and clean data as required.
    
2. ### **Complex Joins**:
    - **INNER JOIN**, **LEFT JOIN**: Used to combine multiple related tables (e.g., linking **books**, **issued_status**, and **members**), which is essential for data analysts to retrieve consolidated datasets for analysis.
    
3. ### **Aggregation & Grouping**:
    - **GROUP BY**, **COUNT**, **SUM()**: Aggregating data, such as counting books issued per member or calculating rental income by book category. This helps in deriving insights from raw data, an important skill for data analysts.
    - 
4. ### **CTAS (Create Table as Select)**:
    - **CTAS** queries were used to create new summary tables from existing data, such as **Total_Books_Issued_by_Each_Book** and **Active Members**. This allows for efficient data extraction and transformation to build reporting tables for further analysis.
    
5. ### **Advanced Filtering with `WHERE` and Date Functions**:
    - **DATEADD**, **DATEDIFF**, and conditional **WHERE** clauses: Used to filter records based on dates (e.g., finding members registered in the last 300 days or identifying overdue books). This type of filtering is essential for time-based analysis in data analytics.
      
6. ### **Stored Procedures**:
    - Used for encapsulating business logic, such as updating book status on return. **Stored procedures** automate repetitive tasks and ensure transactional integrity, making them valuable for any data analyst working with large databases.
      
7. ### **Performance Ranking and Metrics**:
    - Ranking employees based on the number of processed book issues. **Ranking functions** like `ROW_NUMBER()` or `RANK()` would be typically used for performance metrics analysis, which is an advanced task for data analysts who need to extract business insights.
      
8. ### **Data Profiling & Risk Assessment**:
    - Advanced **data profiling** techniques were applied to identify high-risk books and members. This involves grouping and filtering large datasets to identify patterns and potential issues, an important skill for risk analysis in a data-driven role.
9. ### **Error Handling and Conditional Updates**:
    - Use of **CASE** statements and **error handling** in stored procedures for updating book status and managing transactional data. These conditional updates ensure data accuracy and consistency, crucial for data analysts to maintain clean and valid datasets.
      
10. ### **Fine and Penalty Calculation**:
    - **Analytical problem-solving** with calculated columns for fines based on overdue books. This concept is often used in data analysis to perform business-specific calculations based on predefined rules.

11. ### **Multi-Table Joins for Relational Data Extraction**:
    - Combining data from multiple related tables (e.g., employee and branch information) using **multi-table joins**. This is key for data analysts to work with relational databases and derive insights from interconnected data sources.

By applying these **advanced SQL concepts**, this project demonstrates how a **Data Analyst** can use SQL Server to automate, manage, and extract meaningful insights from complex relational databases, ensuring accurate reporting and data-driven decision-making.

### **Task 1: Create a New Book Record**

- **Objective**: Add a new book titled **"To Kill a Mockingbird"** into the **books** table.
- **Skills Demonstrated**:
    - **INSERT** operation to add a new record into a table.
    - Basic knowledge of handling table columns for book details like ISBN, category, rental price, author, and publisher.

### **Task 2: Update an Existing Member's Address**

- **Objective**: Update the address of member **C101** to "125 Main St" in the **members** table.
- **Skills Demonstrated**:
    - **UPDATE** operation to modify an existing record.
    - Understanding of condition-based updates using **WHERE** clause.

### **Task 3: Delete a Record from the Issued Status Table**

- **Objective**: Delete the record with **issued_id = IS121** from the **issued_status** table.
- **Skills Demonstrated**:
    - **DELETE** operation to remove a record.
    - Data cleaning and integrity enforcement by removing invalid records (in this case, an entry with no matching **issued_id** in the **return_status** table).

### **Task 4: Retrieve All Books Issued by a Specific Employee**

- **Objective**: Retrieve all books issued by the employee with **emp_id = E101**.
- **Skills Demonstrated**:
    - **SELECT** query to fetch data from a related table using a specific employee’s **emp_id**.
    - Basic **JOIN** operations for related table lookups.

### **Task 5: List Members Who Have Issued More Than One Book**

- **Objective**: Find members who have issued more than one book using **GROUP BY** and **COUNT**.
- **Skills Demonstrated**:
    - **GROUP BY** for aggregating data based on **issued_member_id**.
    - **COUNT** function to calculate the total number of books issued by each member.

### **Task 6: Create Summary Tables (CTAS)**

- **Objective**: Create a new table **Total_Books_Issued_by_Each_book** to show each book with the total number of times it was issued.
- **Skills Demonstrated**:
    - **CTAS (Create Table As Select)** query to create a summary table from the results of a SELECT query.
    - **JOIN** operation to link **books** and **issued_status** tables and calculate the total number of books issued.

### **Task 7: Retrieve All Books in a Specific Category**

- **Objective**: Retrieve all books categorized as **'Classic'**.
- **Skills Demonstrated**:
    - **SELECT** query with a condition using **WHERE** to filter data by category.
    - Basic filtering and data extraction based on a specific column value.

### **Task 8: Find Total Rental Income by Category**

- **Objective**: Calculate the total rental income by category of books.
- **Skills Demonstrated**:
    - **JOIN** operation between the **books** and **issued_status** tables.
    - Use of **SUM()** for calculating total rental income and **GROUP BY** for grouping by book category.
    - Sorting results by rental income in descending order.

### **Task 9: List Members Who Registered in the Last 300 Days**

- **Objective**: Retrieve all members who registered within the last 300 days.
- **Skills Demonstrated**:
    - **DATEADD** function to calculate the date range for the last 300 days.
    - **SELECT** query with date comparison to filter records.

### **Task 10: List Employees with Their Branch Manager's Name and Branch Details**

- **Objective**: List employees with their branch manager's name and branch details.
- **Skills Demonstrated**:
    - **JOIN** operations between **employees** and **branch** tables, as well as self-join on **employees** to get manager information.
    - Retrieval of multiple related fields, including manager’s name and branch information.

### **Task 11: Create a Table of Books with Rental Price Above a Certain Threshold (7 USD)**

- **Objective**: Create a new table **Books_Price_Greater_than_Seven** containing books with rental prices greater than 7 USD.
- **Skills Demonstrated**:
    - **SELECT INTO** query to create a new table based on a condition (books with rental price > 7).
    - Filtering data based on a numeric condition in **WHERE** clause.

### **Task 12: Retrieve the List of Books Not Yet Returned**

- **Objective**: Identify books that have been issued but not returned.
- **Skills Demonstrated**:
    - **LEFT JOIN** operation to include all records from **issued_status** and matching records from **return_status**.
    - Identification of **NULL** values in the **return_id** column to find books not returned yet.

---

### **Additional Operations:**

- **Inserting Records into issued_status Table**:
    - Several records were inserted into the **issued_status** table to simulate the issuance of books, with members, books, and employees involved.
- **Adding a New Column to return_status Table**:
    - Added a **book_quality** column to the **return_status** table with a default value of **'Good'**.
    - Updated the **book_quality** column for certain **issued_ids** to reflect the condition of the books as **'Damaged'**.

### **Task 13: Identify Members with Overdue Books**

- **Concepts Used:**
    - Date calculations (`DATEDIFF`) for overdue analysis.
    - Conditional filtering to identify overdue records.
    - Multi-table joins for retrieving combined data.
- **Skills Demonstrated:**
    - Data manipulation using SQL.
    - Working with dates and conditional logic.
    - Joining and querying relational databases.


### **Task 14: Update Book Status on Return**

- **Concepts Used:**
    - Stored procedures for encapsulating business logic.
    - Update operations to modify existing records.
    - Input validation using procedural SQL.
- **Skills Demonstrated:**
    - Advanced SQL programming with procedures.
    - Handling dynamic updates in relational databases.
    - Managing transactional integrity.

### **Task 15: Branch Performance Report**

- **Concepts Used:**
    - Aggregation functions (`COUNT`, `SUM`) for data summarization.
    - Grouping and categorization to generate insights.
    - Multi-table joins for relational data extraction.
- **Skills Demonstrated:**
    - Generating actionable business reports.
    - Aggregating and presenting data from multiple sources.
    - Performance analysis and metrics computation.


### **Task 16: Create a Table of Active Members**

- **Concepts Used:**
    - Temporary table creation using CTAS (CREATE TABLE AS SELECT).
    - Filtering records based on recent activity using date functions.
- **Skills Demonstrated:**
    - Identifying active customers or users.
    - Using CTAS for efficient table creation.
    - Time-based filtering and analysis.


### **Task 17: Find Employees with the Most Book Issues Processed**

- **Concepts Used:**
    - Ranking employees based on performance.
    - Aggregation and grouping to calculate totals.
    - Sorting and limiting results to retrieve top performers.
- **Skills Demonstrated:**
    - Performance ranking within organizations.
    - Data aggregation and comparison.
    - Applying business rules for recognition.


### **Task 18: Identify Members Issuing High-Risk Books**

- **Concepts Used:**
    - Filtering records for specific conditions (damaged books).
    - Aggregation to count and group repetitive behaviors.
    - Relational database joins for linking tables.
- **Skills Demonstrated:**
    - Risk assessment and pattern identification.
    - Data profiling and quality checks.
    - Advanced querying for business insights.


### **Task 19: Stored Procedure for Book Status Management**

- **Concepts Used:**
    - Procedural SQL for dynamic query execution.
    - Conditional updates based on book availability.
    - Error handling and business logic encapsulation.
- **Skills Demonstrated:**
    - Automating routine operations with stored procedures.
    - Dynamic database management.
    - Implementing business processes in SQL.


### **Task 20: CTAS for Overdue Books and Fines**

- **Concepts Used:**
    - Combining analytical calculations (overdue days and fines).
    - Using CTAS to create derived datasets.
    - Multi-step processing to manage overdue information.
- **Skills Demonstrated:**
    - Analytical problem-solving in SQL.
    - Fine and penalty calculation based on business rules.
    - Creating structured, reusable data models.


This summary highlights the **conceptual understanding** and **practical SQL And Advance SQL skills** involved in these tasks, demonstrating proficiency in managing, analyzing, and automating relational database operations.
