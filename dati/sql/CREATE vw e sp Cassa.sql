USE [MSSql171182]
GO
/****** Object:  View [dbo].[pf_parSediVista]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[pf_parSediVista]
AS
SELECT idSede, descrizioneSede, '123' AS ruolo, '0' AS banca
FROM     dbo.pf_parSedi
WHERE  deleted = 0
UNION
(SELECT 0 AS idSede, 'Banca' AS descrizioneSede, '12' AS ruolo, '01' AS banca)
GO
/****** Object:  View [dbo].[admCassaVista]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admCassaVista]
AS
SELECT dbo.admCassaMovimenti.idMov, dbo.admCassaMovimenti.idProg, dbo.admCassaMovimenti.idCausale, dbo.admCassaCausali.descCausale, dbo.admCassaMovimenti.idDoc, dbo.admCassaDocumento.descDoc, dbo.admCassaCausali.idCat, 
                  dbo.admCassaCausali.idSottCat, dbo.admCassaCausali.ruolo, dbo.admCassaMovimenti.idTipoCassa, dbo.pf_parSediVista.descrizioneSede AS descCassa, dbo.admCassaCausali.banca, dbo.admCassaMovimenti.dataMov, 
                  CONVERT(varchar(10), dbo.admCassaMovimenti.dataMov, 105) AS dataMovGMA, dbo.admCassaMovimenti.importoMov, dbo.admCassaCausali.segno, dbo.admCassaMovimenti.soggettoMov, dbo.admCassaMovimenti.codiceFiscaleMov, 
                  dbo.admCassaMovimenti.deletedMov, dbo.admCassaMovimenti.notaMov
FROM     dbo.admCassaMovimenti LEFT OUTER JOIN
                  dbo.admCassaDocumento ON dbo.admCassaMovimenti.idDoc = dbo.admCassaDocumento.idDoc LEFT OUTER JOIN
                  dbo.pf_parSediVista ON dbo.admCassaMovimenti.idTipoCassa = dbo.pf_parSediVista.idSede LEFT OUTER JOIN
                  dbo.admCassaCausali ON dbo.admCassaMovimenti.idCausale = dbo.admCassaCausali.idCausale
GO
/****** Object:  View [dbo].[admBilancioVista]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admBilancioVista]
AS
SELECT Anno, idCat, Segno, Causale, ISNULL([0], 0) AS Banca, ISNULL([1], 0) + ISNULL([2], 0) AS Cassa, ISNULL([1], 0) AS CassaErnesto, ISNULL([2], 0) AS CassaBasilio
FROM     (SELECT YEAR(dataMov) AS Anno, segno * (- 1) AS Segno, idCat, idSottcat, CASE segno WHEN 1 THEN 'E.' WHEN - 1 THEN 'U.' END + CONVERT(varchar(4), idCat) + '.' + CONVERT(varchar(5), idSottCat) + ' ' + descCausale AS Causale, 
                                    importoMov * segno AS importoMov, idTipoCassa
                  FROM      admCassaVista) AS sourceTable PIVOT (SUM(importoMov) FOR idTipoCassa IN ([0], [1], [2])) AS pivotTable
GO
/****** Object:  View [dbo].[admCassaCausaliVista]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admCassaCausaliVista]
AS
SELECT idCausale, idCat, idSottCat, CASE WHEN segno > 0 THEN 'E.' ELSE 'U.' END + CONVERT(varchar(2), idCat) + '.' + CONVERT(varchar(2), idSottCat) AS tipo, descCausale, segno, ruolo, banca
FROM     dbo.admCassaCausali
GO
/****** Object:  StoredProcedure [dbo].[admCassaCausaliRead]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <23/01/2020>
-- Description:	<Elenco Causali Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaCausaliRead]

@idCausale int,
@idRuolo varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idCausale = 0
		BEGIN			
			SELECT * FROM admCassaCausaliVista WHERE CHARINDEX(@idRuolo, ruolo, 1) > 0 AND idSottCat > 0 ORDER BY segno DESC, idCat ASC, idSottCat ASC
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaCausali WHERE idCausale = @idCausale
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaDocRead]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <23/01/2020>
-- Description:	<Elenco Tipo Documenti Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaDocRead]

@idDoc int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idDoc = 0
		BEGIN			
			SELECT * FROM admCassaDocumento
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaDocumento WHERE idDoc = @idDoc
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaRead]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <11/12/2019>
-- Description:	<Elenco Movimenti Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaRead]

@idMov int,
@idRuolo varChar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idMov = 0
		BEGIN			
			SELECT * FROM admCassaVista WHERE CHARINDEX(@idRuolo, ruolo, 1 ) > 0 ORDER BY YEAR(dataMov) DESC, dataMov DESC, idMov DESC
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaVista WHERE idMov = @idMov
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaTipoRead]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <03/02/2019>
-- Description:	<Legge Elenco Sedi>
-- =============================================

CREATE PROCEDURE [dbo].[admCassaTipoRead]

@idRuolo varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM pf_parSediVista WHERE CHARINDEX(@idRuolo, ruolo, 1) > 0 ORDER BY idSede

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaUpdate]    Script Date: 05/02/2020 17:32:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <19/12/2019>
-- Description:	<Aggiorna Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaUpdate]

@idMov int,
@idCausale int,
@idProg varchar(10),
@idDoc int,
@idTipoCassa int,
@dataMovGMA date,
@importoMov float,
@soggettoMov varchar(200),
@codiceFiscaleMov varchar(16),
@notaMov varchar(300),
@deletedMov bit,

@idRuolo int,
@banca bit,
@delete bit,
@spUpdate varchar(1),
@OK int = 0 OUTPUT

AS

DECLARE
@segno int,
@ultimoProg int,
@succesProg varchar(10)

BEGIN
	SET NOCOUNT ON;	

	IF @idMov = 0
		BEGIN
			SET @segno = (SELECT segno FROM admCassaCausali WHERE idCausale = @idCausale)
			IF @segno = 1
				BEGIN
					SET @ultimoProg = (SELECT MAX(CASE WHEN segno = 1 THEN idProg ELSE 0 END) FROM admCassaVista WHERE segno = 1 AND YEAR(dataMov) = YEAR(@dataMovGMA))
					SET @succesProg = CONVERT(varchar(10), @ultimoProg + 1)
				END
			ELSE
				BEGIN
					SET @succesProg = @idProg		
				END

			INSERT INTO admCassaMovimenti
						(idCausale,  idProg,      idDoc,  idTipoCassa,  dataMov,     importoMov,  codiceFiscaleMov,  soggettoMov,  notaMov) 
				VALUES  (@idCausale, @succesProg, @idDoc, @idTipoCassa, @dataMovGMA, @importoMov, @codiceFiscaleMov, @soggettoMov, @notaMov)

			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE admCassaMovimenti
				SET idCausale = @idCausale,
					idProg = @idProg,
					idDoc = @idDoc,
					idTipoCassa = @idTipoCassa,
					dataMov = @dataMovGMA,
					importoMov = @importoMov,
					codiceFiscaleMov = @codiceFiscaleMov,
					soggettoMov = @soggettoMov,
					notaMov = @notaMov,
					deletedMov = @deletedMov
				WHERE idMov= @idMov
			
			SET @OK = 3
		END
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[49] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 972
         Width = 792
         Width = 948
         Width = 7032
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admBilancioVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[33] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admCassaCausali"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 234
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1560
         Width = 4884
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5040
         Alias = 900
         Table = 1824
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaCausaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaCausaliVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[41] 4[28] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[57] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[52] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admCassaMovimenti"
            Begin Extent = 
               Top = 38
               Left = 40
               Bottom = 419
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admCassaDocumento"
            Begin Extent = 
               Top = 243
               Left = 689
               Bottom = 384
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parSediVista"
            Begin Extent = 
               Top = 287
               Left = 380
               Bottom = 406
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admCassaCausali"
            Begin Extent = 
               Top = 13
               Left = 376
               Bottom = 229
               Right = 602
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 756
         Width = 1092
         Width = 1128
         Width = 2892
         Width = 816
         Width = 1464
         Width = 780
         Width = 708
         Width = 960
         Width = 1296
         Width = 2004
         Width = 1956
         Width = 1200
         Width = 708
         Width = 2220
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 
      Begin ColumnWidths = 11
         Column = 4008
         Alias = 2244
         Table = 2640
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admCassaVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[44] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1320
         Width = 2412
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parSediVista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_parSediVista'
GO
