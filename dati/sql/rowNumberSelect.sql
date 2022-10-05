declare 
@r int = 50

select * from
(select ROW_NUMBER() OVER (order by idProfessore asc ) ROWID, *  from pf_anagrafeProfessori) temp
where ROWID = @r