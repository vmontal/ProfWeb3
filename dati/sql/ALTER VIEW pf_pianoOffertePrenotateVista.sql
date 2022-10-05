USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_pianoOffertePrenotateVista]    Script Date: 04/10/2020 09:23:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_pianoOffertePrenotateVista]
AS
SELECT TOP (100) PERCENT dbo.pf_pianoOfferteVista.idRS, dbo.pf_pianoOfferteVista.idSede, dbo.pf_pianoOfferteVista.idOfferta, dbo.pf_pianoOfferteVista.idLezione, dbo.pf_pianoOfferteVista.idProfessore, 
                  dbo.pf_pianoOfferteVista.nomeProf + CASE WHEN dbo.pf_pianoOfferteVista.distanza = 1 THEN ' a Distanza' ELSE ' di Presenza' END AS nomeProf, dbo.pf_pianoOfferteVista.emailProf, dbo.pf_pianoOfferteVista.tel1Prof, 
                  dbo.pf_pianoOfferteVista.tel2Prof, dbo.pf_pianoOfferteVista.idMateria, dbo.pf_pianoOfferteVista.materia, dbo.pf_pianoOfferteVista.idGruppo, dbo.pf_pianoOfferteVista.gruppo, CONVERT(varchar(10), 
                  dbo.pf_pianoOfferteVista.dataOfferta, 105) AS dataOfferta, dbo.pf_pianoOfferteVista.attivo, dbo.pf_pianoOfferteVista.notaOfferta, dbo.pf_pianoOfferteVista.idStatusOfferta, dbo.pf_pianoOfferteVista.statusOfferta, 
                  dbo.pf_pianoOfferteVista.idOrario, dbo.pf_pianoOfferteVista.orario, dbo.pf_pianoOfferteVista.idGiorno, dbo.pf_pianoOfferteVista.giorno, dbo.pf_pianoOfferteVista.idOra, CONVERT(varchar(5), dbo.pf_pianoOfferteVista.orario) AS ora, 
                  dbo.pf_pianoOfferteVista.idStudente, dbo.pf_pianoOfferteVista.nomeStud, dbo.pf_pianoOfferteVista.emailStud, dbo.pf_pianoOfferteVista.tel1Stud, dbo.pf_pianoOfferteVista.tel2Stud, dbo.pf_pianoOfferteVista.anno, 
                  dbo.pf_pianoOfferteVista.istitutoNome, dbo.pf_pianoOfferteVista.istitutoTipo, dbo.pf_pianoOfferteVista.notaStud, dbo.pf_pianoOfferteVista.anni, dbo.pf_pianoOfferteVista.wfOfferta, dbo.pf_pianoOfferteVista.deletedProf, 
                  dbo.pf_pianoOfferteVista.deletedStud, dbo.pf_parSedi.indirizzoSede + ' presso ' + dbo.pf_parSedi.descrizioneSede AS sede, dbo.pf_pianoOfferteVista.dataOfferta AS dataOffertaAMG, dbo.pf_pianoOfferteVista.gruppoStud, 
                  dbo.pf_pianoOfferteVista.distanza
FROM     dbo.pf_pianoOfferteVista LEFT OUTER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferteVista.idSede = dbo.pf_parSedi.idSede
WHERE  (dbo.pf_pianoOfferteVista.attivo = 1) AND (dbo.pf_pianoOfferteVista.idStatusOfferta = 2) AND (dbo.pf_pianoOfferteVista.deletedProf = 0) AND (dbo.pf_pianoOfferteVista.deletedStud = 0)
GO


