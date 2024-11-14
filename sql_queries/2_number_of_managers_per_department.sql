/*
- This query shows the count of female and male managers per department from 1990.
*/

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
