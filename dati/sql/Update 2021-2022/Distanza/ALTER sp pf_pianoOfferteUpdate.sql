USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteUpdate]    Script Date: 01/07/2021 16:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Piano Offerta Formativa>
-- =============================================

ALTER PROCEDURE [dbo].[pf_pianoOfferteUpdate] 

@idRS int,
@idSede varchar(1),
@idOfferta int, 
@idLezione int,
@idProfessore int,
@idMateria int,
@idOrario int,
@idGiorno int,
@idOra int, 
@dataOffertaGMA date, 
@idStatusOfferta int,
@idStudente int,
@attivo bit,
@gruppoStud bit,
@notaOfferta varchar(MAX),
@argomentoOfferta varchar(MAX),
@aggiornaData bit,
@riprogramma bit,

@nomeProf varchar(1),
@nomeStud varchar(100),
@materia varchar(2),
@orario varchar(1),
@giorno varchar(1),
--@ora varchar(1),
@anni varchar(2),
@statusOfferta varchar(1),
@anno varchar(1),
@istitutoTipo varchar(1),
@tel1Stud varchar(1),
@tel2Stud varchar(1),
@emailStud varchar(1),
@tel1Prof varchar(1),
@tel2Prof varchar(1),
@emailProf varchar(1),
@distanza bit,
@modoLezione int,

@spUpdate varchar(2),
@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS

