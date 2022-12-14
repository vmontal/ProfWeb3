USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_statOrigineStudentiAnno_Erogate]    Script Date: 30/08/2021 16:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[pf_statOrigineStudentiAnno_Erogate]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)


AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZ', @idSede)

	(
	SELECT idOrigineStud, origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
			FROM (SELECT idOrigineStud, origineStud, anno 
					FROM [pf_pianoOfferteReportVista] 
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND idSede <= @idSedeMax AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable			
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
