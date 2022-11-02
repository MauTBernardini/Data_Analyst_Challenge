
--tabela per capita com coluna de gdp defasado em 1 ano
WITH GDPs AS (
SELECT
    country_code
    ,year
    ,gdp_per_capita
    ,lag(gdp_per_capita)over(partition by country_code order by year) as lagged_gdp
FROM
    per_capita
)

--seleção e cálculo do growth percentage para o ano de 2012 em comparação com 2011
,QUERY AS (
SELECT 
    rank()over(partition by continent_name order by growth_percent desc) AS rank
    ,aux.*
FROM(
    SELECT
        cont.continent_name
        ,c.country_name
        ,(lagged_gdp - gdp_per_capita)/nullif(gdp_per_capita,0) AS growth_percent
    FROM 
        GDPs 
    JOIN 
        continent_map cm ON GDPs.country_code = cm.country_code
    JOIN
        countries c ON cm.country_code = c.country_code
    JOIN
        continents cont ON cm.continent_code = cont.continent_code    
    WHERE 
        GDPs.year = 2012
    )aux
)

--seleção apenas dos ranks entre 10 e 12
SELECT
    rank
    ,continent_name
    ,country_name
    ,round(growth_percent,2) || '%' AS growth_percent
FROM 
    QUERY
WHERE 
    rank BETWEEN 10 AND 12