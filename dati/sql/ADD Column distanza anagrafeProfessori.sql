alter table pf_anagrafeProfessori add distanza bit default 0
go

update pf_anagrafeProfessori set distanza=0
go

select top 20 * from pf_anagrafeProfessori