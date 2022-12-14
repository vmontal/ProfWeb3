USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaMaterieUpdate]    Script Date: 13/01/2022 11:28:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <12/01/2022>
-- Description:	<Aggiorna Professori dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaMaterieUpdate] 

@idRS int,
@idMateria int,
@oreErogate int,

@materia varchar(1),
@gruppo varchar(1),
@spUpdate varchar(2),
--@delete bit,
@OK int = 0 OUTPUT


AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE pf_dbItaliaMaterie
		SET oreErogate = @oreErogate					
		WHERE idRS = @idRS AND idMateria = @idMateria

		SET @OK = 3

	RETURN @OK
END