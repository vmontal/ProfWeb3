
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<ValerioJSQL>
-- Create date: <13/02/2022>
-- Description:	<Buon Compleanno>
-- =============================================
CREATE PROCEDURE pf_anagrafeGeneraleCompleanni 
	-- Add the parameters for the stored procedure here

@sp varchar(1),
@tabella varchar(1)

AS

DECLARE
@mese as int = MONTH(GETDATE()),
@giorno as int = DAY(GETDATE())



BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT nomeStud AS intestazione, emailStud AS email, dataNascitaStud AS dataNascita
	FROM pf_anagrafeStudenti 
	WHERE DATEPART(day, dataNascitaStud) = @giorno AND DATEPART(month, dataNascitaStud) = @mese and idRS = 1 and deleted = 0

	UNION

	(
	SELECT nomeProf AS intestazione, emailProf AS email, dataNascitaProf AS dataNascita
	FROM pf_anagrafeProfessori
	WHERE DATEPART(day, dataNascitaProf) = @giorno AND DATEPART(month, dataNascitaProf) = @mese and idRS = 1 and deleted = 0
	)

END
GO
