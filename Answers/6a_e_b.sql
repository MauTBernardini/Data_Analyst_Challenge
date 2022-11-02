--a e b
SELECT
    cont.continent_name
    ,pc.country_code
    ,count.country_name
    ,'$' || round(gdp_per_capita,2)
FROM
    (
    SELECT 
        country_code
        ,gdp_per_capita
    FROM 
        per_capita
    WHERE
        --filtro do ano de 2009
        year = 2009
    )pc  
--links para obtenção dos campos de nomes
JOIN 
    continent_map cm ON pc.country_code = cm.country_code
JOIN
    countries count ON cm.country_code = count.country_code
JOIN 
    continent cont ON cm.continent_code = cont.continent_code

ORDER BY 
    cont.continent_name  ASC
    --ordenação pelos caracteres 2,3 e 4 do country_name
    ,substring(count.country_name, 2,4) DESC