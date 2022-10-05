USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_dbItaliaStudentiVista]    Script Date: 13/01/2022 17:20:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[pf_dbItaliaStudentiVista]
AS
SELECT dbo.pf_dbItaliaStudenti.idRS, dbo.pf_parAssociazioni.ragioneSociale, dbo.pf_dbItaliaStudenti.idOrigineStud, dbo.admOrigine.origineStud, dbo.pf_dbItaliaStudenti.primo, dbo.pf_dbItaliaStudenti.secondo, dbo.pf_dbItaliaStudenti.terzo, 
                  dbo.pf_dbItaliaStudenti.quarto, dbo.pf_dbItaliaStudenti.quinto, 
                  dbo.pf_dbItaliaStudenti.primo + dbo.pf_dbItaliaStudenti.secondo + dbo.pf_dbItaliaStudenti.terzo + dbo.pf_dbItaliaStudenti.quarto + dbo.pf_dbItaliaStudenti.quinto AS totaleStud
FROM     dbo.pf_dbItaliaStudenti INNER JOIN
                  dbo.admOrigine ON dbo.pf_dbItaliaStudenti.idOrigineStud = dbo.admOrigine.idOrigineStud INNER JOIN
                  dbo.pf_parAssociazioni ON dbo.pf_dbItaliaStudenti.idRS = dbo.pf_parAssociazioni.idRS
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[32] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[41] 4[34] 3) )"
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
         Configuration = "(H (1 [56] 3))"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_dbItaliaStudenti"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 267
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "admOrigine"
            Begin Extent = 
               Top = 7
               Left = 318
               Bottom = 126
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 118
               Left = 525
               Bottom = 281
               Right = 752
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
         Width = 3228
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3432
         Alias = 900
         Table = 4140
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_dbItaliaStudentiVista'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_dbItaliaStudentiVista'
GO


