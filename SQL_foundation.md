JOINS
INNER JOIN: only rows that match in both tables.

LEFT JOIN: all rows from left table; matching rows from right or NULL for no match.

RIGHT JOIN: all rows from right table; matching rows from left or NULL for no match.

NULL join keys (e.g., Neha’s dept_id NULL) never match equality in JOIN conditions.

To avoid duplicate column names in results, select specific columns (e.g., e.emp_id, e.name, d.dept_name) rather than SELECT *.


CTE and CASE WHEN 

A Common Table Expression (CTE) is a temporary named result set defined using WITH that you can reference within a single SQL statement to simplify, modularize, or reuse complex subqueries.

CASE WHEN is an expression that evaluates conditions in order and returns a value for the first true condition (like if-then-else) and is used to produce conditional columns, bucket values, or drive conditional logic inside SELECT, ORDER BY, WHERE, HAVING, and other clauses.

What a CTE does and when to use it

Definition: A CTE is declared at the start of a statement with WITH name AS (subquery) and exists only for that single statement; it behaves like a temporary, named table or derived table.

Benefits: improves readability for long/complex queries, lets you break a problem into steps, allows reusing the same intermediate result multiple times, and enables recursive queries (e.g., hierarchical/graph traversals).

Typical uses: replacing nested subqueries for clarity, preparing aggregated or windowed results to be joined later, or implementing recursion (WITH RECURSIVE) for bill-of-materials, org charts, paths.

Example pattern:
WITH step1 AS ( ... ), step2 AS (SELECT ... FROM step1 ...) SELECT ... FROM step2;

Notes: CTEs are not persisted; performance can be similar to equivalent derived tables but optimizer behavior may vary by database, so test with large datasets.

How CASE WHEN works and common uses

Definition: CASE evaluates WHEN conditions in order and returns the corresponding THEN value for the first true condition; if none match, the ELSE value is returned (or NULL if ELSE omitted).

Syntax forms:

Simple CASE: compares an expression to values (CASE expr WHEN val1 THEN ... WHEN val2 THEN ... ELSE ... END).

Searched CASE: evaluates boolean conditions (CASE WHEN cond1 THEN ... WHEN cond2 THEN ... ELSE ... END).

Typical uses: create categorical buckets (salary ranges, risk levels), conditional transformations (normalize formats), compute derived columns, and implement conditional aggregation in SELECT or HAVING.

Example usage: SELECT emp_id, salary, CASE WHEN salary <= 50000 THEN 'LOW' WHEN salary <= 80000 THEN 'MEDIUM' ELSE 'HIGH' END AS salary_band FROM employees;

Notes: CASE returns a single scalar value per row; it is not control flow for selecting which query runs — use application logic, stored-procedure IF, or dynamic SQL for branching full-query execution.

Short comparisons and tips

CTE vs derived table: both create temporary result sets; CTEs improve readability and can be recursive; derived tables are inline subqueries.

CASE vs IF: CASE is standard SQL and usable inside expressions; some databases provide IF() as a nonstandard expression but CASE is portable.

Performance tip: For complex transformations, push filtering/aggregation into the CTE to reduce rows early; for very large intermediate results, compare query plans because some engines materialize CTEs while others inline them.

One concise example combining both (illustrative)

Use a CTE to compute department averages, then use CASE to label each employee relative to that average:
WITH dept_avg AS (SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department)
SELECT e.emp_id, e.emp_name, e.salary,
CASE WHEN e.salary < d.avg_salary THEN 'Below Avg' WHEN e.salary = d.avg_salary THEN 'At Avg' ELSE 'Above Avg' END AS cmp_to_dept
FROM employees e JOIN dept_avg d ON e.department = d.department;
