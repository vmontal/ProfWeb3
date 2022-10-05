declare @materia varchar(20) = '13'
declare @separa varchar(1) = '@'
declare @ante varchar(20) = 'idMateria#'
declare @post varchar(1) = ';'

select count(*) as matStud 
	from pf_anagrafeStudentiVista 
	where idRS=1 and CHARINDEX(@separa + @materia + @separa, @separa + materiaStud + @separa) > 0

PRINT @ante + @materia + @post

select count(*) as matProf 
	from pf_anagrafeProfessoriVista 
	where idRS=1 AND CHARINDEX (@ante + @materia + @post, materiaProf) > 0