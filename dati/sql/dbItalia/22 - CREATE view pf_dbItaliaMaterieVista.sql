USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_dbItaliaMaterieVista]    Script Date: 13/01/2022 17:19:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[pf_dbItaliaMaterieVista]
AS
SELECT dbo.pf_dbItaliaMaterie.idRS, dbo.pf_parAssociazioni.ragioneSociale, dbo.pf_dbItaliaMaterie.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, dbo.pf_dbItaliaMaterie.oreErogate
FROM     dbo.pf_dbItaliaMaterie INNER JOIN
                  dbo.pf_parMaterie ON dbo.pf_dbItaliaMaterie.idMateria = dbo.pf_parMaterie.idMateria AND dbo.pf_dbItaliaMaterie.idRS = dbo.pf_parMaterie.idRS INNER JOIN
                  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
                  dbo.pf_parAssociazioni ON dbo.pf_dbItaliaMaterie.idRS = dbo.pf_parAssociazioni.idRS
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[27] 2[13] 3) )"
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
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_dbItaliaMaterie"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 148
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterie"
            Begin Extent = 
               Top = 9
               Left = 374
               Bottom = 205
               Right = 596
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parMaterieGruppo"
            Begin Extent = 
               Top = 38
               Left = 705
               Bottom = 179
               Right = 927
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_parAssociazioni"
            Begin Extent = 
               Top = 105
               Left = 946
               Bottom = 268
               Right = 1173
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
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
         Or ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_dbItaliaMaterieVista'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_dbItaliaMaterieVista'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_dbItaliaMaterieVista'
GO


