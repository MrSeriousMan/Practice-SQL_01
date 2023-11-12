      /*ex1: hackerank-revising-the-select-query */
      SELECT NAME FROM CITY 
      WHERE POPULATION >120000 AND COUNTRYCODE="USA";
      
      /*ex2: hackerank-japanese-cities-attributes */
      SELECT * FROM CITY
      WHERE COUNTRYCODE = "JPN";
      
      /*ex3: hackerank-weather-observation-station-1. */
      SELECT CITY, STATE FROM STATION;
      
      /*ex4: hackerank-weather-observation-station-6. */
      SELECT DISTINCT (city) FROM station
      WHERE LEFT(city,1) IN ('a','e','i','o','u')
        
      /* ex5: hackerank-weather-observation-station-7. */
      SELECT DISTINCT (city) FROM station 
      WHERE RIGHT(city,1) IN ('a','e','i','o','u')

      /* ex6: hackerank-weather-observation-station-9. */
      SELECT DISTINCT CITY FROM STATION
      WHERE LOWER(SUBSTRING(CITY, 1, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');

      /* ex7: hackerank-name-of-employees. */
      SELECT NAME FROM EMPLOYEE 
      ORDER BY NAME ASC;

      /*ex8: hackerank-salary-of-employees.*/
      SELECT NAME FROM EMPLOYEE
      WHERE SALARY > 2000 AND MONTHS < 10;

      /*ex9: leetcode-recyclable-and-low-fat-products.*/
      SELECT product_id FROM Products 
      WHERE low_fats='y' AND recyclable='y';

      /* ex10: leetcode-find-customer-referee. */
      select name from Customer
      where coalesce(referee_id,'') != 2
        
      /*ex11: leetcode-big-countries.*/
      select name, population, area from world
      where area >= 3000000 or population >= 25000000
      order by name asc
        
     /* ex12: leetcode-article-views.*/
      select distinct author_id as id from Views
      where author_id = viewer_id
      order by id;

      /*ex13: datalemur-tesla-unfinished-part.*/
      SELECT part, assembly_step FROM parts_assembly
      WHERE finish_date IS NULL;

      /*ex14: datalemur-lyft-driver-wages.*/
      select * from lyft_drivers 
      where yearly_salary<=30000 or yearly_salary>=70000;

      /*ex15: datalemur-find-the-advertising-channel.*/
      select distinct  advertising_channel from uber_advertising
      where money_spent >= 100000 and year ='2019'
