USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaStudentiUpdate]    Script Date: 13/01/2022 13:23:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <11/01/2022>
-- Description:	<Aggiorna Studenti dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaStudentiUpdate] 

@idRS int,
@idOrigineStud int,
@origineStud varchar(1),
@primo int,
@secondo int,
@terzo int,
@quarto int,
@quinto int,
@totaleStud int,

@spUpdate varchar(2),
--@delete bit,
@OK int = 0 OUTPUT


AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idOrigineStud = -1
		BEGIN
			INSERT INTO pf_dbItaliaStudenti (idRS,  idOrigineStud,  primo,  secondo,  terzo,  quarto,  quinto)
									 VALUES (@idRS, @idOrigineStud, @primo, @secondo, @terzo, @quarto, @quinto)
			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE pf_dbItaliaStudenti 
				SET idOrigineStud = @idOrigineStud,
					primo = @primo,
					secondo = @secondo,
					terzo = @terzo,
					quarto = @quarto,
					quinto = @quinto					
				WHERE idRS = @idRS AND idOrigineStud = @idOrigineStud

			SET @OK = 3
		END

	RETURN @OK
END