SELECT *
FROM Top200RichestPersonintheWorld;

-- 1. Retrieve the 20 richest billionaires
SELECT
		rank,
        name,
        age,
        networth_billion,
        industry
FROM Top200RichestPersonintheWorld
LIMIT 20;

-- 2. Identify the five youngest billionaires
SELECT `rank`,
       name,
       age,
       country,
       networth_billion,
       industry
FROM Top200RichestPersonintheWorld
ORDER BY CAST(age AS UNSIGNED) ASC
LIMIT 5;

-- 3. Calculate the average age and average net worth
SELECT ROUND(AVG(CAST(age AS UNSIGNED)), 2) AS average_age,
       ROUND(AVG(networth_billion), 2) AS average_networth_billion
FROM Top200RichestPersonintheWorld;

-- 4. Identify the five most represented countries
SELECT country,
       COUNT(*) AS number_of_billionaires
FROM Top200RichestPersonintheWorld
GROUP BY country
ORDER BY number_of_billionaires DESC
LIMIT 5;

-- 5. Calculate the combined net worth of billionaires from each country
SELECT country,
       ROUND(SUM(networth_billion), 2) AS combined_networth_billion
FROM Top200RichestPersonintheWorld
GROUP BY country
ORDER BY combined_networth_billion DESC;

-- 6. Identify the five industries with the highest number of billionaires
SELECT industry,
	   COUNT(*) AS number_of_billionaires
FROM Top200RichestPersonintheWorld
GROUP BY industry
ORDER BY number_of_billionaires DESC
LIMIT 5;
	   
-- 7. Find countries with at least five billionaires
SELECT country,
	   COUNT(*) AS number_of_billionaires
FROM Top200RichestPersonintheWorld
GROUP BY country
HAVING COUNT(*) >=5
ORDER BY number_of_billionaires DESC

-- 8. Calculate total wealth of billionaires younger than 50
SELECT ROUND(SUM(networth_billion), 2) AS total_wealth_billion
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) < 50;

-- 9. Identify billionaires whose net worth exceeds the overall average net worth
SELECT name,
       age,
       country,
       networth_billion
FROM Top200RichestPersonintheWorld
WHERE networth_billion > (
    SELECT AVG(networth_billion)
    FROM Top200RichestPersonintheWorld
)
ORDER BY networth_billion DESC;

-- 10. Identify the industry with the highest average net worth
SELECT industry,
ROUND(AVG(networth_billion), 2) AS average_networth_billion
FROM Top200RichestPersonintheWorld
GROUP BY industry
ORDER BY average_networth_billion DESC
LIMIT 1;

-- 11. Identify industries with atleast 200 billion combined
SELECT country,
       ROUND(SUM(networth_billion), 2) AS combined_networth_billion
FROM Top200RichestPersonintheWorld
GROUP BY country
HAVING SUM(networth_billion) >= 200
ORDER BY combined_networth_billion DESC;

-- 12. How many billionaires are represented in the dataset
SELECT COUNT(*) AS total_billionaires
FROM Top200RichestPersonintheWorld;

-- 13. What is the lowest net worth recorded?
SELECT MIN(networth_billion) AS lowest_networth_billion
FROM Top200RichestPersonintheWorld;

-- 14. What is the highest network recorded?
SELECT MAX(networth_billion) AS lowest_networth_billion
FROM Top200RichestPersonintheWorld;

-- 15. What is the average age difference between the oldest and youngest billionaires?
SELECT 
    MAX(CAST(age AS UNSIGNED)) AS oldest_age,
    MIN(CAST(age AS UNSIGNED)) AS youngest_age,
    MAX(CAST(age AS UNSIGNED)) - MIN(CAST(age AS UNSIGNED)) AS age_difference
FROM Top200RichestPersonintheWorld;

-- 16. What is the combined net worth of billionaires younger than 50?
SELECT country,
       ROUND(SUM(networth_billion), 2) AS combined_networth_billion
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) < 50
GROUP BY country
ORDER BY combined_networth_billion DESC;

-- 17. Which billionaires belong to industries with less than 5 representatives?
SELECT name, industry
FROM Top200RichestPersonintheWorld
WHERE industry IN (
    SELECT industry
    FROM Top200RichestPersonintheWorld
    GROUP BY industry
    HAVING COUNT(*) < 5
					)
ORDER BY industry, name;

