USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[admAssembleeUpdate]    Script Date: 02/07/2021 17:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <25/06/2019>
-- Description:	<Aggiorna Convocazione Assemblee>
-- =============================================
CREATE PROCEDURE [dbo].[admMailingUpdate]

@idRS int,
@idMail int,
@idTipoMail varchar(1),
@tipoMail varchar(1),
@dataInvioMail date,
@oggettoMail varchar(100),
@testoMail varchar(MAX),
@inviataMail bit,

@delete bit,
@spUpdate varchar(1),
@OK int = 0 OUTPUT

AS

BEGIN

	SET NOCOUNT ON;

	IF @idMail = 0

		BEGIN
			INSERT INTO admMailing
						(idRS,  idTipoMail,  dataInvioMail,  oggettoMail,  testoMail) 
				VALUES  (@idRS, @idTipoMail, @dataInvioMail, @oggettoMail, @testoMail)

			SET @OK = 1
		END

	ELSE IF @inviataMail = 0
		BEGIN
			UPDATE admMailing
				SET idTipoMail = @idTipoMail, 
					dataInvioMail = @dataInvioMail, 
					oggettoMail = @oggettoMail, 
					testoMail = @testoMail
				WHERE idMail = @idMail AND idRS = @idRS
			
			SET @OK = 3

		END

	ELSE IF @inviataMail = 1
		BEGIN
			UPDATE admMailing
				SET dataInvioMail = @dataInvioMail,
					inviataMail = @inviataMail
				WHERE idMail = @idMail AND idRS = @idRS

			SET @OK = 3
		END
END
