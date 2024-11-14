/*
- This query shows the count of female and male employees in the database from 1990.

- By running this query, you can generate a report showing the number of employees by gender for each year from 1990 onwards,
 facilitating a detailed analysis of the workforce dynamics over time.
*/

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

