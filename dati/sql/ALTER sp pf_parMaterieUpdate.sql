USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieUpdate]    Script Date: 08/07/2021 16:27:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2018>
-- Description:	<Aggiorna Materie>
-- =============================================

ALTER PROCEDURE [dbo].[pf_parMaterieUpdate] 

@idRS int,
@idMateria int, 
@materia varchar(50), 
@idGruppo int, 
@gruppo varchar(20), 
@deleteM bit,

@spUpdate varchar(2),
@delete bit,
@OK int = 0 OUTPUT


AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			INSERT INTO pf_parMaterie (idRS,  materia,  idGruppo)
							   VALUES (@idRS, @materia, @idGruppo)
			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE pf_parMaterie 
				SET materia = @Materia,
					idGruppo = @idGruppo,
					deleted = @deleteM
				WHERE idRS = @idRS AND idMateria = @idMateria

			SET @OK = 3
		END

	RETURN @OK
END
