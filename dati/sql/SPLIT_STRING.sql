--drop table #splitProf
create table #splitProf (nr int , valore varchar(50))

declare
@materiaProf varchar(max),

@valore varchar(60),
@nr int = 1,
@max int,
@idMateria int,
@materia varchar(50),
@materiaProfString varchar(200) = '',
@separa varchar(1) = '',
@idAnno varchar(15),
@idfreq varchar(10)

set nocount on
select @materiaProf=materiaProf from pf_anagrafeProfessoriVista where nomeProf like ('%zerb%')
if (select count(value) from string_split( @materiaProf, '@')) > 0
	begin
	insert into #splitProf select row_number() over(order by value ASC) as NR, value as valore from string_split( @materiaProf, '@')
	set @max = (select max(nr) from #splitProf)
	while @nr <= @max
		begin
			set @valore = (select valore from #splitProf where nr = @nr)
			set @idMateria = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idMateria%'))
			set @idAnno = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idAnno%'))
			set @idfreq = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idFreq%'))
			
			set @materia = (select materia from pf_parMaterie where idMateria = @idMateria)
			--set @materiaProfString = @materiaProfString + @separa + 'materia#' + @materia + ';' + @idAnno + ';' + @idfreq
			set @nr = @nr + 1
			set @separa = '@'
			select @idMateria AS Materia, @idAnno AS Anno, @idFreq AS Frequenza
		end
	end
drop table #splitProf

--select @materiaProfString

