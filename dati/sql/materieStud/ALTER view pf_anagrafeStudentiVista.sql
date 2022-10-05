USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_anagrafeStudentiVista]    Script Date: 26/10/2021 17:00:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_anagrafeStudentiVista]
AS
SELECT dbo.pf_anagrafeStudenti.idRS, dbo.pf_anagrafeStudenti.idStudente, dbo.pf_anagrafeStudenti.nomeStud, dbo.pf_anagrafeStudenti.nomeStud + ' - ' + dbo.pf_anagrafeStudenti.emailStud AS rifStud, dbo.pf_anagrafeStudenti.emailStud, 
                  dbo.pf_anagrafeStudenti.tel1Stud, dbo.pf_anagrafeStudenti.tel2Stud, dbo.pf_anagrafeStudenti.indirizzoStud, dbo.pf_anagrafeStudenti.comuneStud, dbo.pf_anagrafeStudenti.provStud, dbo.pf_anagrafeStudenti.capStud, 
                  dbo.pf_anagrafeStudenti.idIstituto, dbo.pf_anagrafeStudenti.anno, dbo.pf_anagrafeStudenti.notaStud, dbo.pf_anagrafeIstituti.ISTITUTO AS istitutoNome, 
                  dbo.pf_anagrafeIstituti.DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA AS istitutoTipo, dbo.pf_anagrafeIstituti.ISTITUTO + ' - ' + dbo.pf_anagrafeIstituti.DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA AS istitutoNomeTipo, 
                  dbo.pf_anagrafeIstituti.INDIRIZZOEMAILSCUOLA AS istitutoEmail, dbo.pf_anagrafeIstituti.INDIRIZZOPECSCUOLA AS istitutoPEC, dbo.pf_anagrafeStudenti.codiceFiscaleStud, CONVERT(VARCHAR(10), 
                  dbo.pf_anagrafeStudenti.dataNascitaStud, 105) AS dataNascitaStud, dbo.pf_anagrafeStudenti.deleted, dbo.pf_anagrafeStudenti.luogoNascitaStud, CONVERT(VARCHAR(10), dbo.pf_anagrafeStudenti.firmaDataStud, 105) 
                  AS firmaDataStud, dbo.pf_anagrafeStudenti.emailCheck, dbo.pf_anagrafeStudenti.privacyStud, dbo.pf_anagrafeStudenti.liberaStud, dbo.pf_anagrafeStudenti.firmaStud, dbo.pf_anagrafeStudenti.checkCode, 
                  dbo.pf_anagrafeStudenti.sediStud, dbo.pf_anagrafeStudenti.versione, dbo.pf_anagrafeStudenti.dataVersione, dbo.pf_anagrafeStudenti.idOrigineStud, dbo.admOrigine.origineStud, dbo.pf_anagrafeStudenti.regolamentoStud, 
                  ISNULL(dbo.pf_anagrafeStudentiStatusVista.Prenotata, 0) AS Prenotata, ISNULL(dbo.pf_anagrafeStudentiStatusVista.Erogata, 0) AS Erogata, ISNULL(dbo.pf_anagrafeStudentiStatusVista.Disdetta, 0) AS Disdetta, 
                  dbo.pf_anagrafeStudenti.idSpecial, dbo.pf_anagrafeStudenti.codiceFiscaleGen, dbo.pf_parSpecial.special, dbo.pf_anagrafeStudenti.docTipoStud, dbo.pf_anagrafeStudenti.docNumeroStud, dbo.pf_anagrafeStudenti.docRilascioStud, 
                  CONVERT(varchar(10), dbo.pf_anagrafeStudenti.docDataEStud, 105) AS docDataEStud, CONVERT(varchar(10), dbo.pf_anagrafeStudenti.docDataSStud, 105) AS docDataSStud, dbo.pf_anagrafeStudenti.docTipoGen, 
                  dbo.pf_anagrafeStudenti.docNumeroGen, dbo.pf_anagrafeStudenti.docRilascioGen, CONVERT(varchar(10), dbo.pf_anagrafeStudenti.docDataEGen, 105) AS docDataEGen, CONVERT(varchar(10), dbo.pf_anagrafeStudenti.docDataSGen, 
                  105) AS docDataSGen, dbo.pf_anagrafeStudenti.emailStudAltro, 'Tel:' + dbo.pf_anagrafeStudenti.tel1Stud + ' ,Email:' + dbo.pf_anagrafeStudenti.emailStud AS contactStud, dbo.pf_anagrafeStudenti.materiaStud
FROM     dbo.pf_anagrafeStudenti INNER JOIN
                  dbo.pf_parSpecial ON dbo.pf_anagrafeStudenti.idSpecial = dbo.pf_parSpecial.idSpecial LEFT OUTER JOIN
                  dbo.pf_anagrafeStudentiStatusVista ON dbo.pf_anagrafeStudenti.idRS = dbo.pf_anagrafeStudentiStatusVista.idRS AND dbo.pf_anagrafeStudenti.idStudente = dbo.pf_anagrafeStudentiStatusVista.idStudente LEFT OUTER JOIN
                  dbo.pf_anagrafeIstituti ON dbo.pf_anagrafeStudenti.idRS = dbo.pf_anagrafeIstituti.idRS AND dbo.pf_anagrafeStudenti.idIstituto = dbo.pf_anagrafeIstituti.CODICEISTITUTO LEFT OUTER JOIN
                  dbo.admOrigine ON dbo.pf_anagrafeStudenti.idOrigineStud = dbo.admOrigine.idOrigineStud
GO


