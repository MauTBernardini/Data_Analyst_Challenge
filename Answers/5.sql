SELECT
    year
    ,count(distinct country_code) as country_count
    ,'$' || sum(gdp_per_capita) as total
FROM
    per_capita
WHERE 
    --condição para  gdp não nulo e antes de 2012
    (gdp_per_capita IS NOT NULL
    AND year < 2012)
    OR
    --condição para 2012 e gdp nulo
    (year = 2012 
     AND gdp_per_capita IS NULL)
GROUP BY
    year