USE [MSSql121445]
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeGeneraleRead]    Script Date: 05/02/2019 10.05.59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2019>
-- Description:	<Cerca Anagrafe Generale>
-- =============================================

ALTER PROCEDURE [dbo].[pf_anagrafeGeneraleRead]

@spRead varchar(1),
@tabella varchar(1),
@drop int,
@email varchar(200),
@tipo varchar(1)
--@OK int OUTPUT

AS

DECLARE
@checkCode int = 0


BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @OK = 0

	IF EXISTS (SELECT ID FROM pf_anagrafeGeneraleVista WHERE email = @email AND tipo = @tipo)
		BEGIN
			SET @checkCode = RAND() * 1000000
			SET @checkCode = CASE WHEN @checkCode > 0 AND @checkCode < 100000 THEN @checkCode + 100000 ELSE @checkCode END

			IF @tipo = 'S' UPDATE pf_anagrafeStudenti SET checkCode = @checkCode WHERE emailStud = @email
			IF @tipo = 'D' UPDATE pf_anagrafeProfessori SET checkCode = @checkCode WHERE emailProf = @email
			IF @tipo = 'G' UPDATE admUtenti SET checkCode = @checkCode WHERE email = @email

			--SET @OK = @checkCode

			SELECT ID, nome, email, 1 AS checkCode FROM pf_anagrafeGeneraleVista WHERE email = @email AND tipo = @tipo
		END
	ELSE
		BEGIN
			SELECT 0 AS ID, 'sconosciuto' AS nome, 'sconosciuto' AS email, 0 AS checkCode
		END

END