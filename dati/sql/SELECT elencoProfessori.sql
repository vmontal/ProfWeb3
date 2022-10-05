/****** Script per comando SelectTopNRows da SSMS  ******/
SELECT TOP (1000) [idProfessore]
      ,[nomeProf]
      ,[emailProf]      
      ,[deleted]
      ,[sediProf]
      ,[materiaProf]
      ,[lezioniPrenotate]
  FROM [MSSql171182].[dbo].[pf_anagrafeProfessori] WHERE LEN(materiaProf) > 0 AND deleted = 0