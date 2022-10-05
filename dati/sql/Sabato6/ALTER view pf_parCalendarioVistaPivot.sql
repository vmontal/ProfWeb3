USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_parCalendarioVistaPivot]    Script Date: 03/03/2022 08:25:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_parCalendarioVistaPivot]
AS
SELECT idSede, anno, idMese, mese, settimana, [1] AS 'LU', [2] AS 'MA', [3] AS 'ME', [4] AS 'GI', [5] AS 'VE', [6] AS 'SA'
FROM     (SELECT idSede, MONTH(giorno) AS idMese, DATENAME(MONTH, giorno) AS mese, anno, CONVERT(varchar(10), DAY(giorno) * attivo) + '*L' + CONVERT(varchar(5), Prenotate) AS giorno, settimana, giornoSettimana
                  FROM      pf_parCalendarioVista) AS sourceTable PIVOT (MIN(giorno) FOR giornoSettimana IN ([1], [2], [3], [4], [5], [6])) AS pivotTable
GO


