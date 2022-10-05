SELECT idSede, anno, idMese, mese, settimana,  [1] AS 'LU', [2] AS 'MA', [3] AS 'ME', [4] AS 'GI', [5] AS 'VE' FROM
	(SELECT idSede, MONTH(giorno) As idMese, DATENAME(MONTH, giorno) AS mese, anno, DAY(giorno)*attivo AS giorno, settimana, giornoSettimana FROM pf_parCalendarioVista) AS sourceTable 
	PIVOT (MIN(giorno) FOR giornoSettimana IN ([1], [2], [3], [4], [5])) AS pivotTable ORDER BY idSede, anno, idMese, settimana 

	--CONVERT(varchar(10), giorno, 105) AS data,
	--attivo >= 0 AND 
	--WHERE idSede = 1 