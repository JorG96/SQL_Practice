/*
There are many employees at your company, with a wide range of salaries. You've decided to find out the difference in salary between the employees who make the most and the employees who make the least.

You store information about your employees in the table employees, which has the structure:

id: the unique employee ID;
name: the employee's name;
salary: the employee's salary - a positive integer.
The difference between the sum of the highest salaries and the sum of lowest salaries will give you the information you want. So, given the table employees, write a select statement as follows: The table should contain only one column salary_diff and only one row, which will contain the difference between sum of the highest and the sum of lowest salaries. If employees table is empty, the difference should be equal 0.

Example

For the following table employees

id	name	salary
1	John	1200
2	Bill	1000
3	Mike	1300
4	Katy	1200
5	Brendon	1300
6	Amanda	900
the output should be

salary_diff
1700
There are two highest salaries (1300) and one lowest salary (900). 1300 * 2 - 900 * 1 = 1700.
*/

CREATE PROCEDURE salaryDifference()
BEGIN
	/* Write your SQL here. Terminate each statement with a semicolon. */
   SELECT IFNULL((
   
   SELECT(
    SELECT SUM(salary) FROM employees
        GROUP BY salary
        ORDER BY salary DESC LIMIT 1)-
    
    (SELECT SUM(salary) FROM employees
        GROUP BY salary
        ORDER BY salary ASC LIMIT 1) AS temp
        FROM employees
        LIMIT 1
   ),0) AS difference
    ;
END