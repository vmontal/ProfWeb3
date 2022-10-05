declare @top int = ROUND(RAND(), 0)
--print @top
select top (@top) * from pf_anagrafestudentivista where deleted = 0 order by newid()