DELETE FROM MSSqlProfWeb20.dbo.pf_anagrafeStudenti
GO

DBCC CHECKIDENT ('MSSqlProfWeb20.dbo.pf_anagrafeStudenti', RESEED, 0) 
GO

INSERT INTO MSSqlProfWeb20.dbo.pf_anagrafeStudenti (nomeStud, emailStud, tel1Stud, tel2Stud,indirizzoStud,comuneStud, idIstituto, anno, provStud,capStud,codiceFiscaleStud,notaStud,dataCreate,dataUpdate,dataNascitaStud,luogoNascitaStud,deleted, privacyStud,liberaStud,firmaStud,firmaDataStud,emailCheck,checkCode)
											 SELECT nomeStud, emailStud, tel1Stud, tel2Stud,indirizzoStud,comuneStud, idIstituto, anno, provStud,capStud,codiceFiscaleStud,notaStud,dataCreate,dataUpdate,dataNascitaStud,luogoNascitaStud,deleted, privacyStud,liberaStud,firmaStud,firmaDataStud,emailCheck,checkCode 
											 FROM MSSql121445.dbo.pf_anagrafeStudenti
GO

UPDATE MSSqlProfWeb20.dbo.pf_anagrafeStudenti SET sediStud = 1
GO

INSERT INTO MSSqlProfWeb20.dbo.pf_anagrafeStudenti (nomeStud, emailStud, tel1Stud, tel2Stud,indirizzoStud,comuneStud,idIstituto, anno, provStud,capStud, codiceFiscaleStud,notaStud,dataCreate,dataUpdate,dataNascitaStud,luogoNascitaStud,deleted, privacyStud,liberaStud,firmaStud,firmaDataStud,emailCheck,checkCode)
											 SELECT nomeStud, emailStud, tel1Stud, tel2Stud,indirizzoStud,comuneStud,idIstituto, anno, provStud,capStud, codiceFiscaleStud,notaStud,dataCreate,dataUpdate,dataNascitaStud,luogoNascitaStud,deleted, privacyStud,liberaStud,firmaStud,firmaDataStud,emailCheck,checkCode 
											 FROM MSSql171182.dbo.pf_anagrafeStudenti
											 WHERE tel2Stud <> 'B'
GO

UPDATE MSSqlProfWeb20.dbo.pf_anagrafeStudenti SET sediStud = 2 WHERE sediStud <> 1
GO