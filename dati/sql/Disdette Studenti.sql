--inserire una pivot su campo status offerta 

SELECT idStudente, nomeStud, ISNULL([2], 0) AS Prenotata, ISNULL([3], 0) AS Erogata, ISNULL([4], 0) AS Disdetta FROM
(SELECT idstudente, nomeStud, idstatusOfferta, count(*) AS Num
FROM pf_pianoOfferteVista 
WHERE idStudente <> 0
GROUP BY idStudente, nomeStud, idStatusOfferta
) AS sourceTable
PIVOT (MIN(Num) FOR idStatusOfferta IN ([2],[3],[4])) AS pivotTable