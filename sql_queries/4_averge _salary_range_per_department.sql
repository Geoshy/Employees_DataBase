/*
- This query shows the averge salary of female and male managers per department,
where employees salary from 50000 to 90000.
*/

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
