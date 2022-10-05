USE [MSSql171182]
GO

/****** Object:  View [dbo].[admAuth]    Script Date: 11/01/2022 11:56:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[admAuth]
AS
SELECT dbo.admUtenti.id, dbo.admUtenti.cognome, dbo.admUtenti.nome, dbo.admUtenti.provUser, dbo.admUtenti.username, dbo.admUtenti.idRuolo, ISNULL(dbo.admRuoli.ruolo, 'MASTER') AS ruolo, ISNULL(dbo.admRuoli.admin, 0) AS admin, 
                  ISNULL(dbo.admRuoli.gestione, 0) AS gestione, ISNULL(dbo.admRuoli.modifica, 0) AS modifica, ISNULL(dbo.admRuoli.lettura, 0) AS lettura, dbo.admUtenti.attivo, dbo.admUtenti.cambiaPassword, CONVERT(VARCHAR(10), 
                  dbo.admUtenti.registra, 105) AS registra, dbo.admUtenti.scadenza, CONVERT(VARCHAR(10), dbo.admUtenti.ultimo, 105) AS ultimo, dbo.admUtenti.privacyUser, CONVERT(VARCHAR(10), dbo.admUtenti.firmaDataUser, 105) 
                  AS firmaDataUser, dbo.admUtenti.liberaUser, dbo.admUtenti.checkCode, dbo.admUtenti.emailUser, dbo.admUtenti.firmaUser, dbo.admUtenti.emailCheck, CONVERT(VARCHAR(10), dbo.admUtenti.dataNascitaUser, 105) 
                  AS dataNascitaUser, dbo.admUtenti.codiceFiscaleUser, dbo.admUtenti.luogoNascitaUser, dbo.admUtenti.indirizzoUser, dbo.admUtenti.comuneUser, dbo.admUtenti.capUser, dbo.admUtenti.tel1User, dbo.admUtenti.tel2User, 
                  dbo.admUtenti.sediUser, dbo.admUtenti.idTipoSocioUser, dbo.admTipoSocio.tipoSocio AS tipoSocioUser, dbo.admUtenti.versione, dbo.admUtenti.dataVersione, dbo.admUtenti.idRS, dbo.pf_parAssociazioni.ragioneSociale, 
                  dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo, dbo.pf_parAssociazioni.sedeLegalePR, dbo.pf_parAssociazioni.sedeLegaleCAP, dbo.pf_parAssociazioni.sedeLegaleLogo, 
                  dbo.pf_parAssociazioni.sedeLegaleCF, dbo.pf_parAssociazioni.registroNR, dbo.pf_parAssociazioni.registroData, dbo.pf_parAssociazioni.sedeLegaleEmail, dbo.pf_parAssociazioni.sedeLegalePEC, dbo.pf_parAssociazioni.imgPath, 
                  dbo.pf_parAssociazioni.prof
FROM     dbo.admUtenti LEFT OUTER JOIN
                  dbo.admTipoSocio ON dbo.admUtenti.idTipoSocioUser = dbo.admTipoSocio.idTipoSocio LEFT OUTER JOIN
                  dbo.pf_parAssociazioni ON dbo.admUtenti.idRS = dbo.pf_parAssociazioni.idRS LEFT OUTER JOIN
                  dbo.admRuoli ON dbo.admUtenti.idRuolo = dbo.admRuoli.idRuolo
GO


