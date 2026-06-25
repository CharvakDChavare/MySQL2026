
mysql> SELECT * FROM employees;
+--------+----------+------------+--------------+----------+------------+------------+
| emp_id | emp_name | department | job_title    | salary   | hire_date  | manager_id |
+--------+----------+------------+--------------+----------+------------+------------+
|      1 | Aarav    | IT         | Developer    | 75000.00 | 2021-04-12 |          8 |
|      2 | Priya    | HR         | HR Executive | 48000.00 | 2020-08-19 |          9 |
|      3 | Rohan    | IT         | Tester       | 52000.00 | 2022-01-15 |          8 |
|      4 | Sneha    | Sales      | Sales Exec   | 45000.00 | 2021-11-10 |         10 |
|      5 | Vikram   | Finance    | Analyst      | 68000.00 | 2019-06-25 |         11 |
|      6 | Neha     | IT         | Developer    | 82000.00 | 2018-03-14 |          8 |
|      7 | Karan    | Sales      | Manager      | 90000.00 | 2017-09-01 |       NULL |
|      8 | Meera    | IT         | Team Lead    | 95000.00 | 2016-05-30 |       NULL |
|      9 | Rahul    | HR         | Manager      | 78000.00 | 2015-12-11 |       NULL |
|     10 | Pooja    | Sales      | Sales Head   | 88000.00 | 2016-07-22 |       NULL |
|     11 | Amit     | Finance    | Manager      | 91000.00 | 2014-10-05 |       NULL |
|     12 | Divya    | Finance    | Accountant   | 54000.00 | 2023-02-18 |         11 |
+--------+----------+------------+--------------+----------+------------+------------+
12 rows in set (0.00 sec)

mysql> SELECT *
    -> FROM employees
    -> WHERE salary > (SELECT AVG(salary) FROM employees);
+--------+----------+------------+------------+----------+------------+------------+
| emp_id | emp_name | department | job_title  | salary   | hire_date  | manager_id |
+--------+----------+------------+------------+----------+------------+------------+
|      1 | Aarav    | IT         | Developer  | 75000.00 | 2021-04-12 |          8 |
|      6 | Neha     | IT         | Developer  | 82000.00 | 2018-03-14 |          8 |
|      7 | Karan    | Sales      | Manager    | 90000.00 | 2017-09-01 |       NULL |
|      8 | Meera    | IT         | Team Lead  | 95000.00 | 2016-05-30 |       NULL |
|      9 | Rahul    | HR         | Manager    | 78000.00 | 2015-12-11 |       NULL |
|     10 | Pooja    | Sales      | Sales Head | 88000.00 | 2016-07-22 |       NULL |
|     11 | Amit     | Finance    | Manager    | 91000.00 | 2014-10-05 |       NULL |
+--------+----------+------------+------------+----------+------------+------------+
7 rows in set (0.00 sec)


mysql> SELECT *
    -> FROM employees e
    -> WHERE salary > (SELECT AVG(salary) FROM employees WHERE department = e.department);
+--------+----------+------------+------------+----------+------------+------------+
| emp_id | emp_name | department | job_title  | salary   | hire_date  | manager_id |
+--------+----------+------------+------------+----------+------------+------------+
|      6 | Neha     | IT         | Developer  | 82000.00 | 2018-03-14 |          8 |
|      7 | Karan    | Sales      | Manager    | 90000.00 | 2017-09-01 |       NULL |
|      8 | Meera    | IT         | Team Lead  | 95000.00 | 2016-05-30 |       NULL |
|      9 | Rahul    | HR         | Manager    | 78000.00 | 2015-12-11 |       NULL |
|     10 | Pooja    | Sales      | Sales Head | 88000.00 | 2016-07-22 |       NULL |
|     11 | Amit     | Finance    | Manager    | 91000.00 | 2014-10-05 |       NULL |
+--------+----------+------------+------------+----------+------------+------------+
6 rows in set (0.00 sec)

mysql> WITH dept_avg AS (SELECT department , AVG(salary) AS avg_salary FROM employees GROUP BY department )
    -> SELECT * FROM dept_avg;
+------------+--------------+
| department | avg_salary   |
+------------+--------------+
| IT         | 76000.000000 |
| HR         | 63000.000000 |
| Sales      | 74333.333333 |
| Finance    | 71000.000000 |
+------------+--------------+
4 rows in set (0.00 sec)


mysql> WITH dept_avg AS (SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department)
    -> SELECT e.emp_id, e.emp_name, e.department, e.salary, d.avg_salary
    -> FROM employees e
    -> JOIN dept_avg d
    -> ON e.department = d.department
    -> WHERE e.salary > d.avg_salary;
+--------+----------+------------+----------+--------------+
| emp_id | emp_name | department | salary   | avg_salary   |
+--------+----------+------------+----------+--------------+
|      6 | Neha     | IT         | 82000.00 | 76000.000000 |
|      7 | Karan    | Sales      | 90000.00 | 74333.333333 |
|      8 | Meera    | IT         | 95000.00 | 76000.000000 |
|      9 | Rahul    | HR         | 78000.00 | 63000.000000 |
|     10 | Pooja    | Sales      | 88000.00 | 74333.333333 |
|     11 | Amit     | Finance    | 91000.00 | 71000.000000 |
+--------+----------+------------+----------+--------------+
6 rows in set (0.00 sec)

