USE [MSSql171182]
GO

/****** Object:  StoredProcedure [dbo].[pf_anagrafeClone]    Script Date: 22/02/2022 11:45:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pf_anagrafeClone]

@idRS int

AS


DELETE FROM pf_anagrafeProfessori_transfer

INSERT INTO pf_anagrafeProfessori_transfer 
	SELECT * FROM dbo.pf_anagrafeProfessori 
	WHERE idRS = @idRS


DELETE FROM pf_anagrafeStudenti_transfer

INSERT INTO pf_anagrafeStudenti_transfer 
	SELECT * FROM dbo.pf_anagrafeStudenti
	WHERE idRS = @idRS


DELETE FROM pf_anagrafeIstituti_transfer

INSERT INTO pf_anagrafeIstituti_transfer 
	SELECT * FROM dbo.pf_anagrafeIstituti
	WHERE idRS = @idRS
GO


