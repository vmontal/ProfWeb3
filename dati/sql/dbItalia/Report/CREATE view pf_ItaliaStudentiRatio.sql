USE [MSSql171182]
GO

/****** Object:  View [dbo].[pf_ItaliaStudentiRatio]    Script Date: 20/01/2022 17:40:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[pf_ItaliaStudentiRatio]
AS
SELECT dbo.pf_ItaliaStudentiTotali.idRS, dbo.pf_ItaliaStudentiTotali.ragioneSociale, dbo.pf_ItaliaStudentiTotali.totStudenti, dbo.pf_ItaliaProfessori.Totale AS totProfessori, dbo.pf_ItaliaMaterieTotali.totOreErogate, 
                  ROUND(CAST(dbo.pf_ItaliaStudentiTotali.totStudenti AS Float) / dbo.pf_ItaliaProfessori.Totale, 2) AS ratioStud, ROUND(dbo.pf_ItaliaMaterieTotali.totOreErogate / CAST(dbo.pf_ItaliaStudentiTotali.totStudenti AS Float), 2) AS ratioOre
FROM     dbo.pf_ItaliaStudentiTotali INNER JOIN
                  dbo.pf_ItaliaProfessori ON dbo.pf_ItaliaStudentiTotali.idRS = dbo.pf_ItaliaProfessori.idRS INNER JOIN
                  dbo.pf_ItaliaMaterieTotali ON dbo.pf_ItaliaProfessori.idRS = dbo.pf_ItaliaMaterieTotali.idRS
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
         Configuration = "(H (1[37] 4[27] 3) )"
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
         Configuration = "(H (1[38] 3) )"
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
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pf_ItaliaStudentiTotali"
            Begin Extent = 
               Top = 15
               Left = 47
               Bottom = 174
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pf_ItaliaProfessori"
            Begin Extent = 
               Top = 7
               Left = 374
               Bottom = 278
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "pf_ItaliaMaterieTotali"
            Begin Extent = 
               Top = 7
               Left = 679
               Bottom = 148
               Right = 901
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
         Width = 3504
         Width = 1200
         Width = 1200
         Width = 1536
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5076
         Alias = 2124
         Table = 1944
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_ItaliaStudentiRatio'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'pf_ItaliaStudentiRatio'
GO


