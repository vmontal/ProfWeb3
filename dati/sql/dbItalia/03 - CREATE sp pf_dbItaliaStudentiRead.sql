USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaStudentiRead]    Script Date: 11/01/2022 19:26:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <11/01/2022>
-- Description:	<Legge Elenco Studenti dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaStudentiRead]
@idRS int,
@idOrigineStud int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @drop = 0
		BEGIN
			SELECT * FROM pf_dbItaliaStudentiVista WHERE idRS = @idRS ORDER BY idOrigineStud
		END
	ELSE
		BEGIN
			SELECT * FROM pf_dbItaliaStudentiVista WHERE idRS = @idRS AND idOrigineStud = @idOrigineStud
		END

END