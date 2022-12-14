USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_dbItaliaProfessoriUpdate]    Script Date: 13/01/2022 13:24:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <12/01/2022>
-- Description:	<Aggiorna Professori dbItalia>
-- =============================================

CREATE PROCEDURE [dbo].[pf_dbItaliaProfessoriUpdate] 

@idRS int,
@attivo int,
@pensione int,
@studente int,
@altro int,
@totaleProf int,

@spUpdate varchar(2),
--@delete bit,
@OK int = 0 OUTPUT


AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE pf_dbItaliaProfessori
		SET attivo = @attivo,
			pensione = @pensione,
			studente = @studente,
			altro = @altro					
		WHERE idRS = @idRS

		SET @OK = 3


	RETURN @OK
END