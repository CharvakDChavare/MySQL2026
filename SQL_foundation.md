JOINS
INNER JOIN: only rows that match in both tables.

LEFT JOIN: all rows from left table; matching rows from right or NULL for no match.

RIGHT JOIN: all rows from right table; matching rows from left or NULL for no match.

NULL join keys (e.g., Neha’s dept_id NULL) never match equality in JOIN conditions.

To avoid duplicate column names in results, select specific columns (e.g., e.emp_id, e.name, d.dept_name) rather than SELECT *.
