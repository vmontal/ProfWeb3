USE [MSSql171182]
GO

/****** Object:  StoredProcedure [dbo].[pf_reportItaliaProfessori]    Script Date: 13/01/2022 17:55:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pf_reportItaliaProfessori]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	IF @idRS = 0
		SELECT * FROM pf_ItaliaProfessori ORDER BY idRS
	ELSE
		SELECT * FROM pf_ItaliaProfessori WHERE idRS = @idRS
	
END
GO


