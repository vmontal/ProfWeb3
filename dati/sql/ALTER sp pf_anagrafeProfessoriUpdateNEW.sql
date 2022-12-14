USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriUpdate]    Script Date: 13/11/2019 16:09:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Anagrafe Professore>
-- =============================================

ALTER PROCEDURE [dbo].[pf_anagrafeProfessoriUpdate]

@idProfessore int,
@nomeProf varchar(200), 
@emailProf varchar(200),
@emailCheck bit,  
@tel1Prof varchar(20), 
@tel2Prof varchar(20),
@indirizzoProf varchar(200),
@comuneProf varchar(100),
@provprof varchar(2),
@capProf varchar(5),
@sediProf varchar(40),
@notaProf varchar (255),
@codiceFiscaleProf varchar(16),
@dataNascitaProf date,
@luogoNascitaProf varchar(200),
@privacyProf bit,
@liberaProf bit,
@firmaProf bit,
@firmaDataProf date,
@materiaProf varchar(210),
@lezioniPrenotate varchar(1),
@idTipoSocioProf int,

@spUpdate varchar(20),
@delete bit,
@deletedProf bit,
@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS

DECLARE
@materiaProfOLD varchar(210),
@oggi date,


--variabili per la gestione delle materie--
@String varchar(210),
@separaR varchar(1) = '@',
@separaF varchar(1) = ';',
@separaV varchar(1) = '#',
@TOT int,
@totF int,
@N int = 1,
@F int = 1,
@fine int,
@fineF int,
@record varchar(100),
@valori varchar(100),
@campo varchar(100),

@idMateria int,
@idAnno varchar(5),
@idFreq varchar(1),

