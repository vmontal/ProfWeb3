SELECT
  [sub].[chardate],
  SUM(ISNULL([Australia], 0)) AS [Transactions Australia],
  SUM(CASE WHEN [Australia] IS NOT NULL THEN [TotalAmount] ELSE 0 END) AS [Amount Australia],
  SUM(ISNULL([Austria], 0)) AS [Transactions Austria],
  SUM(CASE WHEN [Austria] IS NOT NULL THEN [TotalAmount] ELSE 0 END) AS [Amount Austria]
FROM
(
  select * 
  from  mytransactions
  pivot (sum (totalcount) for country in ([Australia], [Austria])) as pvt
) AS [sub]
GROUP BY
  [sub].[chardate],
  [sub].[numericmonth]
ORDER BY 
  [sub].[numericmonth] ASC