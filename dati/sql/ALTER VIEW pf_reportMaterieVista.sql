USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[pf_reportMaterieVista]    Script Date: 08/07/2021 16:24:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_reportMaterieVista]
AS
SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, COUNT(dbo.pf_pianoOfferte.idStatusOfferta) 
                  AS NR
FROM     dbo.pf_pianoOfferte INNER JOIN
                  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
                  dbo.pf_parSedi ON dbo.pf_pianoOfferte.idSede = dbo.pf_parSedi.idSede AND dbo.pf_parMaterie.idRS = dbo.pf_parSedi.idRS
WHERE  (dbo.pf_parStatusOfferte.report = 1)
GROUP BY dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idSede, dbo.pf_parSedi.idRS
HAVING (dbo.pf_pianoOfferte.idMateria > 0)
GO


