--tabela per_capita já filtrada no ano de 2009
WITH capita AS (
 SELECT 
        country_code
        ,gdp_per_capita
    FROM 
        per_capita
    WHERE
        year = 2009
)

--obtenção do running total rankeado
, RUNNING_TOTAL AS (
SELECT 
    continent_name
    ,country_code
    ,country_name
    ,gdp_per_capita
    ,running_total
    --rankeamento baseado na mesma ordenação de 6a_e_b
    ,rank() over(partition by continent_name order by substring(country_name, 2,4) DESC) as rank

FROM 
(
SELECT
    cont.continent_name
    ,pc.country_code
    ,count.country_name
    ,gdp_per_capita
    --construção do running total por continente
    ,sum(gdp_per_capita) over(partition by continent_name order by substring(count.country_name, 2,4) DESC) as running_total
FROM
    capita pc
JOIN 
    continent_map cm ON pc.country_code = cm.country_code
JOIN
    countries count ON cm.country_code = count.country_code
JOIN 
    continents cont ON cm.continent_code = cont.continent_code

ORDER BY 
    cont.continent_name  ASC
    ,substring(count.country_name, 2,4) DESC
)aux

WHERE 
    --filtro para obter acumulados maior que 70000 na ordem proposta
    running_total >= 70000 

)

--seleção final e filtro para obtenção do primeiro registro maior que 70000
SELECT 
    continent_name
    ,country_code
    ,country_name
    ,'$' || round(gdp_per_capita,2)
    ,'$' || round(running_total,2)
FROM 
    RUNNING_TOTAL
WHERE RANK = 1