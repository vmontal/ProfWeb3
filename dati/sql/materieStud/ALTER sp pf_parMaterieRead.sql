USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieRead]    Script Date: 26/01/2022 15:37:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <26/01/2022>
-- Description:	<Legge Piano Materie e Aggiorna Richieste Studenti e Offerte Professori>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parMaterieRead]
@idRS int,
@idMateria int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

DECLARE
@tot int,
@i int = 1,
@idMateriaS int,
@idMateriaProf varchar(20),
@idMateriaStud varchar(5),
@richiesteProf int,
@richiesteStud int



BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			SET @tot = (SELECT COUNT(*) FROM pf_parMaterie WHERE idRS=@idRS and deleted = 0)

			WHILE ( @i <= @tot )
				BEGIN
					SELECT @idMateriaS = idMateria FROM (
						SELECT ROW_NUMBER() OVER (ORDER BY idMateria) AS NR, * FROM pf_parMaterie WHERE idRS = @idRS AND deleted = 0
					) elencomaterie
		
					WHERE NR = @i 
		
					SET @idMateriaProf = 'idMateria#' + CONVERT(varchar, @idMateriaS) + ';'
					SET @idMateriaStud = CONVERT(varchar, @idMateriaS) + '@'

					SET @richiesteProf = (SELECT COUNT(*) FROM pf_anagrafeProfessori WHERE idRS = @idRS AND CHARINDEX(@idMateriaProf, materiaProf) > 0)
					SET @richiesteStud = (SELECT COUNT(*) FROM pf_anagrafeStudenti   WHERE idRS = @idRS AND CHARINDEX(@idMateriaStud, materiaStud + '@') > 0)

					UPDATE pf_parMaterie SET richiesteProf = @richiesteProf, richiesteStud = @richiesteStud WHERE idRS = @idRS AND idMateria = @idMateriaS

					SET @i = @i + 1
				END

			IF @drop = 0 
				BEGIN
				   SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS ORDER BY deleted, idGruppo, materia
				END
			ELSE
				BEGIN
				   SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS AND deleted = 0 ORDER BY idGruppo, materia
				END
		END
	
	ELSE
		BEGIN
			SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS AND idMateria = @idMateria
		END

END