/*
- This query shows the averge salary of female and male managers per department from 2002.
*/

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

