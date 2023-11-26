/*Ex1:datalemur-yoy-growth-rate. */
with cte as (
SELECT extract(year from transaction_date) as year,product_id,spend as curr_year_spend,
lag(spend) over(partition by product_id order by transaction_date) as prev_year_spend

from user_transactions)

select *,round(100.0*(curr_year_spend-prev_year_spend)/prev_year_spend,2) as yoy_rate
from cte;

/*Ex2:datalemur-card-launch-success.*/
SELECT DISTINCT
  card_name,
  FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month)
  AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC

/*Ex3: datalemur-third-transaction.*/
SELECT user_id, spend, transaction_date
FROM 
  (SELECT user_id, 
         spend,
         transaction_date, 
         ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS row_nbr
  FROM transactions) AS transactions
WHERE row_nbr = 3;

/*Ex4:datalemur-histogram-users-purchases.*/
SELECT transaction_date,user_id,COUNT(transaction_date) purchase_count
FROM(SELECT *,
    RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC)
    FROM user_transactions
    ORDER BY user_id,transaction_date DESC) a
WHERE rank = 1
GROUP BY user_id,transaction_date
ORDER BY transaction_date

/*Ex5:datalemur-rolling-average-tweets.*/
SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;

/*Ex6:datalemur-repeated-payments.*/
SELECT COUNT(*) AS payment_count
from ( 
  SELECT merchant_id, credit_card_id, amount, transaction_timestamp -
    LAG(transaction_timestamp,1) OVER(PARTITION BY merchant_id, credit_card_id, amount
    ORDER BY transaction_timestamp) as NEXT_TRANS
  FROM TRANSACTIONS
  ORDER BY merchant_id, credit_card_id, amount
) AS S1
WHERE EXTRACT(MINUTE FROM NEXT_TRANS) < 10

/*Ex7:datalemur-highest-grossing.*/
WITH t1 AS (
SELECT category,
       product,
       SUM(spend) AS total_spend,
       RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as s_no
FROM product_spend
WHERE EXTRACT('YEAR' FROM transaction_date) = 2022
GROUP BY category, product
ORDER BY category, SUM(spend) DESC)

SELECT category, product, total_spend
FROM t1
WHERE s_no <= 2;

/*Ex8:datalemur-top-fans-rank.*/
WITH CTE AS(SELECT a.artist_id,artist_name,b.song_id,c.rank,c.day FROM artists a 
    INNER JOIN songs b ON a.artist_id = b.artist_id 
    INNER JOIN global_song_rank AS c ON b.song_id = c.song_id),
CTE1 AS (select artist_name,dense_rank() over(order by artist_rank DESC) as artist_rank from(
  select artist_name,SUM(CASE WHEN rank <=10 THEN 1 ELSE 0 END) 
  as artist_rank from CTE group by artist_name) F)
select * from CTE1 where artist_rank <=5;
