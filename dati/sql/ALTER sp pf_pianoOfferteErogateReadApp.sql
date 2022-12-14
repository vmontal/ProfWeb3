USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOffertePrenotateReadApp]    Script Date: 29/10/2019 17:19:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <29/01/2019>
-- Description:	<Legge Piano Offerte Erogate per App>
-- =============================================

ALTER PROCEDURE [dbo].[pf_pianoOfferteErogateReadApp]


@idOfferta int, 
@idStatusOfferta int, 
@idStud int,
@idMat int,
@emailUser varchar(100),
@tipo varchar(1),

@delete int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS
--DECLARE
--@idStudMin int = 0,
--@idStudMax int = 10000000,

--@idProfMin int = 0,
--@idProfMax int = 10000000,

--@idSede int,
--@idSedeMin int = 0,
--@idSedeMax int = 10000000

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	--SET @idSede = (SELECT idSede FROM pf_anagrafeGeneraleVista WHERE email = @emailUser AND tipo = @tipo)

	--IF @idStud > 0
	--	BEGIN
	--		SET @idStudMin = @idStud
	--		SET @idStudMax = @idStud
	--	END
	
	--IF @idProf > 0
	--	BEGIN
	--		SET @idProfMin = @idProf
	--		SET @idProfMax = @idProf
	--	END	
		
	--IF LEN(@idSede) = 1
	--	BEGIN
	--		SET @idSedeMin = @idSede
	--		SET @idSedeMax = @idSede
	--	END
	
	SELECT * FROM pf_pianoOfferteErogateVista 
	WHERE idStudente = @idStud AND idMateria = @idMat --IN (@idSede) dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	ORDER BY idMateria, dataOffertaAMG

END
