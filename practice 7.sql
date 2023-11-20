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

/*Ex4:datalemur-histogram-users-purchases.*/

/*Ex5:datalemur-rolling-average-tweets.*/

/*Ex6:datalemur-repeated-payments.*/

/*Ex7:datalemur-highest-grossing.*/

/*Ex8:datalemur-top-fans-rank.*/

