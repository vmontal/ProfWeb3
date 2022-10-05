USE [MSSql171182]
GO

/****** Object:  StoredProcedure [dbo].[pf_reportItaliaStudenti]    Script Date: 13/01/2022 17:55:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pf_reportItaliaStudenti]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	IF @idRS = 0
		SELECT * FROM pf_ItaliaStudenti ORDER BY idRS
	ELSE
		SELECT * FROM pf_ItaliaStudenti WHERE idRS = @idRS ORDER BY idRS
END
GO


