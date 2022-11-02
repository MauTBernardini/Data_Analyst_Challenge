SELECT 
    year
    ,count(distinct pc.country_code) AS country_count
    ,'$' || round(sum(gdp_per_capita),2) AS total
FROM 
    per_capita pc
JOIN 
    countries c ON pc.country_code = c.country_code
WHERE
    --filtro de ano para 2007
    year = 2007
    --filtro de string 'an' em qualquer posição do nome e obrigatóriamente minúsculo
    AND lower(c.country_name) like '%an%'