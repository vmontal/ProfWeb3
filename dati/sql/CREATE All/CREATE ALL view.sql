USE [MSSqlProfWeb30]
GO
/****** Object:  View [dbo].[pf_parOrariVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOrariVista]
AS
SELECT dbo.pf_parOrari.idSede, dbo.pf_parOrari.idOrario, dbo.pf_parOrari.idGiorno, dbo.pf_parOrari.idOra, dbo.pf_parGiorni.giorno, dbo.pf_parOrari.impegno, dbo.pf_parOre.ora
FROM     dbo.pf_parOrari INNER JOIN
                  dbo.pf_parGiorni ON dbo.pf_parOrari.idGiorno = dbo.pf_parGiorni.idGiorno INNER JOIN
                  dbo.pf_parOre ON dbo.pf_parOrari.idSede = dbo.pf_parOre.idSede AND dbo.pf_parOrari.idOra = dbo.pf_parOre.idOra
GO
/****** Object:  View [dbo].[pf_anagrafeProfessoriVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeProfessoriVista]
AS
SELECT dbo.pf_anagrafeProfessori.idRS, dbo.pf_anagrafeProfessori.idProfessore, dbo.pf_anagrafeProfessori.nomeProf, dbo.pf_anagrafeProfessori.emailProf, dbo.pf_anagrafeProfessori.tel1Prof, dbo.pf_anagrafeProfessori.tel2Prof, 
                  dbo.pf_anagrafeProfessori.indirizzoProf, dbo.pf_anagrafeProfessori.comuneProf, dbo.pf_anagrafeProfessori.provProf, dbo.pf_anagrafeProfessori.capProf, dbo.pf_anagrafeProfessori.codiceFiscaleProf, CONVERT(VARCHAR(10), 
                  dbo.pf_anagrafeProfessori.dataNascitaProf, 105) AS dataNascitaProf, dbo.pf_anagrafeProfessori.notaProf, dbo.pf_anagrafeProfessori.deleted, dbo.pf_anagrafeProfessori.luogoNascitaProf, dbo.pf_anagrafeProfessori.emailCheck, 
                  dbo.pf_anagrafeProfessori.privacyProf, dbo.pf_anagrafeProfessori.liberaProf, dbo.pf_anagrafeProfessori.firmaProf, CONVERT(VARCHAR(10), dbo.pf_anagrafeProfessori.firmaDataProf, 105) AS firmaDataProf, 
                  dbo.pf_anagrafeProfessori.checkCode, dbo.pf_anagrafeProfessori.sediProf, dbo.pf_anagrafeProfessori.materiaProf, dbo.pf_anagrafeProfessori.lezioniPrenotate, dbo.pf_anagrafeProfessori.idTipoSocioProf, 
                  dbo.admTipoSocio.tipoSocio AS tipoSocioProf, dbo.pf_anagrafeProfessori.versione, dbo.pf_anagrafeProfessori.dataVersione, dbo.pf_anagrafeProfessori.idTipoProf, dbo.admTipoProf.tipoProf
FROM     dbo.pf_anagrafeProfessori INNER JOIN
                  dbo.admTipoSocio ON dbo.pf_anagrafeProfessori.idTipoSocioProf = dbo.admTipoSocio.idTipoSocio INNER JOIN
                  dbo.admTipoProf ON dbo.pf_anagrafeProfessori.idTipoProf = dbo.admTipoProf.idTipoProf
GO
/****** Object:  View [dbo].[pf_anagrafeStudentiStatusVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeStudentiStatusVista]
AS
SELECT idRS, idStudente, ISNULL([2], 0) AS Prenotata, ISNULL([3], 0) AS Erogata, ISNULL([4], 0) AS Disdetta
FROM     (SELECT idRS, idstudente, idstatusOfferta, count(*) AS Num
                  FROM      pf_pianoOfferte
                  WHERE   idStudente <> 0
                  GROUP BY idRS, idStudente, idStatusOfferta) AS sourceTable PIVOT (MIN(Num) FOR idStatusOfferta IN ([2], [3], [4])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_anagrafeStudentiVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeStudentiVista]
AS
SELECT dbo.pf_anagrafeStudenti.idRS, dbo.pf_anagrafeStudenti.idStudente, dbo.pf_anagrafeStudenti.nomeStud, dbo.pf_anagrafeStudenti.emailStud, dbo.pf_anagrafeStudenti.tel1Stud, dbo.pf_anagrafeStudenti.tel2Stud, 
                  dbo.pf_anagrafeStudenti.indirizzoStud, dbo.pf_anagrafeStudenti.comuneStud, dbo.pf_anagrafeStudenti.provStud, dbo.pf_anagrafeStudenti.capStud, dbo.pf_anagrafeStudenti.idIstituto, dbo.pf_anagrafeStudenti.anno, 
                  dbo.pf_anagrafeStudenti.notaStud, dbo.pf_anagrafeIstituti.ISTITUTO AS istitutoNome, dbo.pf_anagrafeIstituti.DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA AS istitutoTipo, 
                  dbo.pf_anagrafeIstituti.INDIRIZZOEMAILSCUOLA AS istitutoEmail, dbo.pf_anagrafeIstituti.INDIRIZZOPECSCUOLA AS istitutoPEC, dbo.pf_anagrafeStudenti.codiceFiscaleStud, CONVERT(VARCHAR(10), 
                  dbo.pf_anagrafeStudenti.dataNascitaStud, 105) AS dataNascitaStud, dbo.pf_anagrafeStudenti.deleted, dbo.pf_anagrafeStudenti.luogoNascitaStud, CONVERT(VARCHAR(10), dbo.pf_anagrafeStudenti.firmaDataStud, 105) 
                  AS firmaDataStud, dbo.pf_anagrafeStudenti.emailCheck, dbo.pf_anagrafeStudenti.privacyStud, dbo.pf_anagrafeStudenti.liberaStud, dbo.pf_anagrafeStudenti.firmaStud, dbo.pf_anagrafeStudenti.checkCode, 
                  dbo.pf_anagrafeStudenti.sediStud, dbo.pf_anagrafeStudenti.versione, dbo.pf_anagrafeStudenti.dataVersione, dbo.pf_anagrafeStudenti.idOrigineStud, dbo.admOrigine.origineStud, dbo.pf_anagrafeStudenti.regolamentoStud, 
                  ISNULL(dbo.pf_anagrafeStudentiStatusVista.Prenotata, 0) AS Prenotata, ISNULL(dbo.pf_anagrafeStudentiStatusVista.Erogata, 0) AS Erogata, ISNULL(dbo.pf_anagrafeStudentiStatusVista.Disdetta, 0) AS Disdetta, 
                  dbo.pf_anagrafeStudenti.idSpecial, dbo.pf_anagrafeStudenti.codiceFiscaleGen, dbo.pf_parSpecial.special
FROM     dbo.pf_anagrafeStudenti INNER JOIN
                  dbo.pf_parSpecial ON dbo.pf_anagrafeStudenti.idSpecial = dbo.pf_parSpecial.idSpecial LEFT OUTER JOIN
                  dbo.pf_anagrafeStudentiStatusVista ON dbo.pf_anagrafeStudenti.idRS = dbo.pf_anagrafeStudentiStatusVista.idRS AND dbo.pf_anagrafeStudenti.idStudente = dbo.pf_anagrafeStudentiStatusVista.idStudente LEFT OUTER JOIN
                  dbo.pf_anagrafeIstituti ON dbo.pf_anagrafeStudenti.idRS = dbo.pf_anagrafeIstituti.idRS AND dbo.pf_anagrafeStudenti.idIstituto = dbo.pf_anagrafeIstituti.CODICEISTITUTO LEFT OUTER JOIN
                  dbo.admOrigine ON dbo.pf_anagrafeStudenti.idOrigineStud = dbo.admOrigine.idOrigineStud
GO
/****** Object:  View [dbo].[pf_pianoOfferteVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOfferteVista]
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
                  dbo.pf_anagrafeStudentiVista.special
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
/****** Object:  View [dbo].[pf_pianoFoglioPresnza]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoFoglioPresnza]
AS
SELECT idRS, dataOfferta, idProfessore, nomeProf, nomeStud, materia, orario
FROM     dbo.pf_pianoOfferteVista
WHERE  (idStatusOfferta = 2)
GROUP BY idRS, dataOfferta, idProfessore, nomeProf, orario, idStudente, nomeStud, materia
GO
/****** Object:  View [dbo].[pf_pianoOffertePrenotateVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOffertePrenotateVista]
AS
SELECT TOP (100) PERCENT dbo.pf_pianoOfferteVista.idRS, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idOfferta, dbo.pf_pianoOfferteVista.idLezione, dbo.pf_pianoOfferteVista.idProfessore, dbo.pf_pianoOfferteVista.nomeProf, 
                  dbo.pf_pianoOfferteVista.emailProf, dbo.pf_pianoOfferteVista.tel1Prof, dbo.pf_pianoOfferteVista.tel2Prof, dbo.pf_pianoOfferteVista.idMateria, dbo.pf_pianoOfferteVista.materia, dbo.pf_pianoOfferteVista.idGruppo, 
                  dbo.pf_pianoOfferteVista.gruppo, CONVERT(varchar(10), dbo.pf_pianoOfferteVista.dataOfferta, 105) AS dataOfferta, dbo.pf_pianoOfferteVista.attivo, dbo.pf_pianoOfferteVista.notaOfferta, dbo.pf_pianoOfferteVista.idStatusOfferta, 
                  dbo.pf_pianoOfferteVista.statusOfferta, dbo.pf_pianoOfferteVista.idOrario, dbo.pf_pianoOfferteVista.orario, dbo.pf_pianoOfferteVista.idGiorno, dbo.pf_pianoOfferteVista.giorno, dbo.pf_pianoOfferteVista.idOra, CONVERT(varchar(5), 
                  dbo.pf_pianoOfferteVista.orario) AS ora, dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, dbo.pf_pianoOfferteVista.emailStud, dbo.pf_pianoOfferteVista.tel1Stud, dbo.pf_pianoOfferteVista.tel2Stud, 
                  dbo.pf_pianoOfferteVista.anno, dbo.pf_pianoOfferteVista.istitutoNome, dbo.pf_pianoOfferteVista.istitutoTipo, dbo.pf_pianoOfferteVista.notaStud, dbo.pf_pianoOfferteVista.anni, dbo.pf_pianoOfferteVista.wfOfferta, 
                  dbo.pf_pianoOfferteVista.deletedProf, dbo.pf_pianoOfferteVista.deletedStud, dbo.pf_parSedi.indirizzoSede + ' presso ' + dbo.pf_parSedi.descrizioneSede AS sede, dbo.pf_pianoOfferteVista.dataOfferta AS dataOffertaAMG, 
                  dbo.pf_pianoOfferteVista.gruppoStud
FROM     dbo.pf_pianoOfferteVista LEFT OUTER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferteVista.idSede = dbo.pf_parSedi.idSede
WHERE  (dbo.pf_pianoOfferteVista.attivo = 1) AND (dbo.pf_pianoOfferteVista.idStatusOfferta = 2) AND (dbo.pf_pianoOfferteVista.deletedProf = 0) AND (dbo.pf_pianoOfferteVista.deletedStud = 0)
GO
/****** Object:  View [dbo].[pf_pianoLezioniOrariVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoLezioniOrariVista]
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
                  dbo.pf_parSedi ON dbo.pf_pianoLezioni.idSede = dbo.pf_parSedi.idSede INNER JOIN
                  dbo.pf_parOrariVista ON dbo.pf_pianoLezioni.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoLezioni.idSede = dbo.pf_parOrariVista.idSede
WHERE  (dbo.pf_pianoLezioni.deleted = 0) AND (dbo.pf_anagrafeProfessori.deleted = 0) AND (dbo.pf_parOrariVista.impegno = 1) AND (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')
GO
/****** Object:  View [dbo].[pf_pianoLezioniVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoLezioniVista]
AS
SELECT dbo.pf_pianoLezioniOrariVista.idRS, dbo.pf_pianoLezioniOrariVista.idSede, dbo.pf_pianoLezioniOrariVista.idOrario, dbo.pf_pianoLezioniOrariVista.idGiorno, dbo.pf_pianoLezioniOrariVista.idOra, dbo.pf_pianoLezioniOrariVista.idLezione, 
                  dbo.pf_pianoLezioniOrariVista.idProfessoreLez, dbo.pf_pianoLezioniOrariVista.nomeProf, dbo.pf_pianoLezioniOrariVista.idMateriaLez, dbo.pf_pianoLezioniOrariVista.materia, dbo.pf_pianoLezioniOrariVista.idGruppo, 
                  dbo.pf_pianoLezioniOrariVista.gruppo, dbo.pf_pianoLezioniOrariVista.anni, dbo.pf_pianoLezioniOrariVista.frequenza, dbo.pf_pianoLezioniOrariVista.frequenzaSet, dbo.pf_pianoLezioniOrariVista.dataCreazione, 
                  dbo.pf_pianoLezioniOrariVista.giorno, dbo.pf_pianoLezioniOrariVista.impegno, ISNULL(offerte.Prenotate, 0) AS Prenotate
FROM     dbo.pf_pianoLezioniOrariVista LEFT OUTER JOIN
                      (SELECT idSede, idProfessore, idMateria, idOrario, COUNT(*) AS Prenotate
                       FROM      dbo.pf_pianoOffertePrenotateVista
                       GROUP BY idSede, idProfessore, idMateria, idOrario) AS offerte ON dbo.pf_pianoLezioniOrariVista.idSede = offerte.idSede AND dbo.pf_pianoLezioniOrariVista.idProfessoreLez = offerte.idProfessore AND 
                  dbo.pf_pianoLezioniOrariVista.idMateriaLez = offerte.idMateria AND dbo.pf_pianoLezioniOrariVista.idOrario = offerte.idOrario
GO
/****** Object:  View [dbo].[pf_pianoLezioniTotaliVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoLezioniTotaliVista]
AS
SELECT idSede, idOrario, idGiorno, idOra, COUNT(DISTINCT idProfessoreLez) AS Lezioni
FROM     dbo.pf_pianoLezioniVista
GROUP BY idSede, idOrario, idGiorno, idOra
GO
/****** Object:  View [dbo].[pf_parOrariTotaliVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOrariTotaliVista]
AS
SELECT TOP (100) PERCENT dbo.pf_parOrariVista.idSede, dbo.pf_parOrariVista.idOrario, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.idOra, dbo.pf_parOrariVista.giorno, CONVERT(varchar(8), dbo.pf_parOrariVista.ora) AS ora, 
                  dbo.pf_parOrariVista.impegno, CASE WHEN pf_parOrariVista.impegno = 0 THEN - 1 WHEN pf_parOrariVista.impegno = 1 AND pf_pianolezionitotalivista.Lezioni IS NULL THEN 0 ELSE pf_pianolezionitotalivista.Lezioni END AS Lezioni
FROM     dbo.pf_parOrariVista LEFT OUTER JOIN
                  dbo.pf_pianoLezioniTotaliVista ON dbo.pf_parOrariVista.idSede = dbo.pf_pianoLezioniTotaliVista.idSede AND dbo.pf_parOrariVista.idOrario = dbo.pf_pianoLezioniTotaliVista.idOrario
WHERE  (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')
ORDER BY dbo.pf_parOrariVista.idSede, dbo.pf_parOrariVista.idOrario
GO
/****** Object:  View [dbo].[pf_parGiorniVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parGiorniVista]
AS
SELECT idSede, idGiorno, giorno, CASE WHEN SUM(CAST(impegno AS int)) > 0 THEN 1 ELSE 0 END AS impegno
FROM     dbo.pf_parOrariTotaliVista
GROUP BY idSede, idGiorno, giorno
GO
/****** Object:  View [dbo].[pf_statMaterieAnnoVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_statMaterieAnnoVistaPivot]
AS
SELECT idSede, idMateria, materia, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
FROM     (SELECT idSede, idMateria, materia, anno
                  FROM      [pf_pianoOfferteVista] WHERE idStatusOfferta = 3) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
GO
/****** Object:  View [dbo].[admAuth]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admAuth]
AS
SELECT dbo.admUtenti.id, dbo.admUtenti.cognome, dbo.admUtenti.nome, dbo.admUtenti.provUser, dbo.admUtenti.username, dbo.admUtenti.idRuolo, ISNULL(dbo.admRuoli.ruolo, 'MASTER') AS ruolo, ISNULL(dbo.admRuoli.admin, 0) AS admin, 
                  ISNULL(dbo.admRuoli.gestione, 0) AS gestione, ISNULL(dbo.admRuoli.modifica, 0) AS modifica, ISNULL(dbo.admRuoli.lettura, 0) AS lettura, dbo.admUtenti.attivo, dbo.admUtenti.cambiaPassword, CONVERT(VARCHAR(10), 
                  dbo.admUtenti.registra, 105) AS registra, dbo.admUtenti.scadenza, CONVERT(VARCHAR(10), dbo.admUtenti.ultimo, 105) AS ultimo, dbo.admUtenti.privacyUser, CONVERT(VARCHAR(10), dbo.admUtenti.firmaDataUser, 105) 
                  AS firmaDataUser, dbo.admUtenti.liberaUser, dbo.admUtenti.checkCode, dbo.admUtenti.emailUser, dbo.admUtenti.firmaUser, dbo.admUtenti.emailCheck, CONVERT(VARCHAR(10), dbo.admUtenti.dataNascitaUser, 105) 
                  AS dataNascitaUser, dbo.admUtenti.codiceFiscaleUser, dbo.admUtenti.luogoNascitaUser, dbo.admUtenti.indirizzoUser, dbo.admUtenti.comuneUser, dbo.admUtenti.capUser, dbo.admUtenti.tel1User, dbo.admUtenti.tel2User, 
                  dbo.admUtenti.sediUser, dbo.admUtenti.idTipoSocioUser, dbo.admTipoSocio.tipoSocio AS tipoSocioUser, dbo.admUtenti.versione, dbo.admUtenti.dataVersione, dbo.admUtenti.idRS, dbo.pf_parAssociazioni.ragioneSociale, 
                  dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo, dbo.pf_parAssociazioni.sedeLegalePR, dbo.pf_parAssociazioni.sedeLegaleCAP, dbo.pf_parAssociazioni.sedeLegaleLogo, 
                  dbo.pf_parAssociazioni.sedeLegaleCF, dbo.pf_parAssociazioni.registroNR, dbo.pf_parAssociazioni.registroData, dbo.pf_parAssociazioni.sedeLegaleEmail, dbo.pf_parAssociazioni.sedeLegalePEC, dbo.pf_parAssociazioni.imgPath
FROM     dbo.admUtenti LEFT OUTER JOIN
                  dbo.admTipoSocio ON dbo.admUtenti.idTipoSocioUser = dbo.admTipoSocio.idTipoSocio LEFT OUTER JOIN
                  dbo.pf_parAssociazioni ON dbo.admUtenti.idRS = dbo.pf_parAssociazioni.idRS LEFT OUTER JOIN
                  dbo.admRuoli ON dbo.admUtenti.idRuolo = dbo.admRuoli.idRuolo
GO
/****** Object:  View [dbo].[pf_anagrafeSociVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeSociVista]
AS
SELECT idRS, nomeProf AS nominativo, emailProf AS email, tel1Prof AS tel1, idTipoSocioProf AS idTipo, tipoSocioProf AS tipoSocio, sediProf AS sedi, 'Prof' AS tipo
FROM     pf_anagrafeProfessoriVista
WHERE  deleted = 0 AND idTipoSocioProf > 0
UNION
(SELECT idRS, cognome + ' ' + nome AS nominativo, emailUser AS email, tel1User AS tel1, idTipoSocioUser AS idTipo, tipoSocioUser AS tipoSocio, sediUser AS sedi, 'User' AS tipo
 FROM      admAuth
 WHERE   attivo = 1 AND idTipoSocioUser > 0)
GO
/****** Object:  View [dbo].[pf_reportStudentiLezioniNoteVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiLezioniNoteVista]
AS
SELECT TOP (100) PERCENT idRS, idSede, idStudente, nomeStud, dataOfferta, 'Materia:' + materia + ', Prof:' + nomeProf + ', Nota:' + notaOfferta AS nota
FROM     dbo.pf_pianoOfferteVista
WHERE  (idStatusOfferta = 3)
ORDER BY idStudente, dataOfferta
GO
/****** Object:  View [dbo].[pf_parOreTotaliVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOreTotaliVista]
AS
SELECT idSede, idOra, COUNT(idProfessore) AS Lezioni
FROM     dbo.pf_pianoOfferteVista
WHERE  (idStatusOfferta = 2)
GROUP BY idSede, idOra
GO
/****** Object:  View [dbo].[pf_parOreSediVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOreSediVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_parSedi.idSede, dbo.pf_parOrdinali.idOra, dbo.pf_parOrdinali.ordinale
FROM     dbo.pf_parOrdinali CROSS JOIN
                  dbo.pf_parSedi
GO
/****** Object:  View [dbo].[pf_parOreVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOreVista]
AS
SELECT TOP (100) PERCENT dbo.pf_parOreSediVista.idRS, dbo.pf_parOreSediVista.idSede, dbo.pf_parOreSediVista.idOra, dbo.pf_parOreSediVista.ordinale, dbo.pf_parOre.ora, ISNULL(dbo.pf_parOreTotaliVista.Lezioni, 0) AS Lezioni, 
                  CASE WHEN dbo.pf_parOre.ora IS NULL OR
                  dbo.pf_parOre.ora = '00:00:00' THEN 0 ELSE 1 END AS oraAttiva
FROM     dbo.pf_parOre RIGHT OUTER JOIN
                  dbo.pf_parOreSediVista ON dbo.pf_parOre.idSede = dbo.pf_parOreSediVista.idSede AND dbo.pf_parOre.idOra = dbo.pf_parOreSediVista.idOra LEFT OUTER JOIN
                  dbo.pf_parOreTotaliVista ON dbo.pf_parOre.idSede = dbo.pf_parOreTotaliVista.idSede AND dbo.pf_parOre.idOra = dbo.pf_parOreTotaliVista.idOra
GO
/****** Object:  View [dbo].[pf_pianoOfferteTotaliVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOfferteTotaliVista]
AS
SELECT idSede, dataOfferta, COUNT(*) AS Prenotate
FROM     dbo.pf_pianoOfferte
WHERE  (idStatusOfferta = 2)
GROUP BY dataOfferta, idSede
GO
/****** Object:  View [dbo].[pf_parCalendarioVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parCalendarioVista]
AS
SELECT dbo.pf_parCalendario.idSede, dbo.pf_parCalendario.giorno, dbo.pf_parCalendario.attivo, dbo.pf_parCalendario.giornoSettimana, dbo.pf_parCalendario.nomeGiorno, dbo.pf_parCalendario.settimana, dbo.pf_parCalendario.anno, 
                  dbo.pf_parCalendario.mese, dbo.pf_parGiorniVista.impegno, CASE WHEN Prenotate IS NULL THEN 0 ELSE Prenotate END AS Prenotate
FROM     dbo.pf_parCalendario LEFT OUTER JOIN
                  dbo.pf_pianoOfferteTotaliVista ON dbo.pf_parCalendario.idSede = dbo.pf_pianoOfferteTotaliVista.idSede AND dbo.pf_parCalendario.giorno = dbo.pf_pianoOfferteTotaliVista.dataOfferta LEFT OUTER JOIN
                  dbo.pf_parGiorniVista ON dbo.pf_parCalendario.giornoSettimana = dbo.pf_parGiorniVista.idGiorno AND dbo.pf_parCalendario.idSede = dbo.pf_parGiorniVista.idSede
GO
/****** Object:  View [dbo].[pf_parCalendarioVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parCalendarioVistaPivot]
AS
SELECT idSede, anno, idMese, mese, settimana, [1] AS 'LU', [2] AS 'MA', [3] AS 'ME', [4] AS 'GI', [5] AS 'VE'
FROM     (SELECT idSede, MONTH(giorno) AS idMese, DATENAME(MONTH, giorno) AS mese, anno, CONVERT(varchar(10), DAY(giorno) * attivo) + '*L' + CONVERT (varchar(5), Prenotate) AS giorno, settimana, giornoSettimana
                  FROM      pf_parCalendarioVista) AS sourceTable PIVOT (MIN(giorno) FOR giornoSettimana IN ([1], [2], [3], [4], [5])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_parSediVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parSediVista]
AS
SELECT idRS, idSede, descrizioneSede, '123' AS ruolo, '02' AS banca
FROM     dbo.pf_parSedi
WHERE  deleted = 0
UNION
(SELECT 0 AS idRS, '0' AS idSede, 'Banca' AS descrizioneSede, '12' AS ruolo, '01' AS banca)
GO
/****** Object:  View [dbo].[admCassaMovimentiVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admCassaMovimentiVista]
AS
SELECT dbo.admCassaMovimenti.idMov, dbo.admCassaMovimenti.idProg, dbo.admCassaMovimenti.idCausale, dbo.admCassaCausali.descCausale, dbo.admCassaMovimenti.idDoc, dbo.admCassaDocumento.descDoc, dbo.admCassaCausali.idCat, 
                  dbo.admCassaCausali.idSottCat, dbo.admCassaCausali.ruolo, dbo.admCassaMovimenti.idTipoCassa, dbo.pf_parSediVista.descrizioneSede AS descCassa, dbo.admCassaCausali.banca, dbo.admCassaMovimenti.dataMov, 
                  CONVERT(varchar(10), dbo.admCassaMovimenti.dataMov, 105) AS dataMovGMA, dbo.admCassaMovimenti.importoMov, dbo.admCassaCausali.segno, dbo.admCassaMovimenti.soggettoMov, dbo.admCassaMovimenti.codiceFiscaleMov, 
                  dbo.admCassaMovimenti.deletedMov, dbo.admCassaMovimenti.notaMov, dbo.admCassaMovimenti.idRS
FROM     dbo.admCassaMovimenti LEFT OUTER JOIN
                  dbo.admCassaDocumento ON dbo.admCassaMovimenti.idDoc = dbo.admCassaDocumento.idDoc LEFT OUTER JOIN
                  dbo.pf_parSediVista ON dbo.admCassaMovimenti.idTipoCassa = dbo.pf_parSediVista.idSede LEFT OUTER JOIN
                  dbo.admCassaCausali ON dbo.admCassaMovimenti.idCausale = dbo.admCassaCausali.idCausale
GO
/****** Object:  View [dbo].[admBilancioVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admBilancioVista]
AS
SELECT idRS, Anno, idCat, Segno, Causale, ISNULL([0], 0) AS Banca, ISNULL([1], 0) + ISNULL([2], 0) AS Cassa, ISNULL([1], 0) AS CassaErnesto, ISNULL([2], 0) AS CassaBasilio, ISNULL([0], 0) + ISNULL([1], 0) + ISNULL([2], 0) AS Totale
FROM     (SELECT idRS, YEAR(dataMov) AS Anno, segno * (- 1) AS Segno, idCat, idSottcat, CASE segno WHEN 1 THEN 'E.' WHEN - 1 THEN 'U.' END + CONVERT(varchar(4), idCat) + '.' + CONVERT(varchar(5), idSottCat) + ' ' + descCausale AS Causale, 
                                    importoMov * segno AS importoMov, idTipoCassa
                  FROM      admCassaMovimentiVista) AS sourceTable PIVOT (SUM(importoMov) FOR idTipoCassa IN ([0], [1], [2])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_anagrafeGeneraleVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeGeneraleVista]
AS
SELECT idRS, idStudente AS ID, nomeStud AS nome, emailStud AS email, 'S' AS tipo, sediStud AS idSede, checkCode, versione, dataVersione, 'S' AS tipoUser
FROM     pf_anagrafeStudentiVista
WHERE  deleted = 0 AND idStudente > 0
UNION
(SELECT idRS, idProfessore AS ID, nomeProf AS nome, emailProf AS email, 'D' AS tipo, sediProf AS idSede, checkCode, versione, dataVersione, CASE WHEN idTipoSocioProf > 0 THEN 'A' ELSE 'D' END AS tipoUser
 FROM      pf_anagrafeProfessoriVista
 WHERE   deleted = 0 AND idProfessore > 0)
UNION
(SELECT idRS, ID AS ID, UPPER(cognome) + ' ' + UPPER(nome) AS nome, emailUser AS email, 'G' AS tipo, sediUser AS idSede, checkCode, versione, dataVersione, CASE WHEN idTipoSocioUser > 0 THEN 'A' ELSE 'D' END AS tipoUser
 FROM      admAuth
 WHERE   attivo = 1 AND idRuolo < 4)
GO
/****** Object:  View [dbo].[pf_reportDocentiVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportDocentiVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessori.nomeProf, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, 
                  COUNT(dbo.pf_pianoOfferte.idStatusOfferta) AS NR
FROM     dbo.pf_anagrafeProfessori INNER JOIN
                  dbo.pf_pianoOfferte ON dbo.pf_anagrafeProfessori.idProfessore = dbo.pf_pianoOfferte.idProfessore INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferte.idSede = dbo.pf_parSedi.idSede
WHERE  (dbo.pf_parStatusOfferte.report = 1)
GROUP BY dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessori.nomeProf, dbo.pf_pianoOfferte.idSede, dbo.pf_parSedi.idRS
HAVING (dbo.pf_pianoOfferte.idProfessore > 0)
GO
/****** Object:  View [dbo].[pf_reportDocentiVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportDocentiVistaPivot]
AS
SELECT idSede, idProfessore, nomeProf, [1] AS disponibile, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [5] AS disdettaProf, [12] AS inevasa
FROM     (SELECT idSede, idProfessore, nomeProf, idStatusOfferta, NR
                  FROM      pf_reportDocentiVista) AS sourceTable PIVOT (MIN(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable
GO
/****** Object:  View [dbo].[admBilancioVistaRollup]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admBilancioVistaRollup]
AS
SELECT idRS, Anno, ISNULL(ISNULL(Causale, 'SUBTOTALE Cat.' + CONVERT(varchar(3), idCat)), IIF(SUM(Totale) > 0, 'TOTALE ENTRATE ', 'TOTALE USCITE')) AS Causale, SUM(Banca) AS Banca, SUM(Cassa) AS Cassa, SUM(Totale) AS Totale
FROM     dbo.admBilancioVista
GROUP BY ROLLUP (idRS, Anno, Segno, idCat, Causale)
GO
/****** Object:  View [dbo].[pf_reportStudentiVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudenti.nomeStud, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, 
                  COUNT(dbo.pf_pianoOfferte.idStatusOfferta) AS NR
FROM     dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_anagrafeStudenti ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudenti.idStudente INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferte.idSede = dbo.pf_parSedi.idSede
WHERE  (dbo.pf_parStatusOfferte.report = 1)
GROUP BY dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudenti.nomeStud, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idSede, dbo.pf_parSedi.idRS
HAVING (dbo.pf_pianoOfferte.idStudente > 0)
GO
/****** Object:  View [dbo].[pf_reportStudentiVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiVistaPivot]
AS
SELECT idStudente, nomeStud, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [7] AS assente, [11] AS attesa
FROM     (SELECT  idStudente, nomeStud, idStatusOfferta, NR
                  FROM      pf_reportStudentiVista) AS sourceTable PIVOT (SUM(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_reportMaterieVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportMaterieVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, COUNT(dbo.pf_pianoOfferte.idStatusOfferta) 
                  AS NR
FROM     dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferte.idSede = dbo.pf_parSedi.idSede
WHERE  (dbo.pf_parStatusOfferte.report = 1)
GROUP BY dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idSede, dbo.pf_parSedi.idRS
HAVING (dbo.pf_pianoOfferte.idMateria > 0)
GO
/****** Object:  View [dbo].[pf_reportMaterieVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportMaterieVistaPivot]
AS
SELECT idSede, idMateria, materia, [1] AS disponibile, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [5] AS disdettaProf, [12] AS inevasa
FROM     (SELECT idSede, idMateria, materia, idStatusOfferta, NR
                  FROM      pf_reportMaterieVista) AS sourceTable PIVOT (MIN(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_reportStudentiLezioniErogateVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiLezioniErogateVista]
AS
SELECT dbo.pf_pianoOfferteVista.idRS, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) 
                  + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) AS Periodo, COUNT(dbo.pf_pianoOfferteVista.idStatusOfferta) AS NR, dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta
FROM     dbo.pf_pianoOfferteVista INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferteVista.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta
GROUP BY dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta, CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) 
                  + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)), dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idRS
HAVING (dbo.pf_pianoOfferteVista.idStudente > 0) AND (dbo.pf_pianoOfferteVista.idStatusOfferta = 3)
GO
/****** Object:  View [dbo].[pf_reportStudentiLezioniDettaglioVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiLezioniDettaglioVista]
AS
SELECT dbo.pf_pianoOfferteVista.idRS, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.idMateria, dbo.pf_pianoOfferteVista.materia, dbo.pf_pianoOfferteVista.nomeStud, 
                  CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) AS Periodo, COUNT(dbo.pf_pianoOfferteVista.idStatusOfferta) AS NR, 
                  dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta
FROM     dbo.pf_pianoOfferteVista INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferteVista.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta
GROUP BY dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta, CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) 
                  + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)), dbo.pf_pianoOfferteVista.idMateria, dbo.pf_pianoOfferteVista.materia, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idRS
HAVING (dbo.pf_pianoOfferteVista.idStudente > 0) AND (dbo.pf_pianoOfferteVista.idStatusOfferta = 3)
GO
/****** Object:  View [dbo].[pf_reportStudentiDocentiDettaglioVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_reportStudentiDocentiDettaglioVista]
AS
SELECT dbo.pf_pianoOfferteVista.idRS, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.idProfessore, dbo.pf_pianoOfferteVista.nomeProf, dbo.pf_pianoOfferteVista.nomeStud, 
                  CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) AS Periodo, COUNT(dbo.pf_pianoOfferteVista.idStatusOfferta) AS NR, 
                  dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta
FROM     dbo.pf_pianoOfferteVista INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferteVista.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta
GROUP BY dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta, CAST(YEAR(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)) 
                  + ' - ' + CAST(MONTH(dbo.pf_pianoOfferteVista.dataOfferta) AS VARCHAR(4)), dbo.pf_pianoOfferteVista.idProfessore, dbo.pf_pianoOfferteVista.nomeProf, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idRS
HAVING (dbo.pf_pianoOfferteVista.idStudente > 0) AND (dbo.pf_pianoOfferteVista.idStatusOfferta = 3)
GO
/****** Object:  View [dbo].[pf_parAssociazioniVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parAssociazioniVista]
AS
SELECT dbo.pf_parAssociazioni.*, dbo.pf_anagrafeSociVista.nominativo AS presidente, dbo.pf_anagrafeSociVista.idTipo
FROM     dbo.pf_parAssociazioni INNER JOIN
                  dbo.pf_anagrafeSociVista ON dbo.pf_parAssociazioni.idRS = dbo.pf_anagrafeSociVista.idRS
WHERE  (dbo.pf_anagrafeSociVista.idTipo = 3)
GO
/****** Object:  View [dbo].[pf_parMaterieVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parMaterieVista]
AS
SELECT dbo.pf_parMaterie.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, LEFT(dbo.pf_parMaterieGruppo.gruppo, 4) + CONVERT(VARCHAR(2), dbo.pf_parMaterie.idGruppo) 
                  + CONVERT(VARCHAR(2), dbo.pf_parMaterie.idMateria) AS keyMateria
FROM     dbo.pf_parMaterie LEFT OUTER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo
WHERE  (dbo.pf_parMaterie.deleted = 0)
GO
/****** Object:  View [dbo].[pf_pianoRichiesteVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoRichiesteVista]
AS
SELECT dbo.pf_pianoRichieste.idRichiesta, dbo.pf_pianoRichieste.idStudente, dbo.pf_anagrafeStudentiVista.nomeStud, dbo.pf_pianoRichieste.idMateria, dbo.pf_parMaterieVista.materia, dbo.pf_pianoRichieste.dataRichiesta, 
                  dbo.pf_pianoRichieste.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoRichieste.notaRichiesta, dbo.pf_pianoRichieste.idOfferta, dbo.pf_anagrafeStudentiVista.anno, dbo.pf_anagrafeStudentiVista.istitutoTipo, 
                  dbo.pf_anagrafeStudentiVista.deleted
FROM     dbo.pf_pianoRichieste INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoRichieste.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoRichieste.idStudente = dbo.pf_anagrafeStudentiVista.idStudente INNER JOIN
                  dbo.pf_parMaterieVista ON dbo.pf_pianoRichieste.idMateria = dbo.pf_parMaterieVista.idMateria
WHERE  (dbo.pf_anagrafeStudentiVista.deleted = 0)
GO
/****** Object:  View [dbo].[pf_pianoOfferteReportVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOfferteReportVista]
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
                  dbo.pf_parAssociazioni.sedeLegaleLogo, dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo
FROM     dbo.pf_parAssociazioni INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_parAssociazioni.idRS = dbo.pf_parSedi.idRS RIGHT OUTER JOIN
                  dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_anagrafeProfessoriVista ON dbo.pf_pianoOfferte.idProfessore = dbo.pf_anagrafeProfessoriVista.idProfessore INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta LEFT OUTER JOIN
                  dbo.pf_parOrariVista ON dbo.pf_pianoOfferte.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoOfferte.idSede = dbo.pf_parOrariVista.idSede ON dbo.pf_parSedi.idSede = dbo.pf_pianoOfferte.idSede LEFT OUTER JOIN
                  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudentiVista.idStudente
WHERE  (CASE WHEN dbo.pf_anagrafeProfessoriVista.deleted = 1 AND dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END = 1)
GO
/****** Object:  View [dbo].[pf_parOrariVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parOrariVistaPivot]
AS
SELECT idSede, idGiorno, giorno, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
FROM     (SELECT idSede, idGiorno, giorno, idOra, CONVERT(varchar, Lezioni) AS impegno
                  FROM      [pf_parOrariTotaliVista]) AS sourceTable PIVOT (MIN(impegno) FOR idOra IN ([1], [2], [3],[4],[5])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_pianoLezioniVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoLezioniVistaPivot]
AS
SELECT idSede, idGiorno, giorno, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
FROM     (SELECT idSede, idGiorno, giorno, idOra, nomeProf, materia, 'Docente:' + nomeProf + ',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + ',freqenza:' + frequenza + ',id:' + CONVERT(varchar, idLezione) AS Lezione
                  FROM      [pf_pianoLezioniVista]) AS sourceTable PIVOT (MIN(Lezione) FOR idOra IN ([1], [2], [3],[4],[5])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_pianoOfferteVistaPivot]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOfferteVistaPivot]
AS
SELECT idRS, idSede, idGiorno, idMateria, deletedProf, giorno + ' - ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
FROM     (SELECT idRS, idSede, idGiorno, idMateria, deletedProf, giorno, dataOfferta, idOra, nomeProf, materia, 'prof:' + nomeProf + ',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + ',' + CASE WHEN nomeStud IS NULL 
                                    THEN 'Studente: -- ' ELSE 'Studente:' + nomeStud END + ',anno:' + CONVERT(varchar, anno) + ',Status:' + statusOfferta + ',idStatus:' + CONVERT(varchar, idStatusOfferta) + ',id:' + CONVERT(varchar, idOfferta) 
                                    + ',idStudente:' + CONVERT(varchar, idStudente) AS Offerta
                  FROM      pf_pianoOfferteVista
                  WHERE   attivo = 1 OR
                                    idStatusOfferta = 5) AS sourceTable PIVOT (MIN(Offerta) FOR idOra IN ([1], [2], [3], [4], [5])) AS pivotTable
GO
/****** Object:  View [dbo].[pf_pianoOfferteErogateVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_pianoOfferteErogateVista]
AS
SELECT TOP (100) PERCENT idSede, idOfferta, idLezione, idProfessore, idMateria, nomeStud, materia, CONVERT(varchar(10), dataOfferta, 105) AS dataOfferta, dataOfferta AS dataOffertaAMG, notaOfferta, argomentoOfferta, idStatusOfferta, 
                  statusOfferta, CONVERT(varchar(5), orario) AS ora, idStudente, deletedProf
FROM     dbo.pf_pianoOfferteVista
WHERE  (idStatusOfferta = 3) AND (deletedProf = 0) AND (deletedStud = 0) OR
                  (idStatusOfferta = 2)
GO
/****** Object:  View [dbo].[admAssembleeVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admAssembleeVista]
AS
SELECT dbo.admAssemblee.idRS, dbo.admAssemblee.idAss, dbo.admAssemblee.idTipoAss, dbo.admTipoAss.tipoAss, CONVERT(varchar(10), dbo.admAssemblee.dataAss, 105) AS dataAss, CONVERT(varchar(10), DATEADD(DAY, - 1, 
                  dbo.admAssemblee.dataAss), 105) AS dataAssPrima, dbo.admAssemblee.oraAss, dbo.admAssemblee.luogoAss, dbo.admAssemblee.indirizzoAss, dbo.admAssemblee.oggettoAss, dbo.admAssemblee.odgAss, CONVERT(varchar(10), 
                  dbo.admAssemblee.dataInvio, 105) AS dataInvio, dbo.admAssemblee.inviata, dbo.admAssemblee.straord, dbo.admAssemblee.conferma
FROM     dbo.admAssemblee INNER JOIN
                  dbo.admTipoAss ON dbo.admAssemblee.idTipoAss = dbo.admTipoAss.idTipoAss
GO
/****** Object:  View [dbo].[admCassaCausaliVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admCassaCausaliVista]
AS
SELECT idCausale, idCat, idSottCat, CASE WHEN segno > 0 THEN 'E.' ELSE 'U.' END + CONVERT(varchar(2), idCat) + '.' + CONVERT(varchar(2), idSottCat) AS tipo, descCausale, segno, ruolo, banca, giro
FROM     dbo.admCassaCausali
GO
/****** Object:  View [dbo].[pf_anagrafeIstitutiVista]    Script Date: 26/07/2020 09:02:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_anagrafeIstitutiVista]
AS
SELECT idRS, CODICEISTITUTO, ISTITUTO, DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA, INDIRIZZO, CAP, COMUNE, PROVINCIA, REGIONE, INDIRIZZOEMAILSCUOLA, INDIRIZZOPECSCUOLA, SITOWEBSCUOLA, deleted
FROM     dbo.pf_anagrafeIstituti
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[44] 4[28] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[50] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[51] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admAssemblee"
            Begin Extent = 
               Top = 8
               Left = 47
               Bottom = 383
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "admTipoAss"
            Begin Extent = 
               Top = 17
               Left = 330
               Bottom = 178
               Right = 552
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 996
         Width = 1116
         Width = 2196
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2076
         Width = 3024
         Width = 2304
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5376
         Alias = 2304
         Table = 2748
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAssembleeVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAssembleeVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[50] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[75] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admUtenti"
            Begin Extent = 
               Top = 27
               Left = 32
               Bottom = 318
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 23
         End
         Begin Table = "admTipoSocio"
            Begin Extent = 
               Top = 32
               Left = 706
               Bottom = 172
               Right = 928
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 202
               Left = 579
               Bottom = 388
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "admRuoli"
            Begin Extent = 
               Top = 12
               Left = 333
               Bottom = 226
               Right = 571
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 53
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAuth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5976
         Alias = 1848
         Table = 2412
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAuth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAuth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[49] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 972
         Width = 792
         Width = 948
         Width = 1176
         Width = 4956
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[26] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[50] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 816
         Width = 1200
         Width = 4704
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVistaRollup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVistaRollup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[33] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admCassaCausali"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 234
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1560
         Width = 4884
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5040
         Alias = 900
         Table = 1824
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaCausaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaCausaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[41] 4[28] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[57] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[52] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admCassaMovimenti"
            Begin Extent = 
               Top = 38
               Left = 40
               Bottom = 419
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admCassaDocumento"
            Begin Extent = 
               Top = 243
               Left = 689
               Bottom = 384
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSediVista"
            Begin Extent = 
               Top = 287
               Left = 380
               Bottom = 406
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admCassaCausali"
            Begin Extent = 
               Top = 13
               Left = 376
               Bottom = 229
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 756
         Width = 1092
         Width = 1128
         Width = 2892
         Width = 816
         Width = 1464
         Width = 780
         Width = 708
         Width = 960
         Width = 1296
         Width = 2004
         Width = 1956
         Width = 1200
         Width = 708
         Width = 2220
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaMovimentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 
      Begin ColumnWidths = 11
         Column = 4008
         Alias = 2244
         Table = 2640
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaMovimentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaMovimentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[35] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 672
         Width = 1008
         Width = 2844
         Width = 3012
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeGeneraleVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeGeneraleVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[40] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_anagrafeIstituti"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 230
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2016
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeIstitutiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeIstitutiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[47] 4[29] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_anagrafeProfessori"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 313
               Right = 316
            End
            DisplayFlags = 280
            TopColumn = 20
         End
         Begin Table = "admTipoSocio"
            Begin Extent = 
               Top = 33
               Left = 416
               Bottom = 152
               Right = 638
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admTipoProf"
            Begin Extent = 
               Top = 179
               Left = 416
               Bottom = 298
               Right = 638
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 26
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1620
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4956
         Alias = 2076
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeProfessoriVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeProfessoriVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeProfessoriVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1056
         Width = 2724
         Width = 3096
         Width = 1200
         Width = 696
         Width = 1896
         Width = 504
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeSociVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeSociVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[25] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1140
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeStudentiStatusVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeStudentiStatusVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[75] 4[13] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[73] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[49] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[60] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4[60] 2) )"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_anagrafeStudenti"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 409
               Right = 308
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "pf_anagrafeStudentiStatusVista"
            Begin Extent = 
               Top = 28
               Left = 550
               Bottom = 230
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeIstituti"
            Begin Extent = 
               Top = 250
               Left = 666
               Bottom = 522
               Right = 935
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admOrigine"
            Begin Extent = 
               Top = 411
               Left = 420
               Bottom = 530
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSpecial"
            Begin Extent = 
               Top = 94
               Left = 963
               Bottom = 247
               Right = 1185
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 37
         Width = 284
         Width = 1200
         Width = 1200
         Width = 2664
         Width = 4308
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Width = 1188
         Width = 1200
         Width = 2724
         Width = 1860
         Width = 2052
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2928
         Alias = 3276
         Table = 1812
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_anagrafeStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 14
               Left = 44
               Bottom = 223
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeSociVista"
            Begin Extent = 
               Top = 7
               Left = 323
               Bottom = 265
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1860
         Alias = 1680
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parAssociazioniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parAssociazioniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[51] 4[31] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[28] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[43] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parCalendario"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 273
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parGiorniVista"
            Begin Extent = 
               Top = 13
               Left = 768
               Bottom = 267
               Right = 990
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoOfferteTotaliVista"
            Begin Extent = 
               Top = 143
               Left = 455
               Bottom = 314
               Right = 750
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2976
         Alias = 1512
         Table = 3936
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parCalendarioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parCalendarioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parCalendarioVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parCalendarioVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[33] 4[42] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parOrariTotaliVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 5808
         Alias = 924
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1404
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parGiorniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parGiorniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[30] 4[46] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 26
               Left = 46
               Bottom = 192
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterieGruppo"
            Begin Extent = 
               Top = 18
               Left = 333
               Bottom = 197
               Right = 644
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 3360
         Width = 1200
         Width = 1200
         Width = 2652
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4680
         Alias = 900
         Table = 1920
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parMaterieVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parMaterieVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[36] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[42] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[42] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parOrariVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 289
               Right = 274
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoLezioniTotaliVista"
            Begin Extent = 
               Top = 0
               Left = 394
               Bottom = 205
               Right = 691
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5220
         Alias = 900
         Table = 1956
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[43] 4[41] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[41] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[43] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parOrari"
            Begin Extent = 
               Top = 17
               Left = 48
               Bottom = 224
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parGiorni"
            Begin Extent = 
               Top = 30
               Left = 710
               Bottom = 177
               Right = 932
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOre"
            Begin Extent = 
               Top = 103
               Left = 404
               Bottom = 277
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1200
         Width = 1308
         Width = 1128
         Width = 924
         Width = 1932
         Width = 1164
         Width = 1356
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 3216
         Alias = 900
         Table = 1536
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[24] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOrariVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[25] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 7
               Left = 318
               Bottom = 170
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOrdinali"
            Begin Extent = 
               Top = 20
               Left = 43
               Bottom = 139
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreSediVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreSediVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 205
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[30] 4[30] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[39] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parOre"
            Begin Extent = 
               Top = 28
               Left = 341
               Bottom = 203
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOreSediVista"
            Begin Extent = 
               Top = 22
               Left = 22
               Bottom = 208
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "pf_parOreTotaliVista"
            Begin Extent = 
               Top = 29
               Left = 650
               Bottom = 186
               Right = 872
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5076
         Alias = 1980
         Table = 2856
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parOreVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[44] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1320
         Width = 732
         Width = 2160
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parSediVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parSediVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 252
               Right = 291
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 4164
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 2652
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoFoglioPresnza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoFoglioPresnza'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[13] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[51] 4[21] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[60] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[56] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoLezioni"
            Begin Extent = 
               Top = 26
               Left = 373
               Bottom = 314
               Right = 581
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeProfessori"
            Begin Extent = 
               Top = 20
               Left = 899
               Bottom = 257
               Right = 1160
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 288
               Left = 903
               Bottom = 461
               Right = 1125
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterieGruppo"
            Begin Extent = 
               Top = 266
               Left = 1168
               Bottom = 419
               Right = 1417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parFrequenza"
            Begin Extent = 
               Top = 202
               Left = 635
               Bottom = 321
               Right = 857
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 8
               Left = 649
               Bottom = 171
               Right = 871
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOrariVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
            ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniOrariVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 20
         Width = 284
         Width = 732
         Width = 816
         Width = 828
         Width = 864
         Width = 972
         Width = 1104
         Width = 1020
         Width = 2832
         Width = 1200
         Width = 1200
         Width = 876
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2892
         Alias = 3912
         Table = 2700
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniOrariVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniOrariVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[25] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoLezioniVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 219
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2304
         Alias = 1188
         Table = 2076
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[31] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[41] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[75] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[44] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4[40] 2) )"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "offerte"
            Begin Extent = 
               Top = 29
               Left = 518
               Bottom = 242
               Right = 740
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoLezioniOrariVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 279
               Right = 311
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2388
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 4248
         Alias = 1428
         Table = 2244
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[25] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1056
         Width = 8652
         Width = 3744
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoLezioniVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[43] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[36] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 6
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 294
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 17
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
         Width = 284
         Width = 924
         Width = 1032
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1992
         Width = 1704
         Width = 1200
         Width = 1548
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3228
         Alias = 2724
         Table = 3336
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteErogateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteErogateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[51] 4[37] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[47] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[36] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 345
               Right = 363
            End
            DisplayFlags = 280
            TopColumn = 41
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 5
               Left = 497
               Bottom = 361
               Right = 719
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 38
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1272
         Width = 2220
         Width = 2208
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2196
         Width = 2460
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2172
         Width = 2484
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 4848
         Alias = 1956
         Table = 2184
         Output = 720
         Append = 14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOffertePrenotateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOffertePrenotateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOffertePrenotateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 7
               Left = 323
               Bottom = 170
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 7
               Left = 593
               Bottom = 170
               Right = 815
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeProfessoriVista"
            Begin Extent = 
               Top = 7
               Left = 863
               Bottom = 170
               Right = 1085
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 7
               Left = 1133
               Bottom = 170
               Right = 1355
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterieGruppo"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 316
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 175
               Left = 318
               Bottom = 338
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteReportVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Right = 552
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOrariVista"
            Begin Extent = 
               Top = 175
               Left = 600
               Bottom = 338
               Right = 822
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeStudentiVista"
            Begin Extent = 
               Top = 175
               Left = 870
               Bottom = 338
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteReportVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteReportVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[46] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 304
               Right = 311
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 1296
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1968
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteTotaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[61] 4[14] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[78] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[54] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[48] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 286
               Left = 1116
               Bottom = 518
               Right = 1343
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 205
               Left = 820
               Bottom = 434
               Right = 1038
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 39
               Left = 26
               Bottom = 442
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 35
               Left = 676
               Bottom = 204
               Right = 887
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterieGruppo"
            Begin Extent = 
               Top = 11
               Left = 950
               Bottom = 156
               Right = 1159
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 479
               Left = 732
               Bottom = 709
               Right = 977
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeProfessoriVista"
            Begin Extent = 
               Top = 13
               Left = 391
               Bottom = 198
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'               Right = 668
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parOrariVista"
            Begin Extent = 
               Top = 217
               Left = 509
               Bottom = 468
               Right = 710
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeStudentiVista"
            Begin Extent = 
               Top = 413
               Left = 327
               Bottom = 650
               Right = 603
            End
            DisplayFlags = 280
            TopColumn = 32
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 51
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1740
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 6024
         Alias = 2040
         Table = 2712
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[51] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 708
         Width = 1536
         Width = 1764
         Width = 1044
         Width = 1704
         Width = 1536
         Width = 2220
         Width = 1704
         Width = 1200
         Width = 1200
         Width = 1644
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoOfferteVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoRichieste"
            Begin Extent = 
               Top = 60
               Left = 33
               Bottom = 302
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 117
               Left = 701
               Bottom = 329
               Right = 935
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeStudentiVista"
            Begin Extent = 
               Top = 5
               Left = 340
               Bottom = 170
               Right = 617
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "pf_parMaterieVista"
            Begin Extent = 
               Top = 208
               Left = 342
               Bottom = 376
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1044
         Width = 1044
         Width = 1488
         Width = 1248
         Width = 2964
         Width = 1200
         Width = 1380
         Width = 1200
         Width = 3924
         Width = 1200
         Width = 1200
         Width = 2736
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1908
         Alias = 900
         Table = 1812
         Output = 720
         Append' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoRichiesteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoRichiesteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_pianoRichiesteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[29] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[53] 4[22] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[60] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_anagrafeProfessori"
            Begin Extent = 
               Top = 14
               Left = 484
               Bottom = 177
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 23
               Left = 104
               Bottom = 368
               Right = 342
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 221
               Left = 514
               Bottom = 406
               Right = 764
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 160
               Left = 876
               Bottom = 323
               Right = 1114
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1536
         Width = 2448
         Width = 2556
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2184
         Alias = 900
         Table = 2568
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1932
         Filte' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportDocentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'r = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportDocentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportDocentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[29] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1200
         Width = 1164
         Width = 2484
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportDocentiVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportDocentiVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[35] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[53] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 20
               Left = 84
               Bottom = 314
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 231
               Left = 458
               Bottom = 386
               Right = 708
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 142
               Left = 848
               Bottom = 305
               Right = 1086
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 0
               Left = 530
               Bottom = 163
               Right = 768
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 2064
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 3612
         Alias = 1380
         Table = 2640
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1944
         Filter = 1356
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportMaterieVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportMaterieVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportMaterieVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[20] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4[60] 2) )"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1404
         Width = 2508
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportMaterieVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportMaterieVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[39] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 279
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 7
               Left = 334
               Bottom = 170
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiDocentiDettaglioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiDocentiDettaglioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[48] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 281
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 7
               Left = 334
               Bottom = 170
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1932
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniDettaglioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniDettaglioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[34] 4[35] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 214
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 7
               Left = 334
               Bottom = 228
               Right = 584
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 2040
         Width = 2004
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2544
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1716
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniErogateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniErogateVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[26] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferteVista"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 289
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2124
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniNoteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiLezioniNoteVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[57] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_pianoOfferte"
            Begin Extent = 
               Top = 32
               Left = 77
               Bottom = 274
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_anagrafeStudenti"
            Begin Extent = 
               Top = 16
               Left = 465
               Bottom = 179
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parStatusOfferte"
            Begin Extent = 
               Top = 214
               Left = 472
               Bottom = 384
               Right = 706
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSedi"
            Begin Extent = 
               Top = 166
               Left = 809
               Bottom = 329
               Right = 1047
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1608
         Width = 1848
         Width = 2064
         Width = 2340
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 4104
         Alias = 900
         Table = 2232
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1788
         Filter =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[27] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 2136
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_reportStudentiVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[33] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[21] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1200
         Width = 1032
         Width = 1452
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_statMaterieAnnoVistaPivot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_statMaterieAnnoVistaPivot'
GO
