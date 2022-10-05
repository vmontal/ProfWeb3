alter table pf_parAssociazioni add prof bit not null default 0
go
update pf_parAssociazioni set prof = 1