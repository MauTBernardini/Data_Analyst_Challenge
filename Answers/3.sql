--fix de continent_name conforme solicitado e filtragem de ano para 2012
WITH CONTINENT_INFO AS (
SELECT
    CASE WHEN continent_name = 'Europe' THEN 'Europe'
         WHEN continent_name = 'Asia' THEN 'Asia'
         ELSE 'Rest of World'
     END as continent
    ,gdp_per_capita
FROM 
    per_capita pc
JOIN 
    continent_map cm ON pc.country_code = cm.country_code
JOIN
    continents c ON cm.continent_code = c.continent_code
WHERE 
    year = 2012    
)

--cálculo por coluna do share de gdp
SELECT 
     round((sum(case when continent = 'Asia' THEN gdp_per_capita Else 0 end) /  (SELECT sum(gdp_per_capita) FROM CONTINENT_INFO))*100,2) || '%'                AS 'Asia'    
    ,round((sum(case when continent = 'Europe' THEN gdp_per_capita Else 0 end) /  (SELECT sum(gdp_per_capita) FROM CONTINENT_INFO))*100,2) || '%'              AS 'Europe'
    ,round((sum(case when continent = 'Rest of World' THEN gdp_per_capita Else 0 end) /  (SELECT sum(gdp_per_capita) FROM CONTINENT_INFO))*100,2) || '%'       AS 'Rest of World'
FROM 
    CONTINENT_INFO
