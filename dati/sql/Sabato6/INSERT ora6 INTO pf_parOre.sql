DECLARE
@idRS int,
@idSede varchar(1),
@id int = 1

WHILE @id <= 30
	begin
		Select @idRS = idrs, @idSede=idSede FROM
		(select top 100 ROW_NUMBER() OVER (ORDER BY idRS ASC) AS ID, * from pf_parSedi order by idrs, idSede) elenco
		WHERE ID = @id

		INSERT INTO pf_parOre (idRS, idSede, idOra, ora) VALUES (@idRS, @idSede, 6, '00:00:00')
		--print @idRS
		--print @idSede
		SET @id = @id +1
	end