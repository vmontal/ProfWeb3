USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_pianoLezioniOrariVista]    Script Date: 01/09/2021 18:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_pianoLezioniOrariVista]
AS
SELECT TOP (100) PERCENT dbo.pf_parSedi.idRS, dbo.pf_parOrariVista.idSede, dbo.pf_parOrariVista.idOrario, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.idOra, dbo.pf_pianoLezioni.idLezione, 
                  dbo.pf_pianoLezioni.idProfessore AS idProfessoreLez, dbo.pf_anagrafeProfessori.nomeProf, dbo.pf_pianoLezioni.idMateria AS idMateriaLez, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, 
                  dbo.pf_parOrariVista.ora AS orario, dbo.pf_pianoLezioni.anni, dbo.pf_pianoLezioni.frequenza, dbo.pf_parFrequenza.frequenzaSet, dbo.pf_pianoLezioni.dataCreazione, dbo.pf_parOrariVista.giorno, dbo.pf_parOrariVista.impegno, 
                  CONVERT(varchar(8), dbo.pf_parOrariVista.ora) AS oraFiltro
FROM     dbo.pf_pianoLezioni INNER JOIN
                  dbo.pf_anagrafeProfessori ON dbo.pf_pianoLezioni.idProfessore = dbo.pf_anagrafeProfessori.idProfessore INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoLezioni.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
                  dbo.pf_parFrequenza ON dbo.pf_pianoLezioni.frequenza = dbo.pf_parFrequenza.frequenza INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoLezioni.idSede = dbo.pf_parSedi.idSede AND dbo.pf_parMaterie.idRS = dbo.pf_parSedi.idRS INNER JOIN
                  dbo.pf_parOrariVista ON dbo.pf_pianoLezioni.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoLezioni.idSede = dbo.pf_parOrariVista.idSede
WHERE  (dbo.pf_pianoLezioni.deleted = 0) AND (dbo.pf_anagrafeProfessori.deleted = 0) AND (dbo.pf_parOrariVista.impegno = 1) AND (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')
GO


