SELECT Anno, ISNULL(CONVERT(varchar(3), idCat),'TOT') AS idCat, ISNULL(SUBSTRING(Causale,1,2),CONVERT(varchar(3), idCat)) AS Tipo, ISNULL(Causale, 'SUBTOTALE Cat ->' + CONVERT(varchar(3), idCat)) AS Causale, SUM(Banca) AS Banca , SUM(Cassa) AS Cassa
FROM admBilancioVista --WHERE Anno = 2020
GROUP BY ROLLUP (Anno, Segno, idCat, Causale)
HAVING Anno = 2020