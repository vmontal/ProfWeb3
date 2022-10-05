USE [MSSqlProfWeb20]
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriRead]    Script Date: 28/02/2019 11.42.38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/02/2019>
-- Description:	<Aggiorna Lezioni prenotate Professore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeProfessoriUpdateLezioni]

@idProfessore int

AS

DECLARE
@prenotata varchar(100) = '',
@i int = 1,
@tot int,
@idProf int,
@idProfOLD int = 0,
@idMat int,
@numLez int

BEGIN
	--CREATE TABLE #lezioniPrenotate (idProf int, prenotate varchar(200))

	SELECT @tot = COUNT(*) FROM
			(SELECT idProfessore, idMateria 
				FROM pf_pianoOfferte 
				WHERE idStatusOfferta = 2 AND idProfessore = @idProfessore GROUP BY idProfessore, idMateria ) lezioniTotali

	WHILE @i <= @tot
		BEGIN
			SELECT @idProf=idProfessore, @idMat=idMateria, @numLez = Prenotate FROM
			(SELECT ROW_NUMBER() OVER( order by idProfessore ASC) AS ID, idProfessore, idMateria, COUNT(*) AS Prenotate 
				FROM pf_pianoOfferte 
				WHERE idStatusOfferta = 2 AND idProfessore = @idProfessore GROUP BY idProfessore, idMateria ) lezioniElenco
			WHERE ID = @i
			
			IF @idProf <> @idProfOLD
				BEGIN
					IF @idProfOLD > 0
						BEGIN
							UPDATE pf_anagrafeProfessori SET lezioniPrenotate = @prenotata WHERE idProfessore = @idProfOLD
							--INSERT INTO #lezioniPrenotate (idProf, prenotate) VALUES (@idProfOLD, @prenotata)
						END
					SET @prenotata =''
				END
				
			SET @prenotata = @prenotata + 'idMateria#' + CONVERT(varchar(3), @idMat) + ';numLez#' + CONVERT(varchar(3), @numLez) +'@'
					
			SET @i = @i + 1
			SET @idProfOLD = @idProf

		END

		UPDATE pf_anagrafeProfessori SET lezioniPrenotate = @prenotata WHERE idProfessore = @idProf
		--INSERT INTO #lezioniPrenotate (idProf, prenotate) VALUES (@idProf, @prenotata)


	--SELECT * FROM #lezioniPrenotate

	--DROP TABLE #lezioniPrenotate
END
