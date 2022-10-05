USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_parMaterieVista]    Script Date: 26/01/2022 16:43:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_parMaterieVista]
AS
SELECT dbo.pf_parMaterie.idRS, dbo.pf_parMaterie.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, LEFT(dbo.pf_parMaterieGruppo.gruppo, 4) + CONVERT(VARCHAR(2), 
                  dbo.pf_parMaterie.idGruppo) + CONVERT(VARCHAR(2), dbo.pf_parMaterie.idMateria) AS keyMateria, dbo.pf_parMaterie.deleted, dbo.pf_parMaterie.richiesteStud, dbo.pf_parMaterie.richiesteProf
FROM     dbo.pf_parMaterie LEFT OUTER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo
GO


