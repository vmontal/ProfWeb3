USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieRead]    Script Date: 08/07/2021 16:25:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <27/01/2018>
-- Description:	<Legge Piano Materie>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parMaterieRead]
@idRS int,
@idMateria int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			IF @drop = 0 
				BEGIN
				   SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS ORDER BY deleted, idGruppo, materia
				END
			ELSE
				BEGIN
				   SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS AND deleted = 0 ORDER BY idGruppo, materia
				END
		END
	
	ELSE
		BEGIN
			SELECT *, deleted AS deleteM FROM pf_parMaterieVista WHERE idRS = @idRS AND idMateria = @idMateria
		END

END
