/*EX1: 1174. Immediate Food Delivery II*/
SELECT 
    ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT customer_id), 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
);

/*EX2:550. Game Play Analysis IV*/
SELECT ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM Activity),2) as fraction 
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) IN 
(
    SELECT player_id, MIN(event_date) as first_login FROM Activity GROUP BY player_id
)

/*EX3:626. Exchange Seats*/
# Write your MySQL query statement below

SELECT CASE
           WHEN s.id % 2 != 0 AND s.id = (SELECT COUNT(*) FROM Seat) THEN s.id
           WHEN s.id % 2 = 0 THEN s.id - 1
           ELSE
               s.id + 1
           END AS id,
       student
FROM Seat AS s
ORDER BY id

/*EX4:1321. Restaurant Growth*/
SELECT
    visited_on,
    (
        SELECT SUM(amount)
        FROM customer
        WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
    ) AS amount,
    ROUND(
        (
            SELECT SUM(amount) / 7
            FROM customer
            WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
        ),
        2
    ) AS average_amount
FROM customer c
WHERE visited_on >= (
        SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY)
        FROM customer
    )
GROUP BY visited_on;

/*EX5:585. Investments in 2016*/
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM insurance
WHERE tiv_2015 IN 
    (SELECT tiv_2015 FROM insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1)
AND (lat, lon) IN 
    (  SELECT lat, lon FROM insurance GROUP BY lat, lon HAVING COUNT(*) = 1)

/*EX6:185. Department Top Three Salaries*/
SELECT dep.name AS Department, emp.name AS Employee, salary AS Salary
FROM Employee emp 
INNER JOIN Department dep ON dep.id = emp.departmentId
WHERE 4 > (SELECT COUNT(DISTINCT salary) 
           FROM Employee empdup
           WHERE empdup.departmentId = emp.departmentId
           AND emp.salary <= empdup.salary
          );

/*EX7:*/
SELECT 
    q1.person_name
FROM Queue q1 JOIN Queue q2 ON q1.turn >= q2.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY SUM(q2.weight) DESC
LIMIT 1

/*EX8:*/

WITH cte AS
(SELECT *, RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS r 
FROM Products
WHERE change_date<= '2019-08-16')

SELECT product_id, new_price AS price
FROM cte
WHERE r = 1
UNION
SELECT product_id, 10 AS price
FROM Products
WHERE product_id NOT IN (SELECT product_id FROM cte)
