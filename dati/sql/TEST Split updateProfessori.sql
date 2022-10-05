create table #splitProf (nr int , valore varchar(50))

declare
@materiaProf varchar(max),
@rowMax int,
@i int = 1,
@idMateria varchar(20) = 'idMateria#12;'

select @materiaProf=materiaProf from pf_anagrafeProfessoriVista where nomeProf like ('%schelot%')

insert into #splitProf select row_number() over(order by value ASC) as NR, value as valore from string_split( @materiaProf, '@')
set @rowMax = (select max(nr) from #splitProf)

select * from #splitProf where valore like ('%' + @idMateria + '%')
--select case when @i <= @rowMax then 'vero' else 'falso' end

drop table #splitProf
