/* EX1: Weather Observation Station 3 */
select distinct city from station where id%2=0;

/*EX2: Weather Observation Station 4 */
select count(city) - count(distinct city) from station;

/*EX3: The Blunder */
SELECT CEIL(AVG(salary) - AVG(REPLACE(salary, '0', ''))) 
AS salary_difference FROM EMPLOYEES;

/*EX4: Compressed Mean [Alibaba SQL Interview Question] */
SELECT 
  ROUND(
    SUM(item_count::DECIMAL*order_occurrences)
    /SUM(order_occurrences)
  ,1) AS mean
FROM items_per_order;

/*EX5: Data Science Skills [LinkedIn SQL Interview Question*/
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

/*EX6:Average Post Hiatus (Part 1) [Facebook SQL Interview Question] */
SELECT 
	user_id, 
    MAX(post_date::DATE) - MIN(post_date::DATE) AS days_between
FROM posts
WHERE DATE_PART('year', post_date::DATE) = 2021 
GROUP BY user_id
HAVING COUNT(post_id)>1;

/*EX7:Cards Issued Difference [JPMorgan Chase SQL Interview Question] */
SELECT 
  card_name, 
  MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

/*EX8: Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question] */
SELECT
  manufacturer,
  COUNT(drug) AS drug_count, 
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC;

/*EX9: NOT BORING MOVIES LEETCODE */
select id, movie, description, rating
from cinema
where id % 2 = 1
and description not in ('boring')
order by rating desc

/*EX10: NUMBER OF UNIQUE SUBJECTS TAUGHT BY TEACHER */
SELECT teacher_id,COUNT(DISTINCT subject_id) as cnt FROM Teacher
GROUP BY teacher_id;

/*EX11: FIND FOLLOWERS COUNT */
SELECT user_id, COUNT(*) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id

/*EX12: CLASSES MORE THAN 5 STUDENTS */
SELECT teacher_id,COUNT(DISTINCT subject_id) as cnt FROM Teacher
GROUP BY teacher_id;
