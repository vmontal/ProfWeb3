USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_pianoOfferteVistaPivot]    Script Date: 05/09/2022 17:17:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[pf_pianoOfferteVistaPivot]
AS
SELECT idRS, idSede, idGiorno, idMateria, idStatusOfferta, deletedProf, giorno + ' - ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5, [6] AS Ora6
FROM     (SELECT idRS, idSede, idGiorno, idMateria, idStatusOfferta, deletedProf, giorno, dataOfferta, idOra, nomeProf, materia, 
								'prof:' + nomeProf + 
								',Didattica:' + IIF(idStatusOfferta = 1, '-------', distanzaDesc) + -- IIF(CONVERT(int, distanza) = 0, 'Presenza' ,'Distanza'))  + 
								',Disp. Docente:' + modoLezioneDesc + -- CASE WHEN modoLezione = 0 THEN 'Completa' WHEN modoLezione = 1 THEN 'Presenza' WHEN modoLezione = 2 THEN 'Distanza' END + --IIF(CONVERT(int, modoLezione) = 0, 'Presenza' ,'Distanza')  +
								',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + 
								',Studente:' + ISNULL(nomeStud, '--') + IIF(gruppoStud = 1, ' (+N)','') + 
								',anno:' + ISNULL(anno, '0') + ',Status:' + statusOfferta + 
								',idStatus:' + CONVERT(varchar, idStatusOfferta) + 
								',id:' + CONVERT(varchar, idOfferta) +
								',idStudente:' + CONVERT(varchar, idStudente) AS Offerta
						  FROM    pf_pianoOfferteVista
						  WHERE   attivo = 1 OR idStatusOfferta = 5) 
					AS sourceTable PIVOT (MIN(Offerta) FOR idOra IN ([1], [2], [3], [4], [5], [6])) AS pivotTable
GO


