USE [MSSql171182]
GO
/****** Object:  StoredProcedure [dbo].[pf_reportItaliaMaterieSintesi]    Script Date: 14/01/2022 08:20:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportItaliaMaterieGruppo]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	SELECT * FROM pf_ItaliaMaterieGruppo ORDER BY oreErogate DESC

END