USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[admAssembleeRead]    Script Date: 02/07/2021 17:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <02/07/2021>
-- Description:	<Elenco Mailing>
-- =============================================
CREATE PROCEDURE [dbo].[admMailingRead]

@idRS int,
@idMail int,
@idTipoMail varchar(1),
@tipoMail varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idMail = 0
		BEGIN			
			SELECT * FROM admMailingVista WHERE idTipoMail = @idTipoMail AND idRS = @idRS
		END
	ELSE
		BEGIN
			SELECT * FROM admMailingVista WHERE idMail = @idMail AND idRS = @idRS
		END

END