WITH rank_by_salary AS (SELECT emp_id, emp_name, salary FROM employees ORDER BY salary ASC)
    -> SELECT *
    -> FROM rank_by_salary;
+--------+----------+----------+
| emp_id | emp_name | salary   |
+--------+----------+----------+
|      4 | Sneha    | 45000.00 |
|      2 | Priya    | 48000.00 |
|      3 | Rohan    | 52000.00 |
|     12 | Divya    | 54000.00 |
|      5 | Vikram   | 68000.00 |
|      1 | Aarav    | 75000.00 |
|      9 | Rahul    | 78000.00 |
|      6 | Neha     | 82000.00 |
|     10 | Pooja    | 88000.00 |
|      7 | Karan    | 90000.00 |
|     11 | Amit     | 91000.00 |
|      8 | Meera    | 95000.00 |
+--------+----------+----------+
12 rows in set (0.00 sec)

WITH rank_by_salary AS (SELECT emp_id, emp_name, salary FROM employees ORDER BY salary DESC)
    -> SELECT *
    -> FROM rank_by_salary;
+--------+----------+----------+
| emp_id | emp_name | salary   |
+--------+----------+----------+
|      8 | Meera    | 95000.00 |
|     11 | Amit     | 91000.00 |
|      7 | Karan    | 90000.00 |
|     10 | Pooja    | 88000.00 |
|      6 | Neha     | 82000.00 |
|      9 | Rahul    | 78000.00 |
|      1 | Aarav    | 75000.00 |
|      5 | Vikram   | 68000.00 |
|     12 | Divya    | 54000.00 |
|      3 | Rohan    | 52000.00 |
|      2 | Priya    | 48000.00 |
|      4 | Sneha    | 45000.00 |
+--------+----------+----------+
12 rows in set (0.00 sec)

SELECT emp_id, emp_name, salary,
    -> CASE
    -> WHEN salary <= 50000 THEN 'LOW'
    -> WHEN salary <= 80000 THEN 'MIDIUM'
    -> WHEN salary >80000 THEN 'HIGH'
    -> END AS classify_salary
    -> FROM employees;
+--------+----------+----------+-----------------+
| emp_id | emp_name | salary   | classify_salary |
+--------+----------+----------+-----------------+
|      1 | Aarav    | 75000.00 | MIDIUM          |
|      2 | Priya    | 48000.00 | LOW             |
|      3 | Rohan    | 52000.00 | MIDIUM          |
|      4 | Sneha    | 45000.00 | LOW             |
|      5 | Vikram   | 68000.00 | MIDIUM          |
|      6 | Neha     | 82000.00 | HIGH            |
|      7 | Karan    | 90000.00 | HIGH            |
|      8 | Meera    | 95000.00 | HIGH            |
|      9 | Rahul    | 78000.00 | MIDIUM          |
|     10 | Pooja    | 88000.00 | HIGH            |
|     11 | Amit     | 91000.00 | HIGH            |
|     12 | Divya    | 54000.00 | MIDIUM          |
+--------+----------+----------+-----------------+
12 rows in set (0.00 sec)

 SELECT emp_id, emp_name,
    -> CASE
    -> WHEN hire_date <= '2019-12-31' THEN 'Senior'
    -> ELSE 'Junior'
    -> END AS experience_lavel
    -> FROM employees;
+--------+----------+------------------+
| emp_id | emp_name | experience_lavel |
+--------+----------+------------------+
|      1 | Aarav    | Junior           |
|      2 | Priya    | Junior           |
|      3 | Rohan    | Junior           |
|      4 | Sneha    | Junior           |
|      5 | Vikram   | Senior           |
|      6 | Neha     | Senior           |
|      7 | Karan    | Senior           |
|      8 | Meera    | Senior           |
|      9 | Rahul    | Senior           |
|     10 | Pooja    | Senior           |
|     11 | Amit     | Senior           |
|     12 | Divya    | Junior           |
+--------+----------+------------------+
12 rows in set (0.00 sec)

SELECT
    -> CASE
    -> WHEN salary <= 50000 THEN 'LOW'
    -> WHEN salary <= 80000 THEN 'MIDIUM'
    -> ELSE 'HIGH'
    -> END AS classify_salary,
    -> COUNT(*) AS total_employees
    -> FROM employees
    -> GROUP BY
    -> CASE
    -> WHEN salary <= 50000 THEN 'LOW'
    -> WHEN salary <= 80000 THEN 'MIDIUM'
    -> ELSE 'HIGH'
    -> END;
+-----------------+-----------------+
| classify_salary | total_employees |
+-----------------+-----------------+
| MIDIUM          |               5 |
| LOW             |               2 |
| HIGH            |               5 |
+-----------------+-----------------+
3 rows in set (0.00 sec)
