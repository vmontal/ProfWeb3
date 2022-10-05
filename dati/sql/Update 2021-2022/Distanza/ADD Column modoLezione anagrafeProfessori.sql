alter table pf_anagrafeProfessori add modoLezione int default 0
go

update pf_anagrafeProfessori set modoLezione=0
go

select top 20 idRS, nomeProf, distanza, modoLezione from pf_anagrafeProfessori