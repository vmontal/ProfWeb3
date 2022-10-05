USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_reportItaliaMaterie]    Script Date: 14/01/2022 08:12:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportItaliaMaterieSintesi]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	SELECT * FROM pf_ItaliaMaterieSintesi ORDER BY oreErogate DESC

END