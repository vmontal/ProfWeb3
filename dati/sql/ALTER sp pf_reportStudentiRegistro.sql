USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_reportStudentiRegistro]    Script Date: 17/10/2019 18:02:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[pf_reportStudentiRegistro]

@idStudente int,

@spRead varchar(1),
@tabella varchar(1),
@idSede int

AS

BEGIN
	SET NOCOUNT ON;

	SELECT idStudente, CONVERT(varchar(10), dataOfferta, 105) AS dataOfferta, materia, nomeProf, argomentoOfferta, notaOfferta
	FROM pf_pianoOfferteVista 
	WHERE idStudente = @idStudente AND  idStatusOfferta = 3
	ORDER BY dataOfferta, materia

END
