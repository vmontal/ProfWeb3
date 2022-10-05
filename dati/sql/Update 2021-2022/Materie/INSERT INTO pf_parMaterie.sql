SET IDENTITY_INSERT pf_parMaterie ON
GO

DECLARE
@idRS int

SET @idRS = 14

WHILE @idRS <= 17
	BEGIN

		INSERT INTO pf_parMaterie (idRS, idMateria, materia, idGruppo, deleted) 
		SELECT @idRS, idMateria, materia, idGruppo, deleted FROM pf_parMaterie WHERE idRS = 1

		SET @idRS = @idRS + 1

	END

SET IDENTITY_INSERT pf_parMaterie OFF
