# **Introduction**:
In this project I would use the integration of **SQL** using **MySQL** DBMS with **Tableau**, which is most known for its wide range of data visualization capabilities, to delve into a comprehensive database that captures essential employee information such as their department, salaries, hire dates, and their management career.

1. First, with a gender-based analysis since 1990, I compare the distribution of male and female employees. 

2. Subsequently, I explore the evolution of male and female managers, particularly highlighting active managers who become managers in a short time.

3. Then, I focused on the analysis of the average annual salaries across departments, shedding light on gender-based disparities. 

4. Finally, I focused on showing the average salary of male and female employees in each separate department.

You can see all SQL queries for the project here: project_sql folder: [sql_queries](/sql_queries/)


# **Tools I Used**:
To thoroughly explore critical insights into the employees' database, I utilized the capabilities of a range of essential tools:
1. **SQL:** allowing me to query the database and explore critical insights.
2. **MySQL:** database management system (DBMS).
3. **Visual Studio Code:** for database management and executing SQL queries.
4. **Tableau:** to create charts of the critical insights that are explored from the analysis, because of its wide range of data visualization capabilities, and you can see the whole dashboard on the Tableau public link [here](https://public.tableau.com/views/ExploringEmployeeDataInsightsIntegratingSQLwithTableauforComprehensiveAnalysis/Dashboard1?:language=en%20US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link).
5. **Git & GitHub:** for sharing my SQL scripts and analysis.

# **The Analysis**:
### 1. **Employee Gender Distribution Per Year (Sience 1990)**
This query provides a breakdown of the male and female employees working in the company each year, starting from 1990.
```sql
SELECT 
    YEAR(from_date) AS 'Year', 
    gender, 
    COUNT(gender) AS 'Number_of_Employees'
FROM 
    employees_mod.t_employees AS emp INNER JOIN employees_mod.t_dept_emp AS demp
    ON emp.emp_no = demp.emp_no
GROUP BY 
    YEAR(from_date), gender
HAVING      
    Year >= '1990'
ORDER BY
    Year ASC;
```
The result of this SQL query turned into a **CSV** file and made a **bar** chart visualization by Tableau software.

![Chart 1](/assest/Chart%201.PNG)
*This Bar Chart showing the evolving gender breakdown within the company from 1990, generated using Tableau Public 2024 software*

### **Conclusion from The Chart:**
1. The increasing number of employed workers throughout the years has been constant.
2. Notably, there is a notable increase in the female workforce, especially post-1994.
3. The ratio between male and female employees in a company nearly fixed over the years and has always been 60 % for males and 40 % for females approximately. 
4. The clear color differentiation between genders aids in the easy interpretation of the data, showing the evolving gender breakdown within the company over the specified years.

### 2. **Departmental Manager Gender Distribution:**
This query shows the count of female and male managers per year per department from 1990.
```sql
SELECT
    YEAR(M.from_date) AS Year_Date,
    D.dept_name AS Department,
    E.gender AS Gender,
    COUNT(E.gender) AS Number_of_Managers
FROM
    t_employees AS E
    INNER JOIN t_dept_manager AS M ON E.emp_no = M.emp_no
    INNER JOIN t_departments AS D ON M.dept_no = D.dept_no
GROUP BY
    YEAR(M.from_date),
    D.dept_name,
    E.gender
HAVING
    Year_Date >= 1990
ORDER BY
    Year_Date ASC,
    Department ASC,
    Gender ASC;
```
The result of this SQL query turned into a **CSV** file and made a **line** chart visualization by Tableau software.
![Chart 2](/assest/Chart%202.PNG)
*This Line Chart displays the fluctuating count of male and female managers per year per department from 1990, generated using Tableau Public 2024 software*
### **Conclusion from The Chart:**
1. Both genders show varying trends, with male managers peaking in 1993 and then declining.
2. While female managers reached their peak around 1994. 

### 3. **Annual Average Salaries by Department and Gender:**
This query shows the average salary of female and male employees per year per department from 2002.
```sql
SELECT
    YEAR(S.from_date) AS Year_Date,
    D.dept_name AS Department,
    E.gender AS Gender,
    ROUND(AVG(S.salary), 2) AS Average_Salary
FROM
    t_employees AS E
    INNER JOIN t_salaries AS S ON E.emp_no = S.emp_no
    INNER JOIN t_dept_emp AS DE ON S.emp_no = DE.emp_no
    INNER JOIN t_departments AS D ON DE.dept_no = D.dept_no 
GROUP BY
    YEAR(S.from_date),
    D.dept_name,
    E.gender
HAVING 
    Year_Date <= 2002
ORDER BY 
    Year_Date ASC;
```
The result of this SQL query turned into a **CSV** file and made a **line chart** visualization by Tableau software.
![Chart 3](/assest/Chart%203.PNG)
*This Line Chart shows the average salary of female and male employees per year per department from 2002, generated using Tableau Public 2024 software*
### **Conclusion from The Chart:**
1. The chart shows the average annual salary of male and female employees from 1989 to 2002, indicating a steady increase over time for both genders.
2. Male employees consistently have a higher average salary than female employees, with a widening gap observed in the later years, particularly after 1999.
3. Both gender lines show minor fluctuations, but the overall trend is an upward trajectory, suggesting general salary growth.
4. It is clear that male employees' salaries grow at a slightly faster rate than female employees over this period.

### 4. **Stored Procedure: Average Salary by Department and Gender Within Salary Range:**
In this query, I created an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range (ex: from 50000 to 90000), by making this range be defined by two values the user can insert when calling the procedure. 
```sql
CREATE PROCEDURE average_salary_range(
    IN min_salary FLOAT,
    IN max_salary FLOAT
)
BEGIN
    SELECT
        D.dept_name AS Department,
        E.gender AS Gender,
        ROUND((AVG(S.salary)), 2) AS Average_Salary
    FROM
        t_salaries AS S
        INNER JOIN t_employees AS E ON S.emp_no = E.emp_no
        INNER JOIN t_dept_emp AS DE ON E.emp_no = DE.emp_no
        INNER JOIN t_departments AS D ON D.dept_no = DE.dept_no
    WHERE
        S.salary BETWEEN min_salary AND max_salary
    GROUP BY
        D.dept_name,
        E.gender
    ORDER BY
        Department;
END;

CALL average_salary_range(50000, 90000);
```
The result of this SQL query turned into a **CSV** file and made a **double bar chart** visualization by Tableau software.
![Chart 4](/assest/Chart%204.PNG)
*This Double Bar Chart shows the average salary of female and male managers per department, where employee's salaries from 50000 to 90000, generated using Tableau Public 2024 software*
### **Conclusion from The Chart:**

1. Both genders generally have similar average salaries within each department, with minor variations across departments. 
2. The departments like Sales and Finance tend to have slightly higher average salaries compared to others.
3. Overall, this suggests relative gender parity in average salaries within each department.

# **Conclusion:**
- Over the years, there has been a steady increase in the overall workforce, with a notable rise in female employees after 1994. 
- The gender ratio has remained stable, with approximately 60% male and 40% female employees. 
Male managers peaked in 1993, while female managers reached their highest numbers in 1994. 
- Although both genders have experienced salary growth, male employees consistently earn more, with a widening gap after 1999. 
- Average salaries across departments show minor gender-based variations, with departments like Sales and Finance offering slightly higher average pay. 
- Overall, both genders see an upward trend in salaries over time.

# **License:**
I uploaded this database from GitHub from this link [here](https://github.com/apburton84/datamysql/blob/master/employees.sql), I have known about this database from a course I have taken from 365datascience.com, The name of the course is SQL + Tableau course in this ink [here](https://learn.365datascience.com/courses/sql-tableau/introduction-to-software-integration/).


