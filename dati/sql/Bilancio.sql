SELECT Anno,
		Causale,		
		ISNULL([0], 0) AS Banca,
		ISNULL([1], 0) + ISNULL([2], 0) AS Cassa, 
		ISNULL([1], 0) AS CassaErnesto, 
		ISNULL([2], 0) AS CassaBasilio
FROM 
	(SELECT YEAR(dataMov) AS Anno,
				segno * (-1) AS Segno,
				idCat, idSottcat,
				CASE segno WHEN 1 THEN 'E.' WHEN -1 THEN 'U.' END + CONVERT(varchar(4), idCat) + '.' + CONVERT(varchar(5), idSottCat) + ' ' + descCausale AS Causale, 
				importoMov * segno AS importoMov, 
				idTipoCassa
		FROM admCassaVista 
		WHERE YEAR(dataMov) = 2020
	) AS sourceTable
	PIVOT (SUM(importoMov) FOR idTipoCassa IN ([0], [1], [2])) AS pivotTable