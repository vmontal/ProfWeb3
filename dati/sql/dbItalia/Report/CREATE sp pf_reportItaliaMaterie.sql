USE [MSSql171182]
GO

/****** Object:  StoredProcedure [dbo].[pf_reportItaliaMaterie]    Script Date: 13/01/2022 17:54:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pf_reportItaliaMaterie]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	IF @idRS = 0
		SELECT * FROM pf_ItaliaMaterie ORDER BY idRS, NR DESC
	ELSE
		SELECT * FROM pf_ItaliaMaterie WHERE idRS = @idRS ORDER BY NR DESC

END
GO


