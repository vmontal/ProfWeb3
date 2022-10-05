DECLARE
@idMateria int,
@idAnno varchar(5),
@idFreq varchar(5),

@valore varchar(MAX),
@idMateriaCheck varchar(20),
@maxOLD int,
@maxNEW int,
@nr int,
@idProfessore int = 11,
@materiaProfOLD varchar(MAX) = 'idMateria#12;idAnno#12345;idFreq#S@idMateria#6111;idAnno#345;idFreq#S',
@materiaProf varchar(MAX) = 'idMateria#123;idAnno#12345;idFreq#S@idMateria#6111;idAnno#345;idFreq#S'


CREATE TABLE #splitMaterieOLD (nr int , valore varchar(50))
CREATE TABLE #splitMaterieNEW (nr int , valore varchar(50))

INSERT INTO #splitMaterieOLD SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProfOLD, '@')
INSERT INTO #splitMaterieNEW SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProf, '@')
--select * from #splitMaterieOLD							
SET @nr = 1
SET @maxOLD = (SELECT MAX(nr) FROM #splitMaterieOLD)
WHILE @nr <= @maxOLD
	BEGIN
		SET @valore = (SELECT valore FROM #splitMaterieOLD WHERE nr = @nr)
		SET @idMateriaCheck = (SELECT value FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))
		SET @idMateria = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))
		--SELECT @valore
		IF NOT EXISTS (SELECT valore FROM #splitMaterieNEW WHERE valore LIKE ('%' + @idMateriaCheck + ';' + '%'))
			BEGIN
				SELECT 'DELETE' AS CMD, @idMateria AS Materia, @idMateriaCheck AS MateriaCheck
				--DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore AND idMateria = @idMateria
				--DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi
			END
		ELSE
			BEGIN
				SET @valore = (SELECT valore FROM #splitMaterieNEW WHERE nr = @nr)
				SET @idAnno = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idAnno%'))
				SET @idFreq = (SELECT rtrim(substring(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idFreq%'))
				SELECT 'UPDATE' AS CMD, @idMateria AS Materia, @idMateriaCheck AS MateriaCheck, @idAnno AS Anno, @idFreq AS Frequenza
				--UPDATE pf_pianoLezioni SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria
				--UPDATE pf_pianoOfferte SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi										
			END
		SET @nr = @nr + 1
	END

DROP TABLE #splitMaterieOLD
DROP TABLE #splitMaterieNEW