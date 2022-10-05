declare
@idSede varchar(10) = '23',
@numSedi int,
@terzo varchar(10)

SET @numSedi = LEN(@idSede)
SET @terzo = REPLICATE('X', @numSedi)

PRINT @numSedi
PRINT @terzo

SELECT nomeStud, sediStud, @idSede AS idSede,TRANSLATE(sediStud, @idSede, @terzo) AS TRA, CHARINDEX('X', TRANSLATE(sediStud, @idSede, @terzo), 1) AS DIF
FROM pf_anagrafeStudenti 
WHERE deleted =0 AND CHARINDEX('X', TRANSLATE(sediStud, @idSede, @terzo), 1) > 0