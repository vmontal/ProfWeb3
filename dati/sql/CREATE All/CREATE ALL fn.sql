USE [MSSqlProfWeb30]
GO
/****** Object:  UserDefinedFunction [dbo].[dataPasqua]    Script Date: 26/07/2020 09:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[dataPasqua] ( @Y INT ) RETURNS DATE 

AS 

BEGIN 
    DECLARE     
		@EpactCalc INT,  
        @PaschalDaysCalc INT, 
        @NumOfDaysToSunday INT, 
        @EasterMonth INT, 
        @EasterDay INT 

    SET @EpactCalc = (24 + 19 * (@Y % 19)) % 30 
    SET @PaschalDaysCalc = @EpactCalc - (@EpactCalc / 28) 
    SET @NumOfDaysToSunday = @PaschalDaysCalc - ( 
        (@Y + @Y / 4 + @PaschalDaysCalc - 13) % 7 
    ) 

    SET @EasterMonth = 3 + (@NumOfDaysToSunday + 40) / 44 

    SET @EasterDay = @NumOfDaysToSunday + 28 - ( 
        31 * (@EasterMonth / 4) 
    ) 

    RETURN 
    ( 
        SELECT CONVERT 
        (  DATE, 
                 RTRIM(@Y)  
            + RIGHT('0'+RTRIM(@EasterMonth), 2)  
            + RIGHT('0'+RTRIM(@EasterDay), 2)  
		)
	)

END

GO
/****** Object:  UserDefinedFunction [dbo].[pf_pianoLezioniUpdateFn]    Script Date: 26/07/2020 09:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[pf_pianoLezioniUpdateFn] (@idProfessore int, @String VARCHAR(1000), @tipo varchar(1)) RETURNS INT

AS

BEGIN

DECLARE 

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
@idFreq varchar(1),

@output varchar(5)

BEGIN
	--CREATE TABLE #temp1 (ID int, idMateria varchar(2), idAnno varchar(5), idFreq varchar(1))

    --SET @String ='idMateria#12;idAnno#345;idFreq#S@idMateria#13;idAnno#12345;idFreq#M@idMateria#14;idAnno#1;idFreq#Q'
	--SET @String ='idMateria#12;idAnno#12;idFreq#S@idMateria#13;idAnno#345;idFreq#Q'
	--SET @String = 'idMateria#12;idAnno#123;idFreq#S'
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

			SET @output = CASE @tipo WHEN 'M' THEN @idMateria WHEN 'A' THEN @idAnno WHEN 'F' THEN @idFreq END
			RETURN @output

			SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
			SET @N = @N + 1

		END

END
	--SET @output = CASE @tipo WHEN 'M' THEN @idMateria WHEN 'A' THEN @idAnno WHEN 'F' THEN @idFreq END
	RETURN 0
END
GO
