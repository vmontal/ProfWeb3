USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteTotaliRead]    Script Date: 19/10/2020 17:43:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <19/10/2020>
-- Description:	<Legge Piano Offerte Totali>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteTotaliRead]

@idSede varchar(1),
@idOfferta int, 
@idStatusOfferta int, 
@dataIniziale date,
@dataFinale date,
@delete bit,
@idMateria int,

@idProfessore int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM pf_pianoOfferteTotaliVistaPivot WHERE idSede = @idSede

END
