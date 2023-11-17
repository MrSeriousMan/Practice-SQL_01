/*Ex1:Laptop vs. Mobile Viewership [New York Times SQL Interview Question]*/
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views, 
  SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views 
FROM viewership;

/*Ex2:Triangel judgement*/
select 
x,y,z,
case when (x+y) > z and (x+z) > y and (y+z) > x then 'Yes' else 'No' end as triangle
from Triangle 

/*Ex3:UnitedHealth Group*/
SELECT 
  ROUND(100.0 * 
    COUNT(case_id)/
      (SELECT COUNT(*) FROM callers),1) AS uncategorised_call_pct
FROM callers
WHERE call_category IS NULL 
  OR call_category = 'n/a';

/*Ex4:Customer Referee*/
select name
from Customer
where coalesce(referee_id,'') != 2

/*Ex5:The number of survivors*/
SELECT
    survived,
    sum(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    sum(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    sum(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY 
    survived
