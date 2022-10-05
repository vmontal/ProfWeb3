--USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_anagrafeProfessoriVista]    Script Date: 25/08/2021 12:32:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_anagrafeProfessoriVista]
AS
SELECT dbo.pf_anagrafeProfessori.idRS, dbo.pf_anagrafeProfessori.idProfessore, dbo.pf_anagrafeProfessori.nomeProf, dbo.pf_anagrafeProfessori.emailProf, dbo.pf_anagrafeProfessori.tel1Prof, dbo.pf_anagrafeProfessori.tel2Prof, 
                  dbo.pf_anagrafeProfessori.indirizzoProf, dbo.pf_anagrafeProfessori.comuneProf, dbo.pf_anagrafeProfessori.provProf, dbo.pf_anagrafeProfessori.capProf, dbo.pf_anagrafeProfessori.codiceFiscaleProf, CONVERT(VARCHAR(10), 
                  dbo.pf_anagrafeProfessori.dataNascitaProf, 105) AS dataNascitaProf, dbo.pf_anagrafeProfessori.notaProf, dbo.pf_anagrafeProfessori.deleted, dbo.pf_anagrafeProfessori.luogoNascitaProf, dbo.pf_anagrafeProfessori.emailCheck, 
                  dbo.pf_anagrafeProfessori.privacyProf, dbo.pf_anagrafeProfessori.liberaProf, dbo.pf_anagrafeProfessori.firmaProf, CONVERT(VARCHAR(10), dbo.pf_anagrafeProfessori.firmaDataProf, 105) AS firmaDataProf, 
                  dbo.pf_anagrafeProfessori.checkCode, dbo.pf_anagrafeProfessori.sediProf, dbo.pf_anagrafeProfessori.materiaProf, dbo.pf_anagrafeProfessori.lezioniPrenotate, dbo.pf_anagrafeProfessori.idTipoSocioProf, 
                  dbo.admTipoSocio.tipoSocio AS tipoSocioProf, dbo.pf_anagrafeProfessori.versione, dbo.pf_anagrafeProfessori.dataVersione, dbo.pf_anagrafeProfessori.idTipoProf, dbo.admTipoProf.tipoProf, dbo.pf_anagrafeProfessori.distanza, 
                  dbo.pf_anagrafeProfessori.modoLezione, dbo.pf_anagrafeProfessori.docTipoProf, dbo.pf_anagrafeProfessori.docNumeroProf, dbo.pf_anagrafeProfessori.docRilascioProf, CONVERT(varchar(10), 
                  dbo.pf_anagrafeProfessori.docDataEProf, 105) AS docDataEProf, CONVERT(varchar(10), dbo.pf_anagrafeProfessori.docDataSProf, 105) AS docDataSProf
FROM     dbo.pf_anagrafeProfessori INNER JOIN
                  dbo.admTipoSocio ON dbo.pf_anagrafeProfessori.idTipoSocioProf = dbo.admTipoSocio.idTipoSocio INNER JOIN
                  dbo.admTipoProf ON dbo.pf_anagrafeProfessori.idTipoProf = dbo.admTipoProf.idTipoProf
GO


