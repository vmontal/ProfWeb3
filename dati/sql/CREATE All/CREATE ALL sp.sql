USE [MSSqlProfWeb30]
GO
/****** Object:  StoredProcedure [dbo].[admAssembleeRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <24/06/2019>
-- Description:	<Elenco Assemblee>
-- =============================================
CREATE PROCEDURE [dbo].[admAssembleeRead]

@idRS int,
@idAss int,
@idTipoAss varchar(1),
@tipoAss varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idAss = 0
		BEGIN			
			SELECT * FROM admAssembleeVista WHERE idTipoAss = @idTipoAss AND idRS = @idRS
		END
	ELSE
		BEGIN
			SELECT * FROM admAssembleeVista WHERE idAss = @idAss AND idRS = @idRS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admAssembleeUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <25/06/2019>
-- Description:	<Aggiorna Convocazione Assemblee>
-- =============================================
CREATE PROCEDURE [dbo].[admAssembleeUpdate]

@idRS int,
@idAss int,
@idTipoAss varchar(1),
@tipoAss varchar(1),
@dataAss date,
@dataAssPrima date,
@oraAss varchar(5),
@luogoAss varchar(100),
@indirizzoAss varchar(200),
@oggettoAss varchar(100),
@odgAss varchar(MAX),
@inviata bit,
@dataInvio date,
@straord bit,
@conferma varchar(300),

@delete bit,
@spUpdate varchar(1),
@OK int = 0 OUTPUT

AS

BEGIN

	SET NOCOUNT ON;

	IF @idAss = 0

		BEGIN
			INSERT INTO admAssemblee 
						(idRS,  idTipoAss,  dataAss,  oraAss,  luogoAss,  indirizzoAss,  oggettoAss,  odgAss) 
				VALUES  (@idRS, @idTipoAss, @dataAss, @oraAss, @luogoAss, @indirizzoAss, @oggettoAss, @odgAss)

			SET @OK = 1
		END

	ELSE IF @inviata = 0
		BEGIN
			UPDATE admAssemblee
				SET idTipoAss = @idTipoAss, 
					dataAss = @dataAss, 
					oraAss = @oraAss, --CAST(@oraAss AS time(0))
					luogoAss = @luogoAss,
					indirizzoAss = @indirizzoAss, 
					oggettoAss = @oggettoAss, 
					odgAss = @odgAss,
					straord = @straord,
					conferma = @conferma
				WHERE idAss = @idAss AND idRS = @idRS
			
			SET @OK = 3

		END

	ELSE IF @inviata = 1
		BEGIN
			UPDATE admAssemblee
				SET dataInvio = @dataInvio,
					inviata = @inviata,
					conferma = @conferma
				WHERE idAss = @idAss AND idRS = @idRS

			SET @OK = 3
		END
END
GO
/****** Object:  StoredProcedure [dbo].[admBilancioRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <03/03/2020>
-- Description:	<Bilancio Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admBilancioRead]

@idRS int,
@idSede varchar(1),
@Anno int,

@spRead varchar(1),
@tabella varchar(1)
	
AS

DECLARE
@maxID int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @maxID = (SELECT COUNT(*) FROM admBilancioVistaRollup WHERE Anno = @Anno AND idRS = @idRS)

	SELECT * FROM 
		(
		SELECT ROW_NUMBER() OVER (Order by Anno) AS id, Anno, Causale, Banca, Cassa, Totale 
		FROM admBilancioVistaRollup 
		WHERE Anno = @Anno AND idRS = @idRS
		) AS Sorgente
	WHERE id <> @maxID
	
	UNION
	(
	SELECT @maxID AS id, @Anno AS Anno, 'TOTALE GENERALE' AS Causale, SUM(Banca) AS Banca, SUM(Cassa) AS Cassa, SUM(Totale) AS Totale 
	FROM admBilancioVistaRollup 
	WHERE Anno = @Anno AND CHARINDEX('TOTALE', Causale) = 0 AND idRS = @idRS
	)
END
GO
/****** Object:  StoredProcedure [dbo].[admCassaCausaliRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <23/01/2020>
-- Description:	<Elenco Causali Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaCausaliRead]

@idCausale int,
@idRuolo varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idCausale = 0
		BEGIN			
			SELECT * FROM admCassaCausaliVista WHERE CHARINDEX(@idRuolo, ruolo, 1) > 0 AND idSottCat > 0 ORDER BY segno DESC, idCat ASC, idSottCat ASC
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaCausali WHERE idCausale = @idCausale
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaDocRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <23/01/2020>
-- Description:	<Elenco Tipo Documenti Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaDocRead]

@idDoc int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idDoc = 0
		BEGIN			
			SELECT * FROM admCassaDocumento
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaDocumento WHERE idDoc = @idDoc
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaMovimentiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <11/12/2019>
-- Description:	<Elenco Movimenti Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaMovimentiRead]

@idRS int,
@idMov int,
@idRuolo varChar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @idMov = 0
		BEGIN			
			SELECT * FROM admCassaMovimentiVista WHERE CHARINDEX(@idRuolo, ruolo, 1 ) > 0 AND idRS = @idRS ORDER BY YEAR(dataMov) DESC, dataMov DESC, idMov DESC
		END
	ELSE
		BEGIN
			SELECT * FROM admCassaMovimentiVista WHERE idMov = @idMov AND idRS = @idRS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[admCassaMovimentiUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <04/03/2020>
-- Description:	<Aggiorna Cassa>
-- =============================================
CREATE PROCEDURE [dbo].[admCassaMovimentiUpdate]

@idRS int,
@idMov int,
@idCausale int,
@idProg varchar(10),
@idDoc int,
@idTipoCassa int,
@dataMovGMA date,
@importoMov float,
@soggettoMov varchar(200),
@codiceFiscaleMov varchar(16),
@notaMov varchar(300),
@deletedMov bit,

@idRuolo int,
@banca bit,
@delete bit,
@spUpdate varchar(1),
@OK int = 0 OUTPUT

AS

DECLARE
@segno int,
@ultimoProg int,
@succesProg varchar(10),
@giro int

BEGIN
	SET NOCOUNT ON;	

	IF @idMov = 0
		BEGIN			
			SELECT @segno = segno, @giro = giro FROM admCassaCausali WHERE idCausale = @idCausale
			IF @giro = 0
				BEGIN
					IF @segno = 1
						BEGIN
							SET @ultimoProg = (SELECT MAX(CASE WHEN segno = 1 THEN idProg ELSE 0 END) FROM admCassaMovimentiVista WHERE segno = 1 AND YEAR(dataMov) = YEAR(@dataMovGMA) AND idRS = @idRS)
							SET @ultimoProg = ISNULL(@ultimoProg, 0)
							SET @succesProg = CONVERT(varchar(10), @ultimoProg + 1)
						END
					ELSE
						BEGIN
							SET @succesProg = @idProg		
						END

				END
			ELSE
				BEGIN
					SET @succesProg = 0 
				END
			
			INSERT INTO admCassaMovimenti
						(idRS,  idCausale,  idProg,      idDoc,  idTipoCassa,  dataMov,     importoMov,  codiceFiscaleMov,  soggettoMov,  notaMov) 
				VALUES  (@idRS, @idCausale, @succesProg, @idDoc, @idTipoCassa, @dataMovGMA, @importoMov, @codiceFiscaleMov, @soggettoMov, @notaMov)

			IF @giro > 0
				BEGIN
					SET @idCausale = (SELECT giro FROM admCassaCausali WHERE idCausale = @idCausale)
					SET @succesProg = 'GC' + CONVERT(varchar(4), YEAR(@dataMovGMA)) + RIGHT('0' + CONVERT(varchar(2), MONTH(@dataMovGMA)), 2) + RIGHT('0' + CONVERT(varchar(2), DAY(@dataMovGMA)), 2)
					SET @idTipoCassa = IIF(@idTipoCassa <> 0, 0, 1) --da modificare nella versione 3.0 
					
					INSERT INTO admCassaMovimenti
								(idRS,  idCausale,  idProg,      idDoc,  idTipoCassa,  dataMov,     importoMov,  codiceFiscaleMov,  soggettoMov,  notaMov) 
						VALUES  (@idRS, @idCausale, @succesProg, @idDoc, @idTipoCassa, @dataMovGMA, @importoMov, @codiceFiscaleMov, @soggettoMov, @notaMov)

				END

			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE admCassaMovimenti
				SET idCausale = @idCausale,
					idProg = @idProg,
					idDoc = @idDoc,
					idTipoCassa = @idTipoCassa,
					dataMov = @dataMovGMA,
					importoMov = @importoMov,
					codiceFiscaleMov = @codiceFiscaleMov,
					soggettoMov = @soggettoMov,
					notaMov = @notaMov,
					deletedMov = @deletedMov
				WHERE idMov= @idMov AND idRS = @idRS
			
			SET @OK = 3
		END
END
GO
/****** Object:  StoredProcedure [dbo].[admCassaTipoRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <03/02/2019>
-- Description:	<Legge Elenco Sedi>
-- =============================================

CREATE PROCEDURE [dbo].[admCassaTipoRead]

@idRS int,
@idRuolo varchar(1),


@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM pf_parSediVista WHERE CHARINDEX(@idRuolo, ruolo, 1) > 0 AND (idRS = @idRS OR idRS = 0) ORDER BY idSede

END
GO
/****** Object:  StoredProcedure [dbo].[admGetService]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <29/04/2020>
-- Description:	<Recupera Servizi Valore Aggiunto>
-- =============================================
CREATE PROCEDURE [dbo].[admGetService]

@idSer int
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
			
	SELECT * FROM admService WHERE idSer = @idSer

END
GO
/****** Object:  StoredProcedure [dbo].[admLogin]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <31/03/2016>
-- Description:	<Verifica Credenziali di Accesso>
-- =============================================

CREATE PROCEDURE [dbo].[admLogin]

--@idRS int,
@User varchar(100),
@Pass varchar(100),

@OK int OUTPUT

AS
BEGIN

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE
@attivo bit = 0,
@cambia bit = 0,
@id int = 0

IF NOT EXISTS (SELECT id FROM admUtenti WHERE Username = @User AND [Password] = @pass) --AND idRS = @idRS)
	BEGIN
		SELECT -1 AS id
	END

ELSE
	BEGIN		
		SELECT @id = id, @attivo = attivo FROM admUtenti WHERE Username = @User AND [Password] = @pass --AND idRS = @idRS
		IF @attivo = 0
			BEGIN
				SELECT -2 AS id
			END
		ELSE
			BEGIN
				UPDATE admUtenti SET ultimo = GETDATE() WHERE id = @id --AND idRS = @idRS			
				SELECT * FROM admAuth WHERE id = @id --FOR JSON PATH--AND idRS = @idRS
			END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[admOrigineStudRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <09/05/2019>
-- Description:	<Elenco Origine Studente>
-- =============================================
CREATE PROCEDURE [dbo].[admOrigineStudRead]

@idOrigineStud int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
			
	SELECT * FROM admOrigine

END
GO
/****** Object:  StoredProcedure [dbo].[admPasswordReset]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET,JS,ng>
-- Create date: <11/04/2016>
-- Description:	<Aggiorna Password>
-- =============================================
CREATE PROCEDURE [dbo].[admPasswordReset]

@idRS int,
@email varchar(255),
@newPass varchar(100),
@cryPass varchar(100),

@sp varchar(1),

@OK int = 0 OUTPUT

AS
BEGIN

--DECLARE @newPass varchar(8)

	SET NOCOUNT ON;

	-- Insert statements for procedure here
	BEGIN
		--SET @newPass = (SELECT Username FROM admUtenti WHERE ID = @ID)

		UPDATE admUtenti
			SET [password] = LTRIM(RTRIM(@cryPass)), cambiaPassword = 1, scadenza = GETDATE() + 60
			WHERE emailUser = @email AND idRS = @idRS
			
		SET @OK = 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[admPasswordUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET,JS,ng>
-- Create date: <10/04/2016>
-- Description:	<Aggiorna Password>
-- =============================================
CREATE PROCEDURE [dbo].[admPasswordUpdate]

@idRS int,
@ID int,
@password varchar(100),

@OK int = 0 OUTPUT

AS
BEGIN

	SET NOCOUNT ON;

	-- Insert statements for procedure here
	BEGIN
		UPDATE admUtenti
			SET Password = @password, cambiaPassword = 0, scadenza = GETDATE() + 60
			WHERE ID = @ID AND idRS = @idRS
			
		SET @OK = 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[admResetUtente]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET, JS, ng>
-- Create date: <18/12/2016>
-- Description:	<Reset Utente>
-- =============================================
CREATE PROCEDURE [dbo].[admResetUtente]

--@idRS int,
@mail varchar(255),
@newPass varchar(200) 

AS
BEGIN

DECLARE
@utente varchar(100),
@OK int
 

	SET NOCOUNT ON;

	-- Insert statements for procedure here
	BEGIN
		IF NOT EXISTS (SELECT Username FROM admUtenti WHERE emailUser = @mail) --AND idRS = @idRS)
			BEGIN
				SET @OK = 0
			END
		ELSE
			BEGIN
				--SET @utente = (SELECT Username FROM admUtenti WHERE emailUser = @mail)
				--SET @newPass = CHAR(65 + ROUND(RAND()*25,0))+ CHAR(97 + ROUND(RAND()*25,0)) + CONVERT(varchar,ROUND(100000 * RAND(),0)) + CHAR(97 + ROUND(RAND()*25,0))+ CHAR(65 + ROUND(RAND()*25,0))
				UPDATE admUtenti
					SET password = @newPass, cambiaPassword = 1, scadenza = GETDATE() + 60
				WHERE emailUser = @mail --AND idRS = @idRS
				SET @OK = 1
			END

		SELECT @OK AS OK
	END
END
GO
/****** Object:  StoredProcedure [dbo].[admRuoliRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <11/06/2016>
-- Description:	<Elenco Ruoli>
-- =============================================
CREATE PROCEDURE [dbo].[admRuoliRead]

@idRuolo int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
			
	SELECT * FROM admRuoli

END
GO
/****** Object:  StoredProcedure [dbo].[admTipoProfRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <09/05/2019>
-- Description:	<Elenco Tipo Professore>
-- =============================================
CREATE PROCEDURE [dbo].[admTipoProfRead]

@idTipoProf int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
			
	SELECT * FROM admTipoProf

END
GO
/****** Object:  StoredProcedure [dbo].[admTipoSocioRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <09/05/2019>
-- Description:	<Elenco Tipo Soci>
-- =============================================
CREATE PROCEDURE [dbo].[admTipoSocioRead]

@idTipoSocio int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)
	
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
			
	SELECT * FROM admTipoSocio

END
GO
/****** Object:  StoredProcedure [dbo].[admUtentiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <05/04/2016>
-- Description:	<Elenco Utenti>
-- =============================================
CREATE PROCEDURE [dbo].[admUtentiRead]
	-- Add the parameters for the stored procedure here
@idRS int,
@id int,
@idSede varchar(10),
@idRuolo int,
@drop int,

@spRead varchar(1),
@tabella varchar(1)
	
AS

DECLARE
@idMin int,
@idMax int,
@numSedi int,
@terzo varchar(10)

SET @numSedi = LEN(@idSede)
SET @terzo = REPLICATE('X', @numSedi)
--@all bit


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @all = CASE WHEN @idSede = 0 THEN 1 ELSE 0 END;
	
	SET @idMin = CASE WHEN @id = 0 THEN 0    ELSE @id END;
	SET @idMax = CASE WHEN @id = 0 THEN (SELECT MAX(id) FROM admAuth WHERE idRS = @idRS) ELSE @id END;

	SELECT * FROM admAuth WHERE id >= @idMin AND id <= @idMax AND CHARINDEX('X', TRANSLATE(sediUser, @idSede, @terzo), 1) > 0 AND idRuolo >= @idRuolo AND idRS = @idRS ORDER BY attivo DESC, idRuolo ASC, cognome ASC
END
GO
/****** Object:  StoredProcedure [dbo].[admUtentiUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET,JS,ng>
-- Create date: <07/04/2016>
-- Description:	<Aggiorna Utente>
-- =============================================
CREATE PROCEDURE [dbo].[admUtentiUpdate]

@idRS int,
@id int,
@cognome varchar(100),
@nome varchar(100),
@emailUser varchar(200),
@username varchar(100),
@password varchar(200),
@dataNascitaUser date,
@luogoNascitaUser varchar(100),
@codiceFiscaleUser varchar(16),
@indirizzoUser varchar(255),
@comuneUser varchar(100),
@provUser varchar(2),
@capUser varchar(5),
@tel1User varchar(20),
@tel2User varchar(20),
@attivo bit,
@idRuolo int,
@idTipoSocioUser int,
@privacyUser bit,
@liberaUser bit,
@firmaUser bit,
@firmaDataUser date,
@sediUser varchar(9),

@emailCheck bit,
@delete int,
@spUpdate varchar(1),
@OK int = 0 OUTPUT

AS

BEGIN

	SET NOCOUNT ON;
	--SET @pos = charindex('@', @emailUser )
	--SET @username = LEFT(@emailUser, @pos -1 )

	IF @id = 0

		BEGIN
			IF NOT EXISTS (SELECT id FROM admUtenti WHERE emailUser = @emailUser AND idRS = @idRS)
				BEGIN
					INSERT INTO admUtenti 
								(idRS,  cognome,  nome,  emailUser,  username, [password], privacyUser,  liberaUser,  firmaUser,  firmaDataUser,  dataNascitaUser,  luogoNascitaUser,  codiceFiscaleUser,  indirizzoUser,  comuneUser,  capUser,  provUser,  tel1User,  tel2User,  sediUser) 
						VALUES  (@idRS, @cognome, @nome, @emailUser, @username, @password, @privacyUser, @liberaUser, @firmaUser, @firmaDataUser, @dataNascitaUser, @luogoNascitaUser, @codiceFiscaleUser, @indirizzoUser, @comuneUser, @capUser, @provUser, @tel1User, @tel2User, @sediUser)

					SET @OK = 1
				END
			ELSE
				BEGIN
					SET @OK = 2
				END
		END

	ELSE
		BEGIN
			IF NOT EXISTS (SELECT id FROM admUtenti WHERE id <> @id AND emailUser = @emailUser AND idRS = @idRS)
				BEGIN
					UPDATE admUtenti
						SET cognome = @cognome, 
							nome = @nome, 
							emailUser = @emailUser, 
							username = @username, 
							attivo = @attivo, 
							idRuolo = @idruolo,
							idTipoSocioUser = @idTipoSocioUser,
							privacyUser = @privacyUser,
							liberaUser = @liberaUser,
							firmaUser = @firmaUser,
							firmaDataUser = @firmaDataUser,
							dataNascitaUser = @dataNascitaUser,
							luogoNascitaUser = @luogoNascitaUser,
							codiceFiscaleUser = @codiceFiscaleUser,
							indirizzoUser = @indirizzoUser,
							comuneUser = @comuneUser,
							provUser = @provUser,
							capUser = @capUser,
							tel1User = @tel1User,
							tel2User = @tel2User,
							emailCheck = @emailCheck,
							sediUser = @sediUser

						WHERE id = @id AND idRS = @idRS
			
					SET @OK = 3
				END
			ELSE
				BEGIN
					SET @OK = 2
				END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[admVerificaMail]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET,JS,ng>
-- Create date: <06/06/2016>
-- Description:	<Verifica Mail per Attivazione Utente>
-- =============================================
CREATE PROCEDURE [dbo].[admVerificaMail]

--@idRS int,
@mail varchar(255),
@form varchar(100),

@OK int = 0 OUTPUT,
@testo varchar(255) OUTPUT

AS

BEGIN

	SET NOCOUNT ON;

	-- Insert statements for procedure here
	BEGIN
	IF @form='Utente'
		BEGIN
		IF NOT EXISTS (SELECT emailUser FROM admUtenti WHERE emailUser=@mail) -- AND idRS = @idRS)
			BEGIN
				SET @OK = 0
				SET @testo = 'Impossibile Attivare: mail non presente in archivio'
			END
		ELSE
			BEGIN
				IF (SELECT attivo FROM admUtenti WHERE emailUser=@mail ) = 0 --AND idRS = @idRS
					BEGIN
						UPDATE admUtenti SET attivo = 1, emailCheck = 1 WHERE emailUser=@mail --AND idRS = @idRS
						SET @OK = 1
						SET @testo = 'Utente Attivato con successo'
					END
				ELSE
					BEGIN
						UPDATE admUtenti SET attivo = 1, emailCheck = 1 WHERE emailUser=@mail --AND idRS = @idRS
						SET @OK = 2
						SET @testo = 'Utente già attivo'
					END
			END
		END

	ELSE IF @form='Studente'
		BEGIN
		IF NOT EXISTS (SELECT emailStud FROM pf_anagrafeStudenti WHERE emailStud=@mail) -- AND idRS = @idRS)
			BEGIN
				SET @OK = 0
				SET @testo = 'Impossibile Attivare Studente: mail non presente in archivio'
			END
		ELSE
			BEGIN
				IF (SELECT emailCheck FROM pf_anagrafeStudenti WHERE emailStud=@mail ) = 0 --AND idRS = @idRS
					BEGIN
						UPDATE pf_anagrafeStudenti SET emailCheck = 1 WHERE emailStud=@mail --AND idRS = @idRS
						SET @OK = 1
						SET @testo = 'Studente Attivato con successo: indirizzo eMail riconosciuto'
					END
				ELSE
					BEGIN
						SET @OK = 2
						SET @testo = 'Studente già attivo'
					END
			END			
		END

	ELSE IF @form='Docente'
		BEGIN
		IF NOT EXISTS (SELECT emailProf FROM pf_anagrafeProfessori WHERE emailProf=@mail) -- AND idRS = @idRS)
			BEGIN
				SET @OK = 0
				SET @testo = 'Impossibile Attivare Docente: mail non presente in archivio'
			END
		ELSE
			BEGIN
				IF (SELECT emailCheck FROM pf_anagrafeProfessori WHERE emailProf=@mail ) = 0 --AND idRS = @idRS
					BEGIN
						UPDATE pf_anagrafeProfessori SET emailCheck = 1 WHERE emailProf=@mail --AND idRS = @idRS
						SET @OK = 1
						SET @testo = 'Docente Attivato con successo: indirizzo eMail riconosciuto'
					END
				ELSE
					BEGIN
						SET @OK = 2
						SET @testo = 'Docente già attivo'
					END
			END			
		END

	END
END
GO
/****** Object:  StoredProcedure [dbo].[admVersione]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <01/1072019>
-- Description:	<Aggiorno il numero e la data della versione dell'APP>
-- =============================================
CREATE PROCEDURE [dbo].[admVersione]

	-- Add the parameters for the stored procedure here
@idRs int,
@spUpdate varchar(1),
@userID int,
@tipoUser varchar(1),
@versione varchar(5),
@dataVersione date,
@email varchar(200),
@OK int = 0 OUTPUT


AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @tipoUser = 'S'
		BEGIN
			UPDATE pf_anagrafeStudenti SET versione = @versione, dataVersione = @dataVersione WHERE emailStud = @email AND idRS = @idRS
			SET @OK = 1
		END

	ELSE IF @tipoUser = 'D'
		BEGIN
			UPDATE pf_anagrafeProfessori SET versione = @versione, dataVersione = @dataVersione WHERE emailProf = @email AND idRS = @idRS
			SET @OK = 1
		END

	ELSE IF @tipoUser = 'G'
		BEGIN
			UPDATE admUtenti SET versione = @versione, dataVersione = @dataVersione WHERE emailUser = @email AND idRS = @idRS
			SET @OK = 1
		END
	
	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[getStruttura]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <14/03/2018>
-- Description:	<Struttura Tabella>
-- =============================================
CREATE PROCEDURE [dbo].[getStruttura]

@table varchar(200),

@sp varchar(1)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	 SET NOCOUNT ON;

	SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @table

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeGeneraleCheck]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2019>
-- Description:	<Cerca Anagrafe Generale>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeGeneraleCheck]

--@idRS int,
@spRead varchar(1),
@tabella varchar(1),
@drop int,
@email varchar(200),
@tipo varchar(1),
@txtCheckCode int

AS
DECLARE
@istitutoNome varchar(50) = '',
@istitutoTipo varchar(60) = '',
@annoStud varchar(1) = 0,
@materiaProf varchar(300) = '',

@valore varchar(60),
@nr int = 1,
@max int,
@idMateria int,
@materia varchar(50),
@materiaProfString varchar(max) = '',
@separa varchar(1) = '',
@idAnno varchar(15),
@idFreq varchar(10),
@frequenza varchar(15)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @OK = 0

	SET @txtCheckCode = (SELECT checkCode FROM pf_anagrafeGeneraleVista WHERE email = @email AND tipo = @tipo AND checkCode = @txtCheckCode) --AND idRS = @idRS)	
	SET @txtCheckCode = CASE WHEN @txtCheckCode IS NULL OR @txtCheckCode = 0 THEN 0 ELSE 1 END

	IF @tipo = 'S'
		BEGIN
			SELECT @istitutoNome = istitutoNome, @istitutoTipo = istitutoTipo, @annoStud = anno FROM pf_anagrafeStudentiVista WHERE emailStud = @email --AND idRS = @idRS
		END
	ELSE IF @tipo = 'D'
		BEGIN
			SELECT @materiaProf = materiaProf FROM pf_anagrafeProfessoriVista WHERE emailProf = @email --AND idRS = @idRS
			IF LEN(@materiaProf) > 0
				BEGIN
					CREATE TABLE #splitProf (NR int , valore varchar(50))
					INSERT INTO #splitProf select row_number() over(order by value ASC) as NR, value as valore FROM STRING_SPLIT( @materiaProf, '@')
					SET @max = (SELECT MAX(NR) FROM #splitProf)
					WHILE @nr <= @max
						BEGIN
							SET @valore = (select valore from #splitProf where nr = @nr)
							SET @idMateria = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idMateria%'))
							SET @idAnno = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idAnno%'))
							SET @idFreq = (select rtrim(substring(value, charindex('#', value) + 1, 5)) from string_split(@valore, ';') where value like ('%idFreq%'))
							SET @materia = (select materia from pf_parMaterie where idMateria = @idMateria)
							SET @frequenza = CASE WHEN @idFreq ='S' THEN 'Settimanale' WHEN @idFreq = 'Q' THEN 'Quindicinale' ELSE 'Mensile' END
							SET @materiaProfString = @materiaProfString + @separa + @materia + ' - anni ' + @idAnno + ' - ' + @frequenza
							SET @nr = @nr + 1
							SET @separa = '@'
						END
					DROP TABLE #splitProf

				END
		END

	SELECT idRS, ID,  nome AS nomeUser, 
				email AS emailUser, 
				tipo AS tipoUser, 
				@txtCheckCode AS checkCode, 
				idSede, 
				@istitutoNome AS istitutoNome,  
				@istitutoTipo AS istitutoTipo, 
				@annoStud AS annoStud, 
				@materiaProfString AS materiaProf, 
				versione, 
				CONVERT (varchar(10), dataVersione, 105) AS dataVersione 
	FROM pf_anagrafeGeneraleVista 
	WHERE email = @email AND tipo = @tipo --AND idRS = @idRS

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeGeneraleRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2019>
-- Description:	<Cerca Anagrafe Generale>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeGeneraleRead]

--@idRS int,
@spRead varchar(1),
@tabella varchar(1),
@drop int,
@email varchar(200),
@tipo varchar(1)
--@OK int OUTPUT

AS

DECLARE
@checkCode int = 0


BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	--SET @OK = 0

	IF EXISTS (SELECT ID FROM pf_anagrafeGeneraleVista WHERE email = @email AND tipo = @tipo) -- AND idRS = @idRS)
		BEGIN
			SET @checkCode = RAND() * 1000000
			SET @checkCode = CASE WHEN @checkCode > 0 AND @checkCode < 100000 THEN @checkCode + 100000 ELSE @checkCode END

			IF @tipo = 'S' UPDATE pf_anagrafeStudenti SET checkCode = @checkCode WHERE emailStud = @email --AND idRS = @idRS
			IF @tipo = 'D' UPDATE pf_anagrafeProfessori SET checkCode = @checkCode WHERE emailProf = @email --AND idRS = @idRS
			IF @tipo = 'G' UPDATE admUtenti SET checkCode = @checkCode WHERE emailUser = @email --AND idRS = @idRS

			--SET @OK = @checkCode

			SELECT ID + checkCode AS ID, nome, email, checkCode, idSede FROM pf_anagrafeGeneraleVista WHERE email = @email AND tipo = @tipo --AND idRS = @idRS
		END
	ELSE
		BEGIN
			SELECT 0 AS ID, 'sconosciuto' AS nome, 'sconosciuto' AS email, 1 AS checkCode
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeIstitutiCreate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <26/02/2018>
-- Description:	<Inserisci Anagrafe Istituti>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeIstitutiCreate]

@idRS int,
@CODICEISTITUTO int,
@ISTITUTO varchar(50), 
@DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA varchar(60), 
@INDIRIZZO varchar(50), 
@CAP varchar(5),
@COMUNE varchar(50),
@PROVINCIA varchar(50),
@REGIONE varchar(50),
@INDIRIZZOEMAILSCUOLA varchar(40),
@INDIRIZZOPECSCUOLA varchar(40),
@SITOWEBSCUOLA varchar(50),

@deleteI as bit,
@spUpdate varchar(20),
@delete bit,

@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	--IF LEN(@CODICEISTITUTO) = 10
		BEGIN
			IF NOT EXISTS (SELECT CODICEISTITUTO FROM pf_anagrafeIstituti WHERE ISTITUTO = @ISTITUTO AND idRS = @idRS)
				BEGIN
					INSERT INTO pf_anagrafeIstituti
							(
							idRS,
							ISTITUTO,
							DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA,
							INDIRIZZO, CAP, COMUNE, PROVINCIA, REGIONE,							
							INDIRIZZOEMAILSCUOLA, INDIRIZZOPECSCUOLA, SITOWEBSCUOLA
							)
				     VALUES (
							@idRS,
							@ISTITUTO, 
							@DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA, 
							@INDIRIZZO, @CAP, @COMUNE, @PROVINCIA, @REGIONE,							
							@INDIRIZZOEMAILSCUOLA, @INDIRIZZOPECSCUOLA, @SITOWEBSCUOLA							
							)
					-- inserimento completato con successo
					SET @OK = 1
				END
	
			ELSE
				BEGIN

					-- Istituto già presente
					SET @OK = 2
				END
		END
	
	--ELSE
	--	BEGIN
	--		-- codice istituto errato		
	--		SET @OK = 4
	--	END

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeIstitutiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Anagrafe Istituto>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeIstitutiRead]

@idRS int,
@CODICEISTITUTO int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)


AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @CODICEISTITUTO = 0 --OR LEN(@CODICEISTITUTO) < 10
		BEGIN
			IF @drop = 0
				BEGIN
					SELECT *, deleted as deleteI FROM pf_anagrafeIstitutiVista WHERE idRS = @idRS ORDER BY deleted ASC, DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA DESC, ISTITUTO ASC
				END
			ELSE
				BEGIN
					SELECT * FROM pf_anagrafeIstitutiVista WHERE deleted = 0 AND idRS = @idRS ORDER BY DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA DESC, ISTITUTO ASC
				END				
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_anagrafeIstitutiVista WHERE CODICEISTITUTO = @CODICEISTITUTO AND idRS = @idRS --AND deleted = 0
		END

	--RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeIstitutiUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Anagrafe Istituti>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeIstitutiUpdate]

@idRS int,
@CODICEISTITUTO int,
@ISTITUTO varchar(50), 
@DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA varchar(60), 
@INDIRIZZO varchar(50), 
@CAP varchar(5),
@COMUNE varchar(50),
@PROVINCIA varchar(50),
@REGIONE varchar(50),
@INDIRIZZOEMAILSCUOLA varchar(40),
@INDIRIZZOPECSCUOLA varchar(40),
@SITOWEBSCUOLA varchar(50),
@deleteI bit,

@spUpdate varchar(20),
@delete bit,

@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;


	--IF LEN(@CODICEISTITUTO) = 10
		BEGIN
			IF NOT EXISTS (SELECT CODICEISTITUTO FROM pf_anagrafeIstituti WHERE ISTITUTO = @ISTITUTO AND idRS = @idRS)
				BEGIN
					
					-- Istituto già presente
					SET @OK = 2
				END
	
			ELSE
				BEGIN
					UPDATE pf_anagrafeIstituti
						SET --CODICEISTITUTO = @CODICEISTITUTO,
							ISTITUTO = @ISTITUTO,
							DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA = @DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA,
							INDIRIZZO = @INDIRIZZO,
							CAP = @CAP,
							COMUNE = @COMUNE,
							PROVINCIA = @PROVINCIA,
							REGIONE = @REGIONE,
							INDIRIZZOEMAILSCUOLA = @INDIRIZZOEMAILSCUOLA,
							INDIRIZZOPECSCUOLA = @INDIRIZZOPECSCUOLA, 
							SITOWEBSCUOLA = @SITOWEBSCUOLA,
							deleted = @deleteI
							
						WHERE CODICEISTITUTO = @CODICEISTITUTO AND idRS = @idRS

					-- Aggiornamento avvenuto con successo
					SET @OK = 3
				END
		END
	
	--ELSE
	--	BEGIN
	--		-- codice istituto errato		
	--		SET @OK = 4
	--	END

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriMaterieRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Anagrafe Professore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeProfessoriMaterieRead]

@idRS int,
@idProfessore int,
@idMateria int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

AS


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idProfessore = 0
		BEGIN
			SELECT * FROM pf_pianoLezioniVista WHERE idMateriaLez = @idMateria AND idRS = @idRS
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_pianoLezioniVista WHERE idProfessoreLez = @idProfessore AND idMateriaLez = @idMateria AND idRS = @idRS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Read Anagrafe Professore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeProfessoriRead]

@idRS int,
@idProfessore int,
@idSede varchar(10),
@drop int,
@spRead varchar(1),
@tabella varchar(1)

AS
DECLARE 
@cerca int,
--@all bit
@numSedi int,
@terzo varchar(10)

SET @numSedi = LEN(@idSede)
SET @terzo = REPLICATE('X', @numSedi)
SET @cerca = CASE WHEN @drop <= 0 THEN 0 ELSE -1 END
--SET @all = CASE WHEN @idSede = 0 THEN 1 ELSE 0 END

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idProfessore = 0
		BEGIN
		IF @drop <= 0 -- parametro per elenco generale		
			BEGIN
				SELECT *, deleted AS deletedProf 
				FROM pf_anagrafeProfessoriVista 
				WHERE idProfessore > @cerca AND CHARINDEX('X', TRANSLATE(sediProf, @idSede, @terzo), 1) > 0 AND idRS = @idRS 
				ORDER BY deleted, nomeProf  
			END

		ELSE IF @drop = 1 -- parametro per popolare dropDown elenco professori con materie assegnate nella sezione Lezioni
			BEGIN
				SELECT *
				FROM pf_anagrafeProfessoriVista 
				WHERE idProfessore > @cerca AND deleted = 0 AND CHARINDEX('X', TRANSLATE(sediProf, @idSede, @terzo), 1) > 0 AND idRS = @idRS 
				ORDER BY nomeProf 
			END
		
		ELSE IF @drop = 2 --parametro utilizzato nell'App Mobile per popolare le tendine della ricerca (solo utente di Segreteria)
			BEGIN
				SELECT * 
				FROM pf_anagrafeProfessoriVista 
				WHERE idProfessore > @cerca AND deleted = 0 AND (idRS = @idRS OR idRS = 0)
				ORDER BY nomeProf --AND sediProf LIKE ('%' + @idSede + '%')
			END
		END
	ELSE
		BEGIN
			EXEC pf_anagrafeProfessoriUpdateLezioni @idProfessore

			SELECT *, deleted AS deletedProf 
			FROM pf_anagrafeProfessoriVista 
			WHERE idProfessore = @idProfessore AND idRS = @idRS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Anagrafe Professore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeProfessoriUpdate]

@idRS int,
@idProfessore int,
@nomeProf varchar(200), 
@emailProf varchar(200),
@emailCheck bit,  
@tel1Prof varchar(20), 
@tel2Prof varchar(20),
@indirizzoProf varchar(200),
@comuneProf varchar(100),
@provprof varchar(2),
@capProf varchar(5),
@sediProf varchar(40),
@notaProf varchar (255),
@codiceFiscaleProf varchar(16),
@dataNascitaProf date,
@luogoNascitaProf varchar(200),
@privacyProf bit,
@liberaProf bit,
@firmaProf bit,
@firmaDataProf date,
@materiaProf varchar(MAX),
@lezioniPrenotate varchar(1),
@idTipoSocioProf int,
@idTipoProf int,

@spUpdate varchar(20),
@delete bit,
@deletedProf bit,
@OK int = 0 OUTPUT

AS

DECLARE
@materiaProfOLD varchar(MAX),
@oggi date,


--variabili per la gestione delle materie--
@String varchar(210),
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

@idMateria int,
@idAnno varchar(5),
@idFreq varchar(5),
@idFreqOLD varchar(5),

@valore varchar(MAX),
@idMateriaCheck varchar(30),
@maxOLD int,
@maxNEW int,
@nr int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE()

	IF @idProfessore = 0
		BEGIN
			IF NOT EXISTS (SELECT idProfessore FROM pf_anagrafeProfessori WHERE nomeProf = @nomeProf AND idRS = @idRS)
				BEGIN
					INSERT INTO pf_anagrafeProfessori (idRS,  nomeProf,  emailProf,  tel1Prof,  tel2Prof,  indirizzoProf,  comuneProf,  provProf,  capProf, sediProf,  notaProf, codiceFiscaleProf, dataNascitaProf, luogoNascitaProf,  privacyProf, idTipoProf,  liberaProf, materiaProf)
											   VALUES (@idRS, @nomeProf, @emailProf, @tel1Prof, @tel2Prof, @indirizzoProf, @comuneProf, @provProf, @capProf, @sediProf, @notaProf, @codiceFiscaleProf, @dataNascitaProf, @luogoNascitaProf,  @privacyProf, @idTipoProf, @liberaProf, @materiaProf)
					SET @OK = 1
				END
	
			ELSE
				BEGIN
					SET @OK = 2
				END
		END
	
	ELSE
		BEGIN
			SET @materiaProfOLD = (SELECT materiaProf FROM pf_anagrafeProfessori WHERE idProfessore = @idProfessore AND idRS = @idRS)

			UPDATE pf_anagrafeProfessori
				SET nomeProf = @nomeProf,
					emailProf = @emailProf,
					tel1Prof =@tel1Prof,
					tel2Prof = @tel2Prof,
					indirizzoProf = @indirizzoProf,
					comuneProf = @comuneProf,
					provProf = @provProf,
					capProf = @capProf,
					sediProf = @sediProf,
					codiceFiscaleProf = @codiceFiscaleProf,
					dataNascitaProf = @dataNascitaProf,
					luogoNascitaProf = @luogoNascitaProf,
					notaProf = @notaProf,
					dataUpdate = GETDATE(),
					deleted = @deletedProf,
					privacyProf = @privacyProf,
					liberaProf = @liberaProf,
					firmaProf = @firmaProf,
					firmaDataProf = @firmaDataProf,
					materiaProf = @materiaProf,
					idTipoSocioProf = @idTipoSocioProf,
					idTipoProf = @idTipoProf
				WHERE idProfessore = @idProfessore AND idRS = @idRS

				IF @deletedProf = 1
					BEGIN
						-- riprogrammo le lezioni già prenotate
						UPDATE pf_pianoOfferteVista 
							SET idStatusOfferta = 11, idProfessore = 0
						WHERE idProfessore = @idProfessore AND idStatusOfferta = 2 AND dataOfferta >= @oggi AND idRS = @idRS
						
						-- elimino le lezioni dal piano delle lezioni 
						--DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore

						--elimino le lezioni dal piano delle offerte se NON sono state già impegnate o erogate
						--DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idStatusOfferta <> 3 AND dataOfferta >= @oggi
						

					END
				ELSE
					BEGIN
						-- nel caso di riattivazione di un docente rendo inevase le lezioni disponibili già passate
						UPDATE pf_pianoOfferteVista 
							SET idStatusOfferta = 12
							WHERE idProfessore = @idProfessore AND idStatusOfferta = 1 AND dataOfferta < @oggi AND idRS = @idRS

						-- riattivo le lezioni nascoste per accoppiamento orario
						--UPDATE pf_pianoOfferte 
						--	SET attivo = 1
						--	WHERE idProfessore = @idProfessore AND idStatusOfferta = 1 AND attivo = 0 --dataOfferta < @oggi

					END

				IF @deletedProf = 0 AND @materiaProf <> @materiaProfOLD
					BEGIN
						--IF LEN(@materiaProf) > 0
						--BEGIN
							CREATE TABLE #splitMaterieOLD (nr int , valore varchar(50))
							CREATE TABLE #splitMaterieNEW (nr int , valore varchar(50))

							INSERT INTO #splitMaterieOLD SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProfOLD, '@')
							INSERT INTO #splitMaterieNEW SELECT row_number() OVER(ORDER BY value ASC) AS nr, value AS valore FROM string_split( @materiaProf, '@')
							
							SET @nr = 1
							SET @maxOLD = (SELECT MAX(nr) FROM #splitMaterieOLD)
							WHILE @nr <= @maxOLD
								BEGIN
									SET @valore = (SELECT valore FROM #splitMaterieOLD WHERE nr = @nr)
									SET @idMateriaCheck = (SELECT value FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))
									SET @idMateria = (SELECT TRIM(SUBSTRING(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idMateria%'))
									SET @idFreqOLD = (SELECT TRIM(SUBSTRING(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idFreq%'))
									
									IF NOT EXISTS (SELECT valore FROM #splitMaterieNEW WHERE valore LIKE ('%' + @idMateriaCheck + ';' + '%'))
										BEGIN											
											DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore AND idMateria = @idMateria
											DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi
										END
									ELSE
										BEGIN
											SET @valore = (SELECT valore FROM #splitMaterieNEW WHERE nr = @nr)
											SET @idAnno = (SELECT TRIM(SUBSTRING(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idAnno%'))
											SET @idFreq = (SELECT TRIM(SUBSTRING(value, charindex('#', value) + 1, 5)) FROM string_split(@valore, ';') WHERE value LIKE ('%idFreq%'))
											UPDATE pf_pianoLezioni SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria
											UPDATE pf_pianoOfferte SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi										
										END
									SET @nr = @nr + 1
								END

							DROP TABLE #splitMaterieOLD
							DROP TABLE #splitMaterieNEW
						--END

						--BEGIN
							--SET @String = @materiaProf
							--SET @String = @String + @separaR
							--SET @TOT = (CASE WHEN LEN(@String) > 1 THEN (SELECT LEN(@String) - LEN(REPLACE(@String, @separaR, ''))) ELSE 0 END)
							--SET @N = 1
							--WHILE @N <= @TOT
							--	BEGIN
							--		SET @fine = CHARINDEX(@separaR, @String)
							--		SET @record = SUBSTRING(@String, 0, @fine) + @separaF
							--		SET @totF = (CASE WHEN LEN(@record) > 1 THEN (SELECT LEN(@record) - LEN(REPLACE(@record, @separaF, ''))) ELSE 0 END)
							--		SET @F = 1
							--		WHILE @F <= @totF
							--			BEGIN
							--				SET @fineF = CHARINDEX(@separaF, @record)
							--				SET @campo = SUBSTRING(@record, 0, @fineF)

							--				IF @F = 1 SET @idMateria = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
							--				IF @F = 2 SET @idAnno = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
							--				IF @F = 3 SET @idFreq = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))

							--				SET @record = RTRIM(SUBSTRING(@record, @fineF + 1, LEN(@record)))
							--				SET @F = @F + 1
							--			END

							--		UPDATE pf_pianoLezioni SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria
							--		UPDATE pf_pianoOfferte SET anni = @idAnno, frequenza = @idFreq WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi

							--		SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
							--		SET @N = @N + 1

							--	END
							--END

						--ELSE IF LEN(@materiaProf) = 0
						--BEGIN
						--	SET @String = @materiaProfOLD
						--	SET @String = @String + @separaR
						--	SET @TOT = (CASE WHEN LEN(@String) > 1 THEN (SELECT LEN(@String) - LEN(REPLACE(@String, @separaR, ''))) ELSE 0 END)
						--	SET @N = 1
						--	WHILE @N <= @TOT
						--		BEGIN
						--			SET @fine = CHARINDEX(@separaR, @String)
						--			SET @record = SUBSTRING(@String, 0, @fine) + @separaF
						--			SET @totF = (CASE WHEN LEN(@record) > 1 THEN (SELECT LEN(@record) - LEN(REPLACE(@record, @separaF, ''))) ELSE 0 END)
						--			SET @F = 1
						--			WHILE @F <= @totF
						--				BEGIN
						--					SET @fineF = CHARINDEX(@separaF, @record)
						--					SET @campo = SUBSTRING(@record, 0, @fineF)

						--					IF @F = 1 SET @idMateria = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
						--					IF @F = 2 SET @idAnno = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))
						--					IF @F = 3 SET @idFreq = SUBSTRING(@campo, CHARINDEX(@separaV, @campo) + 1, LEN(RTRIM(@campo)))

						--					SET @record = RTRIM(SUBSTRING(@record, @fineF + 1, LEN(@record)))
						--					SET @F = @F + 1
						--				END

						--			DELETE FROM pf_pianoLezioni WHERE idProfessore = @idProfessore AND idMateria = @idMateria
						--			DELETE FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta >= @oggi

						--			SET @String = RTRIM(SUBSTRING(@String, @fine + 1, LEN(@String)))
						--			SET @N = @N + 1

						--		END
						--	END
					END

			SET @OK = 3

		END

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeProfessoriUpdateLezioni]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/02/2019>
-- Description:	<Aggiorna Lezioni prenotate Professore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeProfessoriUpdateLezioni]

@idProfessore int

AS

DECLARE
@prenotata varchar(100) = '',
@i int = 1,
@tot int,
@idProf int,
@idProfOLD int = 0,
@idMat int,
@numLez int,
@separa varchar(1) = ''

BEGIN
	--CREATE TABLE #lezioniPrenotate (idProf int, prenotate varchar(200))

	SELECT @tot = COUNT(*) FROM
		(SELECT idProfessore, idMateria 
			FROM pf_pianoOfferte 
			WHERE idStatusOfferta = 2 AND idProfessore = @idProfessore GROUP BY idProfessore, idMateria ) lezioniTotali

	WHILE @i <= @tot
		BEGIN
			SELECT @idProf=idProfessore, @idMat=idMateria, @numLez = Prenotate FROM
				(SELECT ROW_NUMBER() OVER (ORDER BY idProfessore ASC) AS ID, idProfessore, idMateria, COUNT(*) AS Prenotate 
					FROM pf_pianoOfferte 
					WHERE idStatusOfferta = 2 AND idProfessore = @idProfessore GROUP BY idProfessore, idMateria ) lezioniElenco
			WHERE ID = @i
			
			IF @idProf <> @idProfOLD
				BEGIN
					IF @idProfOLD > 0
						BEGIN
							UPDATE pf_anagrafeProfessori SET lezioniPrenotate = @prenotata WHERE idProfessore = @idProfOLD
							--INSERT INTO #lezioniPrenotate (idProf, prenotate) VALUES (@idProfOLD, @prenotata)
						END
					SET @prenotata =''
					SET @separa =''
				END
				
			SET @prenotata = @prenotata + @separa + 'idMateria#' + CONVERT(varchar(3), @idMat) + ';numLez#' + CONVERT(varchar(3), @numLez)
			--PRINT @prenotata		
			SET @i = @i + 1
			SET @separa = '@'
			SET @idProfOLD = @idProf

		END

		UPDATE pf_anagrafeProfessori SET lezioniPrenotate = @prenotata WHERE idProfessore = @idProfessore
		--INSERT INTO #lezioniPrenotate (idProf, prenotate) VALUES (@idProf, @prenotata)


	--SELECT * FROM #lezioniPrenotate

	--DROP TABLE #lezioniPrenotate
END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeSociRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.SQL>
-- Create date: <23/05/2019>
-- Description:	<Legge ElencoSoci>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeSociRead]

@idRS int,
@id int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)


AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @id = 0 
		BEGIN
			SELECT ROW_NUMBER() OVER (ORDER BY idTipo DESC) AS ID, * FROM pf_anagrafeSociVista WHERE idRS = @idRS ORDER BY idTipo DESC, nominativo ASC
		END
	ELSE

		BEGIN
			SELECT * FROM pf_anagrafeSociVista WHERE idTipo = @id AND idRS = @idRS
		END
END

GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeStudentiAuguri]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <02/11/2018>
-- Description:	<Compleanno Studenti in data OGGI>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeStudentiAuguri]

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT idRS, nomeStud, emailStud, CONVERT(VARCHAR(10), dataNascitaStud, 105) AS dataNascita, YEAR(getdate()) - YEAR(dataNascitaStud) AS Età 
	FROM pf_anagrafeStudenti 
	WHERE MONTH(dataNascitaStud) = MONTH(GETDATE()) AND DAY(dataNascitaStud) = DAY(GETDATE())

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeStudentiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Read Anagrafe Studenti>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeStudentiRead]

@idRS int,
@idStudente int,
@idSede varchar(10),
@drop int,
@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE 
--@sediTot int,
--@all bit,

@cerca int,
@numSedi int,
@terzo varchar(10)

SET @numSedi = LEN(@idSede)
SET @terzo = REPLICATE('X', @numSedi)
--SET @sediTot = (SELECT COUNT(*) FROM pf_parSedi WHERE idRS = @idRS AND deleted = 0)
--SET @all = CASE WHEN LEN(@idSede) = @sediTot THEN 1 ELSE 0 END
SET @cerca = CASE WHEN @drop = 0 THEN 0 ELSE -1 END

BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idStudente = 0
		BEGIN
		IF @drop <= 0 -- parametro per elenco generale
			BEGIN
				SELECT *, deleted AS deletedStud FROM pf_anagrafeStudentiVista WHERE idStudente > @cerca AND CHARINDEX('X', TRANSLATE(sediStud, @idSede, @terzo), 1) > 0 AND idRS = @idRS ORDER BY deleted, nomeStud --
				
			END

		ELSE IF @drop = 1 -- parametro per popolare dropDown elenco professori con materie assegnate nella sezione Lezioni
			BEGIN
				SELECT * FROM pf_anagrafeStudentiVista WHERE idStudente > @cerca  AND deleted = 0 AND CHARINDEX('X', TRANSLATE(sediStud, @idSede, @terzo), 1) > 0 AND idRS = @idRS ORDER BY nomeStud
			END

		ELSE IF @drop = 2  --parametro utilizzato nell'App Mobile per popolare le tendine della ricerca (solo utente di Segreteria)
			BEGIN
				SELECT * FROM pf_anagrafeStudentiVista WHERE idStudente > @cerca  AND deleted = 0 AND (idRS = @idRS OR idRS = 0) ORDER BY nomeStud --AND sediStud LIKE ('%' + @idSede + '%')
			END
		END

	ELSE
		BEGIN
			SELECT *, deleted AS deletedStud FROM pf_anagrafeStudentiVista WHERE idStudente = @idStudente AND idRS = @idRS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_anagrafeStudentiUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Anagrafe Studenti>
-- =============================================

CREATE PROCEDURE [dbo].[pf_anagrafeStudentiUpdate]

@idRS int,
@idStudente int,
@nomeStud varchar(200),
@idIstituto varchar(10),
@anno varchar(1),
@dataNascitaStud date,
@luogoNascitaStud varchar(200),
@idOrigineStud int,
@codiceFiscaleStud varchar(16),
@codiceFiscaleGen varchar(16),
@emailStud varchar(200),
@emailCheck bit, 
@tel1Stud varchar(20), 
@tel2Stud varchar(20),
@indirizzoStud varchar(200), 
@comuneStud varchar(100),
@provStud varchar(2),
@capStud varchar(5),
@notaStud varchar (255),
@idSpecial int,
@sediStud varchar(40),
@delete bit,
@deletedStud bit,
@privacyStud bit,
@regolamentoStud bit,
@liberaStud bit,
@firmaStud bit,
@firmaDataStud date,

@istitutoTipo varchar(1),
@istitutoNome varchar(1),
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@oggi date

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE();

	IF @idStudente = 0 OR @idStudente IS NULL
		BEGIN
			IF NOT EXISTS (SELECT @idStudente FROM pf_anagrafeStudenti WHERE nomeStud = @nomeStud AND idRS = @idRS)
				BEGIN
					INSERT INTO pf_anagrafeStudenti
								(idRS,  nomeStud,  emailStud,  tel1Stud,  tel2Stud,  indirizzoStud,  comuneStud,  provStud,  capStud,  notaStud,  idIstituto,  sediStud,  anno,  codiceFiscaleStud,  codiceFiscaleGen,  dataNascitaStud,  luogoNascitaStud, idOrigineStud, privacyStud,  liberaStud, regolamentoStud)
		          		 VALUES (@idRS, @nomeStud, @emailStud, @tel1Stud, @tel2Stud, @indirizzoStud, @comuneStud, @provStud, @capStud, @notaStud, @idIstituto, @sediStud, @anno, @codiceFiscaleStud, @codiceFiscaleGen, @dataNascitaStud, @luogoNascitaStud, @idOrigineStud, @privacyStud, @liberaStud, @regolamentoStud)
					SET @OK = 1
				END
	
			ELSE
				BEGIN
					SET @OK = 2
				END
		END
	
	ELSE
		BEGIN
			UPDATE pf_anagrafeStudenti
				SET nomeStud = @nomeStud,
					emailStud = @emailStud,
					emailCheck = @emailCheck,
					tel1Stud =@tel1Stud,
					tel2Stud = @tel2Stud,
					indirizzoStud = @indirizzoStud,
					comuneStud = @comuneStud,
					provStud = @provStud,
					capStud = @capStud,
					notaStud = @notaStud,
					idSpecial = @idSpecial,
					idIstituto = @idIstituto,
					anno = @anno,
					codiceFiscaleStud = @codiceFiscaleStud,	
					codiceFiscaleGen = @codiceFiscaleGen,
					dataNascitaStud = @dataNascitaStud,
					luogoNascitaStud = @luogoNascitaStud,
					idOrigineStud = @idOrigineStud,
					sediStud = @sediStud,
					dataUpdate = GETDATE(),
					deleted = @deletedStud,
					privacyStud = @privacyStud,
					liberaStud = @liberaStud,
					regolamentoStud = @regolamentoStud,
					firmaStud = @firmaStud,
					firmaDataStud = @firmaDataStud
				WHERE idStudente = @idStudente AND idRS = @idRS

				IF @deletedStud = 1
					BEGIN
						UPDATE pf_pianoOfferteVista
							SET idStatusOfferta = 1, idStudente = 0
							WHERE idStudente = @idStudente AND dataOfferta >= @oggi AND (idStatusOfferta = 2 OR idStatusOfferta = 11) AND idRS = @idRS

						--DELETE FROM pf_pianoOfferte WHERE idStudente = @idStudente AND idStatusOfferta <> 11 AND idStatusOfferta <> 3 AND dataOfferta >= GETDATE()

						SET @OK = 3
					END

				ELSE
					BEGIN						
						SET @OK = 3
					END
		END

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parAssociazioniRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <13/05/2020>
-- Description:	<Legge Elenco Associazioni>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parAssociazioniRead]

@idRS int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idRS = 0
		BEGIN
			SELECT *, CONVERT(varchar(10), registroData, 105) AS registroDataGMA FROM pf_parAssociazioni ORDER BY idRS
		END	
	ELSE
		BEGIN
			SELECT *, CONVERT(varchar(10), registroData, 105) AS registroDataGMA FROM pf_parAssociazioni WHERE idRS = @idRS
		END
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parAssociazioniUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <12/05/2020>
-- Description:	<Aggiorna Sede Legale>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parAssociazioniUpdate] 

@idRS int,
@ragioneSociale varchar(200), 
@sedeLegaleIndirizzo varchar(300), 
@sedeLegaleLuogo varchar(300),
@sedeLegaleCAP varchar(5),
@sedeLegalePR varchar(2),
@sedeLegaleTEL1 varchar(20),
@sedeLegaleTEL2 varchar(20),
@sedeLegaleEmail varchar(300),
@sedeLegalePEC varchar(300),
@sedeLegaleCF varchar(20),
@registroNR varchar(10),
@registroDataGMA date,
@deletedAss bit,
@adminUser varchar(200),
@adminPass varchar(200),

@imgPath varchar(1),
@spUpdate varchar(1),
--@delete bit,
@OK int = 0 OUTPUT


AS

DECLARE
@oggi date = GETDATE(),
@adminID int

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idRS= 0
		BEGIN
			IF NOT EXISTS (SELECT idRS FROM pf_parAssociazioni WHERE sedeLegaleEmail=@sedeLegaleEmail OR sedeLegaleCF = @sedeLegaleCF)
				BEGIN
					INSERT INTO pf_parAssociazioni ( ragioneSociale,  sedeLegaleIndirizzo,  sedeLegaleLuogo,  sedeLegaleCAP,  sedeLegalePR,  sedeLegaleTEL1,  sedeLegaleTEL2,  sedeLegaleEmail,  sedeLegalePEC,  sedeLegaleCF,  registroNR,  registroData)
									        VALUES ( @ragioneSociale, @sedeLegaleIndirizzo, @sedeLegaleLuogo, @sedeLegaleCAP, @sedeLegalePR, @sedeLegaleTEL1, @sedeLegaleTEL2, @sedeLegaleEmail, @sedeLegalePEC, @sedeLegaleCF, @registroNR, @registroDataGMA)		

					SET @idRS = (SELECT idRS FROM pf_parAssociazioni WHERE ragioneSociale=@ragioneSociale)

					EXEC admUtentiUpdate @idRS, 0, 'AMMINISTRATORE', 'SISTEMA', @sedeLegaleEmail, @adminUser, @adminPass, @oggi, ' ', ' ', ' ' ,' ', ' ', ' ',' ',' ', 1, 1, 0, 0, 0, 0, '2000-01-01', '0', 0, 0, ' ', 0

					SET @adminID = (SELECT id FROM admUtenti WHERE emailUser = @sedeLegaleEmail)
					UPDATE admUtenti SET attivo = 1, idRuolo = 1 WHERE id = @adminID

					SET @OK = 1
				END
		END
	ELSE
		BEGIN
			UPDATE pf_parAssociazioni
				SET ragioneSociale = @ragioneSociale,
					sedeLegaleIndirizzo = @sedeLegaleIndirizzo,
					sedeLegaleLuogo = @sedeLegaleLuogo,
					sedeLegaleCAP = @sedeLegaleCAP,
					sedeLegalePR = @sedeLegalePR,
					sedeLegaleTEL1 = @sedeLegaleTEL1,
					sedeLegaleTEL2 = @sedeLegaleTEL2,
					sedeLegaleEmail = @sedeLegaleEmail,
					sedeLegalePEC = @sedeLegalePEC,
					sedeLegaleCF = @sedeLegaleCF,
					registroNR = @registroNR,
					registroData = @registroDataGMA,
					deletedAss = @deletedAss
				WHERE idRS = @idRS

			SET @OK = 3
		END

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parCalendarioCreate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <14/05/2019>
-- Description:	<Genera i giorni di calendario per l'anno scolastico in corso>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parCalendarioCreate] 

@idRS int,
@idSede varchar(1), 
@dataInizio date, 
@dataFine date,

@delete int,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE 
@giorno date,
@attivo int


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @giorno = @dataInizio

	WHILE @giorno <= @dataFine
		BEGIN
			IF DATEPART(WEEKDAY, @giorno) <= 5
				BEGIN
					SET @attivo = CASE WHEN NOT EXISTS (SELECT dataFestivo FROM pf_parFestivi WHERE dataFestivo = @giorno) THEN 1 ELSE -1 END
					IF NOT EXISTS (SELECT giorno FROM pf_parCalendario WHERE giorno = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS)
						BEGIN
							INSERT INTO pf_parCalendario (idSede, giorno, attivo) VALUES (@idSede, @giorno, @attivo)										
						END
					ELSE
						BEGIN
							UPDATE pf_parCalendario SET giorno = @giorno, attivo = @attivo WHERE giorno = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS
						END

					EXEC pf_pianoOfferteCreate @idRS, @idSede, @giorno, @giorno, 0, 0, '0'
				END

			SET @giorno = DATEADD(DAY, 1, @giorno)
		END

	SET @OK = 1

	RETURN @OK
	
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parCalendarioRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.jSQL>
-- Create date: <15/05/2019>
-- Description:	<Legge i giorni di calendario per l'anno scolastico in corso>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parCalendarioRead] 

@idRS int,
@idSede varchar(1), 
@giorno date,
@idMese int,

@idGiorno int,
@spRead varchar(1),
@tabella varchar(1),
@drop int

AS

DECLARE
@oggi date



BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE()

	IF @drop = 0
		BEGIN
			SELECT * FROM pf_parCalendarioVistaPivot WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idMese = @idMese ORDER BY idSede, anno, idMese, settimana
		END

	ELSE IF @drop = 1
		BEGIN
			SELECT idSede, CONVERT(VARCHAR(10), giorno, 105) AS giornoGMA, nomeGiorno, giornoSettimana FROM pf_parCalendarioVista WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND giorno >= @giorno AND impegno = 1 AND attivo = 1 ORDER BY idSede, giorno
		END		

	ELSE IF @drop = 2
		BEGIN
			SELECT idSede, CONVERT(VARCHAR(10), giorno, 105) AS giornoGMA, nomeGiorno, giornoSettimana FROM pf_parCalendarioVista WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND giorno >= @oggi AND impegno = 1 AND attivo = 1 ORDER BY idSede, giorno
		END			
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parCalendarioUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================================
-- Author:		<Valerio.JSQL>
-- Create date: <15/05/2019>
-- Description:	<Aggiorna i giorni di calendario per l'anno scolastico in corso>
-- ==============================================================================

CREATE PROCEDURE [dbo].[pf_parCalendarioUpdate] 

@idRS int,
@idSede varchar(1), 
@giorno date,
@attivo int,

@delete int,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@oggi date,
@offerteErogate int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @oggi = GETDATE();
	SET @offerteErogate = (SELECT COUNT(*) FROM pf_pianoOfferte WHERE idStatusOfferta = 3 AND dataOfferta = @giorno)

	IF NOT EXISTS (SELECT * FROM pf_parFestivi WHERE dataFestivo = @giorno) AND @giorno >= @oggi AND @offerteErogate = 0
		BEGIN		
			UPDATE pf_parCalendario SET attivo = @attivo WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND giorno = @giorno

			IF @attivo = -1 
				BEGIN
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0 WHERE idStatusOfferta = 2 AND dataOfferta = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS
					UPDATE pf_pianoOfferte SET attivo = 0 WHERE idStatusOfferta = 1 AND dataOfferta = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS
				END
			ELSE
				BEGIN
					UPDATE pf_pianoOfferte SET attivo = 1 WHERE idStatusOfferta = 1 AND dataOfferta = @giorno AND idSede = @idSede COLLATE Latin1_General_CS_AS
					EXEC pf_pianoOfferteCreate @idRS, @idSede, @giorno, @giorno, 0, 0, '0'
				END
		END
	
	SET @OK = 1
	
	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parFestiviUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET,>
-- Create date: <08/10/2018>
-- Description:	<Genera i giorni festivi per l'anno scolastico in corso>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parFestiviUpdate] (@dataInizio AS date)

AS

DECLARE @anno AS int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @anno = YEAR(@dataInizio)

	UPDATE pf_parFestivi SET aa = @anno + inizio,
							 dataFestivo = CONVERT(date, CONVERT(VARCHAR(8),(@anno + inizio)*10000 + mm*100 + gg)),
							 giornoSettimanaFestivo = DATEPART(weekday, CONVERT(date, CONVERT(VARCHAR(8),(@anno + inizio)*10000 + mm*100 + gg))),
							 ponteFestivo = CASE DATEPART(weekday, CONVERT(date, CONVERT(VARCHAR(8),(@anno + inizio)*10000 + mm*100 + gg)))
												 WHEN 4 THEN 1 
												 WHEN 2 THEN -1 
												 ELSE 0 
											END
						 WHERE la = 0

	UPDATE pf_parFestivi SET gg = DATEPART(DAY, DATEADD(DAY, 1, dbo.dataPasqua(@anno + inizio))),
							 mm = DATEPART(MONTH, DATEADD(DAY, 1, dbo.dataPasqua(@anno + inizio))),
							 aa = @anno + inizio,
							 dataFestivo = DATEADD(DAY, 1, dbo.dataPasqua(@anno + inizio)),
							 giornoSettimanaFestivo = DATEPART(weekday, DATEADD(DAY, 1, dbo.dataPasqua(@anno + inizio))),
							 ponteFestivo = CASE DATEPART(weekday, DATEADD(DAY, 1, dbo.dataPasqua(@anno + inizio)))
												 WHEN 4 THEN 1 
												 WHEN 2 THEN -1 
												 ELSE 0
											END
						 WHERE la = 1

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parGiorniRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <07/02/2018>
-- Description:	<Legge Tabella Ore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parGiorniRead]

@idGiorno int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idGiorno = 0
		BEGIN
			SELECT idGiorno, giorno FROM pf_parGiorni ORDER BY idGiorno
		END
	
	ELSE
		BEGIN
			SELECT idGiorno, giorno AS ora FROM pf_parGiorni WHERE idGiorno = @idGiorno
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieGruppoRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2018>
-- Description:	<Legge Gruppi Materie>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parMaterieGruppoRead]

@idGruppo int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idGruppo = 0
		BEGIN
			SELECT * FROM pf_parMaterieGruppo ORDER BY idGruppo
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_parMaterieGruppo WHERE idGruppo = @idGruppo
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <27/01/2018>
-- Description:	<Legge Piano Materie>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parMaterieRead]

@idMateria int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			SELECT * FROM pf_parMaterieVista ORDER BY idGruppo, materia
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_parMaterieVista WHERE idMateria = @idMateria
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parMaterieUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2018>
-- Description:	<Aggiorna Materie>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parMaterieUpdate] 

@idMateria int, 
@materia varchar(50), 
@idGruppo int, 
@gruppo varchar(20), 

@spUpdate varchar(2),
@delete bit,
@OK int = 0 OUTPUT


AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			INSERT INTO pf_parMaterie (materia, idGruppo)
							   VALUES (@materia, @idGruppo)
			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE pf_parMaterie 
				SET materia = @Materia,
					idGruppo = @idGruppo,
					deleted = @delete
				WHERE idMateria = @idMateria

			SET @OK = 3
		END

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parMesiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <19/07/2019>
-- Description:	<Elenco mesi>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parMesiRead]

@idMese int,
@idSede varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)


AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT idMese, anno, mese FROM pf_parCalendarioVistaPivot WHERE idSede = @idSede COLLATE Latin1_General_CS_AS GROUP BY anno, idMese, mese ORDER BY anno, idMese

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOrariCreate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <27/02/2020>
-- Description:	<CREA Orari>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOrariCreate]

--@idOrario int,
@idSede varchar(1), 

@delete bit,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@totOre int = 5,
@runOre int = 1,
@idGiorno int = 1


BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	--SET @totOre = (SELECT COUNT(idOra) FROM pf_parOre WHERE idSede = @idSede)

	WHILE @runOre <= @totOre
		BEGIN
			WHILE @idGiorno <= 5
				BEGIN
					IF NOT EXISTS (SELECT idOra FROM pf_parOrari WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idOra = @runOre AND idGiorno = @idGiorno)
						BEGIN
							INSERT INTO pf_parOrari (idSede, idOra, idGiorno, impegno)
											VALUES (@idSede, @runOre, @idGiorno, 1)
						END
					SET @idGiorno = @idGiorno + 1
				
				END				
			SET @runOre = @runOre + 1
			SET @idGiorno = 1

		END

	SET @OK = 1

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOrariPivotRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2018>
-- Description:	<Legge Piano Orario>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOrariPivotRead]

@idOrario int,
@idSede varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idOrario = 0
		BEGIN
			SELECT * FROM pf_parOrariVistaPivot WHERE idSede = @idSede COLLATE Latin1_General_CS_AS ORDER BY idGiorno
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_parOrariVista WHERE idOrario = @idOrario AND idSede = @idSede COLLATE Latin1_General_CS_AS
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOrariRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <28/01/2018>
-- Description:	<Legge Piano Orario>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOrariRead]

@idOrario int,
@idSede varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idOrario = 0
		BEGIN
			--SELECT idOrario, idGiorno, giorno, idOra, CONVERT(varchar(8), ora) AS ora, orario FROM pf_parOrariVista ORDER BY idGiorno, idOra
			SELECT idOrario, ora AS orario, idGiorno, giorno, idOra, CONVERT(varchar, ora) AS ora 
			FROM pf_parOrariVista 
			WHERE CONVERT(varchar(8), ora) <> '00:00:00'  AND idSede = @idSede COLLATE Latin1_General_CS_AS --impegno = 1
			ORDER BY idGiorno
		END
	
	ELSE
		BEGIN
			SELECT * 
			FROM pf_parOrariVista 
			WHERE idOrario = @idOrario AND idSede = @idSede COLLATE Latin1_General_CS_AS 
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOrariUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <07/02/2018>
-- Description:	<Aggiorna Orari>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOrariUpdate]

--@idOrario int,
@idSede varchar(1), 
@idGiorno int, 
@idOra int,
@value int,

@delete bit,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

AS

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
		UPDATE pf_parOrari SET impegno = @value WHERE idGiorno = @idGiorno AND idOra = @idOra AND idSede = @idSede COLLATE Latin1_General_CS_AS;

	SET @OK = 1

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOreCreate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <11/05/2020>
-- Description:	<Crea tabella Ore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOreCreate]

--@idOrario int,
@idRS int,
@idSede varchar(1), 

@delete bit,
@spCreate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@totOre int = 5,
@idOra int = 1

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	WHILE @idOra <= @totOre
		BEGIN

			IF NOT EXISTS (SELECT idOra FROM pf_parOre WHERE idRS = @idRS AND idSede = @idSede COLLATE Latin1_General_CS_AS AND idOra = @idOra)
				BEGIN
					INSERT INTO pf_parOre  (idRS,  idSede,  idOra,  ora)
									VALUES (@idRS, @idSede, @idOra, '00:00:00')
				END			
			SET @idOra = @idOra + 1

		END

	SET @OK = 1

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOreRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <07/02/2018>
-- Description:	<Legge Tabella Ore>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOreRead]

@idRS int,
@idSede varchar(1),
@idOra int,


@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @idSede = '0'
		BEGIN
			SELECT idSede, idOra, CONVERT(varchar(8), ora) AS ora, Lezioni, oraAttiva FROM pf_parOreVista WHERE idRS = @idRS  ORDER BY idSede, idOra
		END

	ELSE
		BEGIN
			IF @idOra = 0
				BEGIN
					SELECT idSede, idOra, CONVERT(varchar(8), ora) AS ora, Lezioni, oraAttiva FROM pf_parOreVista WHERE idSede = @idSede COLLATE Latin1_General_CS_AS ORDER BY idOra
				END
	
			ELSE
				BEGIN
					SELECT idSede, idOra, CONVERT(varchar(8), ora) AS ora, Lezioni, oraAttiva FROM pf_parOreVista WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idOra = @idOra
				END

		END
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parOreUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <28/02/2020>
-- Description:	<Aggiorna Piano Orario>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parOreUpdate]

@idSede varchar(1),
@idOra int,
@ora varchar(10),
@Lezioni int,
@oraAttiva bit,

@delete bit,
@spUpdate varchar(1),

@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS

DECLARE
@oraTime time


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @ora = REPLACE(@ora, '-', '')
	SET @ora = IIF(LEN(@ora) = 4, @ora + '00', @ora)
	--PRINT TIMEFROMPARTS(LEFT(@ora,2), SUBSTRING(@ora,3,2), RIGHT(@ora,2), 0, 0) 
	SET @oraTime = IIF(@oraAttiva = 1, TIMEFROMPARTS(LEFT(@ora,2), SUBSTRING(@ora,3,2), ISNULL(RIGHT(@ora,2), '00'), 0, 0), '00:00:00')

	--IF @delete = 1 
	--	BEGIN
	--		DELETE FROM pf_parOre WHERE idOra = @idOra AND idSede = @idSede
	--		DELETE FROM pf_parOrari WHERE idOra = @idOra AND idSede = @idSede
	--		SET @OK = 3

	--		RETURN @OK
	--	END

	--IF NOT EXISTS (SELECT idOra FROM pf_parOre WHERE idOra = @idOra AND idSede = @idSede)
	--	BEGIN
	--		SET @idOra = ISNULL((SELECT MAX(idOra) FROM pf_parOre WHERE idSede = @idSede), 0) + 1
	--		INSERT INTO pf_parOre  (idSede,  idOra,  ora) VALUES (@idSede, @idOra, @oraTime)

	--		EXEC pf_parOrariCreate @idSede, 0, '', 0
	--		SET @OK = 1
	--	END
	--ELSE
	--	BEGIN
			UPDATE pf_parOre SET ora = @oraTime WHERE idOra = @idOra AND idSede = @idSede COLLATE Latin1_General_CS_AS
			SET @OK = 3
		--END

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parSediRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <03/02/2019>
-- Description:	<Legge Elenco Sedi>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parSediRead]

@idRS int,
@idSede varchar(1),
@drop int,

@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idSede = '0'
		BEGIN
			IF @drop <= 0 -- parametro per elenco generale
				BEGIN
					SELECT * FROM pf_parSedi WHERE idRS = @idRS ORDER BY idSede
				END
			ELSE IF @drop = 1 -- parametro per elenco sedi in anagrafe professori e studenti
				BEGIN
					SELECT * FROM pf_parSedi WHERE deleted = 0 AND idRS = @idRS ORDER BY idSede
				END
			ELSE IF @drop = 3 -- parametro per popolare tendina in scheda Controlli
				BEGIN
					SELECT idRS, idSede, descrizioneSede FROM pf_parSedi WHERE deleted = 0 AND idRS = @idRS 
					UNION
					(
					SELECT @idRS AS idRS, '0' AS idSede, 'Sede' AS descrizioneSede --, 'indirizzo' AS indirizzoSede, 'luogo' AS luogoSede, 'cap' AS capSede, 'prov' AS provSede, '091' AS tel1Sede, '091' AS tel2Sede, 'email' AS emailSede, 'img' AS imgPath, 'file' AS imgFile, 0 AS deleted
					)
					ORDER BY idSede
				END
			ELSE IF @drop = 4 -- parametro per popolare tendina in form Cassa 
				BEGIN
					SELECT * FROM pf_parSediVista WHERE idRS = @idRS ORDER BY idSede
				END
		END
	
	ELSE
		BEGIN
			SELECT *, deleted AS deletedSede FROM pf_parSedi WHERE idSede = @idSede COLLATE Latin1_General_CS_AS 
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parSediUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <14/07/2020>
-- Description:	<Aggiorna Sedi>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parSediUpdate] 

@idRS int,
@idSede varchar(1), 
@descrizioneSede varchar(250), 
@indirizzoSede varchar(250), 
@luogoSede varchar(200),
@capSede varchar(5),
@provSede varchar(2),
@tel1Sede varchar(50),
@tel2Sede varchar(50),
@emailSede varchar(200),
--@imgPath varchar(200),
--@imgFile varchar(200),

@spUpdate varchar(2),
@delete bit,
@deletedSede bit,
@OK int = 0 OUTPUT


AS

DECLARE
@ultimo_idSede varchar(1),
@nuovo_idSede varchar(1)

BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idSede = 0
		BEGIN
			SET @ultimo_idSede = (SELECT MAX(idSede) FROM pf_parSedi)
			IF ASCII(@ultimo_idSede) > 48 AND ASCII(@ultimo_idSede) < 57
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END
			ELSE IF ASCII(@ultimo_idSede) = 57 
				BEGIN
					SET @nuovo_idSede = CHAR(65)
				END
			ELSE IF ASCII(@ultimo_idSede) >= 65 AND ASCII(@ultimo_idSede) < 90
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END
			ELSE IF ASCII(@ultimo_idSede) = 90
				BEGIN
					SET @nuovo_idSede = CHAR(97)
				END
			ELSE IF ASCII(@ultimo_idSede) >= 97 AND ASCII(@ultimo_idSede) < 122
				BEGIN
					SET @nuovo_idSede = CHAR(ASCII(@ultimo_idSede) + 1)
				END

			INSERT INTO pf_parSedi (idRS,  idSede,        descrizioneSede,  indirizzoSede,  luogoSede,  capSede,  provSede,  tel1Sede,  tel2Sede,  emailSede)
							VALUES (@idRS, @nuovo_idSede, @descrizioneSede, @indirizzoSede, @luogoSede, @capSede, @provSede, @tel1Sede, @tel2Sede, @emailSede)
			
			SET @idSede = (SELECT idSede FROM pf_parSedi WHERE descrizioneSede = @descrizioneSede AND idRS = @idRS)
			
			UPDATE pf_anagrafeStudenti   SET sediStud = sediStud + @idSede WHERE idStudente = 0
			UPDATE pf_anagrafeProfessori SET sediProf = sediProf + @idSede WHERE idProfessore = 0

			EXEC pf_parOrariCreate @idSede, 0, '', 0
			EXEC pf_parOreCreate @idRS, @idSede, 0, ''

			SET @OK = 1
		END
	ELSE
		BEGIN
			UPDATE pf_parSedi
				SET descrizioneSede = @descrizioneSede,
					indirizzoSede = @indirizzoSede,
					luogoSede = @luogoSede,
					capSede = @capSede,
					provSede = @provSede,
					tel1Sede = @tel1Sede,
					tel2Sede = @tel2Sede,
					emailSede = @emailSede,
					--imgPath = @imgPath,
					--imgFile = @imgFile,
					deleted = @deletedSede
				WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idRS = @idRS

			SET @OK = 3
		END

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_parSpecialRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <02/07/2020>
-- Description:	<Legge Tabella Special>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parSpecialRead]

@idSpecial int,

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idSpecial = 0
		BEGIN
			SELECT * FROM pf_parSpecial
		END
	
	ELSE
		BEGIN
			SELECT * FROM pf_parSpecial WHERE idSpecial = @idSpecial
		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_parStatusOfferteRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <11/02/2018>
-- Description:	<Legge Parametri Status Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_parStatusOfferteRead]

@idStatusOfferta int, 

@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS

DECLARE
@insertZero int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @insertZero = (SELECT insertZero FROM pf_parStatusOfferte WHERE idStatusOfferta = @idStatusOfferta)

	SET @insertZero = CASE @insertZero WHEN 1 THEN 0 ELSE 99 END 

	IF @idStatusOfferta = 0
		BEGIN
			SELECT * FROM pf_parStatusOfferte WHERE idStatusOfferta > 0 AND idStatusOfferta <> 10
		END
	ELSE
		BEGIN
			SELECT * FROM pf_parStatusOfferte WHERE wfOfferta LIKE ('%' + CONVERT(varchar, @idStatusOfferta) + '%') OR idStatusOfferta = @insertZero
		END
END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoLezioniRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <17/02/2019>
-- Description:	<Legge Piano Lezioni Professori 2.0>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoLezioniRead]

@idRS int,
@idLezione int,
@idProfessore int,
@idMateria int,
@idSede varchar(1),

@drop int,
@spRead varchar(1),
@tabella varchar(1)

	-- Add the parameters for the stored procedure here

AS

--DECLARE 


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idLezione = 0
		BEGIN
			SELECT * FROM pf_pianoLezioniVistaPivot WHERE idSede = @idSede COLLATE Latin1_General_CS_AS ORDER BY idGiorno
		END
	
	ELSE
		BEGIN
			--SELECT *, CONVERT(varchar(10), dataCreazione, 105) AS dataCrea FROM pf_pianoLezioniVista WHERE idProfessoreLez = @idProfessore AND idMateriaLez = @idMateria AND idSede = @idSede

			CREATE TABLE #Orario  (idSede varchar(1), idOrario int, idGiorno int, idOra int, giorno varchar(15), impegno bit)
			CREATE TABLE #Lezioni (idSede varchar(1), idOrario int, idLezioni int, Prenotate int)
			CREATE TABLE #Plan    (idSede varchar(1), idOrario int, idGiorno int, idOra int, giorno varchar(15), Prenota varchar(20))

			INSERT INTO #Orario SELECT idSede, idOrario, idGiorno, idOra, giorno, impegno
								FROM pf_parOrariVista     
								WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND CONVERT(varchar(8), ora) <> '00:00:00'

			INSERT INTO #Lezioni SELECT idSede, idOrario, idLezione, Prenotate      
								 FROM pf_pianoLezioniVista 
								 WHERE idSede = @idSede COLLATE Latin1_General_CS_AS AND idProfessoreLez = @idProfessore AND idMateriaLez = @idMateria 
			
			INSERT INTO #Plan SELECT #Orario.idSede, #Orario.idOrario, #Orario.idGiorno, #Orario.idOra, #Orario.giorno, 
											CASE WHEN #Orario.impegno = 0 THEN '0//-2'
												 WHEN #Orario.impegno = 1 AND #Lezioni.Prenotate IS NULL THEN '0//-1'
												 WHEN #Orario.impegno = 1 AND #Lezioni.Prenotate IS NOT NULL THEN CONVERT(varchar(10), #Lezioni.idLezioni) + '//'+ CONVERT(varchar(2), #Lezioni.Prenotate) END AS Prenota
				FROM #Orario LEFT OUTER JOIN #Lezioni ON #Orario.idOrario = #Lezioni.idOrario

			--SELECT * FROM #Plan
												 
			SELECT idSede, idGiorno, giorno, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
				FROM (SELECT idSede, idGiorno, giorno, idOra, CONVERT(varchar, Prenota) AS Prenota FROM [#Plan]) AS sourceTable PIVOT (MIN(Prenota) 
				FOR idOra IN ([1], [2], [3], [4], [5])) AS pivotTable

			DROP TABLE #Orario
			DROP TABLE #Lezioni
			DROP TABLE #Plan

		END

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoLezioniUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.SQL>
-- Create date: <16/05/2019>
-- Description:	<Aggiorna lezioni professori e piano offerte 3.0>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoLezioniUpdate]

@idRS int,
@idSede varchar(1),
@idLezione int, 
@idProfessoreLez int, 
@idMateriaLez int, 
@idOrarioLez int, 
@anni varchar(5),
@frequenza varchar(1),

@nomeProf varchar(1),
@materia varchar(1),
@orario varchar(1), 

@delete bit,
@spUpdate varchar(1), 
@OK int OUTPUT

AS

DECLARE
@oggi date,
@giorno date,
@dataFinale date,
@insert bit = 0

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @oggi = GETDATE()

	IF @idLezione = 0
		BEGIN
			-- Verifico se il docente è già impegnato su altra sede nello stesso giorno di settimana
			IF NOT EXISTS (SELECT idLezione FROM pf_pianoLezioniVista WHERE idProfessoreLez = @idProfessoreLez AND idGiorno = LEFT(@idOrarioLez,1) AND idRS = @idRS AND idSede <> @idSede COLLATE Latin1_General_CS_AS )
				BEGIN
					INSERT INTO pf_pianoLezioni (idSede, idProfessore, idMateria, idOrario, anni, frequenza)
										 VALUES (@idSede, @idProfessoreLez, @idMateriaLez, @idOrarioLez, @anni, @frequenza)

					SET @idLezione = (SELECT idLezione FROM pf_pianoLezioni WHERE idProfessore = @idProfessoreLez AND idMateria = @idMateriaLez AND idOrario = @idOrarioLez AND idSede = @idSede COLLATE Latin1_General_CS_AS)
					SET @dataFinale = (SELECT MAX(giorno) FROM pf_parCalendario WHERE idSede = @idSede COLLATE Latin1_General_CS_AS )
					SET @giorno = @oggi
					
					WHILE @giorno <= @dataFinale
						BEGIN
							-- verifico che si tratta di un giorno lavorativo disponibile per la sede selezionata
							IF EXISTS (SELECT giorno FROM pf_parCalendario WHERE giorno = @giorno AND attivo = 1 AND idSede = @idSede COLLATE Latin1_General_CS_AS ) AND DATEPART(weekday, @giorno) = LEFT(@idOrarioLez, 1)
								BEGIN																	
									SET @insert = CASE WHEN @frequenza = 'Q' AND @insert = 0 THEN 1
													   WHEN @frequenza = 'Q' AND @insert = 1 THEN 0	
												  END

									IF CASE WHEN @frequenza = 'S' THEN 1 WHEN @frequenza = 'Q' THEN @insert END = 1
										BEGIN
											INSERT INTO pf_pianoOfferte (idSede, idLezione, idProfessore, idMateria, idOrario, dataOfferta,  anni, frequenza) 
																 VALUES (@idSede, @idLezione, @idProfessoreLez, @idMateriaLez, @idOrarioLez, @giorno, @anni, @frequenza)
										END
								END
							SET @giorno = DATEADD(DAY, 1, @giorno)
						END		
					
					SET @OK = 1
				END
	
			ELSE
				BEGIN
					SET @OK = 11
				END
		END
	ELSE
		BEGIN
			IF @delete = 1
				BEGIN
					-- elimino la lezione dall'archivio lezioni
					DELETE FROM pf_pianoLezioni WHERE idLezione = @idLezione AND idSede = @idSede COLLATE Latin1_General_CS_AS 
							
					-- riprogrammo nel piano offerte le lezioni già prenotate
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0 WHERE idLezione = @idLezione AND idStatusOfferta = 2 AND dataOfferta >= @oggi AND idSede = @idSede COLLATE Latin1_General_CS_AS 
							
					-- elimino nel piano offerte le lezioni non prenotate
					DELETE FROM pf_pianoOfferte WHERE (idStatusOfferta <> 11 AND idStatusOfferta <> 3 AND idStatusOfferta <> 5 AND idLezione = @idLezione AND dataOfferta >= @oggi AND idSede = @idSede COLLATE Latin1_General_CS_AS )  --AND (idStatusOfferta = 1 AND attivo = 1 AND idLezione = @idLezione AND dataOfferta >= @oggi AND idSede = @idSede)
				END

			SET @OK = 1
		END

	RETURN @OK
END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteAttiva]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <29/06/2018>
-- Description:	<Riattiva Piano Offerta per lezioni sospese dal docente>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteAttiva] 

@idRS int,
@idSede int,
@dataIniziale date, 
@dataFinale date,
@idProfessore int,
@idStatusAttiva int,

@spAttiva varchar(1),
@OK int = 0 OUTPUT

AS

DECLARE
@idProf0 int,
@idProf9 int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @idProf0 = CASE WHEN @idProfessore = 0 THEN 0                                                     ELSE @idProfessore END
	SET @idProf9 = CASE WHEN @idProfessore = 0 THEN (SELECT MAX(idProfessore) FROM pf_anagrafeProfessori) ELSE @idProfessore END
	
	IF @dataFinale < @dataIniziale 
		BEGIN
			SET @dataFinale = @dataIniziale
		END

	UPDATE pf_pianoOfferte SET idStatusOfferta = 1, attivo = 1
		WHERE dataOfferta  >= @dataIniziale AND dataOfferta  <= @dataFinale AND 
			  idProfessore >= @idProf0      AND idProfessore <= @idProf9    AND 
			  idStatusOfferta = @idStatusAttiva AND idSede = @idSede

	--DELETE FROM pf_pianoOfferte 
	--	WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	--		  idProfessore >= @idProf0 AND idProfessore <= @idProf9 AND 
	--		  idStatusOfferta <> 11

	--UPDATE pf_pianoOfferte SET idStatusOfferta = 10, attivo = 0, notaOfferta = 'Lezione Rimossa da azione centrale' 
	--	WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	--		  idProfessore >= @idProf0 AND idProfessore <= @idProf9 AND 
	--		  idStatusOfferta <> 11

	SET @OK = 1

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteCreate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteCreate] 

@idRS int,
@idSede varchar(1),
@dataIniziale date, 
@dataFinale date,
@ponteFestivo int,
@preFestivo int,
@spCreate varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE
@idLezione int,
@giorno date,
@giornoSettimana int,
@giornoSettimanaStart int,
@settimana int,
@frequenzaLez int
--@giornoAttivo int,
--@attivo bit

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @giorno = @dataIniziale
	SET @giornoSettimanaStart = DATEPART(weekday, @giorno)
	SET @settimana = -1

	IF @dataFinale < @dataIniziale
		BEGIN
			SET @dataFinale = DATEADD(MONTH, 1, @dataIniziale)
		END
			
	WHILE @giorno <= @dataFinale
		BEGIN
			SET @giornoSettimana = DATEPART(weekday, @giorno)
			SET @settimana = CASE WHEN @giornoSettimana = @giornoSettimanaStart THEN @settimana + 1 ELSE @settimana END
			--SET @giornoAttivo = (SELECT attivo FROM pf_parCalendario WHERE giorno = @giorno AND idSede = @idSede)
			--SET @attivo = CASE WHEN @giornoAttivo = 1 THEN 1 ELSE 0 END
			
			--PRINT @giorno
			--PRINT @attivo

			IF NOT EXISTS (SELECT dataFestivo FROM pf_parFestivi WHERE DATEADD(DAY, CASE WHEN @ponteFestivo = 1 THEN ponteFestivo ELSE 0 END, datafestivo) = @giorno OR
																	   DATEADD(DAY, CASE WHEN @preFestivo = 1   THEN -1           ELSE 0 END, datafestivo) = @giorno OR
																	   dataFestivo = @giorno ) --AND @attivo = 1

				BEGIN					
					DECLARE Cursor_ID CURSOR FOR SELECT idLezione FROM pf_pianoLezioniVista WHERE idGiorno=@giornoSettimana AND idSede = @idSede COLLATE Latin1_General_CS_AS
					OPEN Cursor_ID FETCH NEXT FROM Cursor_ID INTO @idLezione 
					
					WHILE @@FETCH_STATUS = 0

						BEGIN
							SET @frequenzaLez = (SELECT frequenzaSet FROM pf_pianoLezioniVista WHERE idLezione = @idLezione AND idSede = @idSede COLLATE Latin1_General_CS_AS)
							IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferte WHERE idLezione = @idLezione AND dataOfferta = @giorno AND idProfessore <> 0 AND idSede = @idSede COLLATE Latin1_General_CS_AS) --AND attivo = 1 
								BEGIN
									IF @settimana % @frequenzaLez = 0
										BEGIN
											INSERT INTO pf_pianoOfferte ( idSede, idLezione, idProfessore, idMateria, idOrario, anni, frequenza, dataOfferta)				
																  SELECT  idSede, idLezione, idProfessoreLez, idMateriaLez, idOrario, anni, frequenza, @giorno
																  FROM pf_pianoLezioniVista 
																  WHERE idLezione = @idLezione AND idSede = @idSede COLLATE Latin1_General_CS_AS
										END
								END

							FETCH NEXT FROM Cursor_ID INTO @idLezione

						END
	
					CLOSE Cursor_ID
					DEALLOCATE Cursor_ID
				END		
			
			SET @giorno = DATEADD(DAY, 1, @giorno)
		END

	SET @OK = 1

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteDelete]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Crea Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteDelete] 

@idRS int,
@idSede int,
@dataIniziale date, 
@dataFinale date,
@idProfessore int,
@erase bit,

@spDelete varchar(1),
@OK int = 0 OUTPUT

AS

DECLARE
@idProf0 int,
@idProf9 int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @idProf0 = CASE WHEN @idProfessore = 0 THEN 0                                                     ELSE @idProfessore END
	SET @idProf9 = CASE WHEN @idProfessore = 0 THEN (SELECT MAX(idProfessore) FROM pf_anagrafeProfessori) ELSE @idProfessore END
	
	IF @dataIniziale < GETDATE() 
		BEGIN
			SET @dataIniziale = GETDATE()
		END
	
	IF @dataFinale < @dataIniziale 
		BEGIN
			SET @dataFinale = @dataIniziale
		END


	-- riprogrammo le lezioni già prenotate
	UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0, notaOfferta = notaOfferta + ' - notaOfferta' 
		WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
			  idProfessore >= @idProf0 AND idProfessore <= @idProf9 AND 
			  idStatusOfferta = 2 AND idSede = @idSede

	IF @erase = 1
		BEGIN
			-- elimino in modo definitivo le lezioni non prenotate
			DELETE FROM pf_pianoOfferte 
				WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
				idProfessore >= @idProf0 AND idProfessore <= @idProf9 AND 
				idStatusOfferta <> 11 AND idSede = @idSede
		END

	ELSE
		BEGIN
			-- tolgo dalla disponibilità le lezioni non prenotate
			UPDATE pf_pianoOfferte SET idStatusOfferta = 5, attivo = 0, notaOfferta = notaOfferta + ' - Lezione cancellata dalla segreteria' 
				WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
					  idProfessore >= @idProf0 AND idProfessore <= @idProf9 AND 
					  idStatusOfferta <> 11 AND idSede = @idSede
		END

	SET @OK = 1

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteErogateReadApp]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <29/01/2019>
-- Description:	<Legge Piano Offerte Erogate per App>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteErogateReadApp]


@idOfferta int, 
@idStatusOfferta int, 
@idStud int,
@idMat int,
@emailUser varchar(100),
@tipo varchar(1),

@delete int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS
--DECLARE
--@idStudMin int = 0,
--@idStudMax int = 10000000,

--@idProfMin int = 0,
--@idProfMax int = 10000000,

--@idSede int,
--@idSedeMin int = 0,
--@idSedeMax int = 10000000

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	--SET @idSede = (SELECT idSede FROM pf_anagrafeGeneraleVista WHERE email = @emailUser AND tipo = @tipo)

	--IF @idStud > 0
	--	BEGIN
	--		SET @idStudMin = @idStud
	--		SET @idStudMax = @idStud
	--	END
	
	--IF @idProf > 0
	--	BEGIN
	--		SET @idProfMin = @idProf
	--		SET @idProfMax = @idProf
	--	END	
		
	--IF LEN(@idSede) = 1
	--	BEGIN
	--		SET @idSedeMin = @idSede
	--		SET @idSedeMax = @idSede
	--	END
	
	SELECT * FROM pf_pianoOfferteErogateVista 
	WHERE idStudente = @idStud AND idMateria = @idMat --IN (@idSede) dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	ORDER BY idMateria, dataOffertaAMG DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteErogateUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSql>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteErogateUpdate] 

@sp varchar(1),
@tabella varchar(1),

@OK int = 0 OUTPUT

AS

DECLARE

@ieri date,
@dataLimite date


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @ieri = GETDATE() - 1
	SET @dataLimite = GETDATE() - 7

	-- chiudo con Erogate le lezioni prenotate il giorno prima
	UPDATE pf_pianoOfferte SET idStatusOfferta = 3  WHERE idStatusOfferta = 2  AND dataOfferta <= @ieri

	-- elimino le lezioni da riprogrammare che non sono state riprogrammate entro la data limite
	--UPDATE pf_pianoOfferte SET idStatusOfferta = 10 WHERE idStatusOfferta = 11 AND dataOfferta <= @dataLimite
	DELETE FROM pf_pianoOfferte WHERE idStatusOfferta = 11 AND dataOfferta <= @dataLimite

	-- tolgo dall'archivio le lezioni che non sono state utilizzate
	UPDATE pf_pianoOfferte SET idStatusOfferta = 12 WHERE idStatusOfferta = 1  AND dataOfferta <= @ieri

	SET @OK = 1

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteOggiRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <27/03/2018>
-- Description:	<Legge Piano Offerta Formativa di Oggi>
-- =============================================


CREATE PROCEDURE [dbo].[pf_pianoOfferteOggiRead]

--@idRS int,
@sp varchar(1),
@tabella varchar(1)

AS

BEGIN

DECLARE
@oggi date

	SET @oggi = DATEADD(HOUR, 2, GETDATE())

	SELECT CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, CONVERT(varchar(8), orario) AS orarioHMS, * 
	FROM pf_pianoOfferteVista 
	WHERE idStatusOfferta = 2 AND dataOfferta = @oggi and attivo = 1 --AND idRS = @idRS
	ORDER BY idRS, idSede --AND idSede = @idSede

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOffertePrenotateRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Legge Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOffertePrenotateRead]

@idSede int,
@idOfferta int, 
@idStatusOfferta int, 
@dataIniziale date,
@dataFinale date,

@delete int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT dataOfferta, idOrario, 'Orario:' + CONVERT(varchar(10), ora) + 
			', Docente:' + nomeProf + ', Materia:' + materia  + ', Studente:' + nomeStud + ', Indirizzo:' + istitutoTipo + ', Anno:' + CONVERT(varchar, anno) AS Offerta, -- + ', id:' + CONVERT(varchar, idOfferta)
				giorno + ' | ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
	FROM pf_pianoOffertePrenotateVista 
	WHERE idSede = @idSede --dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	ORDER BY dataOffertaAMG, idOrario, Offerta  -- AND attivo = 1 

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOffertePrenotateReadApp]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <29/01/2019>
-- Description:	<Legge Piano Offerta Formativa per App>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOffertePrenotateReadApp]

--@idRS int,
@idOfferta int, 
@idStatusOfferta int, 
@dataIniziale date,
@dataFinale date,
@idStud int,
@idProf int,
@emailUser varchar(100),
@tipo varchar(1),

@delete int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS
DECLARE
@idStudMin int = 0,
@idStudMax int = 10000000,

@idProfMin int = 0,
@idProfMax int = 10000000,

@idSede int,
@idSedeMin int = 0,
@idSedeMax int = 10000000

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @idSede = (SELECT idSede FROM pf_anagrafeGeneraleVista WHERE email = @emailUser AND tipo = @tipo)

	IF @idStud > 0
		BEGIN
			SET @idStudMin = @idStud
			SET @idStudMax = @idStud
		END
	
	IF @idProf > 0
		BEGIN
			SET @idProfMin = @idProf
			SET @idProfMax = @idProf
		END	
		
	IF LEN(@idSede) = 1
		BEGIN
			SET @idSedeMin = @idSede
			SET @idSedeMax = @idSede
		END
	
	SELECT * FROM pf_pianoOffertePrenotateVista 
	WHERE idStudente >= @idStudMin AND idStudente <= @idStudMax AND idProfessore >= @idProfMin AND idProfessore <= @idProfMax AND idSede >= @idSedeMin AND idSede <= @idSedeMax --AND idRS = @idRS --IN (@idSede) dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND 
	ORDER BY  sede, dataOffertaAMG, idOrario

END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteRead]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.JSQL>
-- Create date: <15/07/2020>
-- Description:	<Legge Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteRead]

@idSede varchar(1),
@idOfferta int, 
@idStatusOfferta int, 
@dataIniziale date,
@dataFinale date,
@delete bit,
@idMateria int,

@idProfessore int,
@drop int,
@spRead varchar(1), 
@tabella varchar(1)

AS
DECLARE
@idStatusMin int,
@idStatusMax int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @idMateria = 0
		BEGIN
			SET @idStatusMin = CASE WHEN @idStatusOfferta = 0 THEN 0   ELSE @idStatusOfferta END
			SET @idStatusMax = CASE WHEN @idStatusOfferta = 0 THEN 100 ELSE @idStatusOfferta END
		END
	ELSE
		BEGIN
			SET @idStatusMin = 1
			SET @idStatusMax = 1
		END

	BEGIN
		IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVista', 'U') IS NOT NULL
			DROP TABLE #tmp_pianoOfferteVista; 

		CREATE TABLE #tmp_pianoOfferteVista 
				(idSede varchar(1) ,idOfferta int, idLezione int, idProfessore int, nomeProf varchar(200), 
				emailProf varchar(200), idMateria int, materia varchar(200), idGruppo int, gruppo varchar(20), dataOfferta date, 
				attivo bit, notaOfferta varchar(MAX), argomentoOfferta varchar(MAX), idStatusOfferta int, statusOfferta varchar(100), idOrario int, orario varchar(43),
				idGiorno int, giorno varchar(10), idOra int, ora time(0), idStudente int, nomeStud varchar(200), emailStud varchar(200),
				tel1Stud varchar(20), tel2Stud varchar(20), anno varchar(1), istitutoNome varchar(50), istitutoTipo varchar(60), notaStud varchar(255), gruppoStud bit,
				anni varchar(5), wfOfferta varchar(8), deletedProf bit, deletedStud bit, tel1Prof varchar(20), tel2Prof varchar(20), 
				impegno bit, frequenza varchar(1))

		INSERT INTO #tmp_pianoOfferteVista 
		SELECT dbo.pf_pianoOfferte.idSede, dbo.pf_pianoOfferte.idOfferta, dbo.pf_pianoOfferte.idLezione, dbo.pf_pianoOfferte.idProfessore, dbo.pf_anagrafeProfessoriVista.nomeProf, dbo.pf_anagrafeProfessoriVista.emailProf, 
						  dbo.pf_pianoOfferte.idMateria, dbo.pf_parMaterie.materia, dbo.pf_parMaterie.idGruppo, dbo.pf_parMaterieGruppo.gruppo, dbo.pf_pianoOfferte.dataOfferta, dbo.pf_pianoOfferte.attivo, dbo.pf_pianoOfferte.notaOfferta, dbo.pf_pianoOfferte.argomentoOfferta, 
						  dbo.pf_pianoOfferte.idStatusOfferta, dbo.pf_parStatusOfferte.statusOfferta, dbo.pf_pianoOfferte.idOrario, dbo.pf_parOrariVista.ora, dbo.pf_parOrariVista.idGiorno, dbo.pf_parOrariVista.giorno, dbo.pf_parOrariVista.idOra, 
						  dbo.pf_parOrariVista.ora, dbo.pf_pianoOfferte.idStudente, dbo.pf_anagrafeStudentiVista.nomeStud, dbo.pf_anagrafeStudentiVista.emailStud, dbo.pf_anagrafeStudentiVista.tel1Stud, dbo.pf_anagrafeStudentiVista.tel2Stud, 
						  dbo.pf_anagrafeStudentiVista.anno, dbo.pf_anagrafeStudentiVista.istitutoNome, dbo.pf_anagrafeStudentiVista.istitutoTipo, dbo.pf_anagrafeStudentiVista.notaStud, dbo.pf_pianoOfferte.gruppoStud, dbo.pf_pianoOfferte.anni, dbo.pf_parStatusOfferte.wfOfferta, 
						  dbo.pf_anagrafeProfessoriVista.deleted AS deletedProf, dbo.pf_anagrafeStudentiVista.deleted AS deletedStud, dbo.pf_anagrafeProfessoriVista.tel1Prof, dbo.pf_anagrafeProfessoriVista.tel2Prof, dbo.pf_parOrariVista.impegno,
						  dbo.pf_pianoOfferte.frequenza
		FROM     dbo.pf_pianoOfferte INNER JOIN
						  dbo.pf_anagrafeProfessoriVista ON dbo.pf_pianoOfferte.idProfessore = dbo.pf_anagrafeProfessoriVista.idProfessore INNER JOIN
						  dbo.pf_parMaterie ON dbo.pf_pianoOfferte.idMateria = dbo.pf_parMaterie.idMateria INNER JOIN
						  dbo.pf_parMaterieGruppo ON dbo.pf_parMaterie.idGruppo = dbo.pf_parMaterieGruppo.idGruppo INNER JOIN
						  dbo.pf_parStatusOfferte ON dbo.pf_pianoOfferte.idStatusOfferta = dbo.pf_parStatusOfferte.idStatusOfferta INNER JOIN
						  dbo.pf_parOrariVista ON dbo.pf_pianoOfferte.idOrario = dbo.pf_parOrariVista.idOrario AND dbo.pf_pianoOfferte.idSede = dbo.pf_parOrariVista.idSede LEFT OUTER JOIN
						  dbo.pf_anagrafeStudentiVista ON dbo.pf_pianoOfferte.idStudente = dbo.pf_anagrafeStudentiVista.idStudente
		WHERE  (dbo.pf_parOrariVista.impegno = 1 AND dbo.pf_pianoOfferte.idStatusOfferta >= @idStatusMin AND dbo.pf_pianoOfferte.idStatusOfferta <= @idStatusMax) AND (CONVERT(varchar(8), dbo.pf_parOrariVista.ora) <> '00:00:00')


		IF OBJECT_ID('tempdb.dbo.#tmp_pianoOfferteVistaPivot', 'U') IS NOT NULL
			DROP TABLE #tmp_pianoOfferteVistaPivot; 

		CREATE TABLE #tmp_pianoOfferteVistaPivot 
				(idSede varchar(1), idGiorno int, idMateria int, deletedProf bit, dataOffertaGMA varchar(23), dataOfferta date,
				Ora1 varchar(920), Ora2 varchar(920), Ora3 varchar(920), Ora4 varchar(920), Ora5 varchar(920))

		INSERT INTO #tmp_pianoOfferteVistaPivot
		SELECT idSede, idGiorno, idMateria, deletedProf, giorno + ' - ' + CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA, dataOfferta, [1] AS Ora1, [2] AS Ora2, [3] AS Ora3, [4] AS Ora4, [5] AS Ora5
		FROM     (SELECT idSede, idGiorno, idMateria, deletedProf, giorno, dataOfferta, idOra, nomeProf, materia, 'prof:' + nomeProf + ',materia:' + materia + ',anni:' + CONVERT(varchar, anni) + ',' + 'Studente:' + ISNULL(nomeStud, '--') + IIF(gruppoStud = 1, ' (+N)','') + ',anno:' + ISNULL(anno, '0') + ',Status:' + statusOfferta + ',idStatus:' + CONVERT(varchar, idStatusOfferta) + ',id:' + CONVERT(varchar, idOfferta) 
											+ ',idStudente:' + CONVERT(varchar, idStudente) AS Offerta
						  FROM    #tmp_pianoOfferteVista
						  WHERE   attivo = 1 OR idStatusOfferta = 5) 
					AS sourceTable PIVOT (MIN(Offerta) FOR idOra IN ([1], [2], [3], [4], [5])) AS pivotTable
	END

	IF @idMateria = 0
		BEGIN
			IF @idOfferta = 0
				BEGIN
					IF @idStatusOfferta = 0
						BEGIN
							SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
							FROM #tmp_pianoOfferteVistaPivot 
							WHERE  dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND (deletedProf = 0  ) AND idSede = @idSede COLLATE Latin1_General_CS_AS --OR (idStatusOfferta = 3 AND deletedProf <= 1)
							ORDER BY dataOfferta, Ora1 --, idStatusOfferta -- AND attivo = 1  
						END
					ELSE
						BEGIN
							SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
							FROM #tmp_pianoOfferteVistaPivot 
							WHERE dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND deletedProf <= @delete AND idSede = @idSede COLLATE Latin1_General_CS_AS --idStatusOfferta = @idStatusOfferta AND 
							ORDER BY dataOfferta, Ora1 -- AND attivo = 1 
						END
					END
			ELSE
				BEGIN
					SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
					FROM pf_pianoOfferteVista 
					WHERE idOfferta = @idOfferta AND attivo = 1 AND deletedProf <= @delete AND idSede = @idSede COLLATE Latin1_General_CS_AS --AND dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale
				END
		END
	ELSE
		BEGIN
			SELECT *, CONVERT(varchar(10), dataOfferta, 105) AS dataOffertaGMA 
			FROM #tmp_pianoOfferteVistaPivot 
			WHERE idMateria = @idMateria AND deletedProf <= @delete AND dataOfferta >= @dataIniziale AND dataOfferta <= @dataFinale AND idSede = @idSede COLLATE Latin1_General_CS_AS --AND idStatusOfferta = 1
			ORDER BY dataOfferta
		END
END
GO
/****** Object:  StoredProcedure [dbo].[pf_pianoOfferteUpdate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Valerio.NET>
-- Create date: <04/01/2018>
-- Description:	<Aggiorna Piano Offerta Formativa>
-- =============================================

CREATE PROCEDURE [dbo].[pf_pianoOfferteUpdate] 

@idRS int,
@idSede varchar(1),
@idOfferta int, 
@idLezione int,
@idProfessore int,
@idMateria int,
@idOrario int,
@idGiorno int,
@idOra int, 
@dataOffertaGMA date, 
@idStatusOfferta int,
@idStudente int,
@attivo bit,
@gruppoStud bit,
@notaOfferta varchar(MAX),
@argomentoOfferta varchar(MAX),
@aggiornaData bit,
@riprogramma bit,

@nomeProf varchar(1),
@nomeStud varchar(100),
@materia varchar(2),
@orario varchar(1),
@giorno varchar(1),
--@ora varchar(1),
@anni varchar(2),
@statusOfferta varchar(1),
@anno varchar(1),
@istitutoTipo varchar(1),
@tel1Stud varchar(1),
@tel2Stud varchar(1),
@emailStud varchar(1),
@tel1Prof varchar(1),
@tel2Prof varchar(1),
@emailProf varchar(1),

@spUpdate varchar(2),
@OK int = 0 OUTPUT

	-- Add the parameters for the stored procedure here

AS

DECLARE
@idStatusOffertaFinale int,
@idOrarioFinale int,
@idGiornoFinale int,
@idOraFinale int,
@idOrarioOld int,
@dataOffertaOld date,
@badLog bit,
@annullaAttesa bit


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT @idStatusOffertaFinale = idStatusOffertaFinale, @badLog = badLog, @annullaAttesa = annullaAttesa FROM pf_parStatusOfferte WHERE idStatusOfferta = @idStatusOfferta
	SELECT @dataOffertaOld = dataOfferta, @idOrarioOld = idOrario FROM pf_pianoOfferte WHERE idOfferta = @idOfferta

	IF @idStatusOfferta = 1 -- offerta libera
		BEGIN
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 2 -- prenota lezione e blocca le altre lezione del professore nella stessa ora e verifico che lo studente in quel giorno non abbia lezione prenotate in altra sede
		BEGIN
			IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferteVista WHERE (idSede = @idSede AND idStudente = @idStudente AND idOrario = @idOrario AND attivo = 1 AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idStatusOfferta <> 11) OR (idSede <> @idSede AND idRS = @idRS AND idStudente = @idStudente AND attivo = 1 AND dataOfferta = @dataOffertaGMA AND idStatusOfferta <> 11 ))
				BEGIN
					UPDATE pf_pianoOfferte SET idStudente = @idStudente, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
					UPDATE pf_pianoOfferte SET attivo = 0 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
					SET @OK = 3
					
				END
			ELSE
				BEGIN
					SET @OK = 2
				END

		END

	ELSE IF @idStatusOfferta = 3 -- lezione erogata e chiusa
		BEGIN
			UPDATE pf_pianoOfferte SET idStudente = @idStudente, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 4 -- lezione annullata dallo studente;  si rende di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 5 -- lezione annullata dal professore; bloccata per tutti
		BEGIN			
			IF @idStudente = 0 -- la lezione non era prenotata, posso metterla nel log
				BEGIN
					UPDATE pf_pianoOfferte SET idStatusOfferta = @idStatusOffertaFinale, attivo = 0, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
					UPDATE pf_pianoOfferte SET idStatusOfferta = 5 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND dataOfferta = @dataOffertaGMA and idOrario = @idOrario AND idSede = @idSede
					SET @OK = 3
				END
			ELSE -- la lezione era prenotata; riprogrammo lo studente
				BEGIN
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
					INSERT INTO pf_pianoOfferte (idSede, idLezione, idProfessore, idMateria, idOrario, dataOfferta, idStudente, idStatusOfferta, notaOfferta, argomentoOfferta, attivo)
							VALUES (@idSede, @idLezione, @idProfessore, @idMateria, @idOrario, @dataOffertaGMA, 0, 5, @notaOfferta, @argomentoOfferta, 0)
					UPDATE pf_pianoOfferte SET idStatusOfferta = 5, idProfessore = @idProfessore WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND dataOfferta = @dataOffertaGMA and idOrario = @idOrario
					SET @OK = 3
				END
				
		END

	ELSE IF @idStatusOfferta = 6 -- prenotazione annullata dalla segreteria; si rende di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta  WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 7 -- lo studente non si presenta; la lezione è di nuovo disponibile e libero il professore nella fascia oraria di quel giorno
		BEGIN
			--SET @nomeStud = (SELECT nomeStud FROM pf_anagrafeStudenti WHERE idStudente = @idStudente)
			UPDATE pf_pianoOfferte SET idStudente = 0, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
			UPDATE pf_pianoOfferte SET attivo = 1 WHERE idProfessore = @idProfessore AND idOrario = @idOrario AND dataOfferta = @dataOffertaGMA AND idOfferta <> @idOfferta AND idSede = @idSede
			SET @OK = 3
		END

	ELSE IF @idStatusOfferta = 8 OR @idStatusOfferta = 9  -- il professore chiede di spostare la lezione ad altra data-ora
		BEGIN
			SET @idOraFinale = @idOra
			SET @idGiornoFinale = DATEPART(WEEKDAY, @dataOffertaGMA)
			SET @idOrarioFinale = (SELECT idOrario FROM pf_parOrari WHERE idGiorno = @idGiornoFinale AND idOra = @idOraFinale AND idSede = @idSede)
				
			IF @idStudente = 0  -- non ci sono lezioni prenotate; verifico la disponibilità del professore (anche su altre sedi) e sposto tutte le lezioni del giorno in esame
				BEGIN
					IF NOT EXISTS (SELECT idOfferta 
									FROM pf_pianoOfferteVista 
									WHERE (idSede = @idSede  AND idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND idMateria = @idMateria AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta) OR --AND attivo = 1
										  (idSede <> @idSede AND idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idRS = @idRS)
								   ) 
						BEGIN
							UPDATE pf_pianoOfferte 
							SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta 
							WHERE idProfessore=@idProfessore AND dataOfferta = @dataOffertaOld  AND idOrario = @idOrario AND idSede = @idSede -- sposto tutte le lezioni della giornata
							
							SET @OK = 3
						END
					ELSE
						BEGIN
							SET @OK = 2
						END
				END
			ELSE                
				-- sono presenti delle lezioni prenotate; 
				-- prima verifico se si tratta solo di uno spostamento di ora nella stessa giornata
				-- dopo verifico la disponibilità di studente e professore e sposto la lezione
				BEGIN
					IF @dataOffertaGMA = @dataOffertaOld AND @idOrarioFinale <> @idOrarioOld
						BEGIN
							IF EXISTS (SELECT idOfferta FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idStatusOfferta = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) --AND idMateria = @idMateria 								 
								BEGIN
									-- libero la lezione che devo spostare
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, idStudente = 0, attivo = 1 WHERE idOfferta = @idOfferta
									-- libero tutte le altre lezioni della giornata nell'orario di origine
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, attivo = 1 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND idOrario = @idOrarioOld AND dataOfferta = @dataOffertaGMA and idSede = @idSede
									
									-- prenoto la lezione nell'orario di destinazione
									UPDATE pf_pianoOfferte SET idStatusOfferta = 2, idStudente = @idStudente, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idProfessore = @idProfessore AND idMateria = @idMateria AND dataOfferta = @dataOffertaGMA AND idOrario = @idOrarioFinale AND attivo = 1 AND idStatusOfferta = 1 AND idOfferta <> @idOfferta AND idSede = @idSede --AND idOrario = @idOrarioFinale 
									-- blocco le altre lezioni della giornata nell'orario di destinazione
									UPDATE pf_pianoOfferte SET idStatusOfferta = 1, attivo = 0 WHERE idProfessore = @idProfessore AND idMateria <> @idMateria AND idOrario = @idOrarioFinale AND dataOfferta = @dataOffertaGMA and idSede = @idSede
									SET @OK = 4
								END

							ELSE IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferte WHERE idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND idOrario = @idOrarioFinale AND idSede = @idSede)
								BEGIN --sposto una lezione che era già stata spostata
									UPDATE pf_pianoOfferte SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
									SET @OK = 4
								END

							ELSE
								BEGIN
									SET @OK = 2
								END
						END

					ELSE 
						BEGIN
							-- verifico la disponibilità di professore e studente anche su altre sedi
							IF NOT EXISTS (SELECT idOfferta FROM pf_pianoOfferteVista WHERE (idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) OR
																							(idStudente   = @idStudente   AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idOrario = @idOrarioFinale AND idOfferta <> @idOfferta AND idSede = @idSede) OR
																							(idProfessore = @idProfessore AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idSede <> @idSede AND idRS = @idRS) OR
																							(idStudente   = @idStudente   AND dataOfferta = @dataOffertaGMA AND attivo = 1 AND idSede <> @idSede AND idRS = @idRS)
										   )
								BEGIN
									UPDATE pf_pianoOfferte SET dataOfferta = @dataOffertaGMA, idOrario = @idOrarioFinale, idStatusOfferta = @idStatusOffertaFinale, gruppoStud = @gruppoStud, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
									SET @OK = 3
								END
							ELSE
								BEGIN
									SET @OK = 2
								END
						END
				END
		END

	ELSE IF @idStatusOfferta = 10 -- codice desueto non più utilizzato
		BEGIN
			IF (SELECT idStudente FROM pf_pianoOfferte WHERE idOfferta = @idOfferta AND idSede = @idSede) = 0
				BEGIN  -- la lezione non era prenotata; posso eliminarla dal calendario
					DELETE FROM pf_pianoOfferte WHERE idOfferta = @idOfferta AND idSede = @idSede
				END
			ELSE
				BEGIN -- la lezione era prenotata; la inserisco nel log delle lezioni da riprogrammare
					UPDATE pf_pianoOfferte SET idStatusOfferta = 11, idProfessore = 0, notaOfferta = @notaOfferta, argomentoOfferta = @argomentoOfferta WHERE idOfferta = @idOfferta AND idSede = @idSede
				END
			
			SET @OK = 3
		END

	IF @OK = 3
		BEGIN
			IF @badLog = 1 
				BEGIN -- inserisco nel log le lezioni disdette in modo da evidenziare nel report di controllo
					INSERT INTO pf_pianoOfferte (idSede, idLezione, idProfessore, idMateria, idOrario, dataOfferta, idStudente, idStatusOfferta, gruppoStud, notaOfferta, argomentoOfferta, attivo)
										VALUES  (@idSede, @idLezione, @idProfessore, @idMateria, @idOrario, @dataOffertaOld, @idStudente, @idStatusOfferta, @gruppoStud, @notaOfferta, @argomentoOfferta, 0)
				END

			IF @riprogramma = 1
				BEGIN
					--UPDATE pf_pianoOfferte SET attivo = 0 WHERE idStudente = @idStudente AND idMateria = @idMateria AND idStatusOfferta = 11
					DELETE FROM pf_pianoOfferte WHERE idStudente = @idStudente AND idMateria = @idMateria AND idStatusOfferta = 11 AND idSede = @idSede
				END
		END

	RETURN @OK

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportDocenti]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportDocenti]

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	(
	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, nomeProf, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), idProfessore, nomeProf)

	UNION

	(
	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, 'TOTALE MESE' AS nomeProf, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta)
	)
	
	ORDER BY YEAR(dataOfferta),  MONTH(dataOfferta), NumLez

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportMaterie]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportMaterie]

AS

BEGIN
	SET NOCOUNT ON;

	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, materia, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), idMateria, materia
	ORDER BY NumLez DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportOfferte]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportOfferte]

AS

BEGIN

	SET NOCOUNT ON;

	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, statusOfferta, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta <> 11 OR (idStatusOfferta = 1 AND attivo = 1)

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), idStatusOfferta, statusOfferta
	ORDER BY Anno, Mese,NumLez  DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportRichiesteDocenti]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportRichiesteDocenti]

@idRS int,
@idSede varchar(1),
@idProfessore int, 

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@SQLPivot varchar(900),
@SQLVista varchar(100) = 'pf_reportDocentiVista',
@whereidSede varchar(100),
@campoidSede varchar(20)

BEGIN
	SET NOCOUNT ON;

	SET @campoidSede = CASE WHEN @idSede = '0' THEN ' ' ELSE ' idSede, ' END
	SET @whereidSede = CASE WHEN @idSede = '0' THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CHAR(39) + @idSede + CHAR(39) END

	SET @SQLPivot = 'SELECT idRS,' + @campoidSede + ' idProfessore, nomeProf, [1] AS disponibile, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [5] AS disdettaProf, [12] AS inevasa
					FROM     
					(SELECT idRS,' + @campoidSede + ' idProfessore, nomeProf, idStatusOfferta, NR FROM ' + @SQLVista + ') AS sourceTable 
						PIVOT (SUM(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable' + @whereidSede + ' ORDER BY erogata DESC, nomeProf ASC'

	--PRINT @SQLPivot
	EXEC(@SQLPivot);

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportRichiesteMaterie]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportRichiesteMaterie]

@idRS int,
@idSede varchar(1),
@idMateria int,
@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@SQLPivot varchar(900),
@SQLVista varchar(100) = 'pf_reportMaterieVista',
@whereidSede varchar(100),
@campoidSede varchar(20)

BEGIN
	SET NOCOUNT ON;

	SET @campoidSede = CASE WHEN @idSede = '0' THEN ' ' ELSE ' idSede, ' END
	SET @whereidSede = CASE WHEN @idSede = '0' THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CHAR(39) + @idSede + CHAR(39) END

	SET @SQLPivot = 'SELECT idRS,' + @campoidSede + ' idMateria, materia, [1] AS disponibile, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [5] AS disdettaProf, [12] AS inevasa
					FROM     
					(SELECT idRS,' + @campoidSede + ' idMateria, materia, idStatusOfferta, NR FROM ' + @SQLVista + ') AS sourceTable 
						PIVOT (SUM(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable' + @whereidSede + ' ORDER BY erogata DESC, materia ASC'

	--PRINT @SQLPivot
	EXEC(@SQLPivot);

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportRichiesteStudenti]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportRichiesteStudenti]

@idRS int,
@idSede varchar(1),
@idStudente int,
@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@SQLPivot varchar(900),
@SQLVista varchar(100) = 'pf_reportStudentiVista',
@whereidSede varchar(100),
@campoidSede varchar(20)

BEGIN
	SET NOCOUNT ON;

	SET @campoidSede = CASE WHEN @idSede = '0' THEN ' ' ELSE ' idSede, ' END
	SET @whereidSede = CASE WHEN @idSede = '0' THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CHAR(39) + @idSede + CHAR(39) END --CAST(@idSede AS varchar) END

	SET @SQLPivot = 'SELECT idRS,' + @campoidSede + ' idStudente, nomeStud, [2] AS prenotata, [3] AS erogata, [4] AS disdettaStud, [7] AS assente, [11] AS attesa
					FROM     
					(SELECT idRS,' + @campoidSede + ' idStudente, nomeStud, idStatusOfferta, NR FROM ' + @SQLVista + ') AS sourceTable 
						PIVOT (SUM(NR) FOR idStatusOfferta IN ([1], [2], [3], [4], [5], [7], [10], [11], [12])) AS pivotTable' + @whereidSede + ' ORDER BY erogata DESC, nomeStud ASC'

	--PRINT @SQLPivot
	EXEC(@SQLPivot);

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportSDD]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportSDD]

@idRS int,
@dataInizio date,
@dataFinale date,
@idProfessore int,
@idSede int,

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@data date,
@anno int,
@mese int,
@whereidSede varchar(200),
@campoidSede varchar(20),
--@condizione varchar(10),

@SQLclose varchar(2) = ' ',
@SQLcampi VARCHAR(MAX) = ' ',
@SQLpivot VARCHAR(MAX) = ' ',
@SQLString VARCHAR(MAX) = ' ',
@sourceVista varchar(100) = 'pf_reportStudentiDocentiDettaglioVista'

BEGIN
	SET @data = @dataInizio
	SET @mese = MONTH(@data)
	SET @anno = YEAR(@data)
	
	SET @whereidSede = CASE WHEN @idSede = 0 THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CAST(@idSede AS varchar) END
	SET @campoidSede = CASE WHEN @idSede = 0 THEN ' ' ELSE ' idSede, ' END

	WHILE @data <= @dataFinale
		BEGIN
			--print @data
			SET @SQLcampi = @SQLcampi + ', ISNULL([' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) + '], 0) AS ' + LEFT(DATENAME(MONTH, @data),3) +  ' ' ; --  + RIGHT(CAST(@anno AS varchar), 2)
			--print @SQLcampi
			SET @SQLpivot = @SQLpivot + @SQLclose + '[' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) +'] ';
			--print @SQLpivot

			SET @data = DATEADD(MONTH, 1, @data);
			SET @mese = MONTH(@data);
			SET @anno = YEAR(@data);
			SET @SQLclose =', ';
		END

	SET @SQLString = 'SELECT idRS, ' + @campoidSede + ' idProfessore, nomeProf, idStudente, nomeStud ' + @SQLcampi +
			'FROM  (SELECT idRS, ' + @campoidSede + ' idProfessore, nomeProf, idStudente, nomeStud, Periodo, NR FROM ' + @sourceVista +') AS sourceTable 
			PIVOT (SUM(NR) FOR Periodo IN ('+ @SQLpivot + ')) AS pivotTable' + @whereidSede;
	
	IF @idProfessore <> 0
		BEGIN
			--SET @condizione = CASE WHEN @idSede = 0 THEN ' WHERE ' ELSE ' AND ' END 
			SET @SQLString = @SQLString + ' AND idProfessore = ' + CAST(@idProfessore AS varchar) 
		END
	--PRINT @SQLString
	EXEC(@SQLString);
			
END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportSLD]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportSLD]

@idRS int,
@dataInizio date,
@dataFinale date,
@idStudente int,
@idSede int,

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@data date,
@anno int,
@mese int,
@whereidSede varchar(200),
@campoidSede varchar(20),
--@condizione varchar(10),

@SQLclose varchar(2) = ' ',
@SQLcampi VARCHAR(MAX) = ' ',
@SQLpivot VARCHAR(MAX) = ' ',
@SQLString VARCHAR(MAX) = ' ',
@sourceVista varchar(100) = 'pf_reportStudentiLezioniDettaglioVista'

BEGIN
	SET @data = @dataInizio
	SET @mese = MONTH(@data)
	SET @anno = YEAR(@data)
	
	SET @whereidSede = CASE WHEN @idSede = 0 THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CAST(@idSede AS varchar) END
	SET @campoidSede = CASE WHEN @idSede = 0 THEN ' ' ELSE ' idSede, ' END


	WHILE @data <= @dataFinale
		BEGIN
			--print @data
			SET @SQLcampi = @SQLcampi + ', ISNULL([' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) + '], 0) AS ' + LEFT(DATENAME(MONTH, @data),3) +  ' ' ; --  + RIGHT(CAST(@anno AS varchar), 2)
			--print @SQLcampi
			SET @SQLpivot = @SQLpivot + @SQLclose + '[' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) +'] ';
			--print @SQLpivot

			SET @data = DATEADD(MONTH, 1, @data);
			SET @mese = MONTH(@data);
			SET @anno = YEAR(@data);
			SET @SQLclose =', ';
		END

	SET @SQLString = 'SELECT idRS, ' + @campoidSede + ' idStudente, nomeStud, idMateria, materia ' + @SQLcampi +
			'FROM  (SELECT idRS, ' + @campoidSede + ' idStudente, nomeStud, idMateria, materia , Periodo, NR FROM ' + @sourceVista + ') AS sourceTable 
			PIVOT (SUM(NR) FOR Periodo IN ('+ @SQLpivot + ')) AS pivotTable' + @whereidSede;
	
	IF @idStudente <> 0
		BEGIN
			--SET @condizione = CASE WHEN @idSede = 0 THEN ' WHERE ' ELSE ' AND ' END 
			SET @SQLString = @SQLString +  ' AND idStudente =' + CAST(@idStudente AS varchar)
		END
	--PRINT @SQLString
	EXEC(@SQLString);
				
END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportSLE]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportSLE]

@idRS int,
@dataInizio date,
@dataFinale date,
@idStudente int,
@idSede int,

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@data date,
@anno int,
@mese int,
@whereidSede varchar(200),
@campoidSede varchar(20),
@condizione varchar(10),

@SQLclose varchar(2) = ' ',
@SQLcampi VARCHAR(MAX) = ' ',
@SQLpivot VARCHAR(MAX) = ' ',
@SQLString VARCHAR(MAX) = ' ',
@sourceVista varchar(100) = 'pf_reportStudentiLezioniErogateVista'

BEGIN
	SET @data = @dataInizio
	SET @mese = MONTH(@data)
	SET @anno = YEAR(@data)
	
	SET @whereidSede = CASE WHEN @idSede = 0 THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CAST(@idSede AS varchar) END
	SET @campoidSede = CASE WHEN @idSede = 0 THEN ' ' ELSE ' idSede, ' END

	WHILE @data <= @dataFinale
		BEGIN
			--print @data
			SET @SQLcampi = @SQLcampi + ', ISNULL([' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) + '], 0) AS ' + DATENAME(MONTH, @data) + ' ' ;
			--print @SQLcampi
			SET @SQLpivot = @SQLpivot + @SQLclose + '[' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) +'] ';
			--print @SQLpivot

			SET @data = DATEADD(MONTH, 1, @data);
			SET @mese = MONTH(@data);
			SET @anno = YEAR(@data);
			SET @SQLclose =', ';
		END

	SET @SQLString = 'SELECT idRS, ' + @campoidSede + ' idStudente, nomeStud' + @SQLcampi +
			'FROM  (SELECT idRS, ' + @campoidSede + ' idStudente, nomeStud, Periodo, NR FROM ' + @sourceVista + ') AS sourceTable 
			PIVOT (SUM(NR) FOR Periodo IN ('+ @SQLpivot + ')) AS pivotTable' + @whereidSede;
	
	IF @idStudente <> 0
		BEGIN
			SET @condizione = CASE WHEN @idSede = 0 THEN ' WHERE ' ELSE ' AND ' END 
			SET @SQLString = @SQLString + @condizione + ' idStudente =' + CAST(@idStudente AS varchar)
		END

	EXEC(@SQLString);
				
END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportSMD]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportSMD]

@idRS int,
@dataInizio date,
@dataFinale date,
@idMateria int,
@idSede int,

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@data date,
@anno int,
@mese int,
@whereidSede varchar(200),
@campoidSede varchar(20),
--@condizione varchar(10),

@SQLclose varchar(2) = ' ',
@SQLcampi VARCHAR(MAX) = ' ',
@SQLpivot VARCHAR(MAX) = ' ',
@SQLString VARCHAR(MAX) = ' ',
@sourceVista varchar(100) = 'pf_reportStudentiLezioniDettaglioVista'

BEGIN
	SET @data = @dataInizio
	SET @mese = MONTH(@data)
	SET @anno = YEAR(@data)

	SET @whereidSede = CASE WHEN @idSede = 0 THEN ' WHERE idRS = ' + CAST(@idRS AS varchar) ELSE ' WHERE idSede = ' + CAST(@idSede AS varchar) END
	SET @campoidSede = CASE WHEN @idSede = 0 THEN ' ' ELSE ' idSede, ' END

	WHILE @data <= @dataFinale
		BEGIN
			--print @data
			SET @SQLcampi = @SQLcampi + ', ISNULL([' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) + '], 0) AS ' + LEFT(DATENAME(MONTH, @data),3) +  ' ' ; --  + RIGHT(CAST(@anno AS varchar), 2)
			--print @SQLcampi
			SET @SQLpivot = @SQLpivot + @SQLclose + '[' + CAST(@anno AS varchar) + ' - ' + CAST(@mese AS varchar) +'] ';
			--print @SQLpivot

			SET @data = DATEADD(MONTH, 1, @data);
			SET @mese = MONTH(@data);
			SET @anno = YEAR(@data);
			SET @SQLclose =', ';
		END

	SET @SQLString = 'SELECT idRS, ' + @campoidSede + 'idMateria, materia, idStudente, nomeStud ' + @SQLcampi +
			'FROM  (SELECT idRS, ' + @campoidSede + 'idMateria, materia, idStudente, nomeStud, Periodo, NR FROM ' + @sourceVista + ') AS sourceTable ' +
			'PIVOT (SUM(NR) FOR Periodo IN ('+ @SQLpivot + ')) AS pivotTable' + @whereidSede;
	
	IF @idMateria <> 0
		BEGIN
			--SET @condizione = CASE WHEN @idSede = 0 THEN ' WHERE ' ELSE ' AND ' END 
			SET @SQLString = @SQLString + ' AND idMateria = ' + CAST(@idMateria AS varchar) 
		END
	--PRINT @SQLString
	EXEC(@SQLString);
			
END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportStudenti]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportStudenti]

@spRead varchar(1),
@tabella varchar(1)

AS

BEGIN
	SET NOCOUNT ON;

	(
	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, nomeStud, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), idStudente, nomeStud
	)

	UNION

	(
	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, 'TOTALE MESE' AS nomeStud, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta)
	)
	
	ORDER BY YEAR(dataOfferta),  MONTH(dataOfferta), NumLez 

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportStudentiMateria]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportStudentiMateria]

AS

BEGIN
	SET NOCOUNT ON;

	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, nomeStud, materia, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta = 3 

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), nomeStud, materia
	ORDER BY nomeStud, materia

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportStudentiOfferta]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportStudentiOfferta]

AS

BEGIN
	SET NOCOUNT ON;

	SELECT YEAR(dataOfferta) AS Anno, MONTH(dataOfferta) AS Mese, idStatusOfferta, statusOfferta, nomeStud, count(*) AS NumLez 
	FROM pf_pianoOfferteVista
	WHERE idStatusOfferta < 10 AND YEAR(dataOfferta) = 2018 AND MONTH(dataOfferta) = 3 AND idStudente > 0

	GROUP BY YEAR(dataOfferta),  MONTH(dataOfferta), idStatusOfferta, statusOfferta, nomeStud
	ORDER BY idStatusOfferta, nomeStud

END
GO
/****** Object:  StoredProcedure [dbo].[pf_reportStudentiRegistro]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_reportStudentiRegistro]

@idRS int,
@idStudente int,

@spRead varchar(1),
@tabella varchar(1),
@idSede int

AS

BEGIN
	SET NOCOUNT ON;

	SELECT idStudente, CONVERT(varchar(10), dataOfferta, 105) AS dataOfferta, dataOfferta AS dataOffertaAMG, materia, nomeProf, argomentoOfferta, notaOfferta
	FROM pf_pianoOfferteVista 
	WHERE idStudente = @idStudente AND idStatusOfferta = 3 AND idRS = @idRS
	ORDER BY materia, dataOffertaAMG

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statIstitutoAnno]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statIstitutoAnno]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZZ', @idSede)

	(
	SELECT istitutoTipo, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
			FROM (SELECT istitutoTipo, anno 
					FROM [pf_pianoOfferteReportVista]
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin COLLATE Latin1_General_CS_AS AND idSede <= @idSedeMax COLLATE Latin1_General_CS_AS AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statMaterieAnno]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statMaterieAnno]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZZ', @idSede)

	(
	SELECT idMateria, materia, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
			FROM (SELECT idMateria, materia, anno 
					FROM [pf_pianoOfferteReportVista] 
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin COLLATE Latin1_General_CS_AS AND idSede <= @idSedeMax COLLATE Latin1_General_CS_AS AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable			
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statOrigineStudentiAnno]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statOrigineStudentiAnno]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)


AS

--DECLARE
--@idSedeMin int = 0,
--@idSedeMax int = 0

BEGIN
	SET NOCOUNT ON;
	SET @idSede = IIF(@idSede = '0', '', @idSede)
	--SET @idSedeMin = IIF(LEN(@idSede) > 1, '', @idSede)
	--SET @idSedeMax = IIF(LEN(@idSede) > 1, '', @idSede)

	(
	--SELECT idOrigineStud, origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM (SELECT idOrigineStud, origineStud, anno 
	--				FROM [pf_pianoOfferteVista] 
	--				WHERE idStatusOfferta = 3 AND @idSede LIKE('%' + @idSede +'%') ) AS sourceTable --idSede >= @idSedeMin AND idSede <= @idSedeMax
	--				PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
					
	SELECT origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1]+[2]+[3]+[4]+[5] AS Totale 
			FROM (SELECT idOrigineStud, origineStud, anno 
					FROM pf_anagrafeStudentiVista 
					WHERE deleted = 0 AND sediStud LIKE('%' + @idSede +'%') AND idRS = @idRS ) AS sourcePV
					PIVOT (count(anno) FOR anno IN ([1],[2],[3], [4], [5])) AS tablePV
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statOrigineStudentiAnno_Erogate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statOrigineStudentiAnno_Erogate]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)


AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZ', @idSede)

	(
	SELECT idOrigineStud, origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
			FROM (SELECT idOrigineStud, origineStud, anno 
					FROM [pf_pianoOfferteVista] 
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND idSede <= @idSedeMax AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable			
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statSpecialStudentiAnno]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statSpecialStudentiAnno]

@idRS int,
@idSede varchar(3),

@spRead varchar(1),
@tabella varchar(1)


AS

--DECLARE
--@idSedeMin int = 0,
--@idSedeMax int = 0

BEGIN
	SET NOCOUNT ON;
	SET @idSede = IIF(@idSede = '0', '', @idSede)
	--SET @idSedeMin = IIF(LEN(@idSede) > 1, '', @idSede)
	--SET @idSedeMax = IIF(LEN(@idSede) > 1, '', @idSede)

	(
	--SELECT idOrigineStud, origineStud, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM (SELECT idOrigineStud, origineStud, anno 
	--				FROM [pf_pianoOfferteVista] 
	--				WHERE idStatusOfferta = 3 AND @idSede LIKE('%' + @idSede +'%') ) AS sourceTable --idSede >= @idSedeMin AND idSede <= @idSedeMax
	--				PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
					
	SELECT special, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1]+[2]+[3]+[4]+[5] AS Totale 
			FROM (SELECT idSpecial, special, anno 
					FROM pf_anagrafeStudentiVista 
					WHERE deleted = 0 AND sediStud LIKE('%' + @idSede +'%') AND idRS = @idRS ) AS sourcePV
					PIVOT (count(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS tablePV
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statSpecialStudentiAnno_Erogate]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statSpecialStudentiAnno_Erogate]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)


AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZ', @idSede)

	(
	SELECT idSpecial, special, [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
			FROM (SELECT idSpecial, special, anno 
					FROM [pf_pianoOfferteVista] 
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND idSede <= @idSedeMax AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable			
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
/****** Object:  StoredProcedure [dbo].[pf_statTipoProfMaterie]    Script Date: 26/07/2020 09:13:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pf_statTipoProfMaterie]

@idRS int,
@idSede varchar(1),

@spRead varchar(1),
@tabella varchar(1)

AS

DECLARE
@idSedeMin varchar(1) = '0',
@idSedeMax varchar(1) = '0'

BEGIN
	SET NOCOUNT ON;
	SET @idSedeMin = IIF(@idSede = '0', '0', @idSede)
	SET @idSedeMax = IIF(@idSede = '0', 'ZZZZ', @idSede)

	(
	SELECT idMateria, materia, [0] AS Altro, [1] AS Attivo, [2] AS Pensione, [3] AS Studente, [0] + [1] + [2] + [3] AS Totale
			FROM (SELECT idMateria, materia, idTipoProf 
					FROM [pf_pianoOfferteReportVista] 
					WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin COLLATE Latin1_General_CS_AS AND idSede <= @idSedeMax COLLATE Latin1_General_CS_AS AND idRS = @idRS) AS sourceTable 
					PIVOT (COUNT(idTipoProf) FOR idTipoProf IN ([0], [1], [2], [3])) AS pivotTable			
	)

	--UNION

	--(
	--SELECT '9999' AS idMateria, 'TOTALE' AS materia,  [1] AS Primo, [2] AS Secondo, [3] AS Terzo, [4] AS Quarto, [5] AS Quinto, [1] + [2] + [3] + [4] + [5] AS Totale
	--		FROM  (SELECT anno FROM [pf_pianoOfferteVista] 
	--		WHERE idStatusOfferta = 3 AND idSede >= @idSedeMin AND @idSede <= @idSedeMax) AS sourceTable PIVOT (COUNT(anno) FOR anno IN ([1], [2], [3], [4], [5])) AS pivotTable
	--)

	ORDER BY Totale DESC

END
GO
