/*Ex1:Higher Than 75 Marks*/
SELECT name FROM students
WHERE marks > 75
ORDER BY RIGHT(name, 3), id

/*Ex2: Fix name in table*/
select user_id , concat(upper(substr(name, 1,1)), lower(substr(name,2)))as name 
from users order by user_id

/*Ex3:Pharmacy Analytics (Part 3) [CVS Health SQL Interview Question] */
WITH drug_sales AS (
  SELECT 
    manufacturer, 
    SUM(total_sales) as sales 
  FROM pharmacy_sales 
  GROUP BY manufacturer
) 

SELECT 
  manufacturer, 
  ('$' || ROUND(sales / 1000000) || ' million') AS sales_mil 
FROM drug_sales 
ORDER BY sales DESC, manufacturer;

/*Ex4:Average Review Ratings [Amazon SQL Interview Question]*/
SELECT EXTRACT(Month from submit_date)as month, product_id, ROUND(AVG(stars),2)
FROM reviews
GROUP BY 1,2
ORDER BY 1,2;

/*Ex5:Teams Power Users [Microsoft SQL Interview Question]*/
SELECT 
  sender_id,
  COUNT(sent_date) AS message_count
FROM messages
WHERE sent_date BETWEEN '2022-08-01' AND '2022-08-31'
GROUP BY sender_id 
ORDER BY message_count DESC
LIMIT 2

/*Ex6:invalid-tweets*/
select tweet_id  from Tweets 
where length(content)>15

/*Ex7:leetcode.com/problems/user-activity-for-the-past-30-days-*/
SELECT activity_date as day, COUNT(DISTINCT user_id)
AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27',   INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;

/*Ex8:Number of Hires During Specific Time Period*/
SELECT
COUNT(employee_id) as number_employee
FROM employees
WHERE extract(month FROM joining date) BETWEEN 1 AND 7
abd extract(year from joining_date)=2022

/*Ex9:Positions of letter "a"*/
select 
position('a' in first_time) as position
from worker 
where first_name="Amitah"

/*Ex10:Macedonian Vintages*/
select substring(title, length(winery)+2,4)
from winemag_p2
where country="Macedonia"

