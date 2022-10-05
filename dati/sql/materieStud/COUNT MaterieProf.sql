declare
@idMateria varchar(5) = '1',
@idMateriaS varchar(20)

SET @idMateriaS = 'idMateria#' + @idMateria + ';'

SELECT @idMateriaS

select idProfessore, nomeProf, materiaProf from pf_anagrafeProfessori where idRS= 1 AND CHARINDEX(@idMateriaS, materiaProf) > 0