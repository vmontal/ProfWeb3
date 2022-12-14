USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeStudentiUpdate]    Script Date: 01/09/2021 10:20:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Anagrafe Studenti>
-- =============================================

ALTER PROCEDURE [dbo].[pf_anagrafeStudentiUpdate]

@idRS int,
@idStudente int,
@nomeStud varchar(200),
@idIstituto varchar(10),
@anno varchar(1),
@dataNascitaStud date,
@luogoNascitaStud varchar(200),
@idOrigineStud int,
@codiceFiscaleStud varchar(16),
@codiceFiscaleGen varchar(16),
@emailStud varchar(200),
@emailCheck bit, 
@tel1Stud varchar(20), 
@tel2Stud varchar(20),
@indirizzoStud varchar(200), 
@comuneStud varchar(100),
@provStud varchar(2),
@capStud varchar(5),
@notaStud varchar (255),
@idSpecial int,
@sediStud varchar(40),
@delete bit,
@deletedStud bit,
@privacyStud bit,
@regolamentoStud bit,
@liberaStud bit,
@firmaStud bit,
@firmaDataStud date,
@docTipoStud int,
@docNumeroStud varchar(30),
@docRilascioStud varchar(50),
@docDataEStud date,
@docDataSStud date,
@docTipoGen int,
@docNumeroGen varchar(30),
@docRilascioGen varchar(50),
@docDataEGen date,
@docDataSGen date,

@istitutoTipo varchar(1),
@istitutoNome varchar(1),
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@oggi date

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE();

	IF @idStudente = 0 OR @idStudente IS NULL
		BEGIN
			IF NOT EXISTS (SELECT @idStudente FROM pf_anagrafeStudenti WHERE nomeStud = @nomeStud AND idRS = @idRS)
				BEGIN
					INSERT INTO pf_anagrafeStudenti
								(idRS,  nomeStud,  emailStud,  tel1Stud,  tel2Stud,  indirizzoStud,  comuneStud,  provStud,  capStud,  notaStud,  idIstituto,  sediStud,  anno,  codiceFiscaleStud,  codiceFiscaleGen,  dataNascitaStud,  luogoNascitaStud,  idOrigineStud,  privacyStud,  liberaStud,  regolamentoStud,  docTipoStud,  docNumeroStud,  docRilascioStud,  docDataEStud,  docDataSStud,  docTipoGen,  docNumeroGen,  docRilascioGen,  docDataEGen,  docDataSGen)
		          		 VALUES (@idRS, @nomeStud, @emailStud, @tel1Stud, @tel2Stud, @indirizzoStud, @comuneStud, @provStud, @capStud, @notaStud, @idIstituto, @sediStud, @anno, @codiceFiscaleStud, @codiceFiscaleGen, @dataNascitaStud, @luogoNascitaStud, @idOrigineStud, @privacyStud, @liberaStud, @regolamentoStud, @docTipoStud, @docNumeroStud, @docRilascioStud, @docDataEStud, @docDataSStud, @docTipoGen, @docNumeroGen, @docRilascioGen, @docDataEGen, @docDataSGen)
					SET @OK = 1
				END
	
			ELSE
				BEGIN
					SET @OK = 2
				END
		END
	
	ELSE
		BEGIN
			UPDATE pf_anagrafeStudenti
				SET nomeStud = @nomeStud,
					emailStud = @emailStud,
					emailCheck = @emailCheck,
					tel1Stud =@tel1Stud,
					tel2Stud = @tel2Stud,
					indirizzoStud = @indirizzoStud,
					comuneStud = @comuneStud,
					provStud = @provStud,
					capStud = @capStud,
					notaStud = @notaStud,
					idSpecial = @idSpecial,
					idIstituto = @idIstituto,
					anno = @anno,
					codiceFiscaleStud = @codiceFiscaleStud,	
					codiceFiscaleGen = @codiceFiscaleGen,
					dataNascitaStud = @dataNascitaStud,
					luogoNascitaStud = @luogoNascitaStud,
					idOrigineStud = @idOrigineStud,
					sediStud = @sediStud,
					dataUpdate = GETDATE(),
					deleted = @deletedStud,
					privacyStud = @privacyStud,
					liberaStud = @liberaStud,
					regolamentoStud = @regolamentoStud,
					firmaStud = @firmaStud,
					firmaDataStud = @firmaDataStud,
					docTipoStud = @docTipoStud,
					docNumeroStud = @docNumeroStud,
					docRilascioStud = @docRilascioStud,
					docDataEStud = @docDataEStud,
					docDataSStud = @docDataSStud,
					docTipoGen = @docTipoGen,
					docNumeroGen = @docNumeroGen,
					docRilascioGen = @docRilascioGen,
					docDataEGen = @docDataEGen,
					docDataSGen = @docDataSGen

				WHERE idStudente = @idStudente AND idRS = @idRS

				IF @deletedStud = 1
					BEGIN
						UPDATE pf_pianoOfferteVista
							SET idStatusOfferta = 1, idStudente = 0
							WHERE idStudente = @idStudente AND dataOfferta >= @oggi AND (idStatusOfferta = 2 OR idStatusOfferta = 11) AND idRS = @idRS

						--DELETE FROM pf_pianoOfferte WHERE idStudente = @idStudente AND idStatusOfferta <> 11 AND idStatusOfferta <> 3 AND dataOfferta >= GETDATE()

						SET @OK = 3
					END

				ELSE
					BEGIN						
						SET @OK = 3
					END
		END

	RETURN @OK

END
