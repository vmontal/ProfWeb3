USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parAssociazioniUpdate]    Script Date: 13/01/2022 10:56:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <12/05/2020>
-- Description:	<Aggiorna Sede Legale>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parAssociazioniUpdate] 

@idRS int,
@ragioneSociale varchar(200), 
@sedeLegaleIndirizzo varchar(300), 
@sedeLegaleLuogo varchar(300),
@sedeLegaleCAP varchar(5),
@sedeLegalePR varchar(2),
@sedeLegaleTEL1 varchar(20),
@sedeLegaleTEL2 varchar(20),
@sedeLegaleEmail varchar(300),
@sedeLegalePEC varchar(300),
@sedeLegaleCF varchar(20),
@registroNR varchar(10),
@registroDataGMA date,
@deletedAss bit,
@adminUser varchar(200),
@adminPass varchar(200),
@prof bit,

@imgPath varchar(1),
@spUpdate varchar(1),
--@delete bit,
@OK int = 0 OUTPUT


AS

DECLARE
@oggi date = GETDATE(),
@adminID int,
@idOrigineStud int

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idRS= 0
		BEGIN
			IF NOT EXISTS (SELECT idRS FROM pf_parAssociazioni WHERE sedeLegaleEmail=@sedeLegaleEmail OR sedeLegaleCF = @sedeLegaleCF)
				BEGIN
					INSERT INTO pf_parAssociazioni ( ragioneSociale,  sedeLegaleIndirizzo,  sedeLegaleLuogo,  sedeLegaleCAP,  sedeLegalePR,  sedeLegaleTEL1,  sedeLegaleTEL2,  sedeLegaleEmail,  sedeLegalePEC,  sedeLegaleCF,  registroNR,  registroData,     prof)
									        VALUES ( @ragioneSociale, @sedeLegaleIndirizzo, @sedeLegaleLuogo, @sedeLegaleCAP, @sedeLegalePR, @sedeLegaleTEL1, @sedeLegaleTEL2, @sedeLegaleEmail, @sedeLegalePEC, @sedeLegaleCF, @registroNR, @registroDataGMA, @prof)		

					SET @idRS = (SELECT idRS FROM pf_parAssociazioni WHERE ragioneSociale=@ragioneSociale)
					EXEC admUtentiUpdate @idRS, 0, 'AMMINISTRATORE', 'SISTEMA', @sedeLegaleEmail, @adminUser, @adminPass, @oggi, ' ', ' ', ' ' ,' ', ' ', ' ',' ',' ', 1, 1, 0, 0, 0, 0, '2000-01-01', '0', 0, 0, ' ', 0

					SET @adminID = (SELECT id FROM admUtenti WHERE emailUser = @sedeLegaleEmail)
					UPDATE admUtenti SET attivo = 1, idRuolo = 1 WHERE id = @adminID
					
					SET IDENTITY_INSERT pf_parMaterie ON
					INSERT INTO pf_parMaterie (idRS, idMateria, materia, idGruppo, deleted) 
										SELECT @idRS, idMateria, materia, idGruppo, deleted 
										FROM pf_parMaterie 
										WHERE idRS = 1 AND deleted = 0
					SET IDENTITY_INSERT pf_parMaterie OFF
					
					-- Inserisco la struttura dati per dbItalia --
					IF @prof = 0 
						BEGIN						
							-- Studenti per origine e anno --
							SET @idOrigineStud = 1							
							WHILE @idOrigineStud <=3
								BEGIN
									INSERT INTO pf_dbItaliaStudenti (idRS,  idOrigineStud)
															VALUES  (@idRS, @idOrigineStud)

									SET @idOrigineStud = @idOrigineStud + 1
								END
							-- Professori per tipologia
							INSERT INTO pf_dbItaliaProfessori (idRS)
													   VALUES (@idRS)

							-- Materie --
							INSERT INTO pf_dbItaliaMaterie (idRS, idMateria)
													SELECT @idRS, idMateria
													FROM pf_parMaterie
													WHERE idRS = 1 AND deleted = 0

						END

					SET @OK = 1
				END
		END
	ELSE
		BEGIN
			UPDATE pf_parAssociazioni
				SET ragioneSociale = @ragioneSociale,
					sedeLegaleIndirizzo = @sedeLegaleIndirizzo,
					sedeLegaleLuogo = @sedeLegaleLuogo,
					sedeLegaleCAP = @sedeLegaleCAP,
					sedeLegalePR = @sedeLegalePR,
					sedeLegaleTEL1 = @sedeLegaleTEL1,
					sedeLegaleTEL2 = @sedeLegaleTEL2,
					sedeLegaleEmail = @sedeLegaleEmail,
					sedeLegalePEC = @sedeLegalePEC,
					sedeLegaleCF = @sedeLegaleCF,
					registroNR = @registroNR,
					registroData = @registroDataGMA,
					prof = @prof,
					deletedAss = @deletedAss
				WHERE idRS = @idRS

			SET @OK = 3
		END

	RETURN @OK
END