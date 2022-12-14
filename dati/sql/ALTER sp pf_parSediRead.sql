USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_parSediRead]    Script Date: 05/02/2020 17:33:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <03/02/2019>
-- Description:	<Legge Elenco Sedi>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parSediRead]

@idSede int,
@drop int,

@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idSede = 0
		BEGIN
			IF @drop <= 1 -- paramtero per elenco generale ed elenco sedi in anagrafe professori e studenti
				BEGIN
					SELECT * FROM pf_parSedi WHERE deleted = 0 ORDER BY idSede
				END
			ELSE IF @drop = 3 -- parametro per popolare tendina in scheda Controlli
				BEGIN
					SELECT idSede, descrizioneSede FROM pf_parSedi WHERE deleted = 0 
					UNION
					(
					SELECT 0 AS idSede, 'Portofranco Palermo' AS descrizioneSede --, 'indirizzo' AS indirizzoSede, 'luogo' AS luogoSede, 'cap' AS capSede, 'prov' AS provSede, '091' AS tel1Sede, '091' AS tel2Sede, 'email' AS emailSede, 'img' AS imgPath, 'file' AS imgFile, 0 AS deleted
					)
					ORDER BY idSede
				END
			ELSE IF @drop = 4 -- parametro per popolare tendina in form Cassa 
				BEGIN
					SELECT * FROM pf_parSediVista ORDER BY idSede
				END
		END
	
	ELSE
		BEGIN
			SELECT *, deleted AS deletedSede FROM pf_parSedi WHERE idSede = @idSede
		END

END
