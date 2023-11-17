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

/*Ex5:*/
