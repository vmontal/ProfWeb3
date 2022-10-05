DECLARE 
@String VARCHAR(1000),
@separa varchar(1) = '@',
@TOT int,
@N int = 1,
@inizio int = 0,
@fine int

	create table #temp1 (ID int, VALUE varchar(1000))
	--create table #temp2 (ID int, VALUE varchar(1000))
	--CREATE TABLE #VALORI (ID varchar(20), valore varchar(5))

    SET @String ='idMateria#12;idAnno#12345;idFreq#S@idMateria#13;idAnno#12345;idFreq#S@idMateria#14;idAnno#12345;idFreq#S'
	--SET @String = 'idMateria#12;idAnno#12345;idFreq#S'
	--SET @String = 'idMateria#12;idAnno#12345;idFreq#S'

	--SELECT SUBSTRING(@String, CHARINDEX(@separa, @String) +1,  CHARINDEX(@separa, @String)- 1)
	SET @TOT = (SELECT LEN(@String) - LEN(REPLACE(@String, @separa, '')) + 1)
	SET @fine = CHARINDEX(@separa, @String)

	WHILE @N <= @TOT
		BEGIN
			INSERT INTO #temp1 (ID, VALUE)
				VALUES (@N, SUBSTRING(@String, @inizio, @fine))
			SET @inizio = CHARINDEX(@separa, @String) + 1
			SET @fine = CHARINDEX(@separa, @String) - 1
			SET @N = @N + 1

		END
	SELECT * FROM #temp1

	--INSERT INTO #temp1 
	--SELECT ROW_NUMBER() OVER(order by SUBSTRING(@separa + @String + @separa, Number + 1, CHARINDEX(@separa, @separa + @String + @separa, Number + 1) - Number -1)) AS ID, SUBSTRING(@separa + @String + @separa, Number + 1, CHARINDEX(@separa, @separa + @String + @separa, Number + 1) - Number -1) AS VALUE
	--FROM master.dbo.spt_values
	--WHERE type ='P' AND Number <= LEN(@separa + @String + @separa) - 1 AND SUBSTRING(@separa + @String + @separa, Number, 1) = @separa

	--SET @maxRowT = (SELECT MAX(ID) FROM #temp1)
	--WHILE @rowT <= @maxRowT
	--	BEGIN
	--		SET @String = (SELECT VALUE FROM #temp1 WHERE ID = @rowT)
	--		SET @separa = ';'
	--		INSERT INTO #temp2
	--		SELECT ROW_NUMBER() OVER(order by SUBSTRING(@separa + @String + @separa, Number + 1, CHARINDEX(@separa, @separa + @String + @separa, Number + 1) - Number -1)) AS ID, SUBSTRING(@separa + @String + @separa, Number + 1, CHARINDEX(@separa, @separa + @String + @separa, Number + 1) - Number -1) AS VALUE
	--		FROM master.dbo.spt_values
	--		WHERE type ='P' AND Number <= LEN(@separa + @String + @separa) - 1 AND SUBSTRING(@separa + @String + @separa, Number, 1) = @separa

	--		SET @maxRowS = (SELECT MAX(ID) FROM #temp2)
	--		SET @rowS = 1
	--		WHILE @rowS <= @maxRowS
	--			BEGIN
	--				SET @String = (SELECT VALUE FROM #temp2 WHERE ID = @rowS)
	--				SET @separa = '#'					
	--				INSERT INTO #VALORI (ID, valore) 
	--					VALUES (SUBSTRING(@String, 1, CHARINDEX(@separa, @String) - 1), SUBSTRING(@String, CHARINDEX(@separa, @String) + 1, LEN(@String)))

	--				SET @rowS = @rowS + 1
	--			END

	--		--SELECT * FROM #temp2


	--		DELETE FROM #temp2
	--		SET @rowT = @rowT + 1
	--	END

	--	SELECT * FROM #VALORI

	DROP TABLE #temp1
	--DROP TABLE #temp2
	--DROP TABLE #VALORI