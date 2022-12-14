USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[admLogin]    Script Date: 11/01/2022 11:51:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <31/03/2016>
-- Description:	<Verifica Credenziali di Accesso>
-- =============================================

ALTER PROCEDURE [dbo].[admLogin]

--@idRS int,
@User varchar(100),
@Pass varchar(100),

@OK int OUTPUT

AS
BEGIN

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE
@attivo bit = 0,
@cambia bit = 0,
@id int = 0

IF NOT EXISTS (SELECT id FROM admUtenti WHERE Username = @User AND [Password] = @pass) --AND idRS = @idRS)
	BEGIN
		SELECT -1 AS idRuolo
	END

ELSE
	BEGIN		
		SELECT @id = id, @attivo = attivo FROM admUtenti WHERE Username = @User AND [Password] = @pass --AND idRS = @idRS
		IF @attivo = 0
			BEGIN
				SELECT -2 AS idRuolo
			END
		ELSE
			BEGIN
				UPDATE admUtenti SET ultimo = GETDATE() WHERE id = @id --AND idRS = @idRS			
				SELECT * FROM admAuth WHERE id = @id --FOR JSON PATH--AND idRS = @idRS
			END
	END
END