SET IDENTITY_INSERT pf_anagrafeIstituti_transfer ON

INSERT INTO pf_anagrafeIstituti_transfer (
		[CODICEISTITUTO]
      ,[ISTITUTO]
      ,[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA]
      ,[INDIRIZZO]
      ,[CAP]
      ,[COMUNE]
      ,[PROVINCIA]
      ,[REGIONE]
      ,[INDIRIZZOEMAILSCUOLA]
      ,[INDIRIZZOPECSCUOLA]
      ,[SITOWEBSCUOLA]
      ,[deleted]
      ,[idRS])

(SELECT [CODICEISTITUTO]
      ,[ISTITUTO]
      ,[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA]
      ,[INDIRIZZO]
      ,[CAP]
      ,[COMUNE]
      ,[PROVINCIA]
      ,[REGIONE]
      ,[INDIRIZZOEMAILSCUOLA]
      ,[INDIRIZZOPECSCUOLA]
      ,[SITOWEBSCUOLA]
      ,[deleted]
      ,[idRS]
	  FROM pf_anagrafeIstituti
	  WHERE idRS = 28)

SET IDENTITY_INSERT pf_anagrafeIstituti_transfer OFF