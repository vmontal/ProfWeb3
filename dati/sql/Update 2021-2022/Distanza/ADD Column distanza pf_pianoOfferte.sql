alter table pf_pianoOfferte add distanza bit default 0
go

update pf_pianoOfferte set distanza=0
go

select top 20 * from pf_pianoOfferte