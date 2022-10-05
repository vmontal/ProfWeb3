DECLARE 
@String VARCHAR(1000),
@separaR varchar(1) = '@',
@separaF varchar(1) = ';',
@separaV varchar(1) = '#',
@TOT int,
@totF int,
@N int = 1,
@F int = 1,
@fine int,
@fineF int,
@record varchar(100),
@valori varchar(100),
@campo varchar(100),
@idMateria varchar (3),
@idAnno varchar(5),
@idFreq varchar(1)

BEGIN
	CREATE TABLE #temp1 (ID int, idMateria varchar(2), idAnno varchar(5), idFreq varchar(1))

    --SET @String ='idMateria#12;idAnno#345;idFreq#S@idMateria#13;idAnno#12345;idFreq#M@idMateria#14;idAnno#1;idFreq#Q'
	--SET @String ='idMateria#12;idAnno#12;idFreq#S@idMateria#13;idAnno#345;idFreq#Q'
	SET @String = 'idMateria#36;idAnno#12345;idFreq#Q'
	--SET @String = ''

	SET @String = @String + @separaR
	SET @TOT = (CASE WHEN LEN(@String) > 1 THEN (SELECT LEN(@String) - LEN(REPLACE(@String, @separaR, ''))) ELSE 0 END)

	WHILE @N <= @TOT
		BEGIN
			SET @fine = CHARINDEX(@separaR, @String)
			SET @record = SUBSTRING(@String, 0, @fine) + @separaF
			SET @totF = (CASE WHEN LEN(@record) > 1 THEN (SELECT LEN(@record) - LEN(REPLACE(@record, @separaF, ''))) ELSE 0 END)
			SET @F = 1
			WHILE @F <= @totF
				BEGIN
					SET @fineF = CHARINDEX(@separaF, @record)
					SET @campo = SUBSTRING(@record, 0, @fineF)

					IF @F = 1 SET @idMateria = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
					IF @F = 2 SET @idAnno = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
					IF @F = 3 SET @idFreq = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))

					SET @record = RTRIM(SUBSTRING(@record, @fineF + 1, LEN(@record)))
					SET @F = @F + 1
				END
				
			INSERT INTO #temp1 (ID, idMateria, idAnno, idFreq) VALUES (@N, @idMateria, @idAnno, @idFreq)


			SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
			SET @N = @N + 1

		END

	SELECT * FROM #temp1

	DROP TABLE #temp1

END
