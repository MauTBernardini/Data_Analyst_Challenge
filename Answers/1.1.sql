UPDATE continent_map

--substituíção de brancos por null    
SET
    country_code = CASE country_code 
                        WHEN '' THEN NULL 
                        ELSE country_code 
                    END,
    continent_code = CASE continent_code
                         WHEN '' THEN NULL 
                         ELSE continent_code 
                     END;


SELECT
    --caso nulo, substituíção de null por 'FOO'
    coalesce(country_code, 'FOO') as country_code_fixed
FROM
    continent_map
GROUP BY 
    country_code
HAVING 
    --condição para pegar duplicatas
    count(1) > 1
ORDER BY
    country_code;
    
