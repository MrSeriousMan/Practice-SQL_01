/*Ex1:Average Population of Each Continent*/
SELECT country.continent, FLOOR(AVG(city.population))
FROM city
LEFT JOIN country ON country.code = city.countrycode
WHERE country.continent IS NOT NULL
GROUP BY country.continent

/*Ex2:Signup Activation Rate [TikTok SQL Interview Question]*/
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL
    /COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';

/*Ex3:Sending vs. Opening Snaps [Snapchat SQL Interview Question] */
SELECT age_bucket,
ROUND(100*SUM(CASE WHEN activity_type = 'send' THEN time_spent END)::decimal/SUM(CASE WHEN activity_type = 'send' or activity_type = 'open' THEN time_spent END)::decimal,2) AS send,
ROUND(100*SUM(CASE WHEN activity_type = 'open' THEN time_spent END)::decimal/SUM(CASE WHEN activity_type = 'send' or activity_type = 'open' THEN time_spent END)::decimal,2) AS open
FROM activities
JOIN age_breakdown
ON age_breakdown.user_id = activities.user_id
GROUP BY age_bucket

/*Ex4:Supercloud Customer [Microsoft SQL Interview Question]*/
SELECT cc.customer_id from customer_contracts as cc 
LEFT JOIN products as p  
on cc.product_id = p.product_id
group by cc.customer_id
having COUNT(DISTINCT(p.product_category)) = (select COUNT(Distinct(product_category)) from products)

/*Ex5:the-number-of-employees-which-report-to-each-employee*/
select e2.employee_id,e2.name, count(e2.employee_id) as reports_count, round(avg(e1.age *1.00),0) as average_age
from employees e1
inner join employees e2 on e1.reports_to = e2.employee_id
group by  e2.employee_id,e2.name
order by e2.employee_id as

/*Ex6:leetcode.com/problems/list-the-products-ordered-in-a-period*/
# Write your MySQL query statement below
SELECT P.PRODUCT_NAME,SUM(O.UNIT) AS UNIT FROM PRODUCTS P,ORDERS O 
WHERE P.PRODUCT_ID = O.PRODUCT_ID AND O.ORDER_DATE BETWEEN '2020-02-01' AND '2020-02-29' 
GROUP BY O.PRODUCT_ID 
HAVING UNIT >= 100 
ORDER BY O.PRODUCT_ID;

/*Ex7:Page With No Likes [Facebook SQL Interview Question]*/
SELECT t1.page_id
FROM pages AS t1
WHERE t1.page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY t1.page_id ASC;

---------------------------------------------------Mid course test---------------------------------------------------------------
/*Ex1:Topic: DISTINCT
Task: Tạo danh sách tất cả chi phí thay thế (replacement costs )  khác nhau của các film.
Question: Chi phí thay thế thấp nhất là bao nhiêu? */
-- Tạo danh sách tất cả các chi phí thay thế khác nhau của các film

SELECT DISTINCT replacement_cost
FROM films;

-- Tìm chi phí thay thế thấp nhất
SELECT MIN(replacement_cost) AS lowest_replacement_cost
FROM films;

/*Ex2:Topic: CASE + GROUP BY
Task: Viết một truy vấn cung cấp cái nhìn tổng quan về số lượng phim có chi phí thay thế trong các phạm vi chi phí sau
1.	low: 9.99 - 19.99
2.	medium: 20.00 - 24.99
3.	high: 25.00 - 29.99
Question: Có bao nhiêu phim có chi phí thay thế thuộc nhóm “low”? */

SELECT 
    CASE
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
        WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
        ELSE 'other'
    END AS cost_group,
    COUNT(*) AS movie_count
FROM 
    film
GROUP BY 
    cost_group

/*Ex3:Topic: JOIN
Task: Tạo danh sách các film_title  bao gồm tiêu đề (title), độ dài (length) và tên danh mục (category_name) được sắp xếp theo độ dài giảm dần. Lọc kết quả để chỉ các phim trong danh mục 'Drama' hoặc 'Sports'.
Question: Phim dài nhất thuộc thể loại nào và dài bao nhiêu? */

  SELECT
    film.title AS film_title,
    film.length AS length,
    category.name AS category_name
FROM
    film
JOIN
    film_category ON film.film_id = film_category.film_id
JOIN
    category ON film_category.category_id = category.category_id
WHERE
    category.name IN ('Drama', 'Sports')
ORDER BY
    film.length DESC
LIMIT 1;

/*Ex4: Topic: JOIN & GROUP BY
Task: Đưa ra cái nhìn tổng quan về số lượng phim (tilte) trong mỗi danh mục (category).
Question:Thể loại danh mục nào là phổ biến nhất trong số các bộ phim? */
SELECT
    category.name AS category_name,
    COUNT(film.title) AS movie_count
FROM
    category
LEFT JOIN
    film_category ON category.category_id = film_category.category_id
LEFT JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name
ORDER BY
    movie_count DESC
LIMIT 1;

/*Ex5:*/
SELECT
    actor.first_name AS first_name,
    actor.last_name AS last_name,
    COUNT(film_actor.film_id) AS movie_count
FROM
    actor
LEFT JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY
    actor.first_name, actor.last_name
ORDER BY
    movie_count DESC
LIMIT 1;

/*Ex6:*/
SELECT
    address.address_id,
    address.address
FROM
    address
LEFT JOIN
    customer ON address.address_id = customer.address_id
WHERE
    customer.address_id IS NULL;


/*Ex7:*/
SELECT
    city.city,
    SUM(payment.amount) AS total_revenue
FROM
    city
JOIN
    address ON city.city_id = address.city_id
JOIN
    customer ON address.address_id = customer.address_id
JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY
    city.city
ORDER BY
    total_revenue DESC
LIMIT 1;

/*Ex8:*/
SELECT
    CONCAT(city.city, ', ', country.country) AS city_country,
    SUM(payment.amount) AS total_revenue
FROM
    city
JOIN
    country ON city.country_id = country.country_id
JOIN
    address ON city.city_id = address.city_id
JOIN
    customer ON address.address_id = customer.address_id
JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY
    city.city, country.country
ORDER BY
    total_revenue ASC
LIMIT 1;







