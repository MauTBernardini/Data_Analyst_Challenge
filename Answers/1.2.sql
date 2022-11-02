--criacao de tabela temporaria
CREATE TEMPORARY TABLE single_country (country_code text, continent_code text , rank integer);

--remocao de duplicatas em tabela temporaria
WITH repited_country AS (
SELECT
    cm.*
    ,rank()over(partition by cm.country_code order by continent_code ASC) as rank
FROM 
    continent_map cm
)
INSERT INTO single_country 
SELECT
   *
FROM 
    repited_country rc
WHERE 
    rank = 1;

--conferencia de resultados
SELECT count(*) FROM continent_map;
SELECT count(*) FROM single_country;


--delecao de continent_map
DELETE FROM continent_map;

--reinsercao em continent_map
INSERT INTO continent_map
SELECT 
    country_code
    ,continent_code
FROM single_country;


--conferencia
SELECT
    count(*)
FROM 
    continent_map;
    
--delecao de tabela temporaria
drop table single_country;