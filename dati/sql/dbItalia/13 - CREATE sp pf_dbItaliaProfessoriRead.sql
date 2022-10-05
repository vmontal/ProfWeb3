USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaProfessoriRead]    Script Date: 12/01/2022 19:37:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <12/01/2022>
-- Description:	<Legge Elenco Professori dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaProfessoriRead]
@idRS int,
@idTipo int ,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM pf_dbItaliaProfessoriVista WHERE idRS = @idRS

END