-- 18. What percentage of the dataset is made up of billionaires older than 30?
SELECT 
    ROUND(
        COUNT(CASE WHEN CAST(age AS UNSIGNED) > 30 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS percentage_older_than_30
FROM Top200RichestPersonintheWorld;

-- 19. Who has net worth less than $100 and aged below 50 by name, age, networth billion
SELECT name, age, networth_billion
FROM Top200RichestPersonintheWorld
WHERE CAST(networth_billion AS DECIMAL(10,2)) < 100
  AND CAST(age AS UNSIGNED) < 50
ORDER BY networth_billion DESC;

-- 20.  Which industry has the have atleast 15 billionaires aged below 60
SELECT industry,
       COUNT(*) AS lowestworth_billionaires
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) < 60
GROUP BY industry
HAVING COUNT(*) >= 15
ORDER BY lowestworth_billionaires DESC;

-- 21.  Who is the richest youngest billionaire and which country and age do they belong to?
SELECT name, age, country, networth_billion
FROM Top200RichestPersonintheWorld
ORDER BY CAST(age AS UNSIGNED) ASC, 
         CAST(networth_billion AS DECIMAL(10,2)) DESC
LIMIT 1;         

-- 22. How many industries have billionaries with average net worth below $70
sELECT COUNT(*) AS total_industries_below_70_avg
FROM (
  SELECT industry
  FROM Top200RichestPersonintheWorld
  GROUP BY industry
  HAVING AVG(CAST(networth_billion AS DECIMAL(10,2))) < 70
) AS low_avg_industries;

-- 23. Who are billionaries from Spain, Mexico, United States, Canada , Italy with net worth above $50 and aged between 30 to 70?
SELECT name,
       country,
       industry,
       CAST(networth_billion AS DECIMAL(10,2)) AS networth,
       CAST(age AS UNSIGNED) AS age,
       CAST(`rank` AS UNSIGNED) AS `rank`
FROM Top200RichestPersonintheWorld
WHERE country IN ('Spain', 'Mexico', 'United States', 'Canada', 'Italy')
  AND CAST(networth_billion AS DECIMAL(10,2)) > 50
  AND CAST(age AS UNSIGNED) BETWEEN 30 AND 70
ORDER BY country ASC,
         CAST(networth_billion AS DECIMAL(10,2)) DESC;
         
-- 24. Who has net worth less than $100 and aged below 40 by name, age
SELECT name, age
FROM Top200RichestPersonintheWorld
WHERE CAST(networth_billion AS DECIMAL(10,2)) < 100
  AND CAST(age AS UNSIGNED) < 40
ORDER BY networth_billion DESC;

-- 25. Who has net worth more than $50 and aged above 40 by name, age, country, industry, networth
SELECT name, age, country, industry, networth_billion
FROM Top200RichestPersonintheWorld
WHERE CAST(networth_billion AS DECIMAL(10,2)) > 50
  AND CAST(age AS UNSIGNED) > 40
  
 -- 26.  Who is the richest Oldest billionaire and which country ,age, industry do they belong to?
SELECT name, age, country, networth_billion, industry
FROM Top200RichestPersonintheWorld
ORDER BY CAST(age AS UNSIGNED) ASC, 
         CAST(networth_billion AS DECIMAL(10,2)) DESC
LIMIT 1;   

-- 27.What is the Percentage of all billionaires' net worth between aged between 20 and 60, with net worth between 20-200 billion and from which industry
SELECT industry,
       SUM(CAST(networth_billion AS DECIMAL(10,2))) AS total_networth_billion,
       ROUND(
         SUM(CAST(networth_billion AS DECIMAL(10,2))) * 100.0 /
         (SELECT SUM(CAST(networth_billion AS DECIMAL(10,2)))
          FROM Top200RichestPersonintheWorld),
         2
       ) AS percentage_of_all_billionaires
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) BETWEEN 20 AND 60
  AND CAST(networth_billion AS DECIMAL(10,2)) BETWEEN 20 AND 200
GROUP BY industry
ORDER BY percentage_of_all_billionaires DESC;

/* What is the percantage of networth of billionaires in united states, canada, italy within age range 40-60 and what industries
do they belong to */
SELECT country,
       industry,
       SUM(CAST(networth_billion AS DECIMAL(10,2))) AS industry_networth,
       ROUND(
         SUM(CAST(networth_billion AS DECIMAL(10,2))) * 100.0 / 
         (SELECT SUM(CAST(networth_billion AS DECIMAL(10,2)))
          FROM Top200RichestPersonintheWorld
          WHERE country IN ('United States', 'Canada', 'Italy')
            AND CAST(age AS UNSIGNED) BETWEEN 40 AND 60)
       , 2) AS percentage_of_group
