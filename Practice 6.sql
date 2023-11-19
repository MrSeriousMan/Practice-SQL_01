/*Ex1:Duplicate Job Listings [Linkedin SQL Interview Question] */
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;      

/*Ex4: Page With No Likes [Facebook SQL Interview Question]*/
SELECT page_id
FROM pages
WHERE PAGE_ID NOT IN (
		SELECT page_id
		FROM page_likes
		)
ORDER BY page_id ASC;

/*Ex5:Active User Retention [Facebook SQL Interview Question] */
SELECT
  7 as month,
  COUNT(1) AS monthly_active_users
FROM (SELECT
        user_id
      FROM user_actions
      WHERE EXTRACT(MONTH FROM event_date) >= 6
      GROUP BY user_id
      HAVING COUNT(DISTINCT TO_CHAR(event_date, 'MM/YYYY')) = 2) sq

/*Ex6:leetcode.com/problems/monthly-transactions */
SELECT DATE_FORMAT(trans_date, '%Y-%m') 
AS month,
       country,
       COUNT(id) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;

/*Ex7:leetcode.com/problems/product-sales-analysis-iii */
SELECT product_id, year AS first_year, quantity, price 
FROM sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year) 
    FROM sales 
    GROUP BY product_id
);

/*Ex8:leetcode.com/problems/customers-who-bought-all-products */
SELECT  customer_id FROM Customer GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) FROM Product)

/*Ex9: leetcode.com/problems/employees-whose-manager-left-the-company */
SELECT e.employee_id 
FROM Employees e 
WHERE e.salary < 30000 AND e.manager_id NOT IN (
    SELECT m.employee_id 
    FROM Employees m)
GROUP BY e.employee_id 
ORDER BY e.employee_id

/*Ex10: Duplicate Job Listings [Linkedin SQL Interview Question] */
WITH employee2 AS
(SELECT employee_id, count(department_id)
FROM employee
GROUP BY employee_id
HAVING count(Department_id)=1)

SELECT employee_id, department_id
FROM employee
WHERE primary_flag='Y'
OR
employee_id IN 
(SELECT employee_id
FROM employee2)

/*Ex11: */

/*Ex12: */
