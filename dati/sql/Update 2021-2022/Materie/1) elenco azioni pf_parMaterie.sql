'

1) ADD Column
2) Set Index PrimaryKey idRS, idMateria
3) INSERT INTO pf_parMaterie (idRS, idMateria, materia, idGruppo, deleted) SELECT @idRS, idMateria, materia, idGruppo, deleted FROM pf_parMaterie WHERE idRS = 1
4) pf_parMaterieVista
5) pf_parMaterieRead
6) pf_parMaterieUpdate

'