# ✨🚀𝑱𝒂𝒑𝒂𝒏 𝒗𝒔 𝑪𝒉𝒊𝒏𝒂 𝑻𝒆𝒄𝒉 𝑨𝒅𝒗𝒂𝒏𝒄𝒆𝒎𝒆𝒏𝒕𝒔 𝑨𝒏𝒂𝒍𝒚𝒔𝒊𝒔🌐⭐

This project provides a comprehensive analysis of technological advancements in Japan and China using SQL.

<img src='japanvschina.jpg'>

## 📊 **Dataset Overview**
The dataset includes detailed information on the tech sectors of China and Japan across different years from 2000 to 2023 containing 1000 rows and columns such as:
- `country` `year` `tech_sector` `market_share` `rd_investment` `number_of_patents` `number_of_tech_companies` `tech_exports_usd` `number_startups` `venture_capital_funding_usd` `global_innovation_rank` `internet_penetration` `five_g_network_coverage` `univ_research_collab` `top_tech_products_exported` `number_of_tech_workers`

## 🔍 **Key Findings**
- **China's growth**:
  - China saw a big increase in R&D investments over the years, especially in 2017, 2001, and 2023. In these years, the growth went up a lot compared to the previous years.
- **Japan's growth**:
  - Japan also had significant growth in R&D investments, particularly in 2004, 2009, and 2021, where the investments increased more than usual.
- **COVID-19 impact**:
  - In 2020, during the COVID-19 pandemic, China increased its R&D investments by 131,882,954,302.18 USD compared to 2019, while Japan’s investment dropped by 92,632,543,191.01 USD.
  - In 2021, China’s R&D investment went down by 227,444,519,422.00 USD compared to 2020, while Japan increased its investment by 685,867,620,174.64 USD.
  - In 2022, China’s investment grew again by 496,940,582,657.79 USD compared to 2021, while Japan’s investment decreased by 221,601,807,306.60 USD. Despite the ups and downs, both countries invested a lot during the COVID-19 pandemic.
- **Peak in 2023**:
  - In 2023, China continued to grow, reaching its highest investment at 1,322,371,287,257.64 USD, surpassing Japan, which invested 912,226,526,415.36 USD. This could be because China offers more affordable products that many people need nowadays, like clothing, appliances (e.g., Shein, Temu) and cars.
- **Tech sector and patents**:
  - In China, the biggest tech areas by market share are telecommunications and robotics. Major companies like Huawei and DJI lead in these fields. This might explain why companies like Apple depend on China for making their products, due to the strong support in these areas. Software is the smallest market sector in China.
  - In Japan, the top two tech areas by market share are software and semiconductors. Big companies like Sony and Renesas Electronics do well in these sectors. Nintendo also does well in the software market, especially in gaming. Meanwhile, AI has the smallest market share in Japan.
  - China had its highest number of patents in 2001, with 150,297 patents.
  - Japan's peak was in 2015, with 159,578 patents.
  - By 2023, China had 132,645 patents, while Japan had 96,788.
- **Venture Capital Funding**:
  - China saw the highest venture capital funding in 2009, while the lowest was in 2010. In Japan, the peak was in 2021, and again the lowest was in 2010. This shows how investment trends can change significantly year by year.
- **Robotics Market Share**:
  - Robotics has consistently held the highest market share in both countries over the years, with totals of 2,192.54 in China and 2,170.87 in Japan. This suggests strong growth and investment in robotics technology.
- **Internet Penetration**:
  - China had its highest internet penetration rate in 2013 at 74.88%. However, this rate decreased over the years, dropping to 65.59% in 2023, with the lowest point being 64.63% in 2020. In Japan, the highest rate was 75.21% in 2006, but it fell to 69.27% in 2023, also with the lowest in 2020 at 63.38%. The decline in both countries' internet rates in 2020 could be due to the impacts of the COVID-19 pandemic.
- **Tech Workers**:
  - China has a larger number of tech workers in the software sector compared to Japan, which is important for driving innovation and growth.
- **Global Innovation Ranks**:
  - China has a larger number of tech workers in the software sector compared to Japan, which is important for driving innovation and growth.
- **Startups Growth**:
  - The growth in the number of startups over the years is higher in Japan, with an increase of 27, compared to 10 in China.
- **Patents**:
  - The top five tech sectors with the highest average number of patents in Japan are cloud computing (9,989), robotics (9,988), and biotechnology (9,979.75). In China, the top sectors are AI (9,984.33) and biotechnology (9,975.20).
- **R&D Growth**:
  - China had its highest R&D growth percentage in 2017 at 92.75%, but the lowest was in 2012 at -49.32%. In 2023, the growth was 8.13% compared to 2022. For Japan, the peak was in 2021 at 91.56%, while the lowest was in 2005 at -52.79%. In 2023, Japan's growth was -24.82% compared to 2022.
- **Tech Employment**:
  - The average internet penetration in China is 70.24%, while in Japan it is 69.24%. China's average 5G network coverage is 49.61%, while Japan’s is slightly higher at 50.33%. The total number of tech workers in China is 247,878,412, while in Japan it is 248,604,999. The top three sectors that employ the most workers in Japan are semiconductors, telecommunications, and biotechnology. In China, the top sectors are cloud computing, telecommunications, and AI.
- **Startups and Companies**:
  - China has a total of 131,486 startups compared to Japan's 126,038. The number of tech companies in China is 515,860, while in Japan it is 495,273. This indicates that China has more tech companies and startups than Japan.
- **University Research Collaborations**:
  - China has 48,148 university research collaborations, while Japan has a higher number at 50,936.

## 💻 **Technologies Used**

![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?logo=mysql&logoColor=white)
- **SQL** for analysis

## 🛠️ **SQL Features Utilized**

This project makes extensive use of advanced SQL techniques, including:

- **Stored Procedures**: 
  - Created a procedure to calculate the total number of startups in a specified country.
  
  Example:
  ```sql
  DELIMITER //
  CREATE PROCEDURE GetTotalStartupsInCountry(IN input_country VARCHAR(50))
  BEGIN
      SELECT SUM(number_startups) AS total_number_startups
      FROM techAdvancements
      WHERE country = input_country;
  END //
  DELIMITER ;
  CALL GetTotalStartupsInCountry('China');
  ```
  
- **Window Functions**:
  - Used ROW_NUMBER() to find the top tech sector with the highest market share.
  - Used DENSE_RANK() to rank tech sectors based on global innovation rankings.
    
  Example:
  ```sql
  SELECT country, year_, tech_sector, global_innovation_rank, 
       DENSE_RANK() OVER(PARTITION BY country, year_ ORDER BY global_innovation_rank ASC) AS sector_rank
  FROM techAdvancements
  WHERE year_ BETWEEN 2019 and 2023
  ORDER BY year_, sector_rank;
  ```
- **Aggregate Functions**:
  - SUM(), AVG(), and ROUND() were frequently used to analyze investments, market shares, patents, and workforce numbers.
- **Common Table Expressions (CTEs)**:
  - Utilized CTEs for clarity in multi-step calculations, such as determining the growth of startups and R&D investment trends.
- **Joins**:
  - Used JOIN to combine tables for complex calculations and analysis.
- **Ordering and Grouping**:
  - Used GROUP BY for aggregations, and ORDER BY to organize results for better readability.
    
Example:
  ```sql
  WITH startups_growth_cte AS (
    SELECT t.country, 
           MAX(CASE WHEN t.year_ = s.min_year THEN number_startups END) AS start_year_startups,
           MAX(CASE WHEN t.year_ = s.max_year THEN number_startups END) AS end_year_startups
    FROM techAdvancements t
    JOIN startups_years s
    ON t.country = s.country
    GROUP BY t.country
)
SELECT country, (end_year_startups - start_year_startups) AS startup_growth
FROM startups_growth_cte
ORDER BY startup_growth DESC;
  ```
