USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parSediUpdate]    Script Date: 23/02/2022 16:03:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <14/07/2020>
-- Description:	<Aggiorna Sedi>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parSediUpdate] 

@idRS int,
@idSede varchar(1), 
@descrizioneSede varchar(250), 
@indirizzoSede varchar(250), 
@luogoSede varchar(200),
@capSede varchar(5),
@provSede varchar(2),
@tel1Sede varchar(50),
@tel2Sede varchar(50),
@emailSede varchar(200),
--@imgPath varchar(200),
--@imgFile varchar(200),

@spUpdate varchar(2),
@delete bit,
@deletedSede bit,
@OK int = 0 OUTPUT


AS

DECLARE
@ultimo_idSede varchar(1),
@nuovo_idSede varchar(1)

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idSede = '0'
		BEGIN
			SET @ultimo_idSede = (SELECT MAX(idSede) FROM pf_parSedi)
			IF ASCII(@ultimo_idSede) > 48 AND ASCII(@ultimo_idSede) < 57
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END
			ELSE IF ASCII(@ultimo_idSede) = 57 
				BEGIN
					SET @nuovo_idSede = CHAR(65)
				END
			ELSE IF ASCII(@ultimo_idSede) >= 65 AND ASCII(@ultimo_idSede) < 90
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END
			ELSE IF ASCII(@ultimo_idSede) = 90
				BEGIN
					SET @nuovo_idSede = CHAR(97)
				END
			ELSE IF ASCII(@ultimo_idSede) >= 97 AND ASCII(@ultimo_idSede) < 122
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END

			INSERT INTO pf_parSedi (idRS,  idSede,        descrizioneSede,  indirizzoSede,  luogoSede,  capSede,  provSede,  tel1Sede,  tel2Sede,  emailSede)
							VALUES (@idRS, @nuovo_idSede, @descrizioneSede, @indirizzoSede, @luogoSede, @capSede, @provSede, @tel1Sede, @tel2Sede, @emailSede)
			
			SET @idSede = (SELECT idSede FROM pf_parSedi WHERE descrizioneSede = @descrizioneSede AND idRS = @idRS)
			
			UPDATE pf_anagrafeStudenti   SET sediStud = sediStud + @idSede WHERE idStudente = 0
			UPDATE pf_anagrafeProfessori SET sediProf = sediProf + @idSede WHERE idProfessore = 0

			EXEC pf_parOrariCreate @idSede, 0, '', 0
			EXEC pf_parOreCreate @idRS, @idSede, 0, ''

			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE pf_parSedi
				SET descrizioneSede = @descrizioneSede,
					indirizzoSede = @indirizzoSede,
					luogoSede = @luogoSede,
					capSede = @capSede,
					provSede = @provSede,
					tel1Sede = @tel1Sede,
					tel2Sede = @tel2Sede,
					emailSede = @emailSede,
					--imgPath = @imgPath,
					--imgFile = @imgFile,
					deleted = @deletedSede
				WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idRS = @idRS

			SET @OK = 3
		END

	RETURN @OK
END