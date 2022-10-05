USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_parAssociazioniVista]    Script Date: 11/01/2022 11:52:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_parAssociazioniVista]
AS
SELECT dbo.pf_parAssociazioni.idRS, dbo.pf_parAssociazioni.ragioneSociale, dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo, dbo.pf_parAssociazioni.sedeLegalePR, 
                  dbo.pf_parAssociazioni.sedeLegaleCAP, dbo.pf_parAssociazioni.sedeLegaleTEL1, dbo.pf_parAssociazioni.sedeLegaleTEL2, dbo.pf_parAssociazioni.sedeLegaleEmail, dbo.pf_parAssociazioni.sedeLegalePEC, 
                  dbo.pf_parAssociazioni.sedeLegaleCF, dbo.pf_parAssociazioni.registroNR, dbo.pf_parAssociazioni.registroData, dbo.pf_parAssociazioni.sedeLegaleLogo, dbo.pf_parAssociazioni.imgPath, dbo.pf_parAssociazioni.deletedAss, 
                  dbo.pf_parAssociazioni.prof, dbo.pf_anagrafeSociVista.nominativo AS presidente, dbo.pf_anagrafeSociVista.idTipo
FROM     dbo.pf_parAssociazioni INNER JOIN
                  dbo.pf_anagrafeSociVista ON dbo.pf_parAssociazioni.idRS = dbo.pf_anagrafeSociVista.idRS
WHERE  (dbo.pf_anagrafeSociVista.idTipo = 3)
GO


