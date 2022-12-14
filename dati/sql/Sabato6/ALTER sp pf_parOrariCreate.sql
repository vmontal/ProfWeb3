USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parOrariCreate]    Script Date: 23/02/2022 16:04:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <27/02/2020>
-- Description:	<CREA Orari>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parOrariCreate]

--@idOrario int,
@idSede varchar(1), 

@delete bit,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@totOre int = 5,
@runOre int = 1,
@idGiorno int = 1


BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	--SET @totOre = (SELECT COUNT(idOra) FROM pf_parOre WHERE idSede = @idSede)

	WHILE @runOre <= @totOre
		BEGIN
			WHILE @idGiorno <= 6
				BEGIN
					IF NOT EXISTS (SELECT idOra FROM pf_parOrari WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idOra = @runOre AND idGiorno = @idGiorno)
						BEGIN
							INSERT INTO pf_parOrari (idSede, idOra, idGiorno, impegno)
											VALUES (@idSede, @runOre, @idGiorno, 1)
						END
					SET @idGiorno = @idGiorno + 1
				
				END				
			SET @runOre = @runOre + 1
			SET @idGiorno = 1

		END

	SET @OK = 1

	RETURN @OK
END