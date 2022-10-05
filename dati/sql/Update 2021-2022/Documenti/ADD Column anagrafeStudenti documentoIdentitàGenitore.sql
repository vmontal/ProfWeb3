alter table pf_anagrafeStudenti add docTipoGen int default 0
alter table pf_anagrafeStudenti add docNumeroGen VARCHAR(30)
alter table pf_anagrafeStudenti add docRilascioGen VARCHAR(50)
alter table pf_anagrafeStudenti add docDataEGen date
alter table pf_anagrafeStudenti add docDataSGen DATE
go

update pf_anagrafeStudenti SET docTipoGen = 0
go