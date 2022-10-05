/****** Script per comando SelectTopNRows da SSMS  ******/
select pf_parOrariVista.*, CASE WHEN pf_parOrariVista.impegno = 0 THEN -1 WHEN pf_parOrariVista.impegno = 1 AND pf_pianolezionitotalivista.Lezioni IS NULL THEN 0 ELSE pf_pianolezionitotalivista.Lezioni END AS Lezioni  from pf_parOrariVista left outer join pf_pianolezionitotalivista on
 pf_parOrariVista.idsede = pf_pianolezionitotalivista.idsede AND pf_parOrariVista.idOrario = pf_pianolezionitotalivista.idorario
 order by idsede, idOrario

--SELECT * from pf_parOrariVista order by idsede, idOrario