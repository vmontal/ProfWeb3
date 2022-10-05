alter table pf_anagrafeProfessori add docTipoProf int default 0
alter table pf_anagrafeProfessori add docNumeroProf VARCHAR(30)
alter table pf_anagrafeProfessori add docRilascioProf VARCHAR(50)
alter table pf_anagrafeProfessori add docDataEProf date
alter table pf_anagrafeProfessori add docDataSProf DATE
go

update pf_anagrafeProfessori SET docTipoProf = 0
go