@valore varchar(20),
@idMateriaCheck varchar(20),
@maxOLD int,
@maxNEW int,
@nr int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE()

	IF @idProfessore = 0
		BEGIN
			IF NOT EXISTS (SELECT idProfessore FROM pf_anagrafeProfessori WHERE nomeProf = @nomeProf)
				BEGIN
					INSERT INTO pf_anagrafeProfessori ( nomeProf,  emailProf,  tel1Prof,  tel2Prof,  indirizzoProf,  comuneProf,  provProf,  capProf, sediProf,  notaProf, codiceFiscaleProf, dataNascitaProf, luogoNascitaProf,  privacyProf,  liberaProf, materiaProf)
											   VALUES (@nomeProf, @emailProf, @tel1Prof, @tel2Prof, @indirizzoProf, @comuneProf, @provProf, @capProf, @sediProf, @notaProf, @codiceFiscaleProf, @dataNascitaProf, @luogoNascitaProf,  @privacyProf,  @liberaProf, @materiaProf)
					SET @OK = 1
				END
	
			ELSE
				BEGIN
					SET @OK = 2
				END
		END
	
	ELSE
		BEGIN
			SET @materiaProfOLD = (SELECT materiaProf FROM pf_anagrafeProfessori WHERE idProfessore = @idProfessore)

			UPDATE pf_anagrafeProfessori
				SET nomeProf = @nomeProf,
					emailProf = @emailProf,
					tel1Prof =@tel1Prof,
					tel2Prof = @tel2Prof,
					indirizzoProf = @indirizzoProf,
					comuneProf = @comuneProf,
					provProf = @provProf,
					capProf = @capProf,
					sediProf = @sediProf,
					codiceFiscaleProf = @codiceFiscaleProf,
					dataNascitaProf = @dataNascitaProf,
					luogoNascitaProf = @luogoNascitaProf,
					notaProf = @notaProf,
					dataUpdate = GETDATE(),
					deleted = @deletedProf,
					privacyProf = @privacyProf,
					liberaProf = @liberaProf,
					firmaProf = @firmaProf,
					firmaDataProf = @firmaDataProf,
					materiaProf = @materiaProf,
					idTipoSocioProf = @idTipoSocioProf
				WHERE idProfessore = @idProfessore

				IF @deletedProf = 1
					BEGIN
						-- riprogrammo le lezioni già prenotate
						UPDATE pf_pianoOfferte 
							SET idStatusOfferta = 11, idProfessore = 0
							WHERE idProfessore = @idProfessore AND idStatusOfferta = 2 AND dataOfferta >= @oggi
						
						-- elimino le lezioni dal piano delle lezioni 
						--DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore

						--elimino le lezioni dal piano delle offerte se NON sono state già impegnate o erogate
						--DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idStatusOfferta <> 3 AND dataOfferta >= @oggi
						

					END
				ELSE
					BEGIN
						-- nel caso di riattivazione di un docente rendo inevase le lezioni disponibili già passate
						UPDATE pf_pianoOfferte 
							SET idStatusOfferta = 12
							WHERE idProfessore = @idProfessore AND idStatusOfferta = 1 AND dataOfferta < @oggi

						-- riattivo le lezioni nascoste per accoppiamento orario
						--UPDATE pf_pianoOfferte 
						--	SET attivo = 1
						--	WHERE idProfessore = @idProfessore AND idStatusOfferta = 1 AND attivo = 0 --dataOfferta < @oggi

					END

				IF @deletedProf = 0 AND @materiaProf <> @materiaProfOLD
					BEGIN
						--IF LEN(@materiaProf) > 0
						--BEGIN
							CREATE TABLE #splitMaterieOLD (nr int , valore varchar(50))
							CREATE TABLE #splitMaterieNEW (nr int , valore varchar(50))

							INSERT INTO #splitMaterieOLD SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProfOLD, '@')
							INSERT INTO #splitMaterieNEW SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProf, '@')
							
							SET @nr = 1
							SET @maxOLD = (SELECT MAX(nr) FROM #splitMaterieOLD)
							WHILE @nr <= @maxOLD
								BEGIN
									SET @valore = (SELECT valore FROM #splitMaterieOLD WHERE nr = @nr)
									SET @idMateriaCheck = (SELECT value FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))
									SET @idMateria = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))

									IF NOT EXISTS (SELECT valore FROM #splitMaterieNEW WHERE valore LIKE ('%' + @idMateriaCheck + ';' + '%'))
										BEGIN											
											DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore AND idMateria = @idMateria
											DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi
										END
									ELSE
										BEGIN
											SET @idAnno = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idAnno%'))
											SET @idFreq = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idFreq%'))
											UPDATE pf_pianoLezioni SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria
											UPDATE pf_pianoOfferte SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi										
										END
									SET @nr = @nr + 1
								END

							DROP TABLE #splitMaterieOLD
							DROP TABLE #splitMaterieNEW
						--END

						--BEGIN
							--SET @String = @materiaProf
							--SET @String = @String + @separaR
							--SET @TOT = (CASE WHEN LEN(@String) > 1 THEN (SELECT LEN(@String) - LEN(REPLACE(@String, @separaR, ''))) ELSE 0 END)
							--SET @N = 1
							--WHILE @N <= @TOT
							--	BEGIN
							--		SET @fine = CHARINDEX(@separaR, @String)
							--		SET @record = SUBSTRING(@String, 0, @fine) + @separaF
							--		SET @totF = (CASE WHEN LEN(@record) > 1 THEN (SELECT LEN(@record) - LEN(REPLACE(@record, @separaF, ''))) ELSE 0 END)
							--		SET @F = 1
							--		WHILE @F <= @totF
							--			BEGIN
							--				SET @fineF = CHARINDEX(@separaF, @record)
							--				SET @campo = SUBSTRING(@record, 0, @fineF)

							--				IF @F = 1 SET @idMateria = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
							--				IF @F = 2 SET @idAnno = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
							--				IF @F = 3 SET @idFreq = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))

							--				SET @record = RTRIM(SUBSTRING(@record, @fineF + 1, LEN(@record)))
							--				SET @F = @F + 1
							--			END

							--		UPDATE pf_pianoLezioni SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria
							--		UPDATE pf_pianoOfferte SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi

							--		SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
							--		SET @N = @N + 1

							--	END
							--END

						--ELSE IF LEN(@materiaProf) = 0
						--BEGIN
						--	SET @String = @materiaProfOLD
						--	SET @String = @String + @separaR
						--	SET @TOT = (CASE WHEN LEN(@String) > 1 THEN (SELECT LEN(@String) - LEN(REPLACE(@String, @separaR, ''))) ELSE 0 END)
						--	SET @N = 1
						--	WHILE @N <= @TOT
						--		BEGIN
						--			SET @fine = CHARINDEX(@separaR, @String)
						--			SET @record = SUBSTRING(@String, 0, @fine) + @separaF
						--			SET @totF = (CASE WHEN LEN(@record) > 1 THEN (SELECT LEN(@record) - LEN(REPLACE(@record, @separaF, ''))) ELSE 0 END)
						--			SET @F = 1
						--			WHILE @F <= @totF
						--				BEGIN
						--					SET @fineF = CHARINDEX(@separaF, @record)
						--					SET @campo = SUBSTRING(@record, 0, @fineF)

						--					IF @F = 1 SET @idMateria = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
						--					IF @F = 2 SET @idAnno = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
						--					IF @F = 3 SET @idFreq = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))

						--					SET @record = RTRIM(SUBSTRING(@record, @fineF + 1, LEN(@record)))
						--					SET @F = @F + 1
						--				END

						--			DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore AND idMateria = @idMateria
						--			DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi

						--			SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
						--			SET @N = @N + 1

						--		END
						--	END
					END

			SET @OK = 3

		END

	RETURN @OK

END
