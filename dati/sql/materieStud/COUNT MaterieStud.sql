declare
@idMateria varchar(5) = '13',
@idMateriaS varchar(5)

SET @idMateriaS = @idMateria + '@'

select @idMateriaS

select count(*) AS Nr from pf_anagrafeStudenti where idrs=1 and CHARINDEX(@idMateria + '@', materiaStud+'@') > 0

select idStudente, nomeStud, materiaStud from pf_anagrafeStudenti where idRS=1 and CHARINDEX(@idMateria + '@', materiaStud+'@') > 0