SELECT idGiorno, Giorno, [1] AS Prima, [2] AS Seconda, [3] AS Terza 
    FROM (SELECT DISTINCT Giorno, idGiorno, idOra, idProfessoreLez FROM pf_pianoLezioniVista WHERE idSede = 1) AS sourceTable
 PIVOT (COUNT(idProfessoreLez) FOR idOra IN ([1], [2], [3])) AS pivotTable
