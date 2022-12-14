USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteRead]    Script Date: 07/02/2022 15:22:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <15/07/2020>
-- Description:	<Legge Piano Offerta Formativa>
-- =============================================

ALTER PROCEDURE [dbo].[pf_pianoOfferteRead]

@idSede varchar(1),
@idOfferta int, 
@idStatusOfferta int, 
@dataIniziale date,
@dataFinale date,
@delete bit,
@idMateria int,

@idProfessore int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS
DECLARE
@idStatusMin int,
@idStatusMax int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			SET @idStatusMin = CASE WHEN @idStatusOfferta = 0 THEN 0   ELSE @idStatusOfferta END
			SET @idStatusMax = CASE WHEN @idStatusOfferta = 0 THEN 100 ELSE @idStatusOfferta END
		END
	ELSE
		BEGIN
			SET @idStatusMin = 1
			SET @idStatusMax = 1
		END

	--BEGIN
	--	IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVista', 'U') IS NOT NULL
	--		DROP TABLE #tmp_pianoOfferteVista; 

	--	CREATE TABLE #tmp_pianoOfferteVista 
	--			(idRS int, idSede varchar(1) ,idOfferta int, idLezione int, idProfessore int, nomeProf varchar(200), 
	--			emailProf varchar(200), idMateria int, materia varchar(200), idGruppo int, gruppo varchar(20), dataOfferta date, 
	--			attivo bit, notaOfferta varchar(MAX), idStatusOfferta int, statusOfferta varchar(100), idOrario int,
	--			idGiorno int, giorno varchar(10), idOra int, orario varchar(43), idStudente int, nomeStud varchar(200), emailStud varchar(200),
	--			tel1Stud varchar(20), tel2Stud varchar(20), anno varchar(1), istitutoNome varchar(50), istitutoTipo varchar(60), notaStud varchar(255),
	--			anni varchar(5), wfOfferta varchar(8), deletedProf int, deletedStud bit, tel1Prof varchar(20), tel2Prof varchar(20),
	--			impegno bit, frequenza varchar(1), sede varchar(300), visibled int, untouch int, argomentoOfferta varchar(MAX), idOrigineStud int, origineStud varchar(30),idTipoProf int, tipoProf varchar(20), ragioneSociale varchar(200),sedeLegaleLogo varchar(200), sedeLegaleIndirizzo varchar(200), sedeLegaleLuogo varchar(200), gruppoStud int, idSpecial int, special varchar(20), distanza int, modoLezione int, modoLezioneDesc varchar(30), distanzaDesc varchar(20))

	--	INSERT INTO #tmp_pianoOfferteVista 
	--		SELECT dbo.pf_parSedi.idRS, dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idOfferta, dbo.pf_pianoOfferte.idLezione, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessoriVista.nomeProf, dbo.pf_anagrafeProfessoriVista.emailProf, 
	--						  dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, dbo.pf_pianoOfferte.dataOfferta, dbo.pf_pianoOfferte.attivo, dbo.pf_pianoOfferte.notaOfferta, 
	--						  dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idOrario, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.giorno, dbo.pf_parOrariVista.idOra, CONVERT(varchar(8), 
	--						  dbo.pf_parOrariVista.ora) AS orario, dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudentiVista.nomeStud, dbo.pf_anagrafeStudentiVista.emailStud, dbo.pf_anagrafeStudentiVista.tel1Stud, dbo.pf_anagrafeStudentiVista.tel2Stud, 
	--						  dbo.pf_anagrafeStudentiVista.anno, dbo.pf_anagrafeStudentiVista.istitutoNome, dbo.pf_anagrafeStudentiVista.istitutoTipo, dbo.pf_anagrafeStudentiVista.notaStud, dbo.pf_pianoOfferte.anni, dbo.pf_parStatusOfferte.wfOfferta, 
	--						  dbo.pf_anagrafeProfessoriVista.deleted AS deletedProf, dbo.pf_anagrafeStudentiVista.deleted AS deletedStud, dbo.pf_anagrafeProfessoriVista.tel1Prof, dbo.pf_anagrafeProfessoriVista.tel2Prof, dbo.pf_parOrariVista.impegno, 
	--						  dbo.pf_pianoOfferte.frequenza, dbo.pf_parSedi.indirizzoSede + ' presso ' + dbo.pf_parSedi.descrizioneSede AS sede, CASE WHEN dbo.pf_anagrafeProfessoriVista.deleted = 1 AND 
	--						  dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END AS visibled, CASE WHEN dbo.pf_pianoOfferte.attivo = 0 AND dbo.pf_pianoOfferte.idStatusOfferta = 1 THEN 0 ELSE 1 END AS untouch, dbo.pf_pianoOfferte.argomentoOfferta, 
	--						  dbo.pf_anagrafeStudentiVista.idOrigineStud, dbo.pf_anagrafeStudentiVista.origineStud, dbo.pf_anagrafeProfessoriVista.idTipoProf, dbo.pf_anagrafeProfessoriVista.tipoProf, dbo.pf_parAssociazioni.ragioneSociale, 
	--						  dbo.pf_parAssociazioni.sedeLegaleLogo, dbo.pf_parAssociazioni.sedeLegaleIndirizzo, dbo.pf_parAssociazioni.sedeLegaleLuogo, dbo.pf_pianoOfferte.gruppoStud, dbo.pf_anagrafeStudentiVista.idSpecial, 
	--						  dbo.pf_anagrafeStudentiVista.special, dbo.pf_pianoOfferte.distanza, dbo.pf_anagrafeProfessoriVista.modoLezione, dbo.pf_parModoLezione.modoLezioneDesc, dbo.pf_parDistanza.distanzaDesc
	--		FROM     dbo.pf_pianoOfferte INNER JOIN
	--						  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
	--						  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
	--						  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
	--						  dbo.pf_parAssociazioni INNER JOIN
	--						  dbo.pf_parSedi ON dbo.pf_parAssociazioni.idRS = dbo.pf_parSedi.idRS ON dbo.pf_parMaterie.idRS = dbo.pf_parSedi.idRS AND dbo.pf_pianoOfferte.idSede = dbo.pf_parSedi.idSede LEFT OUTER JOIN
	--						  dbo.pf_parDistanza ON dbo.pf_pianoOfferte.distanza = dbo.pf_parDistanza.distanza LEFT OUTER JOIN
	--						  dbo.pf_parModoLezione RIGHT OUTER JOIN
	--						  dbo.pf_anagrafeProfessoriVista ON dbo.pf_parModoLezione.modoLezione = dbo.pf_anagrafeProfessoriVista.modoLezione ON dbo.pf_pianoOfferte.idProfessore = dbo.pf_anagrafeProfessoriVista.idProfessore LEFT OUTER JOIN
	--						  dbo.pf_parOrariVista ON dbo.pf_pianoOfferte.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoOfferte.idSede = dbo.pf_parOrariVista.idSede LEFT OUTER JOIN
	--						  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudentiVista.idStudente
	--	WHERE  (dbo.pf_parOrariVista.impegno = 1 AND dbo.pf_pianoOfferte.idStatusOfferta >= @idStatusMin AND dbo.pf_pianoOfferte.idStatusOfferta <= @idStatusMax) AND (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')


	--	IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVistaPivot', 'U') IS NOT NULL
	--		DROP TABLE #tmp_pianoOfferteVistaPivot; 

	--	CREATE TABLE #tmp_pianoOfferteVistaPivot 
	--			(idSede varchar(1), idGiorno int, idMateria int, deletedProf bit, dataOffertaGMA varchar(23), dataOfferta date,
	--			Ora1 varchar(920), Ora2 varchar(920), Ora3 varchar(920), Ora4 varchar(920), Ora5 varchar(920))

	--	INSERT INTO #tmp_pianoOfferteVistaPivot
	--		SELECT idRS, idSede, idGiorno, idMateria, deletedProf, giorno + ' - ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
	--		FROM     (SELECT idRS, idSede, idGiorno, idMateria, deletedProf, giorno, dataOfferta, idOra, nomeProf, materia, 
	--										'prof:' + nomeProf + 
	--										',Didattica:' + IIF(idStatusOfferta = 1, '-------', distanzaDesc) + -- IIF(CONVERT(int, distanza) = 0, 'Presenza' ,'Distanza'))  + 
	--										',Disp. Docente:' + modoLezioneDesc + -- CASE WHEN modoLezione = 0 THEN 'Completa' WHEN modoLezione = 1 THEN 'Presenza' WHEN modoLezione = 2 THEN 'Distanza' END + --IIF(CONVERT(int, modoLezione) = 0, 'Presenza' ,'Distanza')  +
	--										',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + 
	--										',Studente:' + ISNULL(nomeStud, '--') + IIF(gruppoStud = 1, ' (+N)','') + 
	--										',anno:' + ISNULL(anno, '0') + ',Status:' + statusOfferta + 
	--										',idStatus:' + CONVERT(varchar, idStatusOfferta) + 
	--										',id:' + CONVERT(varchar, idOfferta) +
	--										',idStudente:' + CONVERT(varchar, idStudente) AS Offerta
	--								  FROM    pf_pianoOfferteVista
	--								  WHERE   attivo = 1 OR idStatusOfferta = 5) 
	--							AS sourceTable PIVOT (MIN(Offerta) FOR idOra IN ([1], [2], [3], [4], [5])) AS pivotTable
	--END

	IF @idMateria = 0
		BEGIN
			IF @idOfferta = 0
				BEGIN
					IF @idStatusOfferta = 0
						BEGIN
							SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
							--FROM #tmp_pianoOfferteVistaPivot
							FROM pf_pianoOfferteVistaPivot
							WHERE  dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND (deletedProf = 0  ) AND idSede = @idSede COLLATE Latin1_General_CS_AS --OR (idStatusOfferta = 3 AND deletedProf <= 1)
							ORDER BY dataOfferta, Ora1 --, idStatusOfferta -- AND attivo = 1  
						END
					ELSE
						BEGIN
							SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
							--FROM #tmp_pianoOfferteVistaPivot 
							FROM pf_pianoOfferteVistaPivot
							WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND deletedProf <= @delete AND idSede = @idSede COLLATE Latin1_General_CS_AS AND idStatusOfferta >= @idStatusMin AND idStatusOfferta <= @idStatusMax   --idStatusOfferta = @idStatusOfferta AND 
							ORDER BY dataOfferta, Ora1 -- AND attivo = 1 
						END
					END
			ELSE
				BEGIN
					SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
					FROM pf_pianoOfferteVista 
					WHERE idOfferta = @idOfferta AND attivo = 1 AND deletedProf <= @delete AND idSede = @idSede COLLATE Latin1_General_CS_AS --AND dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale
				END
		END
	ELSE
		BEGIN
			SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
			--FROM #tmp_pianoOfferteVistaPivot 
			FROM pf_pianoOfferteVistaPivot
			WHERE idMateria = @idMateria AND deletedProf <= @delete AND dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND idSede = @idSede COLLATE Latin1_General_CS_AS --AND idStatusOfferta = 1
			ORDER BY dataOfferta
		END
END