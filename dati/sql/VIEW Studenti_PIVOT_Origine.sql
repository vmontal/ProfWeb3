select sediStud, origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1]+[2]+[3]+[4]+[5] As Totale from
( select sediStud, idOrigineStud, origineStud, anno from pf_anagrafeStudentiVista where deleted = 0 ) as source
PIVOT (count(anno) FOR anno IN ([1],[2],[3], [4], [5])) as pivotta