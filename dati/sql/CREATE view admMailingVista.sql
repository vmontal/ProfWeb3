USE [MSSqlProfWeb30]
GO

/****** Object:  View [dbo].[admAssembleeVista]    Script Date: 02/07/2021 17:30:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[admAssembleeVista]
AS
SELECT dbo.admAssemblee.idRS, dbo.admAssemblee.idAss, dbo.admAssemblee.idTipoAss, dbo.admTipoAss.tipoAss, CONVERT(varchar(10), dbo.admAssemblee.dataAss, 105) AS dataAss, CONVERT(varchar(10), DATEADD(DAY, - 1, 
                  dbo.admAssemblee.dataAss), 105) AS dataAssPrima, dbo.admAssemblee.oraAss, dbo.admAssemblee.luogoAss, dbo.admAssemblee.indirizzoAss, dbo.admAssemblee.oggettoAss, dbo.admAssemblee.odgAss, CONVERT(varchar(10), 
                  dbo.admAssemblee.dataInvio, 105) AS dataInvio, dbo.admAssemblee.inviata, dbo.admAssemblee.straord, dbo.admAssemblee.conferma
FROM     dbo.admAssemblee INNER JOIN
                  dbo.admTipoAss ON dbo.admAssemblee.idTipoAss = dbo.admTipoAss.idTipoAss
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[44] 4[28] 3) )"
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
         Configuration = "(H (1[50] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
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
         Configuration = "(H (1[51] 4) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "admAssemblee"
            Begin Extent = 
               Top = 8
               Left = 47
               Bottom = 383
               Right = 269
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "admTipoAss"
            Begin Extent = 
               Top = 17
               Left = 330
               Bottom = 178
               Right = 552
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
      Begin ColumnWidths = 15
         Width = 284
         Width = 996
         Width = 1116
         Width = 2196
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2076
         Width = 3024
         Width = 2304
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5376
         Alias = 2304
         Table = 2748
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAssembleeVista'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'admAssembleeVista'
GO


