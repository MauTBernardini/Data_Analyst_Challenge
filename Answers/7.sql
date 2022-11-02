    
    --construção de base com informações per_capita por continente e país
    WITH BASE AS (
    SELECT
        continent_name
        ,pc.country_code
        ,country_name
        ,avg(gdp_per_capita) AS avg_per_capita
    FROM
        per_capita pc
    JOIN 
        continent_map cm ON pc.country_code = cm.country_code
    JOIN
        countries count ON cm.country_code = count.country_code
    JOIN 
        continents cont ON cm.continent_code = cont.continent_code
    GROUP BY
        continent_name
        ,pc.country_code
        ,country_name
    )
    
    --rankeamento dos registros por continente e ordenado por média do gdp 
    , RANKEAMENTO AS (
    SELECT
        rank()over(partition by continent_name order by avg_per_capita DESC) AS rank
        ,BASE.*
    FROM
        BASE
    )
    
    --seleção apenas do maior valor de média do gdp
    SELECT
        *
    FROM 
        RANKEAMENTO
    WHERE 
    rank = 1   