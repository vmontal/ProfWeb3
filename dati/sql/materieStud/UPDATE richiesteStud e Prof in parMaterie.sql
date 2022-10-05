--USE MSSql171182;
--GO

DECLARE 
@tot int,
@i int = 1,
@idRS int = 1,
@idMateriaS int,
@idMateriaProf varchar(20),
@idMateriaStud varchar(5),
@richiesteProf int,
@richiesteStud int

SET @tot = (SELECT Count(*) FROM pf_parMaterie WHERE idRS=@idRS and deleted = 0)

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

SELECT * FROM pf_parMaterie WHERE idRS = @idRS AND deleted = 0 ORDER BY idGruppo, idMateria