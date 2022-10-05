alter table pf_parMaterie add idRS int default 0
go

update pf_parMaterie set idRS=1
go

select * from pf_parMaterie