DECLARE
@idStatusOffertaFinale int,
@idOrarioFinale int,
@idGiornoFinale int,
@idOraFinale int,
@idOrarioOld int,
@dataOffertaOld date,
@badLog bit,
@annullaAttesa bit


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT @idStatusOffertaFinale = idStatusOffertaFinale, @badLog = badLog, @annullaAttesa = annullaAttesa FROM pf_parStatusOfferte WHERE idStatusOfferta = @idStatusOfferta
	SELECT @dataOffertaOld = dataOfferta, @idOrarioOld = idOrario FROM pf_pianoOfferte WHERE idOfferta = @idOfferta

	IF @idStatusOfferta = 1 -- offerta libera
		BEGIN
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 2 -- prenota lezione e blocca le altre lezione del professore nella stessa ora e verifico che lo studente in quel giorno non abbia lezione prenotate in altra sede
		BEGIN
			IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferteVista WHERE (idSede = @idSede AND idStudente = @idStudente AND idOrario = @idOrario AND attivo = 1 AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idStatusOfferta <> 11) OR (idSede <> @idSede AND idRS = @idRS AND idStudente = @idStudente AND attivo = 1 AND dataOfferta = @dataOffertaGMA AND idStatusOfferta <> 11 ))
				BEGIN
					UPDATE pf_pianoOfferte SET idStudente = @idStudente, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
					UPDATE pf_pianoOfferte SET attivo = 0 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
					SET @OK = 3
					
				END
			ELSE
				BEGIN
					SET @OK = 2
				END

		END

	ELSE IF @idStatusOfferta = 3 -- lezione erogata e chiusa
		BEGIN
			UPDATE pf_pianoOfferte SET idStudente = @idStudente, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 4 -- lezione annullata dallo studente;  si rende di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = 0 WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 5 -- lezione annullata dal professore; bloccata per tutti
		BEGIN			
			IF @idStudente = 0 -- la lezione non era prenotata, posso metterla nel log
				BEGIN
					UPDATE pf_pianoOfferte SET idStatusOfferta = @idStatusOffertaFinale, attivo = 0, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = 0 WHERE idOfferta = @idOfferta AND idSede = @idSede
					UPDATE pf_pianoOfferte SET idStatusOfferta = 5 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND dataOfferta = @dataOffertaGMA and idOrario = @idOrario AND idSede = @idSede
					SET @OK = 3
				END
			ELSE -- la lezione era prenotata; riprogrammo lo studente
				BEGIN
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
					INSERT INTO pf_pianoOfferte (idSede, idLezione, idProfessore, idMateria, idOrario, dataOfferta, idStudente, idStatusOfferta, notaOfferta, argomentoOfferta, attivo)
							VALUES (@idSede, @idLezione, @idProfessore, @idMateria, @idOrario, @dataOffertaGMA, 0, 5, @notaOfferta, @argomentoOfferta, 0)
					UPDATE pf_pianoOfferte SET idStatusOfferta = 5, idProfessore = @idProfessore WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND dataOfferta = @dataOffertaGMA and idOrario = @idOrario
					SET @OK = 3
				END
				
		END

	ELSE IF @idStatusOfferta = 6 -- prenotazione annullata dalla segreteria; si rende di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = 0  WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 7 -- lo studente non si presenta; la lezione è di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = 0 WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 8 OR @idStatusOfferta = 9  -- il professore chiede di spostare la lezione ad altra data-ora
		BEGIN
			SET @idOraFinale = @idOra
			SET @idGiornoFinale = DATEPART(WEEKDAY, @dataOffertaGMA)
			SET @idOrarioFinale = (SELECT idOrario FROM pf_parOrari WHERE idGiorno = @idGiornoFinale AND idOra = @idOraFinale AND idSede = @idSede)
				
			IF @idStudente = 0  -- non ci sono lezioni prenotate; verifico la disponibilità del professore (anche su altre sedi) e sposto tutte le lezioni del giorno in esame
				BEGIN
					IF NOT EXISTS (SELECT idOfferta 
									FROM pf_pianoOfferteVista 
									WHERE (idSede = @idSede  AND idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND idMateria = @idMateria AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta) OR --AND attivo = 1
										  (idSede <> @idSede AND idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idRS = @idRS)
								   ) 
						BEGIN
							UPDATE pf_pianoOfferte 
							SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza 
							WHERE idProfessore=@idProfessore AND dataOfferta = @dataOffertaOld  AND idOrario = @idOrario AND idSede = @idSede -- sposto tutte le lezioni della giornata
							
							SET @OK = 3
						END
					ELSE
						BEGIN
							SET @OK = 2
						END
				END
			ELSE                
				-- sono presenti delle lezioni prenotate; 
				-- prima verifico se si tratta solo di uno spostamento di ora nella stessa giornata
				-- dopo verifico la disponibilità di studente e professore e sposto la lezione
				BEGIN
					IF @dataOffertaGMA = @dataOffertaOld AND @idOrarioFinale <> @idOrarioOld
						BEGIN
							IF EXISTS (SELECT idOfferta FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idStatusOfferta = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) --AND idMateria = @idMateria 								 
								BEGIN
									-- libero la lezione che devo spostare
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, idStudente = 0, attivo = 1, distanza = @distanza WHERE idOfferta = @idOfferta
									-- libero tutte le altre lezioni della giornata nell'orario di origine
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, attivo = 1 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND idOrario = @idOrarioOld AND dataOfferta = @dataOffertaGMA and idSede = @idSede
									
									-- prenoto la lezione nell'orario di destinazione
									UPDATE pf_pianoOfferte SET idStatusOfferta = 2, idStudente = @idStudente, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta = @dataOffertaGMA AND idOrario = @idOrarioFinale AND attivo = 1 AND idStatusOfferta = 1 AND idOfferta <> @idOfferta AND idSede = @idSede --AND idOrario = @idOrarioFinale 
									-- blocco le altre lezioni della giornata nell'orario di destinazione
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, attivo = 0 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND idOrario = @idOrarioFinale AND dataOfferta = @dataOffertaGMA and idSede = @idSede
									SET @OK = 4
								END

							ELSE IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND idOrario = @idOrarioFinale AND idSede = @idSede)
								BEGIN --sposto una lezione che era già stata spostata
									UPDATE pf_pianoOfferte SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
									SET @OK = 4
								END

							ELSE
								BEGIN
									SET @OK = 2
								END
						END

					ELSE 
						BEGIN
							-- verifico la disponibilità di professore e studente anche su altre sedi
							IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferteVista WHERE (idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) OR
																							(idStudente   = @idStudente   AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) OR
																							(idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idSede <> @idSede AND idRS = @idRS) OR
																							(idStudente   = @idStudente   AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idSede <> @idSede AND idRS = @idRS)
										   )
								BEGIN
									UPDATE pf_pianoOfferte SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
									SET @OK = 3
								END
							ELSE
								BEGIN
									SET @OK = 2
								END
						END
				END
		END

	ELSE IF @idStatusOfferta = 10 -- codice desueto non più utilizzato
		BEGIN
			IF (SELECT idStudente FROM pf_pianoOfferte WHERE idOfferta = @idOfferta AND idSede = @idSede) = 0
				BEGIN  -- la lezione non era prenotata; posso eliminarla dal calendario
					DELETE FROM pf_pianoOfferte WHERE idOfferta = @idOfferta AND idSede = @idSede
				END
			ELSE
				BEGIN -- la lezione era prenotata; la inserisco nel log delle lezioni da riprogrammare
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta, distanza = @distanza WHERE idOfferta = @idOfferta AND idSede = @idSede
				END
			
			SET @OK = 3
		END

	IF @OK = 3
		BEGIN
			IF @badLog = 1 
				BEGIN -- inserisco nel log le lezioni disdette in modo da evidenziare nel report di controllo
					INSERT INTO pf_pianoOfferte (idSede, idLezione, idProfessore, idMateria, idOrario, dataOfferta, idStudente, idStatusOfferta, gruppoStud, notaOfferta, argomentoOfferta, attivo)
										VALUES  (@idSede, @idLezione, @idProfessore, @idMateria, @idOrario, @dataOffertaOld, @idStudente, @idStatusOfferta, @gruppoStud, @notaOfferta, @argomentoOfferta, 0)
				END

			IF @riprogramma = 1
				BEGIN
					--UPDATE pf_pianoOfferte SET attivo = 0 WHERE idStudente = @idStudente AND idMateria = @idMateria AND idStatusOfferta = 11
					DELETE FROM pf_pianoOfferte WHERE idStudente = @idStudente AND idMateria = @idMateria AND idStatusOfferta = 11 AND idSede = @idSede
				END
		END

	RETURN @OK

END
