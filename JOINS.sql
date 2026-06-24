mysql> SELECT * FROM employess;
+--------+-------+---------+
| emp_id | name  | dept_id |
+--------+-------+---------+
|      1 | Asha  |      10 |
|      2 | Rohan |      20 |
|      3 | Neha  |    NULL |
|      4 | Karan |      40 |
+--------+-------+---------+
4 rows in set (0.02 sec)

mysql> SELECT * FROM departments;
+--------+-----------+
| dep_id | dept_name |
+--------+-----------+
|     10 | HR        |
|     20 | IT        |
|     30 | FINANCE   |
|     40 | SALES     |
+--------+-----------+
4 rows in set (0.02 sec)


mysql> SELECT *
    -> FROM employess e
    -> INNER JOIN departments d
    -> ON e.dept_id = d.dep_id;
+--------+-------+---------+--------+-----------+
| emp_id | name  | dept_id | dep_id | dept_name |
+--------+-------+---------+--------+-----------+
|      1 | Asha  |      10 |     10 | HR        |
|      2 | Rohan |      20 |     20 | IT        |
|      4 | Karan |      40 |     40 | SALES     |
+--------+-------+---------+--------+-----------+
3 rows in set (0.00 sec)

mysql> SELECT emp_id
    -> FROM employess e
    -> INNER JOIN departments d
    -> ON e.dept_id = d.dep_id;
+--------+
| emp_id |
+--------+
|      1 |
|      2 |
|      4 |
+--------+
3 rows in set (0.00 sec)


mysql> SELECT *
    -> FROM employess e
    -> LEFT JOIN departments d
    -> ON e.dept_id = d.dep_id;
+--------+-------+---------+--------+-----------+
| emp_id | name  | dept_id | dep_id | dept_name |
+--------+-------+---------+--------+-----------+
|      1 | Asha  |      10 |     10 | HR        |
|      2 | Rohan |      20 |     20 | IT        |
|      3 | Neha  |    NULL |   NULL | NULL      |
|      4 | Karan |      40 |     40 | SALES     |
+--------+-------+---------+--------+-----------+
4 rows in set (0.00 sec)

mysql> SELECT name
    -> FROM employess e
    -> LEFT JOIN departments d
    -> ON e.dept_id = dep_id;
+-------+
| name  |
+-------+
| Asha  |
| Rohan |
| Neha  |
| Karan |
+-------+
4 rows in set (0.00 sec)


mysql> SELECT *
    -> FROM employess e
    -> RIGHT JOIN departments d
    -> ON e.dept_id = dep_id;
+--------+-------+---------+--------+-----------+
| emp_id | name  | dept_id | dep_id | dept_name |
+--------+-------+---------+--------+-----------+
|      1 | Asha  |      10 |     10 | HR        |
|      2 | Rohan |      20 |     20 | IT        |
|   NULL | NULL  |    NULL |     30 | FINANCE   |
|      4 | Karan |      40 |     40 | SALES     |
+--------+-------+---------+--------+-----------+
4 rows in set (0.00 sec)
