USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_pianoOfferteVista]    Script Date: 03/10/2020 19:29:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_pianoOfferteVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idOfferta, dbo.pf_pianoOfferte.idLezione, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessoriVista.nomeProf, dbo.pf_anagrafeProfessoriVista.emailProf, 
                  dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, dbo.pf_pianoOfferte.dataOfferta, dbo.pf_pianoOfferte.attivo, dbo.pf_pianoOfferte.notaOfferta, 
                  dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idOrario, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.giorno, dbo.pf_parOrariVista.idOra, CONVERT(varchar(8), 
                  dbo.pf_parOrariVista.ora) AS orario, dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudentiVista.nomeStud, dbo.pf_anagrafeStudentiVista.emailStud, dbo.pf_anagrafeStudentiVista.tel1Stud, dbo.pf_anagrafeStudentiVista.tel2Stud, 
                  dbo.pf_anagrafeStudentiVista.anno, dbo.pf_anagrafeStudentiVista.istitutoNome, dbo.pf_anagrafeStudentiVista.istitutoTipo, dbo.pf_anagrafeStudentiVista.notaStud, dbo.pf_pianoOfferte.anni, dbo.pf_parStatusOfferte.wfOfferta, 
                  dbo.pf_anagrafeProfessoriVista.deleted AS deletedProf, dbo.pf_anagrafeStudentiVista.deleted AS deletedStud, dbo.pf_anagrafeProfessoriVista.tel1Prof, dbo.pf_anagrafeProfessoriVista.tel2Prof, dbo.pf_parOrariVista.impegno, 
                  dbo.pf_pianoOfferte.frequenza, dbo.pf_parSedi.indirizzoSede + ' presso ' + dbo.pf_parSedi.descrizioneSede AS sede, CASE WHEN dbo.pf_anagrafeProfessoriVista.deleted = 1 AND 
                  dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END AS visibled, CASE WHEN dbo.pf_pianoOfferte.attivo = 0 AND dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END AS untouch, dbo.pf_pianoOfferte.argomentoOfferta, 
                  dbo.pf_anagrafeStudentiVista.idOrigineStud, dbo.pf_anagrafeStudentiVista.origineStud, dbo.pf_anagrafeProfessoriVista.idTipoProf, dbo.pf_anagrafeProfessoriVista.tipoProf, dbo.pf_parAssociazioni.ragioneSociale, 
                  dbo.pf_parAssociazioni.sedeLegaleLogo, dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo, dbo.pf_pianoOfferte.gruppoStud, dbo.pf_anagrafeStudentiVista.idSpecial, 
                  dbo.pf_anagrafeStudentiVista.special, dbo.pf_anagrafeProfessoriVista.distanza
FROM     dbo.pf_parAssociazioni INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_parAssociazioni.idRS = dbo.pf_parSedi.idRS RIGHT OUTER JOIN
                  dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta LEFT OUTER JOIN
                  dbo.pf_anagrafeProfessoriVista ON dbo.pf_pianoOfferte.idProfessore = dbo.pf_anagrafeProfessoriVista.idProfessore LEFT OUTER JOIN
                  dbo.pf_parOrariVista ON dbo.pf_pianoOfferte.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoOfferte.idSede = dbo.pf_parOrariVista.idSede ON dbo.pf_parSedi.idSede = dbo.pf_pianoOfferte.idSede LEFT OUTER JOIN
                  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudentiVista.idStudente
WHERE  (dbo.pf_parOrariVista.impegno = 1) AND (CASE WHEN dbo.pf_anagrafeProfessoriVista.deleted = 1 AND dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END = 1) AND (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')
GO


