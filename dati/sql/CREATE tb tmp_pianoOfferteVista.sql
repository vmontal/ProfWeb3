USE [MSSqlProfWeb20]
GO



IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVista', 'U') IS NOT NULL
	DROP TABLE #tmp_pianoOfferteVista; 

CREATE TABLE #tmp_pianoOfferteVista (idSede int ,idOfferta int, idLezione int, idProfessore int, nomeProf varchar(200), 
      emailProf varchar(200), idMateria int, materia varchar(200), idGruppo int, gruppo varchar(20), dataOfferta date, 
      attivo bit, notaOfferta varchar(255), idStatusOfferta int, statusOfferta varchar(100), idOrario int, orario varchar(43),
      idGiorno int, giorno varchar(10), idOra int, ora time(0), idStudente int, nomeStud varchar(200), emailStud varchar(200),
      tel1Stud varchar(20), tel2Stud varchar(20), anno varchar(1), istitutoNome varchar(50), istitutoTipo varchar(60), notaStud varchar(255),
      anni varchar(5), wfOfferta varchar(8), deletedProf bit, deletedStud bit, tel1Prof varchar(20), tel2Prof varchar(20), 
      impegno bit, frequenza varchar(1))
GO

DECLARE
@idStatus int = 2 

INSERT INTO #tmp_pianoOfferteVista 

SELECT dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idOfferta, dbo.pf_pianoOfferte.idLezione, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessoriVista.nomeProf, dbo.pf_anagrafeProfessoriVista.emailProf, 
                  dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, dbo.pf_pianoOfferte.dataOfferta, dbo.pf_pianoOfferte.attivo, dbo.pf_pianoOfferte.notaOfferta, 
                  dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idOrario, dbo.pf_parOrariVista.orario, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.giorno, dbo.pf_parOrariVista.idOra, 
                  dbo.pf_parOrariVista.ora, dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudentiVista.nomeStud, dbo.pf_anagrafeStudentiVista.emailStud, dbo.pf_anagrafeStudentiVista.tel1Stud, dbo.pf_anagrafeStudentiVista.tel2Stud, 
                  dbo.pf_anagrafeStudentiVista.anno, dbo.pf_anagrafeStudentiVista.istitutoNome, dbo.pf_anagrafeStudentiVista.istitutoTipo, dbo.pf_anagrafeStudentiVista.notaStud, dbo.pf_pianoOfferte.anni, dbo.pf_parStatusOfferte.wfOfferta, 
                  dbo.pf_anagrafeProfessoriVista.deleted AS deletedProf, dbo.pf_anagrafeStudentiVista.deleted AS deletedStud, dbo.pf_anagrafeProfessoriVista.tel1Prof, dbo.pf_anagrafeProfessoriVista.tel2Prof, dbo.pf_parOrariVista.impegno, 
                  dbo.pf_pianoOfferte.frequenza
FROM     dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_anagrafeProfessoriVista ON dbo.pf_pianoOfferte.idProfessore = dbo.pf_anagrafeProfessoriVista.idProfessore INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_parOrariVista ON dbo.pf_pianoOfferte.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoOfferte.idSede = dbo.pf_parOrariVista.idSede LEFT OUTER JOIN
                  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudentiVista.idStudente
WHERE  (dbo.pf_parOrariVista.impegno = 1 AND dbo.pf_pianoOfferte.idStatusOfferta = @idStatus)
GO

SELECT idSede, idGiorno, idMateria, deletedProf, giorno + ' - ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3
FROM     (SELECT idSede, idGiorno, idMateria, deletedProf, giorno, dataOfferta, idOra, nomeProf, materia, 'prof:' + nomeProf + ',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + ',' + CASE WHEN nomeStud IS NULL 
                                    THEN 'Studente: -- ' ELSE 'Studente:' + nomeStud END + ',anno:' + CONVERT(varchar, anno) + ',Status:' + statusOfferta + ',idStatus:' + CONVERT(varchar, idStatusOfferta) + ',id:' + CONVERT(varchar, idOfferta) 
                                    + ',idStudente:' + CONVERT(varchar, idStudente) AS Offerta
                  FROM    #tmp_pianoOfferteVista
                  WHERE   attivo = 1 OR idStatusOfferta = 5) 
			AS sourceTable PIVOT (MIN(Offerta) FOR idOra IN ([1], [2], [3])) AS pivotTable

--SELECT * FROM #tmp_pianoOfferteVista
GO


