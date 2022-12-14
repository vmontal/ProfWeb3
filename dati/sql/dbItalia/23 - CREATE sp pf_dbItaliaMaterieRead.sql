USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaMaterieRead]    Script Date: 13/01/2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <13/01/2022>
-- Description:	<Legge Elenco Materie dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaMaterieRead]
@idRS int,
@idMateria int ,

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
		SELECT * FROM pf_dbItaliaMaterieVista WHERE idRS = @idRS ORDER BY gruppo, materia
	ELSE
		SELECT * FROM pf_dbItaliaMaterieVista WHERE idRS = @idRS AND idmateria = @idMateria

END