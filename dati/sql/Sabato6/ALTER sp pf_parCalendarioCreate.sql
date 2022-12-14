USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parCalendarioCreate]    Script Date: 23/02/2022 15:38:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <14/05/2019>
-- Description:	<Genera i giorni di calendario per l'anno scolastico in corso>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parCalendarioCreate] 

@idRS int,
@idSede varchar(1), 
@dataInizio date, 
@dataFine date,

@delete int,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE 
@giorno date,
@attivo int


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @giorno = @dataInizio

	WHILE @giorno <= @dataFine
		BEGIN
			IF DATEPART(WEEKDAY, @giorno) <= 6
				BEGIN
					SET @attivo = CASE WHEN NOT EXISTS (SELECT dataFestivo FROM pf_parFestivi WHERE dataFestivo = @giorno) THEN 1 ELSE -1 END
					IF NOT EXISTS (SELECT giorno FROM pf_parCalendario WHERE giorno = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS)
						BEGIN
							INSERT INTO pf_parCalendario (idSede, giorno, attivo) VALUES (@idSede, @giorno, @attivo)										
						END
					ELSE
						BEGIN
							UPDATE pf_parCalendario SET giorno = @giorno, attivo = @attivo WHERE giorno = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS
						END

					EXEC pf_pianoOfferteCreate @idRS, @idSede, @giorno, @giorno, 0, 0, '0'
				END

			SET @giorno = DATEADD(DAY, 1, @giorno)
		END

	SET @OK = 1

	RETURN @OK
	
END