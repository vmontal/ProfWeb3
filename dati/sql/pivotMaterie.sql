SELECT * FROM (
SELECT idSede, idMateria, materia, idGiorno,  giorno, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3
FROM     (SELECT idSede, idMateria, idGiorno, giorno, dataOfferta, idOra,  materia, idStatusOfferta AS Offerta
                  FROM pf_pianoOfferteVista
                  WHERE attivo = 1 AND idStatusOfferta = 2 --OR idStatusOfferta = 1
				  )
		 AS sourceTable PIVOT (COUNT(Offerta) FOR idOra IN ([1], [2], [3])) AS pivotTable) AS pivotMaterie

		 WHERE idMateria = 14  AND idSede = 1 AND dataOfferta >= GETDATE()
		 
		 ORDER BY dataOfferta



