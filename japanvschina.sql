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
-- import data into table in my case i used MYSQL Workbench

-- show first 5 rows
SELECT * FROM techAdvancements
ORDER BY year_
LIMIT 5;

-- the total R&D investment for each country over the years
SELECT country, year_, SUM(rd_investment) AS total_rd_investment
FROM techadvancements
GROUP BY country, year_
ORDER BY total_rd_investment DESC;

-- total tech exports in usd in both countries 
SELECT country, SUM(tech_exports_usd) AS total_tech_exports_usd
FROM techadvancements
GROUP BY country
ORDER BY total_tech_exports_usd DESC;

-- the total R&D investment for each country in covid 19 period
SELECT country, year_, SUM(rd_investment) AS total_rd_investment
FROM techadvancements
WHERE year_ >= 2019 and year_<=2022
GROUP BY country, year_
ORDER BY year_;

-- calculate the difference growth of r&d investment in china between 2020 and 2019
select ROUND(953443020203.5189 - 821560065901.3379, 2);

-- calculate the difference growth of r&d investment in japan between 2020 and 2019
select ROUND(749091182055.8168 - 841723725246.8252, 2);

-- calculate the difference growth of r&d investment in china between 2020 and 2021
select ROUND(725998500781.5162 - 953443020203.5189, 2);

-- calculate the difference growth of r&d investment in japan between 2020 and 2021
select ROUND(1434958802230.4614 - 749091182055.8168, 2);

-- calculate the difference growth of r&d investment in china between 2022 and 2021
select ROUND(1222939083439.3083 - 725998500781.5162, 2);

-- calculate the difference growth of r&d investment in japan between 2022 and 2021
select ROUND(1213356994923.8652 - 1434958802230.4614, 2);

-- the total R&D investment for each country in 2023
SELECT country, year_, SUM(rd_investment) AS total_rd_investment
FROM techadvancements
WHERE year_ = 2023
GROUP BY country, year_
ORDER BY total_rd_investment DESC;

-- the average market share by tech sector in china
SELECT country, tech_sector, AVG(market_share) AS average_market_share
FROM techadvancements
WHERE country = 'China'
GROUP BY country, tech_sector
ORDER BY average_market_share DESC;

-- the average market share by tech sector in china
SELECT country, tech_sector, AVG(market_share) AS average_market_share
FROM techadvancements
WHERE country = 'Japan'
GROUP BY country, tech_sector
ORDER BY average_market_share DESC;

-- the number of patents filed changed over the years in China and Japan
SELECT country, year_, SUM(number_of_patents) AS number_of_patents
FROM techadvancements
GROUP BY country, year_
ORDER BY number_of_patents DESC;

-- the number of patents in 2023 in China and Japan
SELECT country, year_, SUM(number_of_patents) AS number_of_patents
FROM techadvancements
WHERE year_ = 2023
GROUP BY country, year_
ORDER BY number_of_patents DESC;

-- the trends in venture capital funding over the years in china
SELECT country, year_, SUM(venture_capital_funding_usd) AS venture_capital_funding_usd
FROM techadvancements
WHERE country = 'China'
GROUP BY country, year_
ORDER BY venture_capital_funding_usd DESC;

-- the trends in venture capital funding over the years in japan
SELECT country, year_, SUM(venture_capital_funding_usd) AS venture_capital_funding_usd
FROM techadvancements
WHERE country = 'Japan'
GROUP BY country, year_
ORDER BY venture_capital_funding_usd DESC;

-- tech sector that has the highest market share in each country over the years
WITH sum_market_share_cte AS(
SELECT country, tech_sector, ROUND(SUM(market_share),2) AS sum_market_share, ROW_NUMBER() OVER(PARTITION BY country ORDER BY SUM(market_share) DESC) AS rn
FROM techadvancements
GROUP BY country, tech_sector
)
SELECT country, tech_sector, sum_market_share
FROM sum_market_share_cte
WHERE rn = 1;

-- the average internet penetration rates in China across different years
SELECT country, year_, ROUND(AVG(internet_penetration), 2) AS average_internet_penetration_rates
FROM techadvancements
WHERE country = 'China'
GROUP BY country, year_
ORDER BY average_internet_penetration_rates DESC;

-- the average internet penetration rates in japan across different years
SELECT country, year_, ROUND(AVG(internet_penetration), 2) AS average_internet_penetration_rates
FROM techadvancements
WHERE country = 'Japan'
GROUP BY country, year_
ORDER BY average_internet_penetration_rates DESC;

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

-- the rank of each tech sector based on the global innovation ranking for china in 2023
SELECT country, tech_sector, global_innovation_rank, DENSE_RANK() OVER(PARTITION BY country, year_ ORDER BY global_innovation_rank ASC) AS sector_rank
FROM techadvancements
WHERE country = 'China' and year_ = 2023 
ORDER BY sector_rank;

-- the rank of each tech sector based on the global innovation ranking for japan in 2023
SELECT country, tech_sector, global_innovation_rank, DENSE_RANK() OVER(PARTITION BY country, year_ ORDER BY global_innovation_rank ASC) AS sector_rank
FROM techadvancements
WHERE country = 'Japan' and year_ = 2023 
ORDER BY sector_rank;

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

-- top 5 tech sectors with the highest average number of patents filed and their corresponding countries
SELECT country, tech_sector, ROUND(AVG(number_of_patents) OVER(ORDER BY number_of_patents DESC), 2) AS average_number_of_patents
FROM techadvancements
LIMIT 5;

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
-- china
SELECT country, year_, ROUND(((total_rd_investment - previous_year_investment) / previous_year_investment) * 100, 2) AS rd_growth_percentage
FROM growth_cte
WHERE previous_year_investment IS NOT NULL
ORDER BY rd_growth_percentage DESC;

-- performance of internet_penetration in both countries
SELECT country, ROUND(AVG(internet_penetration), 2) AS average_internet_penetration
FROM techadvancements
GROUP BY country
ORDER BY average_internet_penetration DESC;

-- average five g network coverage in both countries
SELECT country, ROUND(AVG(five_g_network_coverage), 2) AS average_five_g_network_coverage
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

-- total number of tech companies in both countries
SELECT country, SUM(number_of_tech_companies) AS number_tech_companies
FROM techadvancements
GROUP BY country;

-- total number of university research collaboration
SELECT country, SUM(univ_research_collab) AS total_number_univ_research_collab
FROM techadvancements
GROUP BY country;

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
