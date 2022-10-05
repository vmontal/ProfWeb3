USE [MSSqlProfWeb20]
GO

IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVistaPivot', 'U') IS NOT NULL
	DROP TABLE #tmp_pianoOfferteVistaPivot; 

 CREATE TABLE #tmp_pianoOfferteVistaPivot  (idSede int, idGiorno int, idMateria int, deletedProf bit, dataOffertaGMA varchar(23), dataOfferta date,
           Ora1 varchar(920), Ora2 varchar(920), Ora3 varchar(920))
GO