FROM Top200RichestPersonintheWorld
WHERE country IN ('United States', 'Canada', 'Italy')
  AND CAST(age AS UNSIGNED) BETWEEN 40 AND 60
GROUP BY country, industry
ORDER BY percentage_of_group DESC;

/* What is the average networth of billionaries in austria, france, mexico aged above 50 in rank 1-60 and 
which industry do they belong to */
SELECT country,
       industry,
       ROUND(AVG(CAST(networth_billion AS DECIMAL(10,2))), 2) AS avg_networth,
       COUNT(*) AS how_many
FROM Top200RichestPersonintheWorld
WHERE country IN ('Austria', 'France', 'Mexico')
  AND CAST(age AS UNSIGNED) > 50
  AND CAST(`rank` AS UNSIGNED) BETWEEN 1 AND 60
GROUP BY country, industry
ORDER BY avg_networth DESC;

-- 31. Which ranks have the oldest billionaries in the automative, food and beverages, technology and finance & investments industries
SELECT industry, name, age, `rank`
FROM (
  SELECT industry,
         name,
         CAST(age AS UNSIGNED) AS age,
         CAST(`rank` AS UNSIGNED) AS `rank`,
         ROW_NUMBER() OVER (PARTITION BY industry ORDER BY CAST(age AS UNSIGNED) DESC) AS rn
  FROM Top200RichestPersonintheWorld
  WHERE industry IN ('Automotive', 'Food and Beverage', 'Technology', 'Finance & Investments')
) AS oldest_per_industry
WHERE rn = 1;

-- 32. What is the total number of industries in rank 30-70 with billionaires of net worth below $500 and aged atleast 60
SELECT COUNT(DISTINCT industry) AS total_industries
FROM Top200RichestPersonintheWorld
WHERE CAST(`rank` AS UNSIGNED) BETWEEN 30 AND 70
  AND CAST(networth_billion AS DECIMAL(10,2)) < 500
  AND CAST(age AS UNSIGNED) >= 60;
  
 -- 33. Which billionaire has networth below $100 and is in technology indusrty and aged 40
 SELECT name,
       CAST(age AS UNSIGNED) AS age,
       CAST(networth_billion AS DECIMAL(10,2)) AS networth,
       CAST(`rank` AS UNSIGNED) AS `rank`,
       industry,
       country
FROM Top200RichestPersonintheWorld
WHERE industry = 'Technology'
  AND CAST(age AS UNSIGNED) = 40
  AND CAST(networth_billion AS DECIMAL(10,2)) < 100;
  
-- 34. In the entire dataset how many billionaires are in austria with networth atleast $50
SELECT COUNT(*) AS how_many_in_austria
FROM Top200RichestPersonintheWorld
WHERE country = 'Austria'
  AND CAST(networth_billion AS DECIMAL(10,2)) >= 50;
  
 -- 35. In the entire dataset which indusries has the highest networth and who are the billionaires aged atleast 69
 WITH aged_69_plus AS (
  SELECT *
  FROM Top200RichestPersonintheWorld
  WHERE CAST(age AS UNSIGNED) >= 69
),
top_industry AS (
  SELECT industry
  FROM aged_69_plus
  GROUP BY industry
  ORDER BY SUM(CAST(networth_billion AS DECIMAL(10,2))) DESC
  LIMIT 1
)
SELECT name,
       industry,
       CAST(networth_billion AS DECIMAL(10,2)) AS networth,
       CAST(age AS UNSIGNED) AS age,
       CAST(`rank` AS UNSIGNED) AS `rank`,
       country
FROM aged_69_plus
WHERE industry IN (SELECT industry FROM top_industry)
ORDER BY CAST(networth_billion AS DECIMAL(10,2)) DESC;

-- 36. How many billionaires are aged between 20-100 with net worth of atleast $200 and what industry do they belong to?
SELECT industry,
       COUNT(*) AS how_many
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) BETWEEN 20 AND 100
  AND CAST(networth_billion AS DECIMAL(10,2)) >=200
GROUP BY industry
ORDER BY how_many DESC;

 -- 37. List the name and industry of billionaires aged 20-100 with net worth at least $100 billion. Also show how many there are in each industry.
SELECT name,
       industry,
       CAST(age AS UNSIGNED) AS age,
       CAST(networth_billion AS DECIMAL(10,2)) AS networth_billion
FROM Top200RichestPersonintheWorld
WHERE CAST(age AS UNSIGNED) BETWEEN 20 AND 100
  AND CAST(networth_billion AS DECIMAL(10,2)) >= 100
ORDER BY industry, name;