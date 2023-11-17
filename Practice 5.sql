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
