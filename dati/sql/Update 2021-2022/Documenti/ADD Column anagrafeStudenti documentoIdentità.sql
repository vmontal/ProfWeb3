alter table pf_anagrafeStudenti add docTipoStud int default 0
alter table pf_anagrafeStudenti add docNumeroStud VARCHAR(30)
alter table pf_anagrafeStudenti add docRilascioStud VARCHAR(50)
alter table pf_anagrafeStudenti add docDataEStud date
alter table pf_anagrafeStudenti add docDataSStud DATE
go

update pf_anagrafeStudenti SET docTipoStud = 0
go