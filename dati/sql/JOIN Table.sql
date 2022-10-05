DECLARE
@idProfessore int = 50,
@idMateria int = 14,
@idSede int = 1

CREATE TABLE #Orario  (idSede int, idOrario int, idGiorno int, idOra int, giorno varchar(15))
CREATE TABLE #Lezioni (idSede int, idOrario int, idLezione int, impegno bit)
CREATE TABLE #Plan (idSede int, idOrario int, giorno varchar(15), idLezione int, idGiorno int, idOra int, impegno bit)

INSERT INTO #Orario  SELECT idSede, idOrario, idGiorno, idOra, giorno FROM pf_parOrariVista     WHERE idSede = @idSede
INSERT INTO #Lezioni SELECT idSede, idOrario, idLezione, impegno      FROM pf_pianoLezioniVista WHERE idSede = @idSede AND idProfessoreLez = @idProfessore AND idMateriaLez = @idMateria 
INSERT INTO #Plan    SELECT #Orario.idSede, #Orario.idOrario, #Orario.giorno, CASE WHEN #Lezioni.idLezione IS NULL THEN 0 ELSE #Lezioni.idLezione END AS idLezione, #Orario.idGiorno, #Orario.idOra, CASE WHEN #Lezioni.impegno IS NULL THEN 0 ELSE 1 END AS Prenota
FROM #Orario LEFT OUTER JOIN #Lezioni ON #Orario.idOrario = #Lezioni.idOrario

SELECT idSede, idGiorno, giorno, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3
FROM (SELECT idSede, idGiorno, giorno, idOra, CONVERT(varchar, impegno) AS impegno FROM [#Plan]) AS sourceTable PIVOT (MIN(impegno) FOR idOra IN ([1], [2], [3])) AS pivotTable

DROP TABLE #Orario
DROP TABLE #Lezioni
DROP TABLE #Plan
