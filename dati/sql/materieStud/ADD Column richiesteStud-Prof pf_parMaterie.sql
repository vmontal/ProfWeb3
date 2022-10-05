alter table pf_parMaterie add richiesteStud int default(0)
alter table pf_parMaterie add richiesteProf int default(0)
GO

UPDATE pf_parMaterie SET richiesteStud = 0, richiesteProf = 0