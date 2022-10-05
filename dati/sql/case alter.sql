CASE WHEN straord = 1 AND dbo.admTipoAss.idTipoAss = 'S' THEN ' Straodinaria' WHEN straord = 0 AND dbo.admTipoAss.idTipoAss = 'S' THEN ' Ordinaria' ELSE ' ' END
