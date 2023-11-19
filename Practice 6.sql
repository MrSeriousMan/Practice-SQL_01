/*Ex1:Duplicate Job Listings [Linkedin SQL Interview Question] */
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;      

/*Ex4: Page With No Likes [Facebook SQL Interview Question]*/
SELECT page_id
FROM pages
WHERE PAGE_ID NOT IN (
		SELECT page_id
		FROM page_likes
		)
ORDER BY page_id ASC;

/*Ex5: */

/*Ex6: */

/*Ex7: */

/*Ex8: */

/*Ex9: */

/*Ex10: */

/*Ex11: */

/*Ex12: */
