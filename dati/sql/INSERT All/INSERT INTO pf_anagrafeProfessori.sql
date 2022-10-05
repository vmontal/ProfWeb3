DELETE FROM MSSqlProfWeb20.dbo.pf_anagrafeProfessori
GO

DBCC CHECKIDENT ('MSSqlProfWeb20.dbo.pf_anagrafeProfessori', RESEED, 0) 
GO

INSERT INTO MSSqlProfWeb20.dbo.pf_anagrafeProfessori (nomeProf, emailProf, tel1Prof, tel2Prof,indirizzoProf,comuneProf,provProf,capProf,codiceFiscaleProf,notaProf,dataCreate,dataUpdate,dataNascitaProf,luogoNascitaProf,deleted, privacyProf,liberaProf,firmaProf,firmaDataProf,emailCheck,checkCode)
							SELECT nomeProf, emailProf, tel1Prof, tel2Prof,indirizzoProf,comuneProf,provProf,capProf,codiceFiscaleProf,notaProf,dataCreate,dataUpdate,dataNascitaProf,luogoNascitaProf,deleted, privacyProf,liberaProf,firmaProf,firmaDataProf,emailCheck,checkCode 
							FROM MSSql121445.dbo.pf_anagrafeProfessori
GO

UPDATE MSSqlProfWeb20.dbo.pf_anagrafeProfessori SET sediProf = 1
GO

INSERT INTO MSSqlProfWeb20.dbo.pf_anagrafeProfessori (nomeProf, emailProf, tel1Prof, tel2Prof,indirizzoProf,comuneProf,provProf,capProf,codiceFiscaleProf,notaProf,dataCreate,dataUpdate,dataNascitaProf,luogoNascitaProf,deleted, privacyProf,liberaProf,firmaProf,firmaDataProf,emailCheck,checkCode)
							SELECT nomeProf, emailProf, tel1Prof, tel2Prof,indirizzoProf,comuneProf,provProf,capProf,codiceFiscaleProf,notaProf,dataCreate,dataUpdate,dataNascitaProf,luogoNascitaProf,deleted, privacyProf,liberaProf,firmaProf,firmaDataProf,emailCheck,checkCode 
							FROM MSSql171182.dbo.pf_anagrafeProfessori
							WHERE tel2Prof <> 'B'
GO

UPDATE MSSqlProfWeb20.dbo.pf_anagrafeProfessori SET sediProf = 2 WHERE sediProf <> 1
GO