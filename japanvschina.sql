-- create database
CREATE DATABASE IF NOT EXISTS japan_vs_china_data;

-- use the created database
USE japan_vs_china_data;

-- create table
CREATE TABLE IF NOT EXISTS techAdvancements(
	id INT AUTO_INCREMENT PRIMARY KEY,
	country TEXT,
    year_ INT,
    tech_sector TEXT,
    market_share DOUBLE,
    rd_investment DOUBLE,
    number_of_patents INT,
    number_of_tech_companies INT,
    tech_exports_usd DOUBLE,
    number_startups INT,
    venture_capital_funding_usd DOUBLE,
    global_innovation_rank INT,
    internet_penetration DOUBLE,
    five_g_network_coverage DOUBLE,
    univ_research_collab INT,
    top_tech_products_exported TEXT,
    number_of_tech_workers INT
);
-- import data into table

-- show first 5 rows
SELECT * FROM techAdvancements
ORDER BY year_
LIMIT 5;

-- the total R&D investment for each country over the years
SELECT country, year_, SUM(rd_investment) AS total_rd_investment
FROM techadvancements
GROUP BY country, year_
ORDER BY year_;

-- the average market share by tech sector for each country
SELECT country, tech_sector, AVG(market_share) AS average_market_share
FROM techadvancements
GROUP BY country, tech_sector;

-- the number of patents filed changed over the years in China and Japan
SELECT country, year_, SUM(number_of_patents) AS number_of_patents
FROM techadvancements
GROUP BY country, year_
ORDER BY year_;

-- the trends in venture capital funding over the years for each country
SELECT country, year_, SUM(venture_capital_funding_usd) AS venture_capital_funding_usd
FROM techadvancements
GROUP BY country, year_
ORDER BY year_;

-- tech sector that has the highest market share in each country
WITH sum_market_share_cte AS(
SELECT country, tech_sector, SUM(market_share) AS sum_market_share, ROW_NUMBER() OVER(PARTITION BY country ORDER BY SUM(market_share) DESC) AS rn
FROM techadvancements
GROUP BY country, tech_sector
)
SELECT country, tech_sector, sum_market_share
FROM sum_market_share_cte
WHERE rn = 1;

-- the average internet penetration rates between China and Japan across different years
SELECT country, year_, AVG(internet_penetration) AS average_internet_penetration_rates
FROM techadvancements
GROUP BY country, year_
ORDER BY year_;

-- country that has a higher average number of tech workers in the software sector
WITH avg_number_tech_workers_cte AS(
SELECT country, AVG(number_of_tech_workers) AS avg_number_tech_workers
FROM techadvancements
WHERE tech_sector = 'Software'
GROUP BY country
)
SELECT country, avg_number_tech_workers
FROM avg_number_tech_workers_cte
ORDER BY avg_number_tech_workers DESC
LIMIT 1;

-- the rank of each tech sector based on the global innovation ranking for each country in the past 5 years
SELECT country, year_, tech_sector, global_innovation_rank, DENSE_RANK() OVER(PARTITION BY country, year_ ORDER BY global_innovation_rank ASC) AS sector_rank
FROM techadvancements
WHERE year_ BETWEEN 2019 and 2023
ORDER BY year_, sector_rank;

-- the growth in the number of startups over the years in each country
WITH startups_years AS(
	SELECT country, MIN(year_) AS min_year, MAX(year_) AS max_year
    FROM techadvancements
    GROUP BY country
),
startups_growth_cte AS (
	SELECT t.country, 
    MAX(CASE WHEN t.year_ = s. min_year THEN number_startups END) AS start_year_startups,
    MAX(CASE WHEN t.year_ = s.max_year THEN number_startups END) AS end_year_startups
    FROM techadvancements t
    JOIN startups_years s
    ON t.country = s.country
    GROUP BY t.country
)
SELECT country, (end_year_startups - start_year_startups) AS startup_growth
FROM startups_growth_cte
ORDER BY startup_growth DESC;

-- top 3 tech sectors with the highest average number of patents filed and their corresponding countries
SELECT country, tech_sector, ROUND(AVG(number_of_patents) OVER(ORDER BY number_of_patents DESC), 2) AS average_number_of_patents
FROM techadvancements
LIMIT 3;

-- the year-over-year growth of R&D investment for each country
WITH yearly_rd_investment AS (
	SELECT country, year_, SUM(rd_investment) AS total_rd_investment
    FROM techadvancements
    GROUP BY country, year_
),
growth_cte AS (
	SELECT country, year_, total_rd_investment,
    LAG(total_rd_investment) OVER(PARTITION BY country ORDER BY year_) AS previous_year_investment
	FROM yearly_rd_investment
)
SELECT country, year_, ROUND(((total_rd_investment - previous_year_investment) / previous_year_investment) * 100, 2) AS rd_growth_percentage
FROM growth_cte
WHERE previous_year_investment IS NOT NULL
ORDER BY year_;

-- performance of internet_penetration in both countries
SELECT country, AVG(internet_penetration) AS average_internet_penetration
FROM techadvancements
GROUP BY country
ORDER BY average_internet_penetration DESC;

-- performance of internet_penetration in both countries
SELECT country, AVG(five_g_network_coverage) AS average_five_g_network_coverage
FROM techadvancements
GROUP BY country
ORDER BY average_five_g_network_coverage DESC;

-- number of tech workers in each country
SELECT country, SUM(number_of_tech_workers) AS total_number_of_tech_workers
FROM techadvancements
GROUP BY country;

-- top 3 tech sector that employs the most workers in Japan
SELECT tech_sector, AVG(number_of_tech_workers) AS average_number_of_tech_workers
FROM techadvancements
WHERE country = 'Japan'
GROUP BY tech_sector
ORDER BY average_number_of_tech_workers DESC
LIMIT 3;

-- top 3 tech sector that employs the most workers in China
SELECT tech_sector, AVG(number_of_tech_workers) AS average_number_of_tech_workers
FROM techadvancements
WHERE country = 'China'
GROUP BY tech_sector
ORDER BY average_number_of_tech_workers DESC
LIMIT 3;


-- top tech products exported in both countries
-- top tech products exported in Japan
SELECT top_tech_products_exported
FROM techadvancements
WHERE country = 'Japan'
INTERSECT
-- top tech products exported in China
SELECT top_tech_products_exported
FROM techadvancements
WHERE country = 'China';

-- total number of startups in China
DELIMITER //
CREATE PROCEDURE GetTotalStartupsInCountry(IN input_country VARCHAR(50))
BEGIN
	SELECT SUM(number_startups) AS total_number_startups
    FROM techadvancements
    WHERE country = input_country;
END //
DELIMITER ;
CALL GetTotalStartupsInCountry('China');
CALL GetTotalStartupsInCountry('Japan');