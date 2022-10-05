USE [MSSqlProfWeb30]
GO
/****** Object:  Table [dbo].[admAssemblee]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admAssemblee](
	[idAss] [int] IDENTITY(1,1) NOT NULL,
	[idTipoAss] [varchar](1) NOT NULL,
	[dataAss] [date] NOT NULL,
	[oraAss] [varchar](5) NOT NULL,
	[luogoAss] [varchar](100) NOT NULL,
	[indirizzoAss] [varchar](200) NOT NULL,
	[oggettoAss] [varchar](200) NOT NULL,
	[odgAss] [varchar](max) NOT NULL,
	[dataInvio] [date] NULL,
	[inviata] [bit] NOT NULL,
	[straord] [bit] NOT NULL,
	[send] [varchar](100) NULL,
	[conferma] [varchar](100) NULL,
	[idRS] [int] NOT NULL,
 CONSTRAINT [PK_pf_pianoAssemblee] PRIMARY KEY CLUSTERED 
(
	[dataAss] ASC,
	[idTipoAss] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admCassaCausali]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admCassaCausali](
	[idCausale] [int] IDENTITY(1,1) NOT NULL,
	[idCat] [int] NOT NULL,
	[idSottCat] [int] NOT NULL,
	[descCausale] [varchar](250) NOT NULL,
	[segno] [int] NOT NULL,
	[ruolo] [varchar](4) NOT NULL,
	[banca] [varchar](1) NOT NULL,
	[giro] [int] NOT NULL,
 CONSTRAINT [PK_admCassaCausali_1] PRIMARY KEY CLUSTERED 
(
	[segno] DESC,
	[idCat] ASC,
	[idSottCat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admCassaDocumento]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admCassaDocumento](
	[idDoc] [int] IDENTITY(1,1) NOT NULL,
	[descDoc] [varchar](50) NOT NULL,
	[segno] [int] NOT NULL,
 CONSTRAINT [PK_admCassaDocumento] PRIMARY KEY CLUSTERED 
(
	[segno] ASC,
	[descDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admCassaMovimenti]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admCassaMovimenti](
	[idRS] [int] NOT NULL,
	[idMov] [int] IDENTITY(1,1) NOT NULL,
	[idProg] [varchar](10) NOT NULL,
	[idCausale] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idTipoCassa] [varchar](1) NOT NULL,
	[dataMov] [date] NOT NULL,
	[importoMov] [float] NOT NULL,
	[soggettoMov] [varchar](200) NOT NULL,
	[codiceFiscaleMov] [varchar](16) NULL,
	[deletedMov] [bit] NOT NULL,
	[notaMov] [varchar](300) NULL,
	[idUtente] [int] NOT NULL,
	[timeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_admBilancio] PRIMARY KEY CLUSTERED 
(
	[idMov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admOrigine]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admOrigine](
	[idOrigineStud] [int] IDENTITY(0,1) NOT NULL,
	[origineStud] [varchar](50) NOT NULL,
 CONSTRAINT [PK_admOrigine] PRIMARY KEY CLUSTERED 
(
	[origineStud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admRuoli]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admRuoli](
	[idRuolo] [int] IDENTITY(1,1) NOT NULL,
	[ruolo] [varchar](30) NOT NULL,
	[admin] [bit] NOT NULL,
	[gestione] [bit] NOT NULL,
	[modifica] [bit] NOT NULL,
	[lettura] [bit] NOT NULL,
 CONSTRAINT [PK_admRuoli] PRIMARY KEY CLUSTERED 
(
	[idRuolo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admService]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admService](
	[idSer] [int] NOT NULL,
	[servizio] [varchar](50) NOT NULL,
	[utente] [varchar](300) NOT NULL,
	[pw] [varchar](300) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admTipoAss]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admTipoAss](
	[idTipoAss] [varchar](1) NOT NULL,
	[tipoAss] [varchar](50) NOT NULL,
 CONSTRAINT [PK_pf_admTipoAss] PRIMARY KEY CLUSTERED 
(
	[tipoAss] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admTipoProf]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admTipoProf](
	[idTipoProf] [int] IDENTITY(0,1) NOT NULL,
	[tipoProf] [varchar](50) NOT NULL,
 CONSTRAINT [PK_pf_parTipoProf] PRIMARY KEY CLUSTERED 
(
	[tipoProf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admTipoSocio]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admTipoSocio](
	[idTipoSocio] [int] NOT NULL,
	[tipoSocio] [varchar](50) NOT NULL,
 CONSTRAINT [PK_admTipoSocio] PRIMARY KEY CLUSTERED 
(
	[idTipoSocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admUtenti]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admUtenti](
	[idRS] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cognome] [varchar](100) NOT NULL,
	[nome] [varchar](100) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[emailUser] [varchar](255) NOT NULL,
	[dataNascitaUser] [date] NULL,
	[luogoNascitaUser] [varchar](100) NULL,
	[codiceFiscaleUser] [varchar](16) NULL,
	[indirizzoUser] [varchar](255) NULL,
	[comuneUser] [varchar](100) NULL,
	[provUser] [varchar](2) NULL,
	[capUser] [varchar](5) NULL,
	[tel1User] [varchar](20) NULL,
	[tel2User] [varchar](20) NULL,
	[cambiaPassword] [bit] NOT NULL,
	[scadenza] [date] NOT NULL,
	[registra] [date] NOT NULL,
	[ultimo] [date] NOT NULL,
	[attivo] [bit] NOT NULL,
	[idRuolo] [int] NOT NULL,
	[idTipoSocioUser] [int] NOT NULL,
	[privacyUser] [bit] NOT NULL,
	[liberaUser] [bit] NOT NULL,
	[firmaUser] [bit] NOT NULL,
	[firmaDataUser] [date] NULL,
	[checkCode] [int] NULL,
	[emailCheck] [bit] NOT NULL,
	[sediUser] [varchar](9) NOT NULL,
	[versione] [varchar](5) NOT NULL,
	[dataVersione] [date] NOT NULL,
 CONSTRAINT [PK_admUtenti] PRIMARY KEY CLUSTERED 
(
	[emailUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_anagrafeIstituti]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_anagrafeIstituti](
	[idRS] [int] NOT NULL,
	[CODICEISTITUTO] [int] IDENTITY(1,1) NOT NULL,
	[CODICE] [varchar](10) NULL,
	[ISTITUTO] [varchar](50) NOT NULL,
	[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA] [varchar](60) NOT NULL,
	[INDIRIZZO] [varchar](50) NOT NULL,
	[CAP] [varchar](5) NOT NULL,
	[COMUNE] [varchar](50) NOT NULL,
	[PROVINCIA] [varchar](50) NOT NULL,
	[REGIONE] [varchar](50) NOT NULL,
	[INDIRIZZOEMAILSCUOLA] [varchar](40) NULL,
	[INDIRIZZOPECSCUOLA] [varchar](40) NULL,
	[SITOWEBSCUOLA] [varchar](50) NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_pf_anagrafeIstituti] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA] ASC,
	[ISTITUTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_anagrafeProfessori]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_anagrafeProfessori](
	[idRS] [int] NOT NULL,
	[idProfessore] [int] IDENTITY(1,1) NOT NULL,
	[nomeProf] [varchar](200) NOT NULL,
	[emailProf] [varchar](200) NOT NULL,
	[tel1Prof] [varchar](20) NOT NULL,
	[tel2Prof] [varchar](20) NULL,
	[indirizzoProf] [varchar](200) NULL,
	[comuneProf] [varchar](100) NOT NULL,
	[provProf] [varchar](2) NOT NULL,
	[capProf] [varchar](5) NOT NULL,
	[codiceFiscaleProf] [varchar](16) NULL,
	[notaProf] [varchar](255) NULL,
	[dataCreate] [date] NOT NULL,
	[dataUpdate] [date] NOT NULL,
	[dataNascitaProf] [date] NULL,
	[luogoNascitaProf] [varchar](200) NULL,
	[idTipoSocioProf] [int] NOT NULL,
	[idTipoProf] [int] NOT NULL,
	[deleted] [bit] NOT NULL,
	[privacyProf] [bit] NOT NULL,
	[liberaProf] [bit] NOT NULL,
	[firmaProf] [bit] NOT NULL,
	[firmaDataProf] [date] NULL,
	[emailCheck] [bit] NOT NULL,
	[checkCode] [int] NULL,
	[sediProf] [varchar](9) NOT NULL,
	[materiaProf] [varchar](max) NULL,
	[lezioniPrenotate] [varchar](max) NULL,
	[versione] [varchar](5) NOT NULL,
	[dataVersione] [date] NOT NULL,
 CONSTRAINT [PK_pf_anagrafeProfessori] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[nomeProf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_anagrafeStudenti]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_anagrafeStudenti](
	[idRS] [int] NOT NULL,
	[idStudente] [int] IDENTITY(1,1) NOT NULL,
	[nomeStud] [varchar](200) NOT NULL,
	[emailStud] [varchar](200) NOT NULL,
	[dataNascitaStud] [date] NULL,
	[luogoNascitaStud] [varchar](200) NULL,
	[codiceFiscaleStud] [varchar](16) NULL,
	[codiceFiscaleGen] [varchar](16) NULL,
	[indirizzoStud] [varchar](200) NULL,
	[comuneStud] [varchar](100) NULL,
	[provStud] [varchar](2) NULL,
	[capStud] [varchar](5) NULL,
	[tel1Stud] [varchar](20) NULL,
	[tel2Stud] [varchar](20) NULL,
	[idIstituto] [int] NULL,
	[anno] [varchar](1) NULL,
	[idSpecial] [int] NOT NULL,
	[notaStud] [varchar](255) NULL,
	[dataCreate] [date] NOT NULL,
	[dataUpdate] [date] NOT NULL,
	[deleted] [bit] NOT NULL,
	[privacyStud] [bit] NULL,
	[liberaStud] [bit] NULL,
	[firmaStud] [bit] NULL,
	[firmaDataStud] [date] NULL,
	[emailCheck] [bit] NULL,
	[checkCode] [int] NULL,
	[sediStud] [varchar](9) NULL,
	[versione] [varchar](5) NOT NULL,
	[dataVersione] [date] NOT NULL,
	[idOrigineStud] [int] NOT NULL,
	[regolamentoStud] [bit] NOT NULL,
 CONSTRAINT [PK_pf_anagrafeStudenti] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[nomeStud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parAssociazioni]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parAssociazioni](
	[idRS] [int] IDENTITY(1,1) NOT NULL,
	[ragioneSociale] [varchar](200) NOT NULL,
	[sedeLegaleIndirizzo] [varchar](300) NULL,
	[sedeLegaleLuogo] [varchar](300) NULL,
	[sedeLegalePR] [varchar](2) NULL,
	[sedeLegaleCAP] [varchar](5) NULL,
	[sedeLegaleTEL1] [varchar](20) NOT NULL,
	[sedeLegaleTEL2] [varchar](20) NULL,
	[sedeLegaleEmail] [varchar](300) NOT NULL,
	[sedeLegalePEC] [varchar](300) NULL,
	[sedeLegaleCF] [varchar](20) NOT NULL,
	[registroNR] [varchar](10) NULL,
	[registroData] [date] NULL,
	[sedeLegaleLogo] [varchar](500) NULL,
	[imgPath] [varchar](200) NULL,
	[deletedAss] [bit] NOT NULL,
 CONSTRAINT [PK_pf_parLuogo] PRIMARY KEY CLUSTERED 
(
	[ragioneSociale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parAule]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parAule](
	[idSede] [int] NOT NULL,
	[idAula] [int] IDENTITY(1,1) NOT NULL,
	[aula] [varchar](30) NOT NULL,
	[posti] [int] NOT NULL,
 CONSTRAINT [PK_pf_parAula] PRIMARY KEY CLUSTERED 
(
	[aula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parCalendario]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parCalendario](
	[idSede] [varchar](1) NOT NULL,
	[giorno] [date] NOT NULL,
	[attivo] [int] NOT NULL,
	[giornoSettimana]  AS (datepart(weekday,[giorno])),
	[nomeGiorno]  AS (datename(weekday,[giorno])),
	[settimana]  AS (datepart(week,[giorno])),
	[anno]  AS (datepart(year,[giorno])),
	[mese]  AS (datepart(month,[giorno])),
 CONSTRAINT [PK_pf_parCalendario] PRIMARY KEY CLUSTERED 
(
	[idSede] ASC,
	[giorno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parFestivi]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parFestivi](
	[inizio] [smallint] NOT NULL,
	[mm] [smallint] NOT NULL,
	[gg] [smallint] NOT NULL,
	[aa] [smallint] NULL,
	[dataFestivo] [date] NULL,
	[giornoSettimanaFestivo] [smallint] NULL,
	[ponteFestivo] [smallint] NULL,
	[la] [bit] NOT NULL,
 CONSTRAINT [PK_pf_parFestivi_1] PRIMARY KEY CLUSTERED 
(
	[inizio] ASC,
	[mm] ASC,
	[gg] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parFrequenza]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parFrequenza](
	[frequenza] [varchar](1) NOT NULL,
	[frequenzaSet] [int] NOT NULL,
 CONSTRAINT [PK_pf_parFrequenza] PRIMARY KEY CLUSTERED 
(
	[frequenza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parGiorni]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parGiorni](
	[idGiorno] [int] NOT NULL,
	[giorno] [varchar](10) NOT NULL,
	[ore] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parMaterie]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parMaterie](
	[idMateria] [int] IDENTITY(1,1) NOT NULL,
	[materia] [varchar](200) NOT NULL,
	[idGruppo] [int] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_pf_parMaterie] PRIMARY KEY CLUSTERED 
(
	[idGruppo] ASC,
	[materia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parMaterieGruppo]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parMaterieGruppo](
	[idGruppo] [int] IDENTITY(1,1) NOT NULL,
	[gruppo] [varchar](20) NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_pf_parMaterieGruppo] PRIMARY KEY CLUSTERED 
(
	[gruppo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parOrari]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parOrari](
	[idSede] [varchar](1) NOT NULL,
	[idOrario]  AS (CONVERT([varchar](1),[idGiorno])+CONVERT([varchar](1),[idOra])) PERSISTED,
	[idGiorno] [int] NOT NULL,
	[idOra] [int] NOT NULL,
	[impegno] [bit] NOT NULL,
 CONSTRAINT [PK_pf_parOrari] PRIMARY KEY CLUSTERED 
(
	[idSede] ASC,
	[idGiorno] ASC,
	[idOra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parOrdinali]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parOrdinali](
	[idOra] [int] NOT NULL,
	[ordinale] [varchar](10) NOT NULL,
 CONSTRAINT [PK_pf_parOreOrdinali] PRIMARY KEY CLUSTERED 
(
	[idOra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parOre]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parOre](
	[idRS] [int] NOT NULL,
	[idSede] [varchar](1) NOT NULL,
	[idOra] [int] NOT NULL,
	[ora] [time](0) NOT NULL,
 CONSTRAINT [PK_pf_parOre] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[idSede] ASC,
	[idOra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parSedi]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parSedi](
	[idRS] [int] NOT NULL,
	[idSede] [varchar](1) NOT NULL,
	[descrizioneSede] [varchar](200) NOT NULL,
	[indirizzoSede] [varchar](250) NOT NULL,
	[luogoSede] [varchar](200) NOT NULL,
	[capSede] [varchar](5) NOT NULL,
	[provSede] [varchar](2) NOT NULL,
	[tel1Sede] [varchar](50) NULL,
	[tel2Sede] [varchar](50) NULL,
	[emailSede] [varchar](255) NULL,
	[imgPath] [varchar](200) NOT NULL,
	[imgFile] [varchar](200) NOT NULL,
	[deleted] [int] NOT NULL,
 CONSTRAINT [PK_pf_parSedi] PRIMARY KEY CLUSTERED 
(
	[descrizioneSede] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parSpecial]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parSpecial](
	[idSpecial] [int] IDENTITY(1,1) NOT NULL,
	[special] [varchar](50) NOT NULL,
 CONSTRAINT [PK_pf_parSpecial] PRIMARY KEY CLUSTERED 
(
	[special] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parStatusOfferte]    Script Date: 26/07/2020 09:00:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parStatusOfferte](
	[idStatusOfferta] [int] IDENTITY(1,1) NOT NULL,
	[statusOfferta] [varchar](100) NOT NULL,
	[wfOfferta] [varchar](8) NOT NULL,
	[insertZero] [bit] NOT NULL,
	[idStatusOffertaFinale] [int] NOT NULL,
	[badLog] [bit] NOT NULL,
	[annullaAttesa] [bit] NOT NULL,
	[report] [bit] NULL,
 CONSTRAINT [PK_pf_parStatusRichieste] PRIMARY KEY CLUSTERED 
(
	[idStatusOfferta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_pianoLezioni]    Script Date: 26/07/2020 09:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_pianoLezioni](
	[idSede] [varchar](1) NOT NULL,
	[idLezione] [int] IDENTITY(1,1) NOT NULL,
	[idProfessore] [int] NOT NULL,
	[idMateria] [int] NOT NULL,
	[idOrario] [int] NOT NULL,
	[anni] [varchar](5) NOT NULL,
	[frequenza] [varchar](1) NOT NULL,
	[dataCreazione] [date] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_pf_pianoLezioni] PRIMARY KEY CLUSTERED 
(
	[idSede] ASC,
	[idProfessore] ASC,
	[idMateria] ASC,
	[idOrario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_pianoOfferte]    Script Date: 26/07/2020 09:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_pianoOfferte](
	[idRS] [int] NOT NULL,
	[idOfferta] [int] IDENTITY(1,1) NOT NULL,
	[idSede] [varchar](1) NOT NULL,
	[idLezione] [int] NOT NULL,
	[idProfessore] [int] NOT NULL,
	[idMateria] [int] NOT NULL,
	[idOrario] [int] NOT NULL,
	[dataOfferta] [date] NOT NULL,
	[idStudente] [int] NOT NULL,
	[idStatusOfferta] [int] NOT NULL,
	[gruppoStud] [bit] NOT NULL,
	[anni] [varchar](5) NOT NULL,
	[frequenza] [varchar](1) NOT NULL,
	[attivo] [bit] NOT NULL,
	[notaOfferta] [varchar](max) NULL,
	[argomentoOfferta] [varchar](max) NULL,
 CONSTRAINT [PK_pf_pianoOfferte] PRIMARY KEY CLUSTERED 
(
	[idSede] ASC,
	[idLezione] ASC,
	[idProfessore] ASC,
	[idMateria] ASC,
	[idOrario] ASC,
	[dataOfferta] ASC,
	[idStudente] ASC,
	[idStatusOfferta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_pianoRichieste]    Script Date: 26/07/2020 09:00:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_pianoRichieste](
	[idRichiesta] [int] IDENTITY(1,1) NOT NULL,
	[idSede] [int] NOT NULL,
	[idStudente] [int] NOT NULL,
	[idMateria] [int] NOT NULL,
	[dataRichiesta] [date] NOT NULL,
	[idStatusOfferta] [int] NOT NULL,
	[notaRichiesta] [varchar](200) NULL,
	[idOfferta] [int] NOT NULL,
 CONSTRAINT [PK_pf_pianoRichieste_1] PRIMARY KEY CLUSTERED 
(
	[idSede] ASC,
	[idStudente] ASC,
	[idMateria] ASC,
	[dataRichiesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admAssemblee] ON 
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (5, N'D', CAST(N'2019-06-27' AS Date), N'19-00', N'PALERMO', N'VIA CAMPOLO 11', N'ORGANIZZAZIONE ESTIVA', N'<ol><li><span style="font-weight: bold;">APPROVAZIONE </span>ODG </li><li>nuova sede</li><li>orari di apertura</li></ol><div>firma</div>', CAST(N'2019-07-05' AS Date), 1, 0, NULL, N'', 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (4, N'S', CAST(N'2019-07-10' AS Date), N'18-30', N'PALERMO', N'VIA CAMPOLO 11', N'CONVOCAZIONE ASSEMBLEA ANNUALE SOCI', N'<h2>la vita è <span style="font-weight: bold;">soltanto:</span></h2><div><ul><li>uno</li><li><span style="color: rgb(255, 0, 0);">due</span></li><li>tre3</li><li><span style="font-weight: bold;">quattro</span></li><li>cinque</li></ul></div>', CAST(N'2019-07-07' AS Date), 1, 1, NULL, N'', 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (2, N'D', CAST(N'2019-07-16' AS Date), N'11-30', N'PALERMO', N'VIA CAMPOLO', N'CONVOCAZIONE DIRETTIVO', N'<div style="text-align: center;"><span style="font-size: xx-large; font-weight: bold;">APERTURA SUMMER SCHOOL</span></div><div style="text-align: center;"><br></div><div style="">VALORI DI <span style="font-style: italic;">DISPERSIONE </span><span style="font-weight: bold;">altra&nbsp;</span></div>', CAST(N'2019-07-07' AS Date), 1, 0, NULL, NULL, 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (1, N'S', CAST(N'2019-07-16' AS Date), N'11-58', N'PALERMO', N'VIA CAMPOLO 11', N'CONVOCAZIONE ASSEMBLEA STRAORDINARIA SOCI', N'elenco cose da fare:<div><ol><li>prima cosa da fare</li><li>seconda <span style="font-weight: bold; background-color: rgb(255, 255, 0);">cosa </span>da fare</li><li><span style="font-weight: bold;">terza cosa da fare</span></li><li>altro livello</li></ol></div>', CAST(N'2019-07-04' AS Date), 1, 0, NULL, N'', 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (7, N'D', CAST(N'2019-07-31' AS Date), N'18-30', N'MOSCA', N'PIAZZA ROSSA', N'FORMAZIONE CULTURALE SUMMER SCHOOL', N'<ol><li>IL GIOCO DEL <span style="font-weight: bold;">POTERE</span></li><li>LA RESISTENZA INUTILE</li><li>STUDIARE SENZA UN perché</li></ol><div><br></div>', CAST(N'2019-07-07' AS Date), 1, 0, NULL, N'', 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (6, N'S', CAST(N'2019-07-31' AS Date), N'20-00', N'MONDELLO VALDESI', N'PIAZZA DELLA TORRE', N'PROGRAMMAZIONE ANNUALE', N'Valutazione della didattica marina:<div><ol><li><span style="font-weight: bold;">matematica</span></li><li>fisica</li><li>inglese</li><li>latino</li></ol></div>', CAST(N'2019-07-06' AS Date), 1, 0, NULL, NULL, 1)
GO
INSERT [dbo].[admAssemblee] ([idAss], [idTipoAss], [dataAss], [oraAss], [luogoAss], [indirizzoAss], [oggettoAss], [odgAss], [dataInvio], [inviata], [straord], [send], [conferma], [idRS]) VALUES (8, N'S', CAST(N'2019-08-13' AS Date), N'20-30', N'PALM BEACH', N'VIA DEL TRAMONTO 11', N'CALDO IMPORTANTE', N'<ol><li><span style="font-weight: bold;">controllo operazioni;</span></li><li>vista <span style="font-style: italic;">notturna</span></li></ol>', NULL, 0, 0, N'', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[admAssemblee] OFF
GO
SET IDENTITY_INSERT [dbo].[admCassaCausali] ON 
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (45, 2, 0, N'CONTRIBUTI INGRESSO', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (1, 2, 1, N'CONTRIBUTI PER PROGETTI E/O ATTIVITA (art. 5 L. 266/91)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (72, 3, 0, N'CONTRIBUTI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (2, 3, 1, N'QUOTA ASSOCIATIVA ANNUALE DA SOCI ', 1, N'12', N'1', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (3, 3, 2, N'EROGAZIONI LIBERALI DA NON SOCI', 1, N'123', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (4, 3, 3, N'CONTRIBUTI DA CSV E COMITATO DI GESTIONE', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (5, 3, 4, N'CONTRIBUTI  DA ENTI PUBBLICI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (6, 3, 5, N'CONTRIBUTI DA COMUNITÀ EUROPEA E DA ALTRI ORGANISMI INTERNAZIONALI ', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (7, 3, 6, N'CONTRIBUTI DA ALTRE OdV', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (8, 3, 7, N'CONTRIBUTI DAL CINQUE PER MILLE', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (9, 3, 8, N'CONTRIBUTI ALTRO ', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (46, 4, 0, N'DONAZIONI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (10, 4, 1, N'DONAZIONI DA SOCI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (11, 4, 2, N'DONAZIONI DA NON SOCI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (47, 5, 0, N'RIMBORSI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (12, 5, 1, N'RIMBORSI DERIVANTI DA CONVENZIONI CON ENTI PUBBLICI - ART. 5 L.266/91', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (48, 6, 0, N'ENTRATE DA ATTIVITÀ', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (13, 6, 1, N'ENTRATE DA ATTIVITÀ DI VENDITE OCCASIONALI O INIZIATIVE OCCASIONALI DI SOLIDARIETÀ (D.M. 1995 LETT.A) ES.EVENTI, CASSETTINA OFFERTE, TOMBOLE, SPETTACOLI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (14, 6, 2, N'ENTRATE DA ATTIVITÀ DI VENDITA DI BENI ACQUISITI DA TERZI A TITOLO GRATUITO A FINI DI SOVVENZIONE  (D.M. 1995 LETT.B)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (15, 6, 3, N'ENTRATE DA ATTIVITÀ DI SOMMINISTRAZIONE DI ALIMENTI E BEVANDE IN OCCASIONE DI MANIFESTAZIONI E SIMILI A CARATTERE OCCASIONALE  (D.M. 1995 LETT.D)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (49, 7, 0, N'ENTRATE DA SERVIZI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (16, 7, 1, N'ENTRATE DA CESSIONE DI BENI PRODOTTI DAGLI ASSISTITI E DAI VOLONTARI SEMPRECHÉ LA VENDITA DEI PRODOTTI SIA CURATA DIRETTAMENTE DALL''ORGANIZZAZIONE SENZA ALCUN INTERMEDIARIO (D.M. 1995 LETT.C)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (17, 7, 2, N'ENTRATE DA ATTIVITÀ DI PRESTAZIONE DI SERVIZI RESE IN CONFORMITÀ ALLE FINALITÀ ISTITUZIONALI, NON RICONDUCIBILI NELL''AMBITO APPLICATIVO DELL''ART. 111, COMMA 3 (D.M. 1995 LETT. E)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (50, 8, 0, N'RENDITE', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (18, 8, 1, N'RENDITE PATRIMONIALI (FITTI,…)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (19, 8, 2, N'RENDITE FINANZIARIE (INTERESSI, DIVIDENDI)', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (20, 8, 3, N'ALTRO: SPECIFICARE ', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (51, 9, 0, N'ANTICIPAZIONI', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (21, 9, 1, N'ANTICIPAZIONI DI CASSA', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (52, 10, 0, N'PARTITE DI GIRO ENTRATE', 1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (22, 10, 1, N'GIROCONTO DA BANCA A CASSA', 1, N'12', N'2', 75)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (74, 10, 2, N'GIROCONTO DA CASSA A BANCA', 1, N'12', N'1', 44)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (73, 1, 0, N'RIMBORSI SPESE', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (23, 1, 1, N'RIMBORSI SPESE AI VOLONTARI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (53, 2, 0, N'ASSICURAZIONI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (24, 2, 1, N'ASSICURAZIONE VOLONTARI - ART. 4 L.266/90', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (25, 2, 2, N'ASSICURAZIONI ALTRE: ES. VEICOLI, IMMOBILI ...', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (54, 3, 0, N'PERSONALE', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (26, 3, 1, N'PERSONALE DIPENDENTI ', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (27, 3, 2, N'PERSONALE ATIPICI E OCCASIONALI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (28, 3, 3, N'CONSULENTI ', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (55, 4, 0, N'ACQUISTI DI SERVIZI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (29, 4, 1, N'ACQUISTI DI SERVIZI  (MANUTENZIONE, TRASPORTI, SERVICE, CONSULENZA FISCALE...)', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (30, 5, 0, N'UTENZE ', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (56, 5, 1, N'LUCE, ACQUA, GAS, TELEFONIA, ETC...', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (57, 6, 0, N'MATERIALE DI CONSUMO', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (31, 6, 1, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER STRUTTURA OdV', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (32, 6, 2, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER ATTIVITÀ', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (33, 6, 3, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER SOGGETTI SVANTAGGIATI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (58, 7, 0, N'GODIMENTO BENI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (34, 7, 1, N'GODIMENTO BENI DI TERZI (AFFITTI, NOLEGGIO ATTREZZATURE, DIRITTI SIAE,....)', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (59, 8, 0, N'ONERI FINANZIARI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (35, 8, 1, N'ONERI FINANZIARI E PATRIMONIALI (INTERESSI PASSIVI SU MUTUI, PRESTITI, C/C BANCARIO…)', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (60, 9, 0, N'BENI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (36, 9, 1, N'BENI DUREVOLI ', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (62, 10, 0, N'IMPOSTE', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (37, 10, 1, N'IMPOSTE E TASSE', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (63, 11, 0, N'FUNDRAISING', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (38, 11, 1, N'RACCOLTE FONDI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (66, 12, 0, N'CONTRIBUTI VERSO TERZI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (39, 12, 1, N'CONTRIBUTI A SOGGETTI SVANTAGGIATI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (40, 12, 2, N'QUOTE ASSOCIATIVE A FEDERAZIONE OdV - MILANO', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (41, 12, 3, N'VERSATE AD ALTRE OdV', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (42, 12, 4, N'ORGANIZZAZIONE EVENTI', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (43, 12, 5, N'ALTRO', -1, N'12', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (69, 13, 0, N'PARTITE DI GIRO USCITE', -1, N'X', N'0', 0)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (44, 13, 1, N'GIROCONTO DA CASSA A BANCA', -1, N'X', N'1', 74)
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca], [giro]) VALUES (75, 13, 2, N'GIROCONTO DA BANCA A CASSA', -1, N'X', N'2', 22)
GO
SET IDENTITY_INSERT [dbo].[admCassaCausali] OFF
GO
SET IDENTITY_INSERT [dbo].[admCassaDocumento] ON 
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (3, N'Fattura', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (2, N'Ricevuta Fiscale', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (1, N'Scontrino Fiscale', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (7, N'Giroconto', 0)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (5, N'Ricevuta', 1)
GO
SET IDENTITY_INSERT [dbo].[admCassaDocumento] OFF
GO
SET IDENTITY_INSERT [dbo].[admCassaMovimenti] ON 
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 1, N'1', 3, 5, N'1', CAST(N'2020-01-08' AS Date), 10, N'MACRÌ GABRIELE', N'MCRGRL01R13G273S', 0, N'', 0, CAST(N'2020-02-06T14:48:50.967' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 2, N'2', 3, 5, N'1', CAST(N'2020-01-08' AS Date), 10, N'COSTANTINO PIETRA', N'CSTPTR68B65G273U', 0, N'PER CONTO DI BADALÌ FLORIANA', 0, CAST(N'2020-02-06T14:49:17.653' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 3, N'3', 3, 5, N'1', CAST(N'2020-01-08' AS Date), 10, N'PEZZINO LOREDANA', N'PZZLDN66C65G273W', 0, N'PER CONTO DI MERRA ROBERTO', 0, CAST(N'2020-02-06T14:49:46.047' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 4, N'4', 3, 5, N'1', CAST(N'2020-01-10' AS Date), 10, N'ACCARDI ANTONINO', N'', 0, N'PER CONTO DI SCALICI CHIARA', 0, CAST(N'2020-02-06T14:52:16.423' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 5, N'5', 3, 5, N'1', CAST(N'2020-01-14' AS Date), 10, N'SECHI ANGELA MARIA', N'SCHNLM62M44E974T', 0, N'PER CONTO DI TAORMINA EMILIA', 0, CAST(N'2020-02-06T14:52:44.557' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 6, N'6', 3, 5, N'1', CAST(N'2020-01-14' AS Date), 10, N'CARDACI GIROLAMO', N'CRDGLM76A10G273Y', 0, N'PER CONTO DI CARDACI MATTIA', 0, CAST(N'2020-02-06T14:53:15.070' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 7, N'7', 3, 5, N'1', CAST(N'2020-01-14' AS Date), 10, N'LO BIANCO LUCIA', N'LBNLCU70D61B428S', 0, N'PER CONTO DI MARFIA SHARON', 0, CAST(N'2020-02-06T14:53:44.640' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 8, N'8', 3, 5, N'1', CAST(N'2020-01-17' AS Date), 10, N'AMATO GIUSEPPE', N'', 0, N'PER CONTO DI AMATO DANIELE', 0, CAST(N'2020-02-06T14:54:23.007' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 9, N'9', 3, 5, N'1', CAST(N'2020-01-17' AS Date), 10, N'BONOMO MASSIMILIANO', N'BNMMSM73T05G273J', 0, N'PER CONTO DI BONOMO OLGA ALESSIA', 0, CAST(N'2020-02-06T14:54:54.557' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 10, N'10', 3, 5, N'1', CAST(N'2020-01-22' AS Date), 10, N'SCRIRÈ ALBERTO', N'SCRLRT92P16A479J', 0, N'', 0, CAST(N'2020-02-07T13:03:10.593' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 11, N'11', 3, 5, N'1', CAST(N'2020-01-23' AS Date), 10, N'MARCENÒ MARIA ANTONIETTA', N'MRCMNT72T46G273M', 0, N'', 0, CAST(N'2020-02-07T13:03:51.027' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 12, N'12', 3, 5, N'1', CAST(N'2020-01-27' AS Date), 10, N'NASCA ANTONINO', N'NSCNNN71T26G348S', 0, N'', 0, CAST(N'2020-02-07T13:04:26.033' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 13, N'13', 3, 5, N'1', CAST(N'2020-01-28' AS Date), 10, N'SIRAGO CATERINA', N'SRGCRN70D70A662V', 0, N'', 0, CAST(N'2020-02-07T13:05:01.863' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 14, N'19-12', 32, 1, N'1', CAST(N'2020-01-27' AS Date), 2.1, N'CARTOLERIA DI FURMA GIOVANNI', N'', 0, N'', 0, CAST(N'2020-02-07T13:06:44.763' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 15, N'19-7', 32, 1, N'1', CAST(N'2020-01-27' AS Date), 5.9, N'CARTOLERIA DI FURMA GIOVANNI', N'', 0, N'', 0, CAST(N'2020-02-07T13:07:33.650' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 16, N'14', 3, 5, N'1', CAST(N'2020-01-29' AS Date), 10, N'TUCCIO ROSALIA', N'TCCRSL01B53G273W', 0, N'', 0, CAST(N'2020-02-07T13:08:03.647' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 17, N'15', 3, 5, N'1', CAST(N'2020-01-29' AS Date), 10, N'NOTO LILIANA', N'NTOLLN78C71G273K', 0, N'', 0, CAST(N'2020-02-07T13:08:38.657' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 18, N'16', 3, 5, N'1', CAST(N'2020-01-31' AS Date), 10, N'FRANCO FULVIA', N'FRNFLV67T42G273U', 0, N'', 0, CAST(N'2020-02-07T13:09:01.940' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 19, N'17', 3, 5, N'1', CAST(N'2020-02-04' AS Date), 10, N'PIZZUTO GIOVANNI', N'PZZGNN00M23G273N', 0, N'', 0, CAST(N'2020-02-07T13:09:28.720' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 20, N'18', 3, 5, N'1', CAST(N'2020-02-04' AS Date), 10, N'LOMBARDO MARTINA', N'LMBTTN68H48G273U', 0, N'', 0, CAST(N'2020-02-07T13:09:50.767' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 21, N'19', 3, 5, N'1', CAST(N'2020-02-06' AS Date), 10, N'TORRES DAVIDE', N'TRRDVD71C28G273U', 0, N'', 0, CAST(N'2020-02-07T13:10:16.503' AS DateTime))
GO
INSERT [dbo].[admCassaMovimenti] ([idRS], [idMov], [idProg], [idCausale], [idDoc], [idTipoCassa], [dataMov], [importoMov], [soggettoMov], [codiceFiscaleMov], [deletedMov], [notaMov], [idUtente], [timeStamp]) VALUES (1, 22, N'20', 3, 5, N'1', CAST(N'2020-02-17' AS Date), 10, N'SARDO GANDOLFO', N'SRDGDL70M02Z112B', 0, N'PER SARDO ELVIS', 0, CAST(N'2020-02-17T17:02:32.567' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[admCassaMovimenti] OFF
GO
SET IDENTITY_INSERT [dbo].[admOrigine] ON 
GO
INSERT [dbo].[admOrigine] ([idOrigineStud], [origineStud]) VALUES (1, N'Comunitaria')
GO
INSERT [dbo].[admOrigine] ([idOrigineStud], [origineStud]) VALUES (2, N'ExtraComunitaria')
GO
INSERT [dbo].[admOrigine] ([idOrigineStud], [origineStud]) VALUES (0, N'Italiana')
GO
SET IDENTITY_INSERT [dbo].[admOrigine] OFF
GO
SET IDENTITY_INSERT [dbo].[admRuoli] ON 
GO
INSERT [dbo].[admRuoli] ([idRuolo], [ruolo], [admin], [gestione], [modifica], [lettura]) VALUES (1, N'Amministratore', 1, 1, 1, 1)
GO
INSERT [dbo].[admRuoli] ([idRuolo], [ruolo], [admin], [gestione], [modifica], [lettura]) VALUES (2, N'Gestione', 0, 1, 1, 1)
GO
INSERT [dbo].[admRuoli] ([idRuolo], [ruolo], [admin], [gestione], [modifica], [lettura]) VALUES (3, N'Segreteria', 0, 0, 1, 1)
GO
INSERT [dbo].[admRuoli] ([idRuolo], [ruolo], [admin], [gestione], [modifica], [lettura]) VALUES (4, N'Lettura', 0, 0, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[admRuoli] OFF
GO
INSERT [dbo].[admService] ([idSer], [servizio], [utente], [pw]) VALUES (1, N'sendMail', N'valerio.net@valeriomcse.eu', N'leXv25SYnX675+8vP9qk9Cv7GuCwxj6juf3A/hf4OoI=')
GO
INSERT [dbo].[admService] ([idSer], [servizio], [utente], [pw]) VALUES (2, N'sendSMS', N'valerio.net@valeriomcse.eu', N'3m3XxAonSfwf54Icu+6eVi24xge4NWpmNT6obhRDPGU=')
GO
INSERT [dbo].[admTipoAss] ([idTipoAss], [tipoAss]) VALUES (N'S', N'Assemblea')
GO
INSERT [dbo].[admTipoAss] ([idTipoAss], [tipoAss]) VALUES (N'D', N'Direttivo')
GO
SET IDENTITY_INSERT [dbo].[admTipoProf] ON 
GO
INSERT [dbo].[admTipoProf] ([idTipoProf], [tipoProf]) VALUES (0, N'Altro')
GO
INSERT [dbo].[admTipoProf] ([idTipoProf], [tipoProf]) VALUES (1, N'Professore in Attività')
GO
INSERT [dbo].[admTipoProf] ([idTipoProf], [tipoProf]) VALUES (2, N'Professore in Pensione')
GO
INSERT [dbo].[admTipoProf] ([idTipoProf], [tipoProf]) VALUES (3, N'Studente Universitario')
GO
SET IDENTITY_INSERT [dbo].[admTipoProf] OFF
GO
INSERT [dbo].[admTipoSocio] ([idTipoSocio], [tipoSocio]) VALUES (0, N'Volontario')
GO
INSERT [dbo].[admTipoSocio] ([idTipoSocio], [tipoSocio]) VALUES (1, N'Socio Ordinario')
GO
INSERT [dbo].[admTipoSocio] ([idTipoSocio], [tipoSocio]) VALUES (2, N'Componente Direttivo')
GO
INSERT [dbo].[admTipoSocio] ([idTipoSocio], [tipoSocio]) VALUES (3, N'Presidente')
GO
SET IDENTITY_INSERT [dbo].[admUtenti] ON 
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 9, N'RICHIUSA', N'ANTONIA', N'A.RICHIUSA', N'$2a$12$Fg0j.x19986i9LEeOIcuTuZb7LFZnKdcYsmnpmDC0clVllRzwDI.a', N'A.RICHIUSA@HOTMAIL.IT', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2018-11-24' AS Date), CAST(N'2018-09-25' AS Date), CAST(N'2020-02-10' AS Date), 1, 3, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 380990, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 1, N'AMMINISTRATORE', N'SISTEMA', N'ADMIN', N'$2a$12$Fg0j.x19986i9LEeOIcuTukf8boVDQP4W3f9kw/SoEjOz9megEA2.', N'ADMIN@VALERIOMCSE.EU', CAST(N'2018-01-08' AS Date), N'PALERMO', N'', N'VIALE CROCE ROSSA 25', N'PALERMO', N'PA', N'90144', N'', N'', 0, CAST(N'2018-05-14' AS Date), CAST(N'2016-03-30' AS Date), CAST(N'2020-07-21' AS Date), 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), NULL, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 7, N'MARABELLO', N'ANNA MARIA', N'ANNAMARIAMARABELLO', N'$2a$12$Fg0j.x19986i9LEeOIcuTuKlXWKB9FLhp0b.PUrCJT3cfXW5i7Nmq', N'ANNAMARIAMARABELLO@GMAIL.COM', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2018-08-19' AS Date), CAST(N'2018-06-20' AS Date), CAST(N'2018-06-30' AS Date), 0, 4, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), NULL, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 11, N'MONTALBANO', N'CLAUDIO', N'CLAUDIOMONTALBANO94', N'$2a$12$Fg0j.x19986i9LEeOIcuTunUXn1Nrg6A8imd/m0GGhMDKXfdmSu1W', N'CLAUDIOMONTALBANO94@GMAIL.COM', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2018-11-27' AS Date), CAST(N'2018-09-28' AS Date), CAST(N'2018-12-05' AS Date), 0, 4, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), NULL, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 6, N'DI CARLO', N'DOMENICO', N'D.DICARLO', N'$2a$12$Fg0j.x19986i9LEeOIcuTuHvdkeoNxxKTKeVL3TMGeV9CFCauL7Tm', N'D.DICARLO@TISCALI.IT', CAST(N'1900-01-01' AS Date), N'', N'', N'VIA PACINOTTI', N'PALERMO', N'PA', N'90145', N'', N'', 0, CAST(N'2018-08-15' AS Date), CAST(N'2018-06-16' AS Date), CAST(N'2020-05-26' AS Date), 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 924768, 0, N'12', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (14, 19, N'MIRRI', N'DARIO', N'DAMIR', N'$2a$12$Fg0j.x19986i9LEeOIcuTueG0BxVgdrwIdpjZpakjG6/f1SxBSRC.', N'DAMIR@VALERIOMCSE.EU', CAST(N'1969-04-26' AS Date), N'PALERMO', N'', N'CORSO DELLA PROMOZIONE', N'PALERMO', N'PA', N'90100', N'123', N'098', 0, CAST(N'2020-09-18' AS Date), CAST(N'2020-07-20' AS Date), CAST(N'2020-07-20' AS Date), 1, 1, 3, 0, 0, 0, CAST(N'1900-01-01' AS Date), 545409, 1, N'3', N'0.0', CAST(N'2020-07-20' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 13, N'CUTI', N'GIOVANNA', N'GIOVANNACUTI', N'$2a$12$Fg0j.x19986i9LEeOIcuTuwRfj.jL82NEvRZdtf239AVWEB5fck.q', N'GIOVANNACUTI@LIBERO.IT', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2019-05-17' AS Date), CAST(N'2019-03-18' AS Date), CAST(N'2020-02-20' AS Date), 1, 3, 2, 1, 1, 0, CAST(N'1900-01-01' AS Date), 741082, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 8, N'IMMESI', N'FRANCESCA', N'IMMESI1401', N'$2a$12$Fg0j.x19986i9LEeOIcuTumi7/ApCjYZS0Jku6NAPSChdVq0Kn/06', N'IMMESI1401@GMAIL.COM', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2018-11-24' AS Date), CAST(N'2018-09-25' AS Date), CAST(N'2019-02-19' AS Date), 1, 3, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 172204, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 17, N'GIORDANO', N'LUCIA MARIA', N'LUCIAMARIAGIORDANO', N'$2a$12$Fg0j.x19986i9LEeOIcuTuhHwXgh8HFakdPRubtfWN4bZPWtKZp3q', N'LUCIAMARIAGIORDANO@GMAIL.COM', CAST(N'2005-10-19' AS Date), N'PALERMO', N'', N'VIA SAN MARTINO 228', N'PALERMO', N'PA', N'90136', N'3357874137', N'', 1, CAST(N'2019-12-20' AS Date), CAST(N'2019-12-20' AS Date), CAST(N'2019-12-20' AS Date), 1, 4, 0, 1, 1, 1, CAST(N'2019-12-20' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (0, 0, N'MASTER', N'MASTER', N'master', N'$2a$12$Fg0j.x19986i9LEeOIcuTukf8boVDQP4W3f9kw/SoEjOz9megEA2.', N'master@valeriomcse.eu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, CAST(N'2020-07-14' AS Date), CAST(N'2020-07-14' AS Date), CAST(N'2020-07-15' AS Date), 1, 0, 0, 0, 0, 0, NULL, 0, 1, N'0', N'0.0', CAST(N'2020-07-14' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 3, N'Operatore', N'Sistema', N'opera', N'$2a$12$Fg0j.x19986i9LEeOIcuTuqroFHLzjDcZy3C68uUGcuMPV2E8b0bu', N'opera@dominio.it', NULL, N'Palermo', NULL, N'Via Campolo', NULL, N'PA', NULL, NULL, NULL, 0, CAST(N'2018-05-15' AS Date), CAST(N'2016-03-30' AS Date), CAST(N'2018-03-16' AS Date), 0, 4, 0, 0, 0, 0, NULL, NULL, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 5, N'MELI', N'GIUSEPPE', N'PEPPINO.MELI', N'$2a$12$Fg0j.x19986i9LEeOIcuTuQzv4pN7wSIF34jHcJ2XLLgVnjCUeQLy', N'PEPPINO.MELI@GMAIL.COM', CAST(N'1956-10-11' AS Date), N'PALERMO', N'', N'VIA E. TORRICELLI 3', N'PALERMO', N'PA', N'90145', N'', N'', 0, CAST(N'2018-06-08' AS Date), CAST(N'2018-04-09' AS Date), CAST(N'2020-06-05' AS Date), 1, 1, 3, 1, 1, 0, CAST(N'1900-01-01' AS Date), 125058, 0, N'12', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 16, N'GAROFALO', N'PATRIZIA', N'PIRICO63', N'$2a$12$Fg0j.x19986i9LEeOIcuTuS9OoVZzmwd1MARiecs5Pmy9tk5ar9py', N'PIRICO63@GMAIL.COM', CAST(N'1963-03-13' AS Date), N'PALERMO', N'', N'', N'PALERMO', N'PA', N'90100', N'', N'', 0, CAST(N'2020-01-31' AS Date), CAST(N'2018-11-11' AS Date), CAST(N'2020-03-04' AS Date), 1, 3, 2, 1, 1, 0, CAST(N'1900-01-01' AS Date), 274584, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 12, N'SIGNORINO', N'SABRINA', N'SIGNORINOSABRINA', N'$2a$12$Fg0j.x19986i9LEeOIcuTuqKmIl2oo8gA98OfvqtG38f7MMKX.YBK', N'SIGNORINOSABRINA@GMAIL.COM', CAST(N'1900-01-01' AS Date), N'', N'', N'', N'', N'PA', N'90100', N'', N'', 0, CAST(N'2019-11-12' AS Date), CAST(N'2018-10-04' AS Date), CAST(N'2020-03-03' AS Date), 1, 3, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 448830, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (14, 18, N'AMMINISTRATORE', N'SISTEMA', N'SVILUPPO', N'$2a$12$Fg0j.x19986i9LEeOIcuTuf7GQgSyv3/8Hy.izBSUExk6F43SUf3m', N'SVILUPPO@VALERIOMCSE.EU', CAST(N'2020-07-15' AS Date), N'PALERMO', N'', N'', N'', N'', N'', N'', N'', 0, CAST(N'2020-09-18' AS Date), CAST(N'2020-07-15' AS Date), CAST(N'2020-07-21' AS Date), 1, 1, 0, 1, 1, 1, CAST(N'2020-07-19' AS Date), 0, 0, N'3', N'0.0', CAST(N'2020-07-15' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 4, N'UTENTE', N'SISTEMA', N'UTENTE', N'$2a$12$Fg0j.x19986i9LEeOIcuTukf8boVDQP4W3f9kw/SoEjOz9megEA2.', N'UTENTE@DOMINIO.EDU', CAST(N'2019-08-30' AS Date), N'PALERMO', N'', N'VIA CAMPOLO', N'PALERMO', N'PA', N'90145', N'', N'', 0, CAST(N'2019-10-29' AS Date), CAST(N'2018-03-15' AS Date), CAST(N'2019-08-30' AS Date), 0, 4, 0, 0, 0, 0, CAST(N'2019-08-30' AS Date), NULL, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[admUtenti] ([idRS], [id], [cognome], [nome], [username], [password], [emailUser], [dataNascitaUser], [luogoNascitaUser], [codiceFiscaleUser], [indirizzoUser], [comuneUser], [provUser], [capUser], [tel1User], [tel2User], [cambiaPassword], [scadenza], [registra], [ultimo], [attivo], [idRuolo], [idTipoSocioUser], [privacyUser], [liberaUser], [firmaUser], [firmaDataUser], [checkCode], [emailCheck], [sediUser], [versione], [dataVersione]) VALUES (1, 2, N'JSON', N'VALERIO', N'VALERIO.NET', N'$2a$12$Fg0j.x19986i9LEeOIcuTukf8boVDQP4W3f9kw/SoEjOz9megEA2.', N'VALERIO.NET@VALERIOMCSE.EU', CAST(N'2016-01-04' AS Date), N'PALERMO', N'', N'VIA CAMPOLO', N'PALERMO', N'PA', N'90145', N'', N'', 0, CAST(N'2019-10-29' AS Date), CAST(N'2016-03-30' AS Date), CAST(N'2020-07-17' AS Date), 1, 3, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 983303, 1, N'1', N'1.17', CAST(N'2019-10-31' AS Date))
GO
SET IDENTITY_INSERT [dbo].[admUtenti] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeIstituti] ON 
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 39, N'PAVC010006', N'GIOVANNI FALCONE', N'CONVITTO NAZIONALE', N'PIAZZETTA SETT ANGELI 3', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAVC010006@istruzione.it', N'pavc010006@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 40, N'PAVE010005', N'MARIA ADELAIDE', N'EDUCANDATO', N'CORSO CALATAFIMI 86', N'90129', N'PALERMO', N'PA', N'SICILIA', N'PAVE010005@istruzione it', N'pave010005@pec istruzione it', N'Non Disponibile', 1)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 34, N'PARI010007', N'SALVATORE D ACQUISTO BAGHERIA', N'IST PROF INDUSTRIA E ARTIGIANATO', N'VIA PRINCIPE DI PALAGONIA  N  135', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PARI010007@istruzione it', N'Non Disponibile', N'www ipsiabagheria eu', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 33, N'PARH050006', N'F PAOLO CASCINO  EX III ALBERGHERIA', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'VIA FATTORI  60', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH050006@istruzione it', N'parh050006@pec istruzione it', N'www alberghierocascino it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 31, N'PARH01000Q', N'P.BORSELLINO', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'PIAZZETTA  G. BELLISSIMA 3', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH01000Q@istruzione.it', N'parh01000q@pec.istruzione.it', N'www.ipssarpaoloborsellino.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 32, N'PARH02000A', N'PIETRO PIAZZA', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'CORSO DEI MILLE N. 181', N'90123', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH02000A@istruzione.it', N'parh02000a@pec.istruzione.it', N'www.ipssarpiazza.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 25, N'PAPM100009', N'CASSARA', N'ISTITUTO MAGISTRALE', N'VIA DON ORIONE 44', N'90142', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM100009@istruzione.it', N'PAPM100009@pec.istruzione.it', N'www.linguisticocassara.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 22, N'PAPM02000N', N'DE COSMI', N'ISTITUTO MAGISTRALE', N'VIA  LEONARDO RUGGERI 15', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM02000N@istruzione.it', N'papm02000n@pec.istruzione.it', N'www.decosmi.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 24, N'PAPM07000P', N'DOLCI', N'ISTITUTO MAGISTRALE', N'VIA FICHIDINDIA', N'90124', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM07000P@istruzione.it', N'papm07000p@pec.istruzione.it', N'www.liceodanilodolci.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 21, N'PAPM010003', N'FINOCCHIARO APRILE', N'ISTITUTO MAGISTRALE', N'VIA CILEA', N'90144', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM010003@istruzione.it', N'papm010003@pec.istruzione.it', N'www.istitutofinocchiaroaprile.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 23, N'PAPM04000V', N'REGINA MARGHERITA', N'ISTITUTO MAGISTRALE', N'PIAZZETTA  S. SALVATORE 1', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM04000V@istruzione.it', N'papm04000v@pec.istruzione.it', N'http://liceoreginamargherita.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 9, N'PAIS02800T', N'ASCIONE', N'ISTITUTO SUPERIORE', N'VIA CENTURIPE 11', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02800T@istruzione it', N'pais02800t@pec istruzione it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 11, N'PAIS03200D', N'DAMIANI ALMEYDA - FRANCESCO CRISPI', N'ISTITUTO SUPERIORE', N'LARGO MARIO MINEO,14', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03200D@istruzione.it', N'PAIS03200D@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 10, N'PAIS02900N', N'DUCA ABRUZZI - LIBERO GRASSI', N'ISTITUTO SUPERIORE', N'VIA FAZIO N. 1', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02900N@istruzione.it', N'PAIS02900N@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 5, N'PAIS02300P', N'FERRARA', N'ISTITUTO SUPERIORE', N'VIA        SGARLATA 11', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02300P@istruzione.it', N'pais02300p@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 13, N'PAIS03600R', N'GIOENI -  TRABIA', N'ISTITUTO SUPERIORE', N'VIA  VITTORIO EMANUELE , 27', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03600R@istruzione.it', N'pais03600r@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 14, N'PAIS03700L', N'L.EINAUDI-PARETO', N'ISTITUTO SUPERIORE', N'VIA        MONGERBINO 51', N'90144', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03700L@istruzione.it', N'PAIS03700L@PEC.ISTRUZIONE.IT', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 4, N'PAIS01600G', N'MAJORANA', N'ISTITUTO SUPERIORE', N'VIA ASTORINO 56', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS01600G@istruzione.it', N'pais01600g@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 6, N'PAIS02400E', N'MEDI', N'ISTITUTO SUPERIORE', N'VIA   LEONARDO DA VINCI, 364', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02400E@istruzione.it', N'pais02400e@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 7, N'PAIS026006', N'RUTELLI', N'ISTITUTO SUPERIORE', N'PIAZZALE GIANGIACOMO CIACCIO MONTALTO N.3', N'90131', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS026006@istruzione.it', N'pais026006@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 8, N'PAIS027002', N'VOLTA', N'ISTITUTO SUPERIORE', N'PASSAGGIO  DEI PICCIOTTI 1', N'90123', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS027002@istruzione.it', N'pais027002@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 36, N'PATD120009', N'PIO LA TORRE', N'ISTITUTO TECNICO COMMERCIALE', N'VIA NINA SICILIANA, 22', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PATD120009@istruzione.it', N'patd120009@pec.istruzione.it', N'www.itetpiolatorre.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 37, N'PATF030009', N'VITTORIO EMANUELE III', N'ISTITUTO TECNICO INDUSTRIALE', N'VIA  DUCA DELLA VERDURA 48', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PATF030009@istruzione.it', N'patf030009@pec.istruzione.it', N'www.itivittorioemanueleterzopa.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 38, N'PATN01000Q', N'MARCO POLO', N'ISTITUTO TECNICO PER IL TURISMO', N'VIA UGO LA MALFA 113', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PATN01000Q@istruzione.it', N'patn01000q@pec.istruzione.it', N'www.ittmarcopolo.org', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 35, N'PASL01000V', N'CATALANO', N'LICEO ARTISTICO', N'VIA A. LA MARMORA N. 66', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PASL01000V@istruzione.it', N'pasl01000v@pec.istruzione.it', N'www.artisticocatalano.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 12, N'PAIS033009', N'V.RAGUSA E OTAMA KIYOHARA - F.PARLATORE', N'LICEO ARTISTICO', N'P.ZZA  G. TURBA,     71', N'90129', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS033009@istruzione.it', N'PAIS033009@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 18, N'PAPC100005', N'CONVITTO NAZIONALE G.FALCONE', N'LICEO CLASSICO', N'PIAZZA     SETTANGELI 3', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC100005@istruzione.it', N'Non Disponibile', N'convittonazionale.palermo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 2, N'0987654321', N'DON BOSCO RANCHIBILE CLASSICO', N'LICEO CLASSICO', N'VIALE DELLA LIBERTA 199', N'90144', N'PALERMO', N'PA', N'SICILIA', N'CLASSICO@DONBOSCO.ORG', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 16, N'PAPC04000P', N'GARIBALDI', N'LICEO CLASSICO', N'VIA        CANONICO ROTOLO', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC04000P@istruzione.it', N'papc04000p@pec.istruzione.it', N'www.liceogaribaldi.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 20, N'PAPC12000A', N'MARIA ADELAIDE', N'LICEO CLASSICO', N'CORSO CALATAFIMI 86', N'90129', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC12000A@istruzione.it', N'Non Disponibile', N'http://www.mariaadelaide.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 15, N'PAPC030004', N'MELI', N'LICEO CLASSICO', N'VIA S.ALDISIO,2', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC030004@istruzione.it', N'papc030004@pec.istruzione.it', N'www.liceomeli.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 17, N'PAPC09000Q', N'UMBERTO I', N'LICEO CLASSICO', N'VIA        FILIPPO PARLATORE 26 C', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC09000Q@istruzione.it', N'papc09000q@pec.istruzione.it', N'www.umbertoprimo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 19, N'PAPC11000Q', N'VITTORIO EMANUELE II', N'LICEO CLASSICO', N'VIA        SIMONE DA BOLOGNA 11', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC11000Q@istruzione.it', N'papc11000q@pec.istruzione.it', N'liceovittorioemanuelepa.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 3, N'GONZAGALIG', N'GONZAGA LINGUISTICO', N'LICEO LINGUISTICO', N'VIA PIERSANTI MATTARELLA', N'', N'', N'', N'', N'', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 28, N'PAPS05000C', N'ALBERT EINSTEIN', N'LICEO SCIENTIFICO', N'VIA ANTONIO VIVALDI N  60', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS05000C@ISTRUZIONE.IT', N'PAPS05000C@PEC.ISTRUZIONE.IT', N'WWW.LICEOEINSTEIN.PALERMO.IT', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 30, N'PAPS100008', N'BENEDETTO CROCE', N'LICEO SCIENTIFICO', N'VIA BENFRATELLI 4', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS100008@ISTRUZIONE.IT', N'PAPS100008@PEC.ISTRUZIONE.IT', N'WWW.LICEOCROCE.IT', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 27, N'PAPS02000L', N'CANNIZZARO', N'LICEO SCIENTIFICO', N'VIA GEN. ARIMONDI 14', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS02000L@istruzione.it', N'paps02000l@pec.istruzione.it', N'www.cannizzaro.palermo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 1, N'0123456789', N'DON BOSCO RANCHIBILE SCIENTIFICO', N'LICEO SCIENTIFICO', N'VIALE DELLA LIBERTA 199', N'90143', N'PALERMO', N'PA', N'SICILIA', N'SCIENTIFICO@DONBOSCO.ORG', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 29, N'PAPS060003', N'ERNESTO BASILE', N'LICEO SCIENTIFICO', N'VIA SAN CIRO  23', N'90124', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS060003@istruzione.it', N'paps060003@pec.istruzione.it', N'www.liceobasile.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (1, 26, N'PAPS010002', N'GALILEO GALILEI', N'LICEO SCIENTIFICO', N'VIA        DANIMARCA 54', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS010002@istruzione.it', N'paps010002@pec.istruzione.it', N'www.liceoggalileipalermo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 41, N'PAVC010006', N'GIOVANNI FALCONE', N'CONVITTO NAZIONALE', N'PIAZZETTA SETT ANGELI 3', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAVC010006@istruzione.it', N'pavc010006@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 42, N'PAVE010005', N'MARIA ADELAIDE', N'EDUCANDATO', N'CORSO CALATAFIMI 86', N'90129', N'PALERMO', N'PA', N'SICILIA', N'PAVE010005@istruzione it', N'pave010005@pec istruzione it', N'Non Disponibile', 1)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 43, N'PARI010007', N'SALVATORE D ACQUISTO BAGHERIA', N'IST PROF INDUSTRIA E ARTIGIANATO', N'VIA PRINCIPE DI PALAGONIA  N  135', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PARI010007@istruzione it', N'Non Disponibile', N'www ipsiabagheria eu', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 44, N'PARH050006', N'F PAOLO CASCINO  EX III ALBERGHERIA', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'VIA FATTORI  60', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH050006@istruzione it', N'parh050006@pec istruzione it', N'www alberghierocascino it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 45, N'PARH01000Q', N'P.BORSELLINO', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'PIAZZETTA  G. BELLISSIMA 3', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH01000Q@istruzione.it', N'parh01000q@pec.istruzione.it', N'www.ipssarpaoloborsellino.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 46, N'PARH02000A', N'PIETRO PIAZZA', N'IST PROF PER I SERVIZI ALBERGHIERI E RISTORAZIONE', N'CORSO DEI MILLE N. 181', N'90123', N'PALERMO', N'PALERMO', N'SICILIA', N'PARH02000A@istruzione.it', N'parh02000a@pec.istruzione.it', N'www.ipssarpiazza.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 47, N'PAPM100009', N'CASSARA', N'ISTITUTO MAGISTRALE', N'VIA DON ORIONE 44', N'90142', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM100009@istruzione.it', N'PAPM100009@pec.istruzione.it', N'www.linguisticocassara.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 48, N'PAPM02000N', N'DE COSMI', N'ISTITUTO MAGISTRALE', N'VIA  LEONARDO RUGGERI 15', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM02000N@istruzione.it', N'papm02000n@pec.istruzione.it', N'www.decosmi.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 49, N'PAPM07000P', N'DOLCI', N'ISTITUTO MAGISTRALE', N'VIA FICHIDINDIA', N'90124', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM07000P@istruzione.it', N'papm07000p@pec.istruzione.it', N'www.liceodanilodolci.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 50, N'PAPM010003', N'FINOCCHIARO APRILE', N'ISTITUTO MAGISTRALE', N'VIA CILEA', N'90144', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM010003@istruzione.it', N'papm010003@pec.istruzione.it', N'www.istitutofinocchiaroaprile.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 51, N'PAPM04000V', N'REGINA MARGHERITA', N'ISTITUTO MAGISTRALE', N'PIAZZETTA  S. SALVATORE 1', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPM04000V@istruzione.it', N'papm04000v@pec.istruzione.it', N'http://liceoreginamargherita.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 52, N'PAIS02800T', N'ASCIONE', N'ISTITUTO SUPERIORE', N'VIA CENTURIPE 11', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02800T@istruzione it', N'pais02800t@pec istruzione it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 53, N'PAIS03200D', N'DAMIANI ALMEYDA - FRANCESCO CRISPI', N'ISTITUTO SUPERIORE', N'LARGO MARIO MINEO,14', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03200D@istruzione.it', N'PAIS03200D@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 54, N'PAIS02900N', N'DUCA ABRUZZI - LIBERO GRASSI', N'ISTITUTO SUPERIORE', N'VIA FAZIO N. 1', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02900N@istruzione.it', N'PAIS02900N@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 55, N'PAIS02300P', N'FERRARA', N'ISTITUTO SUPERIORE', N'VIA        SGARLATA 11', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02300P@istruzione.it', N'pais02300p@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 56, N'PAIS03600R', N'GIOENI -  TRABIA', N'ISTITUTO SUPERIORE', N'VIA  VITTORIO EMANUELE , 27', N'90133', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03600R@istruzione.it', N'pais03600r@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 57, N'PAIS03700L', N'L.EINAUDI-PARETO', N'ISTITUTO SUPERIORE', N'VIA        MONGERBINO 51', N'90144', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS03700L@istruzione.it', N'PAIS03700L@PEC.ISTRUZIONE.IT', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 58, N'PAIS01600G', N'MAJORANA', N'ISTITUTO SUPERIORE', N'VIA ASTORINO 56', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS01600G@istruzione.it', N'pais01600g@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 59, N'PAIS02400E', N'MEDI', N'ISTITUTO SUPERIORE', N'VIA   LEONARDO DA VINCI, 364', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS02400E@istruzione.it', N'pais02400e@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 60, N'PAIS026006', N'RUTELLI', N'ISTITUTO SUPERIORE', N'PIAZZALE GIANGIACOMO CIACCIO MONTALTO N.3', N'90131', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS026006@istruzione.it', N'pais026006@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 61, N'PAIS027002', N'VOLTA', N'ISTITUTO SUPERIORE', N'PASSAGGIO  DEI PICCIOTTI 1', N'90123', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS027002@istruzione.it', N'pais027002@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 62, N'PATD120009', N'PIO LA TORRE', N'ISTITUTO TECNICO COMMERCIALE', N'VIA NINA SICILIANA, 22', N'90135', N'PALERMO', N'PALERMO', N'SICILIA', N'PATD120009@istruzione.it', N'patd120009@pec.istruzione.it', N'www.itetpiolatorre.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 63, N'PATF030009', N'VITTORIO EMANUELE III', N'ISTITUTO TECNICO INDUSTRIALE', N'VIA  DUCA DELLA VERDURA 48', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PATF030009@istruzione.it', N'patf030009@pec.istruzione.it', N'www.itivittorioemanueleterzopa.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 64, N'PATN01000Q', N'MARCO POLO', N'ISTITUTO TECNICO PER IL TURISMO', N'VIA UGO LA MALFA 113', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PATN01000Q@istruzione.it', N'patn01000q@pec.istruzione.it', N'www.ittmarcopolo.org', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 65, N'PASL01000V', N'CATALANO', N'LICEO ARTISTICO', N'VIA A. LA MARMORA N. 66', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PASL01000V@istruzione.it', N'pasl01000v@pec.istruzione.it', N'www.artisticocatalano.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 66, N'PAIS033009', N'V.RAGUSA E OTAMA KIYOHARA - F.PARLATORE', N'LICEO ARTISTICO', N'P.ZZA  G. TURBA,     71', N'90129', N'PALERMO', N'PALERMO', N'SICILIA', N'PAIS033009@istruzione.it', N'PAIS033009@pec.istruzione.it', N'Non Disponibile', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 67, N'PAPC100005', N'CONVITTO NAZIONALE G.FALCONE', N'LICEO CLASSICO', N'PIAZZA     SETTANGELI 3', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC100005@istruzione.it', N'Non Disponibile', N'convittonazionale.palermo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 68, N'0987654321', N'DON BOSCO RANCHIBILE CLASSICO', N'LICEO CLASSICO', N'VIALE DELLA LIBERTA 199', N'90144', N'PALERMO', N'PA', N'SICILIA', N'CLASSICO@DONBOSCO.ORG', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 69, N'PAPC04000P', N'GARIBALDI', N'LICEO CLASSICO', N'VIA        CANONICO ROTOLO', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC04000P@istruzione.it', N'papc04000p@pec.istruzione.it', N'www.liceogaribaldi.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 70, N'PAPC12000A', N'MARIA ADELAIDE', N'LICEO CLASSICO', N'CORSO CALATAFIMI 86', N'90129', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC12000A@istruzione.it', N'Non Disponibile', N'http://www.mariaadelaide.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 71, N'PAPC030004', N'MELI', N'LICEO CLASSICO', N'VIA S.ALDISIO,2', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC030004@istruzione.it', N'papc030004@pec.istruzione.it', N'www.liceomeli.gov.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 72, N'PAPC09000Q', N'UMBERTO I', N'LICEO CLASSICO', N'VIA        FILIPPO PARLATORE 26 C', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC09000Q@istruzione.it', N'papc09000q@pec.istruzione.it', N'www.umbertoprimo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 73, N'PAPC11000Q', N'VITTORIO EMANUELE II', N'LICEO CLASSICO', N'VIA        SIMONE DA BOLOGNA 11', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPC11000Q@istruzione.it', N'papc11000q@pec.istruzione.it', N'liceovittorioemanuelepa.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 81, N'0', N'DON BOSCO RANCHIBILE - ECONOMICO', N'LICEO ECONOMICO', N'VIA LIBERTÀ 99', N'', N'', N'', N'', N'', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 74, N'GONZAGALIG', N'GONZAGA LINGUISTICO', N'LICEO LINGUISTICO', N'VIA PIERSANTI MATTARELLA', N'', N'', N'', N'', N'', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 75, N'PAPS05000C', N'ALBERT EINSTEIN', N'LICEO SCIENTIFICO', N'VIA ANTONIO VIVALDI N  60', N'90145', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS05000C@ISTRUZIONE.IT', N'PAPS05000C@PEC.ISTRUZIONE.IT', N'WWW.LICEOEINSTEIN.PALERMO.IT', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 76, N'PAPS100008', N'BENEDETTO CROCE', N'LICEO SCIENTIFICO', N'VIA BENFRATELLI 4', N'90134', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS100008@ISTRUZIONE.IT', N'PAPS100008@PEC.ISTRUZIONE.IT', N'WWW.LICEOCROCE.IT', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 77, N'PAPS02000L', N'CANNIZZARO', N'LICEO SCIENTIFICO', N'VIA GEN. ARIMONDI 14', N'90143', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS02000L@istruzione.it', N'paps02000l@pec.istruzione.it', N'www.cannizzaro.palermo.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 78, N'0123456789', N'DON BOSCO RANCHIBILE SCIENTIFICO', N'LICEO SCIENTIFICO', N'VIALE DELLA LIBERTA 199', N'90143', N'PALERMO', N'PA', N'SICILIA', N'SCIENTIFICO@DONBOSCO.ORG', N'', N'', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 79, N'PAPS060003', N'ERNESTO BASILE', N'LICEO SCIENTIFICO', N'VIA SAN CIRO  23', N'90124', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS060003@istruzione.it', N'paps060003@pec.istruzione.it', N'www.liceobasile.it', 0)
GO
INSERT [dbo].[pf_anagrafeIstituti] ([idRS], [CODICEISTITUTO], [CODICE], [ISTITUTO], [DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA], [INDIRIZZO], [CAP], [COMUNE], [PROVINCIA], [REGIONE], [INDIRIZZOEMAILSCUOLA], [INDIRIZZOPECSCUOLA], [SITOWEBSCUOLA], [deleted]) VALUES (14, 80, N'PAPS010002', N'GALILEO GALILEI', N'LICEO SCIENTIFICO', N'VIA        DANIMARCA 54', N'90146', N'PALERMO', N'PALERMO', N'SICILIA', N'PAPS010002@istruzione.it', N'paps010002@pec.istruzione.it', N'www.liceoggalileipalermo.it', 0)
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeIstituti] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeProfessori] ON 
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (0, 0, N' -- Tutti i Docenti', N'--', N'--', N'--', N'--', N'--', N'--', N'--', N'--', N'', CAST(N'2018-03-13' AS Date), CAST(N'2018-03-13' AS Date), NULL, NULL, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, N'123', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 2, N'ACCARDO PALUMBO ANTONINA', N'TANIAA1968@LIBERO.IT', N'3337330417', N'', N'VIALE REGIONE SICILIANA 2507', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-03-15' AS Date), CAST(N'2020-02-07' AS Date), CAST(N'1968-03-05' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2019-04-29' AS Date), 1, 729133, N'1', N'idMateria#44;idAnno#12;idFreq#S@idMateria#15;idAnno#12345;idFreq#S', N'idMateria#15;numLez#4', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 3, N'ACCURSO SANTO', N'SANTOACCURSO@LIBERO.IT', N'3398167577', N'', N'LARGO N. SANSEVERINO 28-B', N'PALERMO', N'PA', N'90143', N'CCRSNT60B07G273Z', N' ', CAST(N'2018-04-09' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'1960-02-07' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 538754, N'1', N'idMateria#9;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S@idMateria#36;idAnno#12;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 4, N'ARICÒ ROSALIA', N'LIA.ARICO@ALICE.IT', N'3392203764', N'0916865027', N'VIA CAMPOLO 40', N'PALERMO', N'PA', N'90145', N'RCARSL62A70G273Y', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'1962-01-30' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 229548, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 5, N'ARMETTA PAOLA', N'PAOLARME@LIBERO.IT', N'3287082157', N'091205665', N'VIALE MICHELANGELO 1004', N'PALERMO', N'PA', N'90145', N'RMTPLA60T70G273L', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'1960-12-30' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 254489, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 6, N'BALLARDINI DAVIDE', N'BALLADAVID@PORTOFRANCOPA.EDU', N'6465461546', N'651461464', N'PIAZZA SCUOLA 4', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 1, CAST(N'2019-09-13' AS Date), 0, NULL, N'1', N'idMateria#1; idAnno#12345; idFreq#M@idMateria#19; idAnno#345; idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 7, N'BARONE ROBERTO', N'ROBERTOBARONE@HOTMAIL.COM', N'3396993521', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-10-02' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 8, N'BILLA CINZIA', N'CINZIA.BILLA2@GMAIL.COM', N'3285338068', N'', N'VIA GIACOMO LEOPARDI- 27', N'PALERMO', N'PA', N'90144', N'', N' ', CAST(N'2018-10-08' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'1972-04-02' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 1, CAST(N'2019-12-06' AS Date), 1, 225903, N'1', N'idMateria#5; idAnno#12345; idFreq#S@idMateria#6; idAnno#12345; idFreq#S', N'idMateria#5;numLez#1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 88, N'BRIGNOLA RAFFAELA', N'ELABRI9@GMAIL.COM', N'3497807737', N'', N'VIA GALILEI 22', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-10-11' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1946-06-24' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 1, CAST(N'2019-10-11' AS Date), 1, 233965, N'1', N'idMateria#2;idAnno#12;idFreq#S@idMateria#3;idAnno#12;idFreq#S@idMateria#9;idAnno#12;idFreq#S', N'', N'1.16', CAST(N'2019-10-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 70, N'BUONGUSTO FEDERICA', N'FEDERICABUONGUSTO@VIRGILIO.IT', N'3279893061', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-26' AS Date), CAST(N'2019-09-30' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'2', N'idMateria#5;idAnno#12;idFreq#S@idMateria#6;idAnno#12;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 71, N'CALÀ ROSARIA', N'CALROSARIA@LIBERO.IT', N'3886543569', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'2', N'idMateria#9;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'idMateria#9;numLez#4@idMateria#10;numLez#1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 9, N'CANGEMI MARIA', N'CANGEMIMARIA@YAHOO.IT', N'3475124598', N'', N'VIA E. NARZISI 19', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-01-29' AS Date), CAST(N'2020-01-20' AS Date), CAST(N'1970-02-12' AS Date), N'PALERMO', 0, 1, 0, 1, 1, 1, CAST(N'2019-05-16' AS Date), 1, 218777, N'1', N'idMateria#5;idAnno#12345;idFreq#S@idMateria#6;idAnno#12345;idFreq#S', N'idMateria#5;numLez#1@idMateria#6;numLez#3', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 10, N'CARFÌ VITO', N'VCARFIX@GMAIL.COM', N'3200540966', N'', N'VIA SAN MARTINO 228', N'PALERMO', N'PA', N'90136', N'CRFVTI01B03G273I', N' ', CAST(N'2018-10-08' AS Date), CAST(N'2018-10-16' AS Date), CAST(N'2001-02-03' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 1, CAST(N'2018-10-08' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 72, N'CARRÀ ANTONINO', N'PROFCARRA@LIBERO.IT', N'3299616263', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 73, N'CARUSO MARIA CHIARA', N'MARY568.MCC@GMAIL.COM', N'3669385514', N'', N'VIALE REGIONE SICILIANA 568', N'PALERMO', N'PA', N'90129', N'', N' ', CAST(N'2019-03-12' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'2000-07-05' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'2', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 84, N'CASTROGIOVANNI GIUSEPPE', N'GIUSEPPE.CASTROGIOVANNI@GMAIL.COM', N'3475597776', N'', N'VIA LEONARDO DA VINCI 17', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-09-26' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1953-08-31' AS Date), N'CAMPOFRANCO CL', 0, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 864457, N'1', N'idMateria#13; idAnno#12345; idFreq#S@idMateria#14; idAnno#123; idFreq#S@idMateria#42; idAnno#12345; idFreq#S', N'idMateria#14;numLez#2@idMateria#42;numLez#4', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 11, N'CENTINEO ELOISA', N'ELOISACENTINEO@LIBERO.IT', N'3200648656', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 74, N'CERAMI IGNAZIO', N'IGNAZIO.CERAMI@GMAIL.COM', N'3332846200', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2019-02-01' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'2', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 12, N'CERRONE EGLE', N'EGLECERRONE@GMAIL.COM', N'3388976663', N'', N'VIALE REGIONE SICILIANA 2305', N'PALERMO', N'PA', N'90135', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1947-02-14' AS Date), N'PALERMO', 0, 2, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 602722, N'1', N'idMateria#13;idAnno#345;idFreq#S@idMateria#14;idAnno#345;idFreq#S', N'', N'1.16', CAST(N'2019-10-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 13, N'CHERTA EUGENIA', N'TATI1YOU@GMAIL.COM', N'3711913572', N'', N'VIA D-AMELIO 3', N'PALERMO', N'PA', N'90143', N'', N' ', CAST(N'2019-02-07' AS Date), CAST(N'2019-09-30' AS Date), CAST(N'1996-02-20' AS Date), N'BIELORUSSIA', 0, 0, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 101378, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'idMateria#6;numLez#2', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 75, N'CHIANCONE PASQUALE', N'PASQUALE.CHIANCONE1944@GMAIL.COM', N'0916682250', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'idMateria#14; idAnno#12345; idFreq#S', N'idMateria#14;numLez#12', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 76, N'CHIOLO ALESSANDRO', N'ANTROPOI1974@GMAIL.COM', N'3898089765', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-19' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'idMateria#1;idAnno#345;idFreq#S@idMateria#10;idAnno#345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 90, N'COSTANZA GIOVANNI', N'SERENACOSTANZA1978@GMAIL.COM', N'3807048861', N'', N'VIA UDITORE 6', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-10-23' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1940-01-03' AS Date), N'AGRIGENTO', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'2', N'idMateria#14; idAnno#12; idFreq#S', N'idMateria#14;numLez#1', N'0.0', CAST(N'2019-10-23' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 77, N'CRISAFULLI CARMELO', N'DR.CARMELOCRISAFULLI@LIBERO.IT', N'3296156042', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'2', N'idMateria#37;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 14, N'CUCCIO CARMELO', N'CUCCIO.CARMELO@LIBERO.IT', N'3395082855', N'', N'VIA E. ARMAFORTE  1', N'PALERMO', N'PA', N'90143', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1960-11-24' AS Date), N'LICATA -AG-', 0, 1, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, NULL, N'1', N'idMateria#14; idAnno#345; idFreq#S', N'idMateria#14;numLez#9', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 15, N'CUTI GIOVANNA', N'GIOVANNACUTI@LIBERO.IT', N'3398505253', N'0916812522', N'PIAZZA O. ZIINO 1', N'PALERMO', N'PA', N'90145', N'CTUGNN61A46G273K', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-12-23' AS Date), CAST(N'1961-01-06' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 114835, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 16, N'CUTRERA AGATA', N'AGATACUTRERA@LIBERO.IT', N'3201938500', N'', N'VIA R. DA SAN GERMANO 2', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1946-05-12' AS Date), N'PALERMO', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'idMateria#2;idAnno#123;idFreq#S@idMateria#3;idAnno#123;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 78, N'D ACCARDI CRISTIAN', N'CRISTIAN.DACCARDI@LIBERO.IT', N'3292716163', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'idMateria#9;idAnno#12;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 79, N'D ACCARDI PIETRO', N'PIERO.DACCARDI@LIBERO.IT', N'3662297481', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 3, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 110105, N'2', N'idMateria#13; idAnno#123; idFreq#S@idMateria#14; idAnno#12345; idFreq#S', N'idMateria#13;numLez#1', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 17, N'D ANGELO FRANCESCO', N'FRANCESCODANGELO95@LIBERO.IT', N'3665088585', N'', N'VIA  BERNABEI 51', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2020-02-12' AS Date), CAST(N'1995-11-28' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 184847, N'1', N'idMateria#13;idAnno#345;idFreq#S@idMateria#14; idAnno#345; idFreq#S@idMateria#15; idAnno#345; idFreq#S@idMateria#38; idAnno#345; idFreq#S', N'idMateria#14;numLez#4', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 19, N'DE ZERBI ROBERTO', N'PERSO@ERGO.ORG', N'123123', N'651615615611', N'PIAZZA FILOSOFIA', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'SAPERLO', 0, 0, 1, 1, 1, 1, CAST(N'2019-08-19' AS Date), 0, NULL, N'1', N'idMateria#1;idAnno#345;idFreq#S@idMateria#10;idAnno#345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 92, N'DEL GIUDICE MARIA', N'LA.DELGI@GMAIL.COM', N'3474639436', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2019-11-26' AS Date), CAST(N'2020-02-07' AS Date), CAST(N'1947-01-13' AS Date), N'NAPOLI', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'1', N'', N'', N'0.0', CAST(N'2019-11-26' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 20, N'DI CRISTOFALO GIANPIERO', N'GIANPIERO.DI.CRISTOFALO@GMAIL.COM', N'3892331535', N'', N'LARGO HILTON 19', N'VILLABATE', N'PA', N'90039', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-12-27' AS Date), CAST(N'1995-02-27' AS Date), N'PALERMO', 2, 3, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 581196, N'1', N'idMateria#13;idAnno#12345;idFreq#S@idMateria#38;idAnno#12345;idFreq#S@idMateria#39;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 21, N'DI FRANCESCO CLAUDIA', N'CLAUDIA.DI_FRANCESCO@LIBERO.IT', N'3295735298', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 245065, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 22, N'DI GANGI PIERA', N'PDIGANGI@HOTMAIL.IT', N'3395469001', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 96, N'DI PIAZZA ANTONELLA', N'ANTONELLADIPIAZZA60@LIBERO.IT', N'3394233744', N'', N'PASSAGGIO G. RICCASALERNO 4', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2020-01-31' AS Date), CAST(N'2020-02-07' AS Date), CAST(N'1960-01-04' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2020-01-31' AS Date), 1, 106477, N'1', N'idMateria#14; idAnno#12; idFreq#S', N'', N'0.0', CAST(N'2020-01-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 91, N'DI PISA CARLO', N'DIPISACARLO@LIBERO.IT', N'3293418988', N'', N'VIA BRAHMS 2', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-10-25' AS Date), CAST(N'2020-02-27' AS Date), CAST(N'1954-08-11' AS Date), N'PALERMO', 0, 2, 0, 1, 1, 1, CAST(N'2019-10-25' AS Date), 0, 0, N'1', N'idMateria#44;idAnno#12;idFreq#S@idMateria#43; idAnno#345; idFreq#S', N'', N'0.0', CAST(N'2019-10-25' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 83, N'ENEA GIOVANNA', N'GIOVANNA.ENEA@LIBERO.IT', N'3397193970', N'', N'VIALE REGIONE SICILIANA 2507', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-09-25' AS Date), CAST(N'2019-09-25' AS Date), CAST(N'1967-10-27' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2019-09-25' AS Date), 1, 202718, N'1', N'idMateria#19;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 23, N'GALATIOTO ROSA', N'ROSYGALAT@GMAIL.COM', N'3319393979', N'0916827815', N'', N'', N'', N'', N'', N' ', CAST(N'2018-10-10' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1951-08-07' AS Date), N'CALTANISSETTA', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 24, N'GALLO ROBERTA', N'ROBERTAGALLO92@LIBERO.IT', N'3202462374', N'', N'VIA LANCIA DI BROLO 116', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-05-22' AS Date), CAST(N'2019-06-13' AS Date), CAST(N'1992-03-10' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 1, CAST(N'2019-05-22' AS Date), 1, 891735, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 25, N'GASPERINI GIAN PIERO', N'GASGIAMPI@PORTOFRANCOPA.ORG', N'123456789', N'111111', N'VIA LIBERAZIONE 2', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'idMateria#10;idAnno#12345;idFreq#S@idMateria#11;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 26, N'GELOSO GIOVANNI', N'GIOVANNI.GELOSO62@GMAIL.COM', N'3331376564', N'', N'VIA PIETRO NENNI N.19', N'PALERMO', N'PA', N'90146', N'', N' ', CAST(N'2019-03-01' AS Date), CAST(N'2019-10-22' AS Date), CAST(N'1962-05-13' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 581556, N'1', N'idMateria#27;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 27, N'GELOSO SALAMONE PAOLA', N'PAO.SALAMONE@GMAIL.COM', N'3384567230', N'', N'VIA P. NENNI 19', N'PALERMO', N'PA', N'90146', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1968-06-03' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 353335, N'1', N'idMateria#14;idAnno#1234;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 28, N'GIAMETTA FINA', N'FINAMARIAGIAMETTA@GMAIL.COM', N'3384778612', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2020-02-15' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 1, CAST(N'1900-01-01' AS Date), 1, 304138, N'1', N'idMateria#2;idAnno#12345;idFreq#Q@idMateria#3;idAnno#12345;idFreq#Q', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 80, N'GRISANTI LORENZO', N'LORENZOGRISANTI@INWIND.IT', N'3382663606', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2019-01-28' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'idMateria#14;idAnno#12;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 29, N'GUARDIOLA GIUSEPPE', N'TROPPOFORTE@VINCOSEMPRE.EU', N'TAGLIATO', N'', N'SEGRETO', N'', N'', N'', N'', N' ', CAST(N'2018-03-03' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'idMateria#12;idAnno#12345;idFreq#S@idMateria#15;idAnno#12345;idFreq#S@idMateria#38;idAnno#12345;idFreq#S@idMateria#39;idAnno#12345;idFreq#S@idMateria#40;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 85, N'GUGLIELMO PIETRA', N'PIETRA.GUGLIELMO@ISTRUZIONE.IT', N'3397903451', N'', N'VIA ANNA FORTINO 17', N'PALERMO', N'PA', N'90146', N'', N' ', CAST(N'2019-10-02' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1954-06-24' AS Date), N'PALERMO', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 793742, N'1', N'idMateria#14; idAnno#12; idFreq#S', N'idMateria#14;numLez#2', N'0.0', CAST(N'2019-10-02' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 30, N'GUIDOLIN FRANCESCO', N'GUIDO@PF.COM', N'5642399', N'521365879', N'PIAZZA SCUOLA 3', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'12', N'idMateria#12;idAnno#12;idFreq#S@idMateria#13; idAnno#12345; idFreq#S@idMateria#14; idAnno#12345; idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 31, N'GULLO SERAFINA', N'ARIAFRESCA63@GMAIL.COM', N'3391702143', N'', N'VIA SAVERINO 31 A', N'CERDA', N'PA', N'90010', N'', N' ', CAST(N'2019-02-08' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1963-03-22' AS Date), N'CERDA -PA-', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 508103, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 32, N'IACHINI GIUSEPPE', N'IACHINI@SALVEZZA.IT', N'52166584', N'5145554', N'PIAZZA SCUOLA 3', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 81, N'INCALCATERRA PAOLO GREGORIO', N'PAOLOGREGORIO.INCALCATERRA@ISTRUZIONE.IT', N'3287952978', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2019-02-13' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'2', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 33, N'INZERILLO ANTONINO', N'INZERILLO.ANTO@GMAIL.COM', N'3881056899', N'', N'VIA FALSOMIELE 6', N'PALERMO', N'PA', N'90124', N'', N' ', CAST(N'2018-10-17' AS Date), CAST(N'2020-03-10' AS Date), CAST(N'1994-11-24' AS Date), N'PALERMO', 0, 3, 0, 1, 1, 1, CAST(N'2020-03-10' AS Date), 1, 956838, N'1', N'idMateria#6;idAnno#12345;idFreq#S@idMateria#14;idAnno#12;idFreq#S@idMateria#38;idAnno#12345;idFreq#S@idMateria#39;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 34, N'LA PORTA TERESA', N'MTERESALAPORTA@LIBERO.IT', N'3283820456', N'', N'', N'PALERMO', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 86, N'LO PRESTI ANTONELLA', N'ANTONELLA.LOPRESTI@LIBERO.IT', N'3381787440', N'', N'VIA CILEA 11', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-10-04' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1968-12-03' AS Date), N'PALERMO', 0, 1, 0, 0, 1, 0, CAST(N'1900-01-01' AS Date), 0, 217760, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'idMateria#6;numLez#1', N'0.0', CAST(N'2019-10-04' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 35, N'LOMBARDO MARTINA', N'MARTINALOMBARDO21@GMAIL.COM', N'3314908221', N'', N'VIA MULÈ 9', N'PALERMO', N'PA', N'90129', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-12-24' AS Date), CAST(N'1993-07-21' AS Date), N'PALERMO', 0, 3, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 230055, N'1', N'idMateria#5;idAnno#12345;idFreq#S@idMateria#6;idAnno#12;idFreq#S@idMateria#7;idAnno#12345;idFreq#S', N'idMateria#5;numLez#1@idMateria#7;numLez#2', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 36, N'LOPIANO LUCIANA', N'LUCIANA.LOPIANO@GMAIL.COM', N'3479567698', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 916754, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 37, N'LUCIDO FILIPPO', N'FILIPPOLUCIDO1@LIBERO.IT', N'3388165488', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-19' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 38, N'MAGGIO EMILIA', N'EMILIA.MAGGIO@GOOGLEMAIL.COM', N'3274949473', N'', N'VIA DEL CELSO 14', N'PALERMO', N'PA', N'90134', N'MGGMLE58M71G273A', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1958-08-31' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 39, N'MAMOLA GIOVANNI', N'GIOVANNI.MAMOLA@UNIPA.IT', N'3204376483', N'', N'VIA G. B. LULLI 4', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2018-04-10' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1938-04-12' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 40, N'MAMOLA LUISA', N'LUISAMAMOLA@GMAIL.COM', N'3315279844', N'', N'VIA G. B. LULLI 4', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2019-09-17' AS Date), CAST(N'1971-07-14' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 849282, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'idMateria#6;numLez#2', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 41, N'MANCO VIRGINIA', N'RF.VIRGINIAMANCO@YAHOO.IT', N'3271683649', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 42, N'MANIACI FRANCESCA', N'FRANCESCA.MANIACI@OUTLOOK.IT', N'3343512100', N'', N'VIA DELLA LIBERTÀ 11 E', N'CINISI', N'PA', N'90045', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1988-04-24' AS Date), N'PALERMO', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 289263, N'1', N'idMateria#5;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 87, N'MANZELLA GISELLA', N'GISELLAMANZELLA@GMAIL.COM', N'3208879575', N'', N'VIA FRANZ LHEAR N.7', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2019-10-07' AS Date), CAST(N'2019-10-22' AS Date), CAST(N'1979-01-08' AS Date), N'CARINI', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 878495, N'1', N'', N'', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 94, N'MANZONI OLGA', N'MANZONIOLGA@LIVE.IT', N'3247855100', N'', N'VIA REGIONE SICILIANA 2629', N'PALERMO', N'PA', N'90145', N'', N' ', CAST(N'2020-01-10' AS Date), CAST(N'2020-01-13' AS Date), CAST(N'1980-02-26' AS Date), N'PALERMO', 0, 1, 0, 1, 1, 1, CAST(N'2020-01-10' AS Date), 1, 0, N'1', N'idMateria#3;idAnno#12;idFreq#S@idMateria#9;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2020-01-10' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 43, N'MARCHICA ANNA', N'ANNUCCIA.MARCHICA@GMAIL.COM', N'3349662169', N'', N'VIA DE GASPERI 70', N'PALERMO', N'PA', N'90146', N'', N' ', CAST(N'2018-11-26' AS Date), CAST(N'2020-03-09' AS Date), CAST(N'1960-03-28' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 668375, N'1', N'idMateria#3;idAnno#12345;idFreq#S@idMateria#5;idAnno#12345;idFreq#S@idMateria#9;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 44, N'MELI GIUSEPPE', N'PEPPINO.MELI@GMAIL.COM', N'3921415773', N'', N'VIA E. TORRICELLI 3', N'PALERMO', N'PA', N'90145', N'MLEGPP56R11G273L', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2020-02-24' AS Date), CAST(N'1956-10-11' AS Date), N'PALERMO', 2, 1, 0, 1, 1, 1, CAST(N'2020-02-24' AS Date), 1, NULL, N'1', N'idMateria#41;idAnno#12345;idFreq#S@idMateria#37;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 45, N'MONTALBANO VALERIO', N'VALERIOMCSE@HOTMAIL.COM', N'3488212068', N'', N'VIALE CROCE ROSSA 25', N'PALERMO', N'PA', N'90144', N'MNTVLR65M23G273D', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2020-02-07' AS Date), CAST(N'1965-08-23' AS Date), N'PALERMO', 2, 0, 0, 1, 1, 1, CAST(N'2019-10-01' AS Date), 1, 253564, N'1', N'idMateria#13; idAnno#12; idFreq#S@idMateria#14; idAnno#12; idFreq#S', N'', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 46, N'MURATORE GIACOMO', N'MURATOREGIACOMO@GMAIL.COM', N'3315915712', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 47, N'NAPOLI DOMENICO', N'NAPOLIDOMENICO91@GMAIL.COM', N'3807967281', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 48, N'ODDO ADALGISA', N'ADODDO.ODDO@GMAIL.COM', N'3405223172', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 436834, N'1', N'idMateria#6;idAnno#12345;idFreq#S', N'idMateria#6;numLez#2', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 89, N'PAPPALARDO GIUSEPPINA', N'GIUSIALI@LIBERO.IT', N'3286476477', N'', N'VIALE MEDIATRICE 57', N'PALERMO', N'PA', N'90129', N'', N' ', CAST(N'2019-10-23' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1969-07-04' AS Date), N'DILLINGEN -GERMANIA-', 0, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'2', N'idMateria#8;idAnno#1234;idFreq#S', N'', N'0.0', CAST(N'2019-10-23' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 95, N'PASSARELLO PAOLO', N'PAOLO.PASSARELLO@GMAIL.COM', N'3483027208', N'', N'VIA ANTONIO PACINOTTI N.34', N'PALERMO', N'PA', N'90145', N'PSSPLA61A30B804Y', N' ', CAST(N'2020-01-22' AS Date), CAST(N'2020-02-10' AS Date), CAST(N'1961-01-30' AS Date), N'CARONIA', 0, 0, 1, 1, 1, 1, CAST(N'2020-01-22' AS Date), 1, 0, N'1', N'idMateria#13;idAnno#12;idFreq#S@idMateria#14;idAnno#12;idFreq#S@idMateria#19;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2020-01-22' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 49, N'POLICARPO MARTINA', N'MARTYNIX88@GMAIL.COM', N'3246063109', N'', N'VIA GIACOMO LEOPARDI- 27', N'PALERMO', N'PA', N'90144', N'', N' ', CAST(N'2018-10-08' AS Date), CAST(N'2020-02-07' AS Date), CAST(N'2001-07-02' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 110920, N'1', N'idMateria#9; idAnno#123; idFreq#S@idMateria#10; idAnno#123; idFreq#S@idMateria#14; idAnno#123; idFreq#S', N'idMateria#14;numLez#1', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 50, N'POLICARPO MICHELANGELO', N'MPOLIK@GMAIL.COM', N'3285338082', N'', N'VIA G. LEOPARDI 27', N'PALERMO', N'PA', N'90144', N'PLCMHL66S01G273N', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2019-12-02' AS Date), CAST(N'1966-11-01' AS Date), N'PALERMO', 1, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 51, N'RAVALLI ANGELA MARIA', N'ANGELAMARIARAVALLI@LIBERO.IT', N'3296218362', N'0916514897', N'VIA M. SCOTO 2', N'PALERMO', N'PA', N'90131', N'', N' ', CAST(N'2019-02-22' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1958-04-19' AS Date), N'VITTORIA -RG-', 0, 0, 1, 1, 1, 1, CAST(N'2019-04-30' AS Date), 0, 562323, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 52, N'ROCCATI FEDERICO', N'FEDERICO.ROCCATI@GMAIL.COM', N'3515556166', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-10-09' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 53, N'RONDELLO CHIARA', N'CHIARAROND@GMAIL.COM', N'3461642523', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2019-02-04' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 54, N'RONDELLO GIULIA', N'GIULIARONDELLO@GMAIL.COM', N'3270670904', N'', N'VIA U. GIORDANO 130', N'PALERMO', N'PA', N'90145', N'RNDGLI92A42G273A', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-12-24' AS Date), CAST(N'1992-01-02' AS Date), N'PALERMO', 1, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'idMateria#3;idAnno#12345;idFreq#S@idMateria#9;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'idMateria#3;numLez#3', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 55, N'ROSA LUCIA', N'LUFORT.ROSA@LIBERO.IT', N'3661021732', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 18, N'ROSSI DELIO', N'COPPAITALIA@FINALEPERSA.ORG', N'3334455668', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-02-26' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'idMateria#2;idAnno#12345;idFreq#S@idMateria#3;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 56, N'SABELLA MARCELLO', N'MARCELLOSABELLA@GMAIL.COM', N'3512442950', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 57, N'SAPIENZA SALVATORE', N'SALVATORE92_10@LIBERO.IT', N'3297407469', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-06' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 498521, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 58, N'SCELSI TERESA', N'TERESASCELSI@ALICE.IT', N'3472574844', N'', N'VIALE DELLE MAGNOLIE 56', N'PALERMO', N'PA', N'90144', N'SCLTRS51A45C696G', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1951-01-05' AS Date), N'CIMINNA -PA-', 1, 2, 0, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 664374, N'1', N'idMateria#2;idAnno#12;idFreq#S@idMateria#3;idAnno#12345;idFreq#S', N'idMateria#2;numLez#2@idMateria#3;numLez#2', N'1.18', CAST(N'2019-10-31' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 59, N'SCHELOTTO GUILLERMO BARROS', N'ADDIO@PORTOFRANCOPA.EDU', N'5546654844', N'5564455', N'PIAZZA INGLESE', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 60, N'SCIORTINO CRISTIANA', N'SCIORTINOCRISTIANA@GMAIL.COM', N'3337817215', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 82, N'SCORSONE FRANCESCO', N'FRANCESCOSCORSONE@HOTMAIL.COM', N'3493133643', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-11-13' AS Date), CAST(N'2020-04-06' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 2, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'12', N'idMateria#38;idAnno#12345;idFreq#S@idMateria#39;idAnno#12345;idFreq#S@idMateria#40;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 61, N'SQUADRITO GIORGIO', N'GIORGIOSQUADRITO1234@GMAIL.COM', N'3283347534', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2020-02-10' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'idMateria#13;idAnno#12345;idFreq#S@idMateria#14;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 62, N'STELLONE ROBERTO', N'PLAYOFF@ULTIMASPIAGGIA.SERIEA', N'TAGLIATO', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'', N'', N' ', CAST(N'2018-05-03' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'idMateria#5;idAnno#12345;idFreq#S@idMateria#6;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 93, N'TAORMINA EMILIA', N'EMILIATAORMINA@GMAIL.COM', N'3245435874', N'', N'VIA M. RUTELLI 26', N'PALERMO', N'PA', N'90144', N'', N' ', CAST(N'2019-12-06' AS Date), CAST(N'2019-12-06' AS Date), CAST(N'2003-04-17' AS Date), N'PALERMO', 0, 0, 0, 1, 1, 1, CAST(N'2019-12-06' AS Date), 1, 124523, N'1', N'idMateria#3;idAnno#1;idFreq#S@idMateria#9;idAnno#12;idFreq#S@idMateria#10;idAnno#1;idFreq#S', N'idMateria#3;numLez#1', N'0.0', CAST(N'2019-12-06' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 63, N'TAORMINA SUSANNA', N'TAORMINAS.ST@GMAIL.COM', N'3203039610', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 64, N'TEDINO BRUNO', N'BRUNO.PALERMO@SERIEA.ORG', N'11111111', N'34343434', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-27' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1968-11-07' AS Date), N'ROMA', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 153674, N'2', N'idMateria#14;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 65, N'TRUPIA GIUSEPPINA', N'BAGNERA2003@LIBERO.IT', N'3385296371', N'', N'VIA M. SCOTO 2', N'PALERMO', N'PA', N'90135', N'TRPGPP51A63G273H', N' ', CAST(N'2018-09-29' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1951-01-23' AS Date), N'PALERMO', 1, 2, 0, 1, 1, 1, CAST(N'2019-04-29' AS Date), 0, 195424, N'1', N'idMateria#2; idAnno#12345; idFreq#S@idMateria#3; idAnno#12345; idFreq#S@idMateria#9;idAnno#12345;idFreq#S', N'idMateria#2;numLez#4@idMateria#3;numLez#2', N'1.16', CAST(N'2019-10-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 66, N'VIGORINI VINCENZA', N'ENZA.VIGORINI@TISCALI.IT', N'3332342414', N'', N'', N'', N'', N'', N'', N' ', CAST(N'2018-09-30' AS Date), CAST(N'2020-02-17' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 1, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 788801, N'1', N'idMateria#41;idAnno#12345;idFreq#S@idMateria#37; idAnno#12345; idFreq#S', N'idMateria#37;numLez#3@idMateria#41;numLez#2', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 67, N'VITO ANDREA', N'ANDREAVITO93@GMAIL.COM', N'3332124704', N'', N'VIA SAMMARTINO 34', N'PALERMO', N'PA', N'90141', N'', N' ', CAST(N'2019-03-21' AS Date), CAST(N'2019-09-17' AS Date), CAST(N'1993-09-05' AS Date), N'NAPOLI', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 122326, N'1', N'idMateria#1;idAnno#12345;idFreq#S@idMateria#10;idAnno#12345;idFreq#S', N'idMateria#10;numLez#4', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 68, N'ZAMPESE DEBORA', N'DEBORA93AO@GMAIL.COM', N'3405271931', N'', N'VIA MANDRALISCA 69', N'CEFALÙ', N'PA', N'90015', N'', N' ', CAST(N'2018-06-18' AS Date), CAST(N'2019-08-27' AS Date), CAST(N'1993-04-16' AS Date), N'AOSTA', 0, 0, 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (1, 69, N'ZAPPA FRANCO', N'zappa@portopa.org', N'34567543', N'', N'', N'', N'', N'', N'', N'', CAST(N'2018-05-09' AS Date), CAST(N'2018-06-15' AS Date), NULL, NULL, 0, 0, 1, 0, 0, 0, NULL, 0, NULL, N'1', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 98, N'BALLARDINI DAVIDE', N'BALLADAVID@PORTOFRANCOPA.EDU', N'6465461546', N'651461464', N'PIAZZA SCUOLA 4', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-19' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 1, 1, 1, CAST(N'2019-09-13' AS Date), 0, NULL, N'3', N'idMateria#1; idAnno#12345; idFreq#M@idMateria#10;idAnno#345;idFreq#S@idMateria#19; idAnno#345; idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 99, N'DE ZERBI ROBERTO', N'PERSO@ERGO.ORG', N'123123', N'6516156156', N'PIAZZA FILOSOFIA 1', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-20' AS Date), CAST(N'1900-01-01' AS Date), N'SAPERLO', 0, 0, 0, 1, 1, 1, CAST(N'2019-08-19' AS Date), 0, NULL, N'3', N'idMateria#1;idAnno#345;idFreq#S@idMateria#10;idAnno#345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 100, N'GASPERINI GIAN PIERO', N'GASGIAMPI@VALERIOMCSE.EU', N'123456789', N'111111', N'VIA LIBERAZIONE 11', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-19' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 1, 823822, N'3', N'idMateria#10;idAnno#12345;idFreq#S@idMateria#11;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 101, N'GUARDIOLA GIUSEPPE', N'TROPPOFORTE@VINCOSEMPRE.EU', N'TAGLIATO', N'', N'SEGRETO 11', N'', N'', N'', N'', N' ', CAST(N'2018-03-03' AS Date), CAST(N'2020-07-19' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'idMateria#12;idAnno#12345;idFreq#S@idMateria#15;idAnno#12345;idFreq#S@idMateria#38;idAnno#12345;idFreq#S@idMateria#39;idAnno#12345;idFreq#S@idMateria#40;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 102, N'GUIDOLIN FRANCESCO', N'GUIDO@PF.COM', N'5642399', N'521365879', N'PIAZZA SCUOLA 3', N'PALERMO', N'PA', N'90100', N'TEST', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'idMateria#12;idAnno#12;idFreq#S@idMateria#13; idAnno#12345; idFreq#S@idMateria#14; idAnno#12345; idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 103, N'IACHINI GIUSEPPE', N'IACHINI@SALVEZZA.IT', N'52166584', N'5145554', N'PIAZZA SCUOLA 3', N'PALERMO', N'PA', N'90100', N'', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-19' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'idMateria#9;idAnno#12345;idFreq#S@idMateria#36;idAnno#12;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 104, N'SCHELOTTO GUILLERMO BARROS', N'ADDIO@PORTOFRANCOPA.EDU', N'5546654844', N'5564455', N'PIAZZA INGLESE', N'PALERMO', N'PA', N'90100', N'TEST', N' ', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 105, N'STELLONE ROBERTO', N'PLAYOFF@ULTIMASPIAGGIA.SERIEA', N'TAGLIATO', N'', N'VIALE DEL FANTE 11', N'PALERMO', N'PA', N'', N'', N' ', CAST(N'2018-05-03' AS Date), CAST(N'2020-07-19' AS Date), CAST(N'1900-01-01' AS Date), N'', 0, 0, 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'idMateria#5;idAnno#12345;idFreq#S@idMateria#6;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
INSERT [dbo].[pf_anagrafeProfessori] ([idRS], [idProfessore], [nomeProf], [emailProf], [tel1Prof], [tel2Prof], [indirizzoProf], [comuneProf], [provProf], [capProf], [codiceFiscaleProf], [notaProf], [dataCreate], [dataUpdate], [dataNascitaProf], [luogoNascitaProf], [idTipoSocioProf], [idTipoProf], [deleted], [privacyProf], [liberaProf], [firmaProf], [firmaDataProf], [emailCheck], [checkCode], [sediProf], [materiaProf], [lezioniPrenotate], [versione], [dataVersione]) VALUES (14, 106, N'TEDINO BRUNO', N'BRUNO.PALERMO@SERIEA.ORG', N'11111111', N'34343434', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'TEST', N' ', CAST(N'2018-01-27' AS Date), CAST(N'2019-09-18' AS Date), CAST(N'1968-11-07' AS Date), N'ROMA', 0, 0, 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 153674, N'3', N'idMateria#14;idAnno#12345;idFreq#S', N'', N'0.0', CAST(N'2000-01-01' AS Date))
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeProfessori] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeStudenti] ON 
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (0, 0, N' --Tutti gli Studenti', N'email@valeriomcse.eu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, N'0', 0, NULL, CAST(N'2020-07-15' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, NULL, 0, 0, N'123', N'0.0', CAST(N'2020-07-15' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 169, N'ACCARDI MARIA DESIREE', N'MARIADESIREE2005@GMAIL.COM', CAST(N'2005-11-21' AS Date), N'PALERMO', N'', N'', N'VIA A.ALESSI N.2-C', N'PALERMO', N'PA', N'90128', N'3273321984', N'3201621441', 30, N'1', 0, N'LATINO', CAST(N'2019-11-20' AS Date), CAST(N'2019-12-27' AS Date), 0, 1, 1, 1, CAST(N'2019-11-20' AS Date), 1, 645933, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 164, N'ALBANESE JOSEPHINE', N'EMANUELACALABRO@GMAIL.COM', CAST(N'2006-04-26' AS Date), N'PALERMO', N'', N'', N'VIA VILLA FLORIO 10', N'PALERMO', N'PA', N'90100', N'3518854088', N'3493879711', 16, N'1', 0, N'MATEMATICA LATINO GRECO', CAST(N'2019-10-29' AS Date), CAST(N'2019-10-29' AS Date), 0, 1, 1, 1, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 176, N'ALBIONE CHIARA', N'ALBIONECHIARA03@GMAIL.COM', CAST(N'2003-02-09' AS Date), N'PALERMO', N'', N'', N'VIA L.SETTEMBRINI N.4', N'PALERMO', N'PA', N'90145', N'3884438434', N'3881198470', 28, N'4', 0, N'MATEMATICA FISICA', CAST(N'2019-11-27' AS Date), CAST(N'2019-11-27' AS Date), 0, 1, 1, 1, CAST(N'2019-11-27' AS Date), 1, 519172, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 2, N'ALEESAMI HAITAM', N'FASCIASX@PALERMO.ORG', CAST(N'2018-09-25' AS Date), N'PALERMO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'12345', N'321654', 24, N'2', 0, N'', CAST(N'2018-02-05' AS Date), CAST(N'2019-12-10' AS Date), 1, 1, 1, 1, CAST(N'2019-12-10' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 1, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 107, N'ALIOTO SOFIA', N'SOFIALATTUGA@GMAIL.COM', CAST(N'2002-04-08' AS Date), N'PALERMO', N'', N'', N'VIA F. PARUTA 22 A', N'PALERMO', N'PA', N'90131', N'3275653351', N'3291573147', 17, N'4', 0, N'MATEMATICA FISICA CHIMICA', CAST(N'2018-11-12' AS Date), CAST(N'2019-11-12' AS Date), 0, 1, 1, 1, CAST(N'2018-11-12' AS Date), 1, 597732, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 186, N'AMATO DANIELE', N'DANIELE.AMATO06@GMAIL.COM', CAST(N'2006-02-19' AS Date), N'PALERMO', N'', N'', N'VIA GIARDINO DELLA CONCORDIA 5', N'PALERMO', N'PA', N'90146', N'3923335929', N'3392039275', 28, N'1', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2019-12-18' AS Date), CAST(N'2019-12-18' AS Date), 0, 1, 1, 1, CAST(N'2019-12-18' AS Date), 1, 747754, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 3, N'AMIGHETTI EGLE', N'EGLEAMIGHETTI@ICLOUD.COM', CAST(N'2003-11-19' AS Date), N'PALERMO', N'', N'', N'VIA DEL PAPPAGALLO 9', N'PALERMO', N'PA', N'90133', N'3890043599', N'3491990030', 17, N'2', 0, N'MATEMATICA INGLESE CHIMICA', CAST(N'2019-01-18' AS Date), CAST(N'2019-01-18' AS Date), 1, 1, 1, 1, CAST(N'2019-01-18' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 108, N'ANELLO GIUSEPPE', N'RINGJOSEPH332@GMAIL.COM', CAST(N'2002-07-31' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 907', N'PALERMO', N'PA', N'90129', N'3202223634', N'3921144336', 30, N'3', 0, N'ITALIANO MATEMATICA FISICA', CAST(N'2018-11-19' AS Date), CAST(N'2019-10-28' AS Date), 0, 1, 1, 1, CAST(N'2018-11-19' AS Date), 1, NULL, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 191, N'BADALÌ FLORIANA', N'COSTANTINO-PIERA@VIRGILIO.IT', CAST(N'2003-12-16' AS Date), N'PALERMO', N'', N'', N'VIA VALDEMONE 14', N'PALERMO', N'PA', N'90144', N'3483473324', N'3282691615', 14, N'3', 0, N'ITALIANO STORIA MATEMATICA', CAST(N'2020-01-10' AS Date), CAST(N'2020-01-10' AS Date), 0, 1, 1, 1, CAST(N'2020-01-10' AS Date), 1, 115416, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 4, N'BARRIE SULAIMAN', N'BARRIESULA@GMAIL.COM', CAST(N'1999-05-28' AS Date), N'SIERRA LEONE', N'', N'', N'VIA MESSINA MARINA N.422', N'PALERMO', N'PA', N'90100', N'3394625850', N'3394625850', 6, N'3', 0, N'MATEMATICA FISICA ELETTROMECCANICA', CAST(N'2019-01-30' AS Date), CAST(N'2020-02-06' AS Date), 0, 1, 1, 1, CAST(N'2019-09-23' AS Date), 0, 780430, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 2, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 5, N'BARTOLOTTA IRENE', N'IRENEBARTOLOTTA974@GMAIL.COM', CAST(N'2001-03-09' AS Date), N'PALERMO', N'', N'', N'VIA GINO ZAPPA- 92', N'PALERMO', N'PA', N'90146', N'3276739565', N'3299370267', 4, N'5', 0, N'ECONOMIA AZIENDALE-MATEMATICA', CAST(N'2018-11-26' AS Date), CAST(N'2018-11-26' AS Date), 1, 1, 1, 1, CAST(N'2018-11-26' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 6, N'BARTOLOTTA RICCARDO', N'BARTOLOTTA04@GMAIL.COM', CAST(N'2004-12-26' AS Date), N'PALERMO', N'', N'', N'VIA GINO ZAPPA- 92', N'PALERMO', N'PA', N'90146', N'3332036612', N'3299370267', 25, N'1', 0, N'MATEMATICA', CAST(N'2018-11-26' AS Date), CAST(N'2018-11-26' AS Date), 1, 1, 1, 1, CAST(N'2018-11-26' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 109, N'BASILE LUCA ANDREA', N'LUCAKARATEKID@GMAIL.COM', CAST(N'2004-01-03' AS Date), N'PALERMO', N'', N'', N'VIA VILLA MAIO 10 N. 29', N'PALERMO', N'PA', N'90131', N'3312004556', N'3662150282', 7, N'2', 0, N'MATEMATICA FISICA CHIMICA', CAST(N'2019-02-13' AS Date), CAST(N'2019-02-18' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 144, N'BERTOLINO MARTINA', N'FRANCYBERTOLINO54@GMAIL.COM', CAST(N'2002-02-01' AS Date), N'PALERMO', N'', N'', N'VIA PERPIGNANO 29', N'PALERMO', N'PA', N'90135', N'3896606906', N'3895328758', 36, N'5', 0, N'INGLESE ECONOMIA AZIENDALE ECONOMIA POLITICA', CAST(N'2019-09-26' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 242008, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 7, N'BONGIORNO GABRIELE', N'MARY.GABRY2001@LIBERO.IT', CAST(N'2001-11-02' AS Date), N'PALERMO', N'', N'', N'VIA GIUSEPPE DI STEFANO 15', N'PALERMO', N'PA', N'90135', N'3886247424', N'3405849361', 17, N'5', 0, N'MATEMATICA LATINO GRECO', CAST(N'2018-09-26' AS Date), CAST(N'2019-09-23' AS Date), 0, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, 973626, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 196, N'BONOMO OLGA ALESSIA', N'OLGAALESSIABONOMO@GMAIL.COM', CAST(N'2003-12-22' AS Date), N'PALERMO', N'', N'', N'VIA DON LUIGI STURZO 159', N'CARINI', N'PA', N'90044', N'3515330652', N'3297007584', 16, N'3', 0, N'LATINO GRECO', CAST(N'2020-01-17' AS Date), CAST(N'2020-01-17' AS Date), 0, 1, 1, 1, CAST(N'2020-01-17' AS Date), 1, 409636, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 8, N'BONURA VINCENZO', N'VINCIBONURA13@GMAIL.COM', CAST(N'2002-10-14' AS Date), N'PALERMO', N'', N'', N'VIA PAOLO CAGGIO- 28', N'PALERMO', N'PA', N'90135', N'3248317009', N'3801754209', 37, N'3', 0, N'MATEMATICA-ELETTROTECNICA', CAST(N'2018-10-15' AS Date), CAST(N'2018-10-15' AS Date), 1, 1, 1, 1, CAST(N'2018-10-15' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 9, N'BORDELAIS ANNALISA IRENE', N'ANNALISABORDELAIS@YAHOO.IT', CAST(N'2000-06-17' AS Date), N'PALERMO', N'', N'', N'CORSO VITTORIO EMANUELE- 111', N'PALERMO', N'PA', N'90133', N'3791246273', N'3276561811', 5, N'5', 0, N'MATEMATICA- INGLESE', CAST(N'2019-03-11' AS Date), CAST(N'2019-11-29' AS Date), 0, 1, 1, 1, CAST(N'2019-03-11' AS Date), 1, 273522, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 148, N'BRUNETTI GINEVRA', N'BRUNETTIGINEVRA1@GMAIL.COM', CAST(N'2004-11-27' AS Date), N'PALERMO', N'', N'', N'VIA LUSSEMBURGO N.75', N'PALERMO', N'PA', N'90146', N'3280696308', N'3272995692', 21, N'1', 0, N'INGLESE MATEMATICA ITALIANO', CAST(N'2019-10-11' AS Date), CAST(N'2019-10-11' AS Date), 0, 1, 1, 1, CAST(N'2019-10-11' AS Date), 1, 903915, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 150, N'BRUNETTI GIORGIA', N'GIORGIABRUNETTI2017@GMAIL.COM', CAST(N'2001-07-14' AS Date), N'PALERMO', N'', N'', N'VIA LUSSEMBURGO N.75', N'PALERMO', N'PA', N'90146', N'3246931322', N'3272995692', 21, N'4', 0, N'MATEMATICA', CAST(N'2019-10-14' AS Date), CAST(N'2019-10-14' AS Date), 0, 1, 1, 1, CAST(N'2019-10-14' AS Date), 1, 859395, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 149, N'BRUNETTI GIUDITTA', N'BRUNETTIGIUDITTA2004@GMAIL.COM', CAST(N'2004-11-27' AS Date), N'PALERMO', N'', N'', N'VIA LUSSEMBURGO 75', N'PALERMO', N'PA', N'90146', N'3277586957', N'3272995692', 21, N'2', 0, N'STORIA ITALIANO SCIENZE NATURALI MATEMATICA', CAST(N'2019-10-11' AS Date), CAST(N'2019-10-14' AS Date), 0, 1, 1, 1, CAST(N'2019-10-11' AS Date), 1, 965554, N'1', N'1.16', CAST(N'2019-10-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 10, N'BRUSCA IVAN', N'IVANBRUSCA10@GMAIL.COM', CAST(N'2003-04-18' AS Date), N'PALERMO', N'', N'', N'VIA CELONA 6', N'PALERMO', N'PA', N'90140', N'3911827145', N'3282877278', 11, N'3', 0, N'SPAGNOLO INGLESE MATEMATICA', CAST(N'2018-09-26' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, 178562, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 192, N'BUFFA DESIRÈE', N'BUFFADESIREE@GMAIL.COM', CAST(N'2004-04-30' AS Date), N'PALERMO', N'', N'', N'VIA SAITTA LONGHI 66', N'PALERMO', N'PA', N'90131', N'3808671251', N'3286569558', 19, N'3', 0, N'MATEMATICA  LATINO  GRECO', CAST(N'2020-01-13' AS Date), CAST(N'2020-01-13' AS Date), 0, 0, 0, 0, NULL, 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 11, N'CAFIERO DAVIDE', N'DAVIDECAFIERO2004@GMAIL.COM', CAST(N'2004-06-08' AS Date), N'PALERMO', N'', N'', N'VIA EUGENIO L-EMIRO N.13', N'PALERMO', N'PA', N'90135', N'3921184403', N'3894415146', 36, N'2', 0, N'FRANCESE MATEMATICA', CAST(N'2019-02-18' AS Date), CAST(N'2020-01-15' AS Date), 0, 1, 1, 1, CAST(N'2020-01-15' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 147, N'CAMINITA CRISTIAN', N'CHRISTIANCAMINITA03@GMAIL.COM', CAST(N'2003-06-24' AS Date), N'PALERMO', N'', N'', N'VIA GUGLIELMO IL BUONO N.148', N'PALERMO', N'PA', N'90100', N'3889967352', N'3884649982', 17, N'1', 0, N'GRECO LATINO MATEMATICA', CAST(N'2019-10-11' AS Date), CAST(N'2019-10-11' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 12, N'CAMMARATA DANIELE', N'CONIGLIAROAURIANA@LIBERO.IT', CAST(N'2001-11-01' AS Date), N'PALERMO', N'', N'', N'VIA A. CASSARINO 108', N'PALERMO', N'PA', N'90135', N'3924692947', N'3200711286', 37, N'4', 0, N'INGLESE MATEMATICA', CAST(N'2018-10-02' AS Date), CAST(N'2019-09-23' AS Date), 0, 1, 1, 1, CAST(N'2018-10-17' AS Date), 1, 283604, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 110, N'CAMPANELLA GIULIA', N'FABIOLAMODICASPORT@LIBERO.IT', CAST(N'2005-03-15' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 589', N'PALERMO', N'PA', N'90129', N'3296953851', N'3287885907', 7, N'1', 0, N'MATEMATICA FISICA STORA', CAST(N'2018-12-04' AS Date), CAST(N'2018-12-04' AS Date), 1, 1, 1, 0, NULL, 0, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 111, N'CAMPANELLA ROBERTO', N'RBRTCAMPANELLA@GMAIL.COM', CAST(N'2001-12-17' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 589', N'PALERMO', N'PA', N'90129', N'3669300919', N'3287885907', 7, N'4', 0, N'MATEMATICA', CAST(N'2018-12-04' AS Date), CAST(N'2018-12-04' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 155, N'CAMPO FABRIZIO', N'CAMPO25FF@GMAIL.COM', CAST(N'2004-01-12' AS Date), N'PALERMO', N'', N'', N'VIA GENERALI BERGONZOLI N.32', N'PALERMO', N'PA', N'90129', N'3913317458', N'3279821980', 30, N'3', 0, N'MATEMATICA FISICA', CAST(N'2019-10-23' AS Date), CAST(N'2019-10-23' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 14, N'CAPPELLANO SOFIA', N'FRINGUELLOMIAO@LIBERO.IT', CAST(N'2004-03-06' AS Date), N'PALERMO', N'', N'', N'VIA ANTONIO CASSARINO N.69', N'PALERMO', N'PA', N'90100', N'3396411374', N'3389734308', 28, N'1', 0, N'', CAST(N'2018-06-25' AS Date), CAST(N'2018-09-25' AS Date), 1, 1, 1, 1, CAST(N'2018-09-25' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 15, N'CARDACI MATTIA', N'CARDACIM4@GMAIL.COM', CAST(N'2003-05-11' AS Date), N'PALERMO', N'', N'', N'VIA BEATI PAOLI 65', N'PALERMO', N'PA', N'90134', N'3714364275', N'3426821184', 37, N'3', 0, N'ITALIANO MATEMATICA INFORMATICA', CAST(N'2018-12-19' AS Date), CAST(N'2020-02-03' AS Date), 0, 1, 1, 1, CAST(N'2018-12-19' AS Date), 1, 839028, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 16, N'CARFÌ VITO', N'VACRFIX@GMAIL.COM', CAST(N'2001-02-03' AS Date), N'PALERMO', N'', N'', N'VIA SAN MARTINO 228', N'PALERMO', N'PA', N'90136', N'3200540966', N'3392468309', 28, N'4', 0, N'MATEMATICA', CAST(N'2019-04-08' AS Date), CAST(N'2019-04-08' AS Date), 1, 1, 1, 0, NULL, 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 136, N'CAROLLO ANDREA DOMENICO', N'CAROLLO_GIOVANNI@YAHOO.IT', CAST(N'2005-11-17' AS Date), N'PALERMO', N'', N'', N'VIA LANCIA DI BROLO', N'PALERMO', N'PA', N'90145', N'3293065306', N'3201817066', 37, N'1', 0, N'STORIA- DIRITTO', CAST(N'2019-09-24' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 17, N'CAROLLO GAIA', N'CAROLLOGAIA1@GMAIL.COM', CAST(N'2000-09-18' AS Date), N'PALERMO', N'', N'', N'VIA ASSORO- 10', N'PALERMO', N'PA', N'90135', N'3911243901', N'3286825291', 22, N'5', 0, N'MATEMATICA', CAST(N'2018-11-12' AS Date), CAST(N'2018-11-12' AS Date), 1, 1, 1, 1, CAST(N'2018-11-12' AS Date), 1, 901163, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 18, N'CARUANA CHIARA', N'AMATO3210@GMAIL.COM', CAST(N'2004-02-03' AS Date), N'PALERMO', N'', N'', N'LARGO M. ACCARDO 7', N'PALERMO', N'PA', N'90145', N'3713442542', N'3713442542', 11, N'3', 0, N'ITALIANO INGLESE MATEMATICA', CAST(N'2018-09-27' AS Date), CAST(N'2020-02-06' AS Date), 0, 1, 1, 1, CAST(N'2018-10-11' AS Date), 1, 810404, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 19, N'CARUSO ALESSIO', N'ALESSIOCARUSO362@GMAIL.COM', CAST(N'2002-01-10' AS Date), N'PALERMO', N'', N'', N'VIA NAVE 24', N'PALERMO', N'PA', N'90135', N'3896489514', N'3297473968', 12, N'3', 0, N'MATEMATICA INGLESE CHIMICA', CAST(N'2019-05-10' AS Date), CAST(N'2019-05-10' AS Date), 1, 1, 1, 1, CAST(N'2019-05-10' AS Date), 1, 381829, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 141, N'CASISI ANTONIO', N'ANTONIOCASISI00@GMAIL.COM', CAST(N'2003-09-20' AS Date), N'PALERMO', N'', N'', N'VIA DOSSUNA 165', N'PALERMO', N'PA', N'90134', N'3246838272', N'3404188686', 17, N'3', 0, N'LATINO GRECO MATEMATICA', CAST(N'2019-09-24' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 1, 377317, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 173, N'CASTIGLIA GIOVANNI CARLO', N'GCCASTIGLIA2014@GMAIL.COM', CAST(N'2002-07-22' AS Date), N'PALERMO', N'', N'', N'VIA COSTANTINO NIGRA N.54', N'PALERMO', N'PA', N'90141', N'3248081171', N'3807951022', 17, N'4', 0, N'MATEMATICA FISICA GRECO', CAST(N'2019-11-27' AS Date), CAST(N'2019-11-27' AS Date), 0, 1, 1, 1, CAST(N'2019-11-27' AS Date), 1, 259388, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 160, N'CATALDI SIMONA', N'SIMONA02C@GMAIL.COM', CAST(N'2002-10-17' AS Date), N'PALERMO', N'', N'', N'VIA ROCCAZZO 112', N'PALERMO', N'PA', N'90135', N'3298471763', N'3208376462', 28, N'4', 0, N'MATEMATICA FISICA', CAST(N'2019-10-25' AS Date), CAST(N'2019-10-25' AS Date), 0, 1, 1, 1, CAST(N'2019-10-25' AS Date), 1, 633327, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 20, N'CAVALLARO EGLE', N'ALESSANDRARICCARDO77@HOTMAIL.IT', CAST(N'2003-11-13' AS Date), N'PALERMO', N'', N'', N'VIA ALCANTARA N.13', N'PALERMO', N'PA', N'90135', N'3392143569', N'3804768574', 22, N'2', 0, N'MATEMATICA INGLESE SCIENZE', CAST(N'2019-01-08' AS Date), CAST(N'2019-01-11' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 170, N'CAVALLOTTI ALESSANDRO', N'CRT_CAVA@LIBERO.IT', CAST(N'2004-12-26' AS Date), N'PALERMO', N'', N'', N'VIA TASCA LANZA 78', N'PALERMO', N'PA', N'90135', N'3200119288', N'3285618424', 37, N'2', 0, N'MATEMATICA INGLESE', CAST(N'2019-11-25' AS Date), CAST(N'2019-11-25' AS Date), 0, 1, 1, 1, CAST(N'2019-11-25' AS Date), 1, 505976, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 21, N'CERVELLO GIORGIA', N'GIORGIACERVELLO1701@GMAIL.COM', CAST(N'2003-01-17' AS Date), N'PALERMO', N'', N'', N'VIA CORPO DI GUARDIA 9', N'MONREALE', N'PA', N'90046', N'3247863435', N'3397656866', 15, N'4', 0, N'LATINO - GRECO - FISICA', CAST(N'2018-09-28' AS Date), CAST(N'2019-09-23' AS Date), 0, 1, 1, 1, CAST(N'2018-09-28' AS Date), 1, 677649, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 151, N'CHIAPPARA MARCO', N'CHIAPPARAMARCO1@GMAIL.COM', CAST(N'2001-09-12' AS Date), N'PALERMO', N'', N'', N'LARGO IPPONA 4', N'PALERMO', N'PA', N'90135', N'3208798567', N'3406918927', 6, N'5', 0, N'MATEMATICA MECCANICA ITALIANO', CAST(N'2019-10-15' AS Date), CAST(N'2019-10-15' AS Date), 0, 1, 1, 1, CAST(N'2019-10-15' AS Date), 1, 114050, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 22, N'CHIARACANE SARA', N'immesi1401@gmail.com', NULL, NULL, N'CHRSRA00E66G273Y', N'', N'Via Villa De Gregorio 7 F', N'Palermo', N' ', N' ', N'3291353151', N'3922239378', 17, N'5', 0, N'', CAST(N'2018-04-09' AS Date), CAST(N'2018-04-09' AS Date), 1, 0, 0, 0, NULL, 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 194, N'CHIAVETTA VINCENZO KAROL', N'NOEMILIBIANCHI15@GMAIL.COM', CAST(N'2005-12-09' AS Date), N'PALERMO', N'', N'', N'VIA G. B. LULLI 4', N'PALERMO', N'PA', N'90145', N'3911153398', N'0916813801', 6, N'1', 0, N'ITALIANO MATEMATICA DIRITTO', CAST(N'2020-01-14' AS Date), CAST(N'2020-01-14' AS Date), 0, 1, 1, 0, NULL, 1, 108768, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 23, N'CHIFARI GABRIEL', N'PIETROCHIFARI@LIBERO.IT', CAST(N'2005-11-13' AS Date), N'PALERMO', N'', N'', N'VIA AQUINO N.8', N'MONREALE -AQUINO-', N'PA', N'90044', N'3661852786', N'3885878126', 28, N'2', 0, N'LATINO ITALIANO', CAST(N'2019-06-20' AS Date), CAST(N'2019-10-01' AS Date), 0, 1, 1, 1, CAST(N'2019-06-20' AS Date), 1, 188773, N'12', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 200, N'CHOWDHURI SAHIFA', N'CSAHIFA2017@GMAIL.COM', CAST(N'2000-12-23' AS Date), N'BANGLADESH', N'', N'', N'VIA P. COLLETTA 39', N'PALERMO', N'PA', N'90135', N'3271110502', N'3208057317', 5, N'5', 0, N'MATEMATICA FRANCESE', CAST(N'2020-01-24' AS Date), CAST(N'2020-01-24' AS Date), 0, 1, 1, 1, CAST(N'2020-01-24' AS Date), 1, 350078, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 2, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 24, N'CIOCEV STEFAN', N'STUDENTE4@VALERIOMCSE.EU', CAST(N'1998-09-09' AS Date), N'BULGARIA', N'', N'', N'VIA CAMPOLO 4', N'PALERMO', N'PA', N'90145', N'32112345678', N'3215468', 8, N'1', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-03-10' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 674163, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 181, N'CONSIGLIO CHIARA', N'GIULIACONSIGLIO95@GMAIL.COM', CAST(N'2004-04-05' AS Date), N'PALERMO', N'', N'', N'VIA CESARE TERRANOVA 8', N'PALERMO', N'PA', N'90131', N'3474632366', N'3496278264', 7, N'2', 0, N'MATEMATICA FISICA LATINO', CAST(N'2019-12-11' AS Date), CAST(N'2019-12-16' AS Date), 0, 1, 1, 1, CAST(N'2019-12-16' AS Date), 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 25, N'CORONADO IGOR', N'CORO@PALERMO.IT', CAST(N'2018-09-05' AS Date), N'PALERMO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'TAGLIATO', N'AVERLO', 33, N'2', 0, N'', CAST(N'2018-02-06' AS Date), CAST(N'2019-09-18' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 177, N'CRISTIANO FEDERICA', N'CRISTIANOFEDERICA7@GMAIL.COM', CAST(N'2003-11-18' AS Date), N'PALERMO', N'', N'', N'VIA GIUSEPPE STAZIONE N 9', N'PALERMO', N'PA', N'90100', N'3291977836', N'3292218602', 6, N'2', 0, N'INGLESE- ITALIANO', CAST(N'2019-11-28' AS Date), CAST(N'2019-11-28' AS Date), 0, 1, 1, 1, CAST(N'2019-11-28' AS Date), 1, 327914, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 112, N'CUSUMANO SOFIA', N'MARCELLADMR@LIBERO.IT', CAST(N'1999-07-11' AS Date), N'PALERMO', N'CSMSFO99L51G273U', N'', N'VIA SAMBUCIA- 10', N'PALERMO', N'PA', N'90126', N'3737224667', N'3701258304', 7, N'5', 0, N' ', CAST(N'2019-02-13' AS Date), CAST(N'2019-02-13' AS Date), 1, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 146, N'D-ALEO ROBERTA', N'ROBY22.DALEO@GMAIL.COM', CAST(N'2002-10-02' AS Date), N'PALERMO', N'', N'', N'VIA VERSILIA- 5', N'PALERMO', N'PA', N'90144', N'3319498744', N'3881737200', 16, N'4', 0, N'LATINO-GRECO-FILOSOFIA-MATEMATICA', CAST(N'2019-10-10' AS Date), CAST(N'2019-10-25' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 154, N'DALLARI SALVATORE', N'SALVO.DALLARI05@GMAIL.COM', CAST(N'2005-05-23' AS Date), N'PALERMO', N'', N'', N'VIA BORREMANS N-9', N'PALERMO', N'PA', N'90145', N'3885670191', N'3207507580', 28, N'1', 0, N'MATEMATICA', CAST(N'2019-10-22' AS Date), CAST(N'2019-10-22' AS Date), 0, 1, 1, 1, CAST(N'2019-10-22' AS Date), 1, 178857, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 26, N'D-AMICO ROMINA', N'ROMIDAMI03@ICLOUD.COM', CAST(N'2003-08-06' AS Date), N'PALERMO', N'', N'', N'LARGO CASTELTERMINI 5', N'PALERMO', N'PA', N'90135', N'3291248010', N'3293531840', 22, N'3', 0, N'INGLESE - CHIMICA', CAST(N'2018-10-09' AS Date), CAST(N'2019-10-03' AS Date), 0, 1, 1, 1, CAST(N'2019-01-16' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 27, N'DE GESU GABRIELE', N'GABRY.DEGESU@GMAIL.COM', CAST(N'2004-06-08' AS Date), N'PALERMO', N'', N'', N'VIA GIOTTO 64', N'PALERMO', N'PA', N'90145', N'3927861993', N'3335693237', 16, N'1', 0, N'CHIMICA SCIENZE DELLA TERRA', CAST(N'2019-02-28' AS Date), CAST(N'2019-09-25' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 746006, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 113, N'DE LUCA VALERIA', N'LANDOLFITIZ@LIVE.IT', CAST(N'2003-12-30' AS Date), N'PALERMO', N'', N'', N'VIA PALMERINO 13', N'PALERMO', N'PA', N'90129', N'3293061195', N'3312244321', 23, N'3', 0, N'MATEMATICA', CAST(N'2018-11-19' AS Date), CAST(N'2019-09-25' AS Date), 0, 1, 1, 1, CAST(N'2018-11-19' AS Date), 1, 204939, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 28, N'DI CARA ELEONORA', N'DICARAMAURIZIO@LIBERO.IT', CAST(N'2003-09-29' AS Date), N'PALERMO', N'', N'', N'LARGO BERNARDO GERACI- 12', N'PALERMO', N'PA', N'90145', N'3246078926', N'3474497642', 15, N'2', 0, N'CHIMICA', CAST(N'2018-11-19' AS Date), CAST(N'2018-11-19' AS Date), 1, 1, 1, 1, CAST(N'2018-11-19' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 217, N'DI GIROLAMO ELIENE CRISTINA', N'CRIDIGIROLAMO@ICLOUD.COM', CAST(N'2003-07-07' AS Date), N'PALERMO', N'', N'', N'VIA GIOVAN BATTISTA BASILE 45', N'PALERMO', N'PA', N'90100', N'3477228554', N'3288618709', 17, N'3', 0, N'MATEMATICA FISICA', CAST(N'2020-02-25' AS Date), CAST(N'2020-02-25' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 837989, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 29, N'DI LIBERTO ERIKA', N'DILIBERTOERIKA3@GMAIL.COM', CAST(N'2001-03-02' AS Date), N'PALERMO', N'', N'', N'VIA M. VACCARO 13', N'PALERMO', N'PA', N'90145', N'3271141925', N'3515189223', 22, N'5', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2018-12-07' AS Date), CAST(N'2018-12-07' AS Date), 1, 1, 1, 1, CAST(N'2018-12-07' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 158, N'DI MARTINO ALICE', N'LINGANPI03@GMAIL.COM', CAST(N'2003-01-07' AS Date), N'PALERMO', N'', N'', N'VIA DEI FRISCALETTARI 73', N'PALERMO', N'PA', N'90147', N'3920848130', N'3273430064', 38, N'4', 0, N'TEDESCO', CAST(N'2019-10-24' AS Date), CAST(N'2019-10-24' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 139, N'DI PIAZZA FRANCESCA', N'DIPIAZZAFRANCESCA4@GMAIL.COM', CAST(N'2004-05-17' AS Date), N'PALERMO', N'', N'', N'VIA DEGLI EMIRI 10', N'PALERMO', N'PA', N'90135', N'3204289787', N'3281928534', 19, N'2', 0, N'LATINO GRECO MATEMATICA', CAST(N'2019-09-24' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 140, N'DI PIAZZA MIRIAM CONCETTA', N'MDIPIAZZ@GMAIL.COM', CAST(N'2002-07-25' AS Date), N'PALERMO', N'', N'', N'VIA DEGLI EMIRI 10', N'PALERMO', N'PA', N'90135', N'3911343908', N'3281928534', 36, N'3', 0, N'MATEMATICA INGLESE ECONOMIA', CAST(N'2019-09-24' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 1, 133865, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 30, N'DI STEFANO BENEDETTO', N'BENNYINTERISTA@HOTMAIL.IT', CAST(N'1999-12-16' AS Date), N'PALERMO', N'', N'', N'VIA G. LA LOGGIA 40', N'PALERMO', N'PA', N'90129', N'3292054612', N'3287094884', 36, N'5', 0, N'INGLESE', CAST(N'2018-11-30' AS Date), CAST(N'2018-11-30' AS Date), 1, 1, 1, 1, CAST(N'2018-11-30' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 31, N'DI STEFANO MARTINA RITA', N'MARTIDST@ICLOUD.COM', CAST(N'2002-04-30' AS Date), N'PALERMO', N'', N'', N'VIA GAETANO LA LOGGIA N.40', N'PALERMO', N'PA', N'90129', N'3248231836', N'3287094884', 36, N'4', 0, N'MATEMATICA FRANCESE', CAST(N'2018-12-12' AS Date), CAST(N'2019-01-11' AS Date), 1, 1, 1, 1, CAST(N'2018-12-20' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 32, N'DIAKITE- MAKAN', N'DANICL2013@GMAIL.COM', CAST(N'2000-02-02' AS Date), N'REPUBBLICA DEL MALI', N'', N'', N'VIA ARCHIMEDE N.92', N'PALERMO', N'PA', N'90139', N'3511589387', N'3397539286', 32, N'1', 0, N'MATEMATICA  INGLESE', CAST(N'2019-02-27' AS Date), CAST(N'2019-02-27' AS Date), 1, 1, 1, 1, CAST(N'2019-02-27' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 114, N'DOMINICI LUCA', N'LUCADOMINICI.03@GMAIL.COM', CAST(N'2004-08-30' AS Date), N'PALERMO', N'', N'', N'VIA P. MERCANTI 34', N'PALERMO', N'PA', N'90131', N'3899346937', N'3492319072', 7, N'1', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2019-02-11' AS Date), CAST(N'2019-02-11' AS Date), 1, 1, 1, 1, CAST(N'2019-02-11' AS Date), 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 115, N'DONATO SILVIA', N'SILVIADONATO@OUTLOOK.IT', CAST(N'1999-09-12' AS Date), N'PALERMO', N'', N'', N'VIA DEL SOMMACCO 6 D', N'MISILMERI', N'PA', N'90036', N'3277813519', N'3805406804', 24, N'5', 0, N'MATEMATICA FISICA', CAST(N'2019-01-18' AS Date), CAST(N'2019-01-18' AS Date), 1, 1, 1, 1, CAST(N'2019-01-18' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 179, N'ESPOSITO GIORGIA', N'GIORGIAE2005@GMAIL.COM', CAST(N'2005-04-15' AS Date), N'PALERMO', N'', N'', N'VIA PALMERINO 69', N'PALERMO', N'PA', N'90129', N'3209072129', N'3333222552', 7, N'2', 0, N'FISICA MATEMATICA', CAST(N'2019-12-09' AS Date), CAST(N'2019-12-09' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 116, N'FAZZARI EMANUELE', N'EMANUELEFAZZARI16@GMAIL.COM', CAST(N'2003-06-16' AS Date), N'PALERMO', N'', N'', N'VIA PALMERINO MOLARA 16', N'PALERMO', N'PA', N'90131', N'3888222350', N'3386101612', 30, N'3', 0, N'MATEMATICA FISICA', CAST(N'2018-11-13' AS Date), CAST(N'2020-01-09' AS Date), 0, 1, 1, 1, CAST(N'2018-11-12' AS Date), 1, NULL, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 33, N'FIORE GIULIA SOFIA', N'GIULIASOFIAF@GMAIL.COM', CAST(N'2002-04-21' AS Date), N'PALERMO', N'', N'', N'VIALE PIEMONTE 55', N'PALERMO', N'PA', N'90144', N'3881465126', N'3339121665', 16, N'4', 0, N'MATEMATICA LATINO GRECO', CAST(N'2018-10-19' AS Date), CAST(N'2020-05-25' AS Date), 0, 1, 1, 1, CAST(N'2018-11-09' AS Date), 0, 141868, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 198, N'FLORIO GIUSEPPE', N'GIUSEPPEFLORIO713@GMAIL.COM', CAST(N'2006-01-18' AS Date), N'PALERMO', N'', N'', N'VIA V. AURIA 16', N'PALERMO', N'PA', N'90100', N'3925160353', N'3663656658', 11, N'1', 0, N'MATEMATICA INGLESE ITALIANO', CAST(N'2020-01-21' AS Date), CAST(N'2020-01-21' AS Date), 0, 1, 1, 1, CAST(N'2020-01-21' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 117, N'FORESTIERI ALESSIO', N'TROLLBOYER95@GMAIL.COM', CAST(N'2003-06-01' AS Date), N'PALERMO', N'', N'', N'VIA VILLAGRAZIA 19', N'PALERMO', N'PA', N'90124', N'3312153690', N'3278289847', 37, N'2', 0, N'MATEMATICA FISICA CHIMICA', CAST(N'2019-01-14' AS Date), CAST(N'2019-01-21' AS Date), 1, 1, 1, 1, CAST(N'2019-01-21' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 118, N'FORESTIERI GABRIEL', N'GABRIEL0312.GF@GMAIL.COM', CAST(N'2004-12-03' AS Date), N'PALERMO', N'', N'', N'VIA VILLAGRAZIA 19', N'PALERMOPA', N'PA', N'90124', N'3343639470', N'3278289847', 13, N'1', 0, N'MATEMATICA FISICA CHIMICA', CAST(N'2019-01-14' AS Date), CAST(N'2019-01-21' AS Date), 1, 1, 1, 1, CAST(N'2019-01-21' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 34, N'GERACI DOMENICO', N'DOMENICO.GERACI2001@GMAIL.COM', CAST(N'2001-11-06' AS Date), N'', N'GRCDNC01S07G273O', N'', N'VIALE DELLE ALPI N.115', N'PALERMO', N'-O', N'-OBJE', N'3897889943', N'3295356535', 4, N'3', 0, N'', CAST(N'2018-06-25' AS Date), CAST(N'2018-09-25' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 178, N'GIAMMONA MICHELA', N'MICHIGIAMMONA@LIBERO.IT', CAST(N'2001-03-28' AS Date), N'PALERMO', N'', N'', N'VIA AMMIRAGLIO CARLO BERGAMINI 16', N'PALERMO', N'PA', N'90128', N'3892638179', N'3892183295', 12, N'5', 0, N'MATEMATICA', CAST(N'2019-11-29' AS Date), CAST(N'2019-11-29' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 215, N'GIANGRECO ALISIA', N'GIOVANNIGIANGRECO@HOTMAIL.IT', CAST(N'2005-12-04' AS Date), N'PALERMO', N'', N'', N'VIA ASSORO 41', N'PALERMO', N'PA', N'90135', N'3711158305', N'3332512377', 27, N'1', 0, N'INGLESE LATINO MATEMATICA', CAST(N'2020-02-21' AS Date), CAST(N'2020-02-21' AS Date), 0, 1, 1, 1, CAST(N'2020-02-21' AS Date), 1, 123100, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 35, N'GIULIANO FEDERICA', N'LAURA.ARLOTTA@LIBERO.IT', CAST(N'2003-04-11' AS Date), N'PALERMO', N'', N'', N'VIA MAMMANA 262', N'PALERMO', N'PA', N'90145', N'3478587187', N'3288197003', 22, N'4', 0, N'MATEMATICA - FISICA - SCIENZE', CAST(N'2018-06-20' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, 387801, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 37, N'GUARNOTTA GIORGIA', N'GIORGIAGUARNO99@GMAIL.COM', CAST(N'2002-05-13' AS Date), N'PALERMO', N'', N'', N'VIA RAFFAELLO 9', N'PALERMO', N'PA', N'90145', N'3297727548', N'3926373954', 17, N'4', 0, N'LATINO GRECO CHIMICA', CAST(N'2018-10-23' AS Date), CAST(N'2020-01-27' AS Date), 1, 1, 1, 1, CAST(N'2019-11-04' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 207, N'GUARNUTO EMANUELE', N'EMANUELEGUARNUTO@GMAIL.COM', CAST(N'2003-12-11' AS Date), N'PALERMO', N'', N'', N'VIA DOMENICO RUSSO 8B', N'PALERMO', N'PA', N'90131', N'3892116155', N'3281930200', 30, N'3', 0, N'MATEMATICA CHIMICA  ITALIANO LATINO', CAST(N'2020-01-29' AS Date), CAST(N'2020-01-29' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 153, N'GURGONE MARCO', N'MARCOGURGO@GMAIL.COM', CAST(N'2003-03-26' AS Date), N'PALERMO', N'', N'', N'VIA CILEA 11', N'PALERMO', N'PA', N'90144', N'3924775317', N'3381787440', 17, N'3', 0, N'CHIMICA', CAST(N'2019-10-22' AS Date), CAST(N'2019-10-22' AS Date), 0, 1, 1, 1, CAST(N'2019-10-22' AS Date), 1, 628406, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 38, N'INGOGLIA SOFIA', N'SOFIAINGOGLIA1999@GMAIL.COM', CAST(N'1999-01-27' AS Date), N'PALERMO', N'', N'', N'VIA ZAMPARRONE 1', N'PALERMO', N'PA', N'90145', N'3920089430', N'3404127068', 6, N'4', 0, N'MATEMATICA', CAST(N'2018-10-16' AS Date), CAST(N'2018-10-16' AS Date), 1, 1, 1, 1, CAST(N'2018-10-16' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 39, N'INZERILLO DAFNE', N'INZERILLO.ANNA@GMAIL.COM', CAST(N'2003-04-26' AS Date), N'PALERMO', N'NZRDNR03D66G273U', N'', N'VIA ROMAGNA- 7', N'PALERMO', N'PA', N'90144', N'3487691916', N'3280954795', 21, N'2', 0, N'LATINO- INGLESE', CAST(N'2019-03-11' AS Date), CAST(N'2019-03-11' AS Date), 1, 1, 1, 0, NULL, 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 40, N'IONES NOEMI', N'IONESNOEMI14@GMAIL.COM', CAST(N'2004-02-14' AS Date), N'PARTINICO', N'NSINMO04B54G348B', N'', N'VIA ROCCAZZO- 100-L', N'PALERMO', N'PA', N'90100', N'3206416710', N'3755021404', 22, N'3', 0, N'INGLESE  CHIMICA', CAST(N'2018-06-18' AS Date), CAST(N'2019-10-22' AS Date), 0, 1, 1, 1, CAST(N'2019-10-22' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 41, N'JAJALO MATO', N'STUDENTE5@SCUOLA.IT', CAST(N'2018-09-06' AS Date), N'PALERMO', N'', N'', N'VIA CAMPOLO 5', N'PALERMO', N'PA', N'90100', N'321456218', N'321234584', 37, N'3', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2019-09-18' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 42, N'LA BUA FEDERICA', N'LABUAFEDERICA@GMAIL.COM', CAST(N'2002-12-16' AS Date), N'PALERMO', N'', N'', N'VIA GIACOMO BESIO 81', N'PALERMO', N'PA', N'90145', N'3313514064', N'3896441807', 14, N'3', 0, N'MATEMATICA INGLESE SPAGNOLO', CAST(N'2018-10-17' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'2018-10-17' AS Date), 1, 739298, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 119, N'LA FRANCA MARIANO', N'LAFRANCAMARIANO08@GMAIL.COM', CAST(N'2002-09-13' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 1039', N'PALERMO', N'PA', N'90131', N'3931091310', N'3339203559', 7, N'3', 0, N'MATEMATICA - FISICA - BIOLOGIA - CHIMICA', CAST(N'2019-02-04' AS Date), CAST(N'2019-10-28' AS Date), 0, 1, 1, 1, CAST(N'2019-02-04' AS Date), 1, 510250, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 120, N'LA LICATA GABRIEL', N'ORIANACANNOVA@HOTMAIL.IT', CAST(N'2004-07-04' AS Date), N'PALERMO', N'', N'', N'VIA DOMENICO RUSSO 18', N'PALERMO', N'PA', N'90131', N'3249816407', N'3494468262', 7, N'1', 0, N'MATEMATICA FISICA', CAST(N'2019-04-08' AS Date), CAST(N'2019-04-08' AS Date), 1, 1, 1, 0, NULL, 0, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 121, N'LA MALFA FRANCESCO', N'LMFRANCESCO2000@VIRGILIO.IT', CAST(N'2009-04-22' AS Date), N'PALERMO', N'', N'', N'VIA MAIO BIONDO N.8', N'PALERMO', N'PA', N'90131', N'3384396948', N'3495786476', 7, N'4', 0, N'MATEMATICA E FISICA', CAST(N'2019-03-12' AS Date), CAST(N'2019-03-12' AS Date), 1, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 43, N'LA MANTIA DORIANA', N'LAMANTIADORIANA857@GMAIL.COM', CAST(N'2003-05-09' AS Date), N'PALERMO', N'', N'', N'VIA ROSINA ANSELMI-6', N'PALERMO', N'PA', N'09135', N'3347567769', N'3339728192', 19, N'2', 0, N'MATEMATICA- GRECO', CAST(N'2019-05-06' AS Date), CAST(N'2019-09-25' AS Date), 0, 1, 1, 1, CAST(N'2019-05-06' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 199, N'LA ROCCA GAETANO', N'TATOLAROCCA@GMAIL.COM', CAST(N'2003-11-10' AS Date), N'PALERMO', N'', N'', N'VIA V. DI MARCO 4', N'PALERMO', N'PA', N'90143', N'3510832688', N'3494233101', 16, N'3', 0, N'LATINO GRECO', CAST(N'2020-01-23' AS Date), CAST(N'2020-01-23' AS Date), 0, 1, 1, 1, CAST(N'2020-01-23' AS Date), 1, 757320, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 44, N'LA ROSA GIANLUCA', N'GIANLUCALAROSA17082017@GMAIL.COM', CAST(N'1996-07-12' AS Date), N'PALERMO', N'', N'', N'VIA NINA SICILIANO 8', N'PALERMO', N'PA', N'90135', N'3294573141', N'3395712830', 36, N'5', 0, N'MATEMATICA FRANCESE SPAGNOLO', CAST(N'2018-06-21' AS Date), CAST(N'2019-01-31' AS Date), 1, 1, 1, 1, CAST(N'2018-10-23' AS Date), 1, 965434, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 45, N'LA VARDERA SABRINA', N'SABRINALAVARDERA28082002@GMAIL.COM', CAST(N'2002-08-28' AS Date), N'PALERMO', N'', N'', N'VIA C. GIRARDENGO 15', N'PALERMO', N'PA', N'90146', N'3890942774', N'3294028098', 4, N'2', 0, N'CHIMICA', CAST(N'2019-05-17' AS Date), CAST(N'2019-05-17' AS Date), 1, 1, 1, 1, CAST(N'2019-05-17' AS Date), 1, 549903, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 138, N'LASILE ALLAN', N'JAHSONO10@OUTLOOK.COM', CAST(N'2004-11-14' AS Date), N'MAURITIUS', N'', N'', N'VIA SELINUNTE 4', N'PALERMO', N'PA', N'90100', N'3895922440', N'3272317419', 31, N'1', 0, N'INGLESE MATEMATICA', CAST(N'2019-09-24' AS Date), CAST(N'2019-10-01' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 0, 214865, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 161, N'LATINO SALVATORE', N'TOTOLAT23@GMAIL.COM', CAST(N'2005-05-23' AS Date), N'PALERMO', N'', N'', N'VIA ERRICO SCIPIONE 4', N'PALERMO', N'PA', N'90145', N'3425735508', N'360560943', 28, N'1', 0, N'MATEMATICA FISICA', CAST(N'2019-10-28' AS Date), CAST(N'2019-10-28' AS Date), 0, 1, 1, 1, CAST(N'2019-10-28' AS Date), 0, 124408, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 197, N'LO CASCIO GABRIELE MARIA', N'GABRIPLAYSTATION@LIBERO.IT', CAST(N'2005-01-03' AS Date), N'PALERMO', N'', N'', N'VIA LEONARDO DA VINCI 518', N'PALERMO', N'PA', N'90135', N'3313101236', N'3455848422', 27, N'2', 0, N'LATINO', CAST(N'2020-01-17' AS Date), CAST(N'2020-01-17' AS Date), 0, 1, 1, 1, CAST(N'2020-01-17' AS Date), 1, 155217, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 46, N'LO PICCOLO AURORA', N'LOPICCOLO.FATIMA@GMAIL.COM', CAST(N'2001-05-13' AS Date), N'PALERMO', N'', N'', N'VIA G. DI BARTOLO 1', N'PALERMO', N'PA', N'90128', N'3293987924', N'3205510806', 3, N'5', 0, N'CHIMICA SPAGNOLO INGLESE', CAST(N'2018-10-10' AS Date), CAST(N'2020-02-11' AS Date), 0, 1, 1, 1, CAST(N'2018-10-10' AS Date), 1, 311206, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 47, N'LUCCHESE NOEMI', N'IRIVIELCICERA@GMAIL.COM', CAST(N'2000-04-17' AS Date), N'PALERMO', N'', N'', N'VIA PALADINI F. 9', N'PALERMO', N'PA', N'90145', N'3270522365', N'3802662469', 23, N'4', 0, N'INGLESE FISICA ITALIANO', CAST(N'2018-10-16' AS Date), CAST(N'2019-01-31' AS Date), 1, 1, 1, 1, CAST(N'2019-01-31' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 48, N'LUPARELLO GIOVANNI', N'GIOVANNILUPARELLO98@GMAIL.COM', CAST(N'2003-06-19' AS Date), N'PALERMO', N'', N'', N'VIA LA MARMORA N.75', N'PALERMO', N'PA', N'90143', N'3925192840', N'3924305107', 27, N'2', 0, N'MATEMATICA', CAST(N'2018-11-09' AS Date), CAST(N'2018-11-09' AS Date), 1, 1, 1, 1, CAST(N'2018-11-09' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 188, N'MACRI- GABRIELE', N'GABRIELEMACRI269@GMAIL.COM', CAST(N'2001-10-13' AS Date), N'PALERMO', N'MCRGRL01R13G273S', N'', N'VIA F.SCO BAGLIESI N.29', N'ISOLA DELLE FEMMINE', N'PA', N'90040', N'3203837082', N'3791885857', 13, N'4', 0, N'INGLESE ELETTROTECNICA', CAST(N'2020-01-08' AS Date), CAST(N'2020-01-08' AS Date), 0, 1, 1, 1, CAST(N'2020-01-08' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 49, N'MALIZIA ENRICO', N'ENRICO14.M@GMAIL.COM', CAST(N'2000-10-23' AS Date), N'PALERMO', N'', N'', N'VIA CORRADO GIACQUINTO N.31', N'PALERMO', N'PA', N'90145', N'3331548150', N'3273218960', 26, N'5', 0, N'MATEMATICA FISICA SCIENZE', CAST(N'2018-10-01' AS Date), CAST(N'2019-03-21' AS Date), 1, 1, 1, 1, CAST(N'2018-10-01' AS Date), 1, 126469, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 50, N'MANCUSO CHIARA', N'BELIEBER94.CM@GMAIL.COM', CAST(N'2001-04-27' AS Date), N'PALERMO', N'', N'', N'VIA M. DE VIO 1', N'PALERMO', N'PA', N'90146', N'3274435575', N'3883871127', 4, N'4', 0, N'MATEMATICA', CAST(N'2019-06-18' AS Date), CAST(N'2019-06-20' AS Date), 1, 1, 1, 1, CAST(N'2019-06-20' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 51, N'MANGIONE ALESSIO', N'ALESSIOMANGIONE14@GMAIL.COM', CAST(N'2002-03-19' AS Date), N'CASTELVETRANO -TP', N'', N'', N'VIA A. PECORARO 4', N'PALERMO', N'PA', N'90144', N'3512082699', N'3339677949', 32, N'3', 0, N'', CAST(N'2018-06-18' AS Date), CAST(N'2018-10-15' AS Date), 1, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 166, N'MANGIONE ELEONORA', N'ELEONORAPRICE@GMAIL.COM', CAST(N'2003-10-13' AS Date), N'PALERMO', N'', N'', N'VIA DEI BISCOTTARI- 27', N'PALERMO', N'PA', N'90100', N'3791622252', N'3491884922', 30, N'3', 0, N'MATEMATICA-LATINO', CAST(N'2019-11-11' AS Date), CAST(N'2019-11-11' AS Date), 0, 1, 1, 1, CAST(N'2019-11-11' AS Date), 1, 644966, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 152, N'MARCO GABRIELE', N'GABRIELEMARCO04@GMAIL.COM', CAST(N'2004-06-02' AS Date), N'PALERMO', N'', N'', N'VIA ALTOFONTE 96-E', N'PALERMO', N'PA', N'90129', N'3312903117', N'3208612436', 30, N'3', 0, N'MATEMATICA FISICA LATINO', CAST(N'2019-10-16' AS Date), CAST(N'2020-01-27' AS Date), 0, 1, 1, 1, CAST(N'2020-01-27' AS Date), 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 193, N'MARFIA SHARON', N'LUCIA210470@GMAIL.COM', CAST(N'2004-09-08' AS Date), N'PALERMO', N'', N'', N'VIA PUCCINI 52', N'PALERMO', N'PA', N'90145', N'3337910217', N'3333094473', 28, N'2', 0, N'FISICA MATEMATICA', CAST(N'2020-01-14' AS Date), CAST(N'2020-01-14' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 205, N'MARRONE ANTONIO', N'ANTONIO3_@LIVE.IT', CAST(N'2001-07-26' AS Date), N'PALERMO', N'', N'', N'VIA VILLAGRAZIA 315 R', N'PALERMO', N'PA', N'90124', N'3888672627', N'3892575513', 6, N'5', 0, N'MECCANICA INGLESE', CAST(N'2020-01-28' AS Date), CAST(N'2020-01-28' AS Date), 0, 1, 1, 1, CAST(N'2020-01-28' AS Date), 1, 292247, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 52, N'MASTRANTONIO DELIA', N'DELIALAURA106@GMAIL.COM', CAST(N'2003-03-28' AS Date), N'PALERMO', N'', N'', N'VIA UMBRIA N.6', N'PALERMO', N'PA', N'90144', N'3298953923', N'3205546194', 22, N'2', 0, N'MATEMATICA INGLESE', CAST(N'2019-01-08' AS Date), CAST(N'2019-01-15' AS Date), 1, 1, 1, 1, CAST(N'2019-01-09' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 53, N'MAZZOLA MARCO', N'MAZZOLAMARCO00@GMAIL.COM', CAST(N'2000-07-07' AS Date), N'PALERMO', N'MZZMRC00L21G273Q', N'', N'VIA SCOBAR 10', N'PALERMO', N'PA', N'90145', N'3496898928', N'3389322606', 28, N'5', 0, N'MATEMATICA- FISICA- CHIMICA', CAST(N'2019-03-11' AS Date), CAST(N'2019-03-11' AS Date), 1, 1, 1, 1, CAST(N'2019-03-11' AS Date), 1, 345987, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 157, N'MELI CHIARA', N'MELI.CHIARA.2003@GMAIL.COM', CAST(N'2003-04-11' AS Date), N'PALERMO', N'', N'', N'VICOLO MANCUSO 20', N'PALERMO', N'PA', N'90145', N'3896910985', N'3353259399', 38, N'4', 0, N'TEDESCO', CAST(N'2019-10-24' AS Date), CAST(N'2019-10-24' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 54, N'MENDITTO MARTINA', N'MARTINAMENDITTO60@GMAIL.COM', CAST(N'2004-02-26' AS Date), N'PALERMO', N'', N'', N'VIA G. ROMERES 4', N'PALERMO', N'PA', N'90129', N'3420677028', N'3925948705', 19, N'2', 0, N'GRECO', CAST(N'2019-05-10' AS Date), CAST(N'2019-05-10' AS Date), 1, 1, 1, 1, CAST(N'2019-05-10' AS Date), 1, 208481, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 189, N'MERRA ROBERTO', N'LOPEZZINO5@GMAIL.COM', CAST(N'2004-05-14' AS Date), N'PALERMO', N'', N'', N'VIA DEI NEBRODI 58', N'PALERMO', N'PA', N'90146', N'3331147913', N'3713626282', 15, N'3', 0, N'LATINO GRECO MAATEMATICA', CAST(N'2020-01-08' AS Date), CAST(N'2020-01-08' AS Date), 0, 1, 1, 1, CAST(N'2020-01-08' AS Date), 1, 926595, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 55, N'MESSI LEO', N'FENOMENO@FIFA.ORG', CAST(N'2000-08-02' AS Date), N'SANTA FE', N'', N'', N'MAGARI', N'PALERMO', N'PA', N'90100', N'OBJECT OBJECT', N'OBJECT OBJECT', 1, N'5', 0, N'', CAST(N'2018-03-12' AS Date), CAST(N'2019-09-18' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 56, N'MESSINA CHIARA', N'CHICHYMESSINA@GMAIL.COM', CAST(N'2004-05-10' AS Date), N'PALERMO', N'', N'', N'VIA CORRADO GIAQUINTO', N'PALERMO', N'PA', N'90145', N'3348772642', N'3382027131', 27, N'2', 0, N'MATEMATICA- FISICA- LATINO', CAST(N'2019-02-11' AS Date), CAST(N'2019-11-05' AS Date), 0, 1, 1, 1, CAST(N'2019-02-11' AS Date), 1, 529466, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 57, N'MICALIZZI GIULIA', N'GIU.MICALIZZI@GMAIL.COM', CAST(N'2003-11-20' AS Date), N'PALERMO', N'', N'', N'VIA PARRINI 14-C', N'PALERMO', N'PA', N'90145', N'3297193561', N'3479188650', 11, N'2', 0, N'INGLESE FRANCESE INFORMATICA', CAST(N'2019-03-18' AS Date), CAST(N'2019-03-18' AS Date), 1, 1, 1, 0, NULL, 1, 507079, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 58, N'MIGLIORE VIOLA', N'VIOLAMIGLIORE@ICLOUD.COM', CAST(N'2000-08-06' AS Date), N'PALERMO', N'', N'', N'VIA A. AGOSTINO 22', N'PALERMO', N'PA', N'90135', N'3890067189', N'3336628579', 16, N'5', 0, N'BIOLOGIA CHIMICA MATEMATICA', CAST(N'2018-10-24' AS Date), CAST(N'2018-10-24' AS Date), 1, 1, 1, 1, CAST(N'2018-10-24' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 59, N'MIGNANO VALERIO', N'VALYMIG1@GMAIL.COM', CAST(N'2004-02-04' AS Date), N'PALERMO', N'', N'', N'VIA AQUILEIA 5', N'PALERMO', N'PA', N'90144', N'3510232413', N'3201579026', 37, N'2', 0, N'MATEMATICA FISICA', CAST(N'2018-11-13' AS Date), CAST(N'2018-11-13' AS Date), 1, 1, 1, 1, CAST(N'2018-11-13' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 60, N'MINACORI GIOVANNI', N'MINACORI65@GMAIL.COM', CAST(N'2004-06-23' AS Date), N'CANICATTÌ -AG-', N'', N'', N'VIA V. LA SCOLA 13', N'PALERMO', N'PA', N'90127', N'3290034664', N'3208377828', 16, N'1', 0, N'LATINO GRECO', CAST(N'2019-03-15' AS Date), CAST(N'2019-03-15' AS Date), 1, 1, 1, 1, CAST(N'2019-03-15' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 167, N'MIROLLA ANDREA', N'ALESSANDRAVENIA@HOTMAIL.IT', CAST(N'2004-02-27' AS Date), N'PALERMO', N'', N'', N'VIA CASUZZE 4', N'PALERMO', N'PA', N'90100', N'3425707112', N'3314666902', 7, N'3', 0, N'LATINO CHIMICA', CAST(N'2019-11-13' AS Date), CAST(N'2019-11-13' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 122, N'MODICA RICCARDO', N'MODICA.RICCARDO@LIBERO.IT', CAST(N'2000-09-09' AS Date), N'PALERMO', N'', N'', N'VIA MOLARA 89', N'PALERMO', N'PA', N'90100', N'3891284333', N'3200417363', 7, N'5', 0, N'MATEMATICA FISICA', CAST(N'2018-11-27' AS Date), CAST(N'2019-11-05' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 803538, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 61, N'MOLLIK FAHIM', N'FAHIM03@LIBERO.IT', CAST(N'2003-10-09' AS Date), N'PALERMO', N'', N'', N'VIA PIETRO MASCAGNI N.12', N'PALERMO', N'PA', N'90145', N'3510576267', N'3401431260', 11, N'1', 0, N'MATEMATICA ECONOMIA AZIENDALE DIRITTO', CAST(N'2019-01-31' AS Date), CAST(N'2019-02-04' AS Date), 1, 1, 1, 1, CAST(N'2019-01-31' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 185, N'MONASTERI ANDREA', N'MONASTERI@NEOMEDIA.IT', CAST(N'2003-12-31' AS Date), N'PALERMO', N'', N'', N'VIA GIUSTI 33', N'PALERMO', N'PA', N'90145', N'3668185956', N'3396810513', 16, N'3', 0, N'GRECO', CAST(N'2019-12-18' AS Date), CAST(N'2019-12-18' AS Date), 0, 1, 1, 1, CAST(N'2019-12-18' AS Date), 1, 157838, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 62, N'MONTALBANO VALERIO', N'VALERIOMCSE@HOTMAIL.COM', CAST(N'1965-08-23' AS Date), N'PALERMO', N'', N'', N'VIA UDITORE 12G', N'PALERMO', N'PA', N'90145', N'091407259', N'091407259', 1, N'5', 0, N'', CAST(N'2018-09-04' AS Date), CAST(N'2020-01-08' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 63, N'MOREO STEFANO', N'ATTACANTE@PALERMO.ORG', CAST(N'2009-08-13' AS Date), N'VERONA', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'12', N'21', 23, N'1', 0, N'', CAST(N'2018-02-26' AS Date), CAST(N'2019-09-18' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 64, N'MOSCA RICCARDO', N'RICCARDOCOSIMOSALVATOREMOSCA@GMAIL.COM', CAST(N'2004-06-18' AS Date), N'PALERMO', N'', N'', N'VIA BERNINI 47', N'PALERMO', N'PA', N'90145', N'3914657917', N'3385960361', 28, N'1', 0, N'MATEMATICA FISICA', CAST(N'2019-02-01' AS Date), CAST(N'2019-02-01' AS Date), 1, 1, 1, 1, CAST(N'2019-02-01' AS Date), 1, 933976, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 65, N'MUSSO ELISA', N'ELISAMUSSOTROJA@GMAIL.COM', CAST(N'2002-07-31' AS Date), N'PALERMO', N'', N'', N'VIA F. P. CIACCIO 13', N'PALERMO', N'PA', N'90145', N'3396638873', N'3495377444', 35, N'2', 0, N'MATEMATICA INGLESE ITALIANO STORIA', CAST(N'2019-02-28' AS Date), CAST(N'2019-03-01' AS Date), 1, 1, 1, 1, CAST(N'2019-02-28' AS Date), 1, 666718, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 204, N'NASCA GIOVANNI', N'GIOVANNINASCA6@GMAIL.COM', CAST(N'2005-07-06' AS Date), N'PALERMO', N'', N'', N'VIA PINO MERCANTI N.32', N'PALERMO', N'PA', N'90131', N'3911705491', N'3334772248', 37, N'1', 0, N'MATEMATICA FISICA CHIMICA SCIENZE DELLA TERRA', CAST(N'2020-01-27' AS Date), CAST(N'2020-01-27' AS Date), 0, 1, 1, 1, CAST(N'2020-01-27' AS Date), 1, 238555, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 66, N'NASCU GABRIELA', N'GABRIELANASCU1111@GMAIL.COM', CAST(N'2004-12-22' AS Date), N'BUCAREST -ROMANIA-', N'', N'', N'VIA DIVISI 37', N'PALERMO', N'PA', N'90133', N'3471799762', N'3803563891', 23, N'1', 0, N'INGLESE LATINO ITALIANO', CAST(N'2019-04-08' AS Date), CAST(N'2019-05-03' AS Date), 1, 1, 1, 1, CAST(N'2019-04-08' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 67, N'NESTOROVSKI ILIJA', N'SKYWALKER@STELLE.COM', CAST(N'1989-04-19' AS Date), N'LUBJANA', N'', N'', N'VIA LATTEA', N'GALASSIA', N'PA', N'90100', N'00000000', N'000000000', 1, N'1', 0, N'', CAST(N'2018-01-27' AS Date), CAST(N'2019-09-18' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 68, N'OLIVEIRA NAKASATO MARIANA', N'ABO1RJ@HOTMAIL.COM', CAST(N'2004-02-11' AS Date), N'RIO DE JANEIRO -BRASILE', N'', N'', N'VIA CARELLA 5', N'PALERMO', N'PA', N'90139', N'3895650411', N'3665099072', 16, N'2', 0, N'MATEMATICA LATINO GRECO', CAST(N'2018-10-03' AS Date), CAST(N'2018-10-15' AS Date), 1, 1, 1, 1, CAST(N'2018-10-12' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 69, N'ORLANDO ANDREA', N'ANDREAORLANDO2002@GMAIL.COM', CAST(N'2002-08-07' AS Date), N'PALERMO', N'', N'', N'VIA SALVO D-ACQUISTO 28', N'CARINI', N'PA', N'90044', N'3662829048', N'3471893131', 26, N'4', 0, N'MATEMATICA FISICA', CAST(N'2018-10-03' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2019-01-31' AS Date), 1, 330260, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 70, N'ORLANDO MARTA', N'AKAMIKODO@VIRGILIO.IT', CAST(N'2000-10-01' AS Date), N'PALERMO', N'', N'', N'VIA SALVO D-ACQUISTO 28', N'CARINI', N'PA', N'90044', N'3803751002', N'3471893131', 22, N'5', 0, N'', CAST(N'2018-10-03' AS Date), CAST(N'2019-01-31' AS Date), 1, 1, 1, 1, CAST(N'2019-01-31' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 156, N'PARISI ELISA', N'ELISAPARISI14@GMAIL.COM', CAST(N'2002-12-30' AS Date), N'PALERMO', N'', N'', N'VIA PARRINI 16', N'PALERMO', N'PA', N'90145', N'3409883264', N'3779623608', 38, N'4', 0, N'TEDESCO', CAST(N'2019-10-24' AS Date), CAST(N'2019-10-24' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 71, N'PARISI GIORGIA', N'GIORGIAPARISI009@GMAIL.COM', CAST(N'2003-06-16' AS Date), N'PALERMO', N'', N'', N'VIA CRUILLAS 90', N'PALERMO', N'PA', N'90146', N'3248279610', N'3382869454', 16, N'2', 0, N'LATINO GRECO', CAST(N'2018-10-18' AS Date), CAST(N'2018-10-18' AS Date), 1, 1, 1, 1, CAST(N'2018-10-18' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 135, N'PATTI FRANCESCO', N'FPATTI922@GMAIL.COM', CAST(N'2004-09-20' AS Date), N'PALEERMO', N'', N'', N'VIA EVANGELISTA DI BLASI N.167-B', N'PALERMO', N'PA', N'90135', N'3892058173', N'3275924855', 9, N'1', 0, N'CHIMICA MATEMATICA ITALIANO INGLESE', CAST(N'2019-09-23' AS Date), CAST(N'2020-02-25' AS Date), 1, 1, 1, 1, CAST(N'2019-09-23' AS Date), 1, 516415, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 72, N'PICCIONE ROBERTA', N'RALLO.GIUSI@GMAIL.COM', CAST(N'2003-08-09' AS Date), N'PALERMO', N'', N'', N'VIA AURELIO COSTANZO N.1', N'PALERMO', N'PA', N'90142', N'3665324896', N'3281055564', 16, N'2', 0, N'GRECO', CAST(N'2019-01-09' AS Date), CAST(N'2019-01-09' AS Date), 1, 1, 1, 1, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 123, N'PICONE GABRIELE', N'GABRIELE2003GP@GMAIL.COM', CAST(N'2003-01-31' AS Date), N'PALERMO', N'', N'', N'FONDO CANNIZZO 26', N'PALERMO', N'PA', N'90100', N'3453435854', N'3400840531', 23, N'3', 0, N'MATEMATICA FISICA', CAST(N'2019-03-07' AS Date), CAST(N'2019-03-25' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 130, N'PINOCCHIO ROBERTA', N'ROBERTA.PINOCCHIO@GMAIL.COM', CAST(N'2002-11-09' AS Date), N'PALERMO', N'', N'', N'VIA LANZA 15', N'PALERMO', N'PA', N'90145', N'3883965252', N'3208348030', 22, N'4', 0, N'MATEMATICA FISICA', CAST(N'2019-09-23' AS Date), CAST(N'2019-09-23' AS Date), 0, 1, 1, 1, CAST(N'2019-09-23' AS Date), 1, 896130, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 203, N'PISANO ASARIA', N'PISANOASARIA@ICLOUD.COM', CAST(N'2006-03-15' AS Date), N'PALERMO', N'', N'', N'CORTILE CATALANO 24 D', N'PALERMO', N'PA', N'90145', N'3472928609', N'3922012090', 16, N'1', 0, N'GRECO MATEMATICA INGLESE', CAST(N'2020-01-27' AS Date), CAST(N'2020-01-27' AS Date), 0, 1, 1, 1, CAST(N'2020-01-27' AS Date), 1, 280494, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 73, N'PISCIOTTA GIULIA', N'GIULIAPISCIOTTA1AT@GMAIL.COM', CAST(N'2004-02-05' AS Date), N'PALERMO', N'', N'', N'VIA M. BONINCONTRO 5', N'PALERMO', N'PA', N'90145', N'3801893081', N'3401409392', 36, N'2', 0, N'CHIMICA MATEMATICA ECONOMIA AZIENDALE', CAST(N'2018-11-23' AS Date), CAST(N'2018-11-23' AS Date), 1, 1, 1, 1, CAST(N'2018-11-23' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 74, N'PIZZIMENTI GINEVRA', N'GINEVRA.GP86@GMAIL.COM', CAST(N'2002-10-19' AS Date), N'PALERMO', N'', N'', N'VIA FLAVIO GIOIA 63', N'PALERMO', N'PA', N'90145', N'3804679107', N'0916812665', 21, N'5', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2018-09-27' AS Date), CAST(N'2019-10-15' AS Date), 0, 1, 1, 1, CAST(N'2018-09-27' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 75, N'POLIZZI AURORA', N'AURORAPOLIZZI@ICLOUD.COM', CAST(N'2004-12-27' AS Date), N'PALERMO', N'', N'', N'VIA NAVE 24', N'PALERMO', N'PA', N'90135', N'3899162787', N'3289612732', 30, N'1', 0, N'MATEMATICA SCIENZE', CAST(N'2019-04-30' AS Date), CAST(N'2019-04-30' AS Date), 1, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 129428, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 76, N'POLIZZI GIULIANA', N'GIULIANAPOLIZZI@ICLOUD.COM', CAST(N'2001-08-21' AS Date), N'PALERMO', N'', N'', N'VIA NAVE 24', N'PALERMO', N'PA', N'90135', N'3299847094', N'3289612732', 30, N'4', 0, N'MATEMATICA CHIMICA', CAST(N'2019-04-30' AS Date), CAST(N'2019-04-30' AS Date), 1, 1, 1, 1, CAST(N'2019-04-30' AS Date), 1, 985171, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 77, N'POMILLA GIADA', N'POMILLAGIADA@GMAIL.COM', CAST(N'2004-12-23' AS Date), N'PALERMO', N'', N'', N'VIA MODICA 3', N'PALERMO', N'PA', N'90135', N'3738365614', N'3931047059', 36, N'2', 0, N'INGLESE ECONOMIA AZIENDALE', CAST(N'2018-09-26' AS Date), CAST(N'2019-09-27' AS Date), 0, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, 692737, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 78, N'POMINI PIETRO', N'PARATUTTO@PORTOFRANCOPA.ORG', CAST(N'1990-11-28' AS Date), N'TRENTO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'124578', N'215487', 27, N'1', 0, N'', CAST(N'2018-02-15' AS Date), CAST(N'2019-09-18' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 79, N'POSAVEC JOSIF', N'JOSIF.POSAVEC@VALERIOMCSE.EU', CAST(N'2000-07-02' AS Date), N'SLAVIA', N'', N'', N'CORSO PORTA CHIUSA', N'PALERMO', N'PA', N'90100', N'32112345678', N'3212345678', 16, N'1', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-15' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 1, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 124, N'PRESTA EMILIANO', N'EMILIANOPRESTA2014@LIBERO.IT', CAST(N'2003-06-14' AS Date), N'PALERMO', N'', N'', N'VIA CASE SPUCHES 10', N'PALERMO', N'PA', N'90131', N'3282624412', N'3296153350', 37, N'2', 0, N'MATEMATICA DIRITTO', CAST(N'2018-11-27' AS Date), CAST(N'2018-11-27' AS Date), 1, 1, 1, 0, NULL, 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 145, N'PRIOLO DANIELE', N'DANIELEPRIOLO@GMAIL.COM', CAST(N'2003-11-18' AS Date), N'PALERMO', N'', N'', N'VIA I.PIZZETTI N.48', N'PALERMO', N'PA', N'90145', N'3400816341', N'3518711859', 28, N'2', 0, N'LATINO MATEMATICA', CAST(N'2019-10-07' AS Date), CAST(N'2019-10-07' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 571736, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 80, N'PUGLISI FABIANA', N'PUGLIP@HOTMAIL.COM', CAST(N'2002-06-29' AS Date), N'REGGIO EMILIA', N'', N'', N'VIA SACRA FAMIGLIA- 41', N'PALERMO', N'PA', N'90146', N'3923910453', N'3895304645', 4, N'3', 0, N'INFORMATICA', CAST(N'2019-06-26' AS Date), CAST(N'2019-06-26' AS Date), 1, 1, 1, 1, CAST(N'2019-06-26' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 209, N'RENNA SALVATORE', N'SALVO.RENNA.15@GMAIL.COM', CAST(N'2000-07-27' AS Date), N'PALERMO', N'', N'', N'VIA FONDO PETIX 28', N'PALERMO', N'PA', N'90100', N'3247742645', N'3204948447', 6, N'4', 0, N'MATEMATICA', CAST(N'2020-02-04' AS Date), CAST(N'2020-02-04' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 129, N'RICCIARDO STEFANO', N'ATTACANTE_SERIED@VALERIOMCSE.EU', CAST(N'2001-12-05' AS Date), N'PALERMO', N'', N'', N'CORSO DEL FANTE', N'PALERMO', N'PA', N'90100', N'123321', N'32123', 1, N'1', 0, N'', CAST(N'2019-09-23' AS Date), CAST(N'2019-09-23' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 81, N'RISPOLI ANDREA', N'studente2@scuola.it', NULL, NULL, N'CCCNNN99Z00A123Z', N'', N'Viale della Promozione', N'Palermo', N' ', N' ', N'12332165478', N'12332165478', 11, N'2', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2018-06-18' AS Date), 1, 0, 0, 0, NULL, 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 216, N'RIZZO AURELIA', N'AURELIARIZZO4@GMAIL.COM', CAST(N'2003-08-19' AS Date), N'PALERMO', N'', N'', N'VIA ALESSIO NARVONE 54', N'PALERMO', N'PA', N'90138', N'3389569030', N'3666715013', 11, N'3', 0, N'DIRITTO ECONOMIA POLITICA', CAST(N'2020-02-21' AS Date), CAST(N'2020-02-21' AS Date), 0, 1, 1, 1, CAST(N'2020-02-21' AS Date), 1, 124458, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 183, N'RIZZO DIMITRI', N'DIMITRI.RIZZO2005@GMAIL.COM', CAST(N'2005-06-15' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 1011', N'PALERMO', N'PA', N'90129', N'3318598958', N'3392398255', 30, N'1', 0, N'MATEMATICA FISICA', CAST(N'2019-12-16' AS Date), CAST(N'2019-12-18' AS Date), 0, 1, 1, 1, CAST(N'2019-12-18' AS Date), 1, 760146, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 184, N'RIZZO GIOVANNI', N'GIOVANNI.RIZZO2903@GMAIL.COM', CAST(N'2004-03-29' AS Date), N'PALERMO', N'', N'', N'CORSO CALATAFIMI 1011', N'PALERMO', N'PA', N'90129', N'3314874276', N'3392398255', 30, N'3', 0, N'MATEMATICA FISICA', CAST(N'2019-12-16' AS Date), CAST(N'2019-12-18' AS Date), 0, 1, 1, 1, CAST(N'2019-12-18' AS Date), 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 180, N'RIZZUTO ANNA', N'RIZZUTOANNA681@GMAIL.COM', CAST(N'1999-01-08' AS Date), N'PALERMO', N'', N'', N'VIA CAPPUCCINI 144', N'PALERMO', N'PA', N'90100', N'3245478696', N'3297914222', 12, N'4', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2019-12-11' AS Date), CAST(N'2019-12-11' AS Date), 0, 1, 1, 1, CAST(N'2019-12-11' AS Date), 1, 747608, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 82, N'ROMANO CHIARA', N'ROMANOCHIARA2306@GMAIL.COM', CAST(N'2003-06-23' AS Date), N'PALERMO', N'RMNCHR03H63G273F', N'', N'VIA SALAPARUTA- 5', N'PALERMO', N'PA', N'90135', N'3249965127', N'3471566046', 22, N'2', 0, N'INGLESE- FRANCESE- SPAGNOLO- MATEMATICA', CAST(N'2019-03-11' AS Date), CAST(N'2019-03-21' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 181722, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 83, N'ROSSI GIACOMO', N'PIP@1918', CAST(N'2000-09-05' AS Date), N'PALERMO', N'', N'', N'CAMPOLO', N'PALERMO', N'PA', N'90100', N'10', N'18', 16, N'3', 0, N'', CAST(N'2018-09-25' AS Date), CAST(N'2018-10-05' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 172, N'RUBBINO GIULIA', N'GIULIAMARIARUBBINO22@GMAIL.COM', CAST(N'2003-05-22' AS Date), N'PALERMO', N'', N'', N'VIA TENENTE ARRIGO 24', N'VILLABATE', N'PA', N'90039', N'3455962544', N'3473055979', 12, N'3', 0, N'ITALIANO STORIA FISICA', CAST(N'2019-11-25' AS Date), CAST(N'2020-01-27' AS Date), 0, 1, 1, 1, CAST(N'2020-01-27' AS Date), 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 171, N'RUBBINO SOFIA', N'SOFIARITARUBBINO22@GMAIL.COM', CAST(N'2003-05-22' AS Date), N'PALERMO', N'', N'', N'VIA TENENTE ARRIGO 24', N'VILLABATE', N'PA', N'90039', N'3429966363', N'3473055979', 12, N'3', 0, N'ITALIANO STORIA INGLESE', CAST(N'2019-11-25' AS Date), CAST(N'2020-01-27' AS Date), 0, 1, 1, 1, CAST(N'2020-01-27' AS Date), 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 125, N'RUSSELLO MARCO', N'MRUSSELLO1018@GMAIL.COM', CAST(N'2004-10-18' AS Date), N'PALERMO', N'', N'', N'VIA NAVE 24', N'PALERMO', N'PA', N'90135', N'3299192864', N'3493923590', 30, N'2', 0, N'MATEMATICA', CAST(N'2018-12-07' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2018-12-07' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 126, N'RUSSELLO WALTER', N'RUSSELLOWALTER04@GMAIL.COM', CAST(N'2004-10-18' AS Date), N'PALERMO', N'', N'', N'VIA NAVE 24', N'PALERMO', N'PA', N'90135', N'3914930118', N'3493923590', 30, N'2', 0, N'MATEMATICA', CAST(N'2018-12-07' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2018-12-07' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 214, N'SACCO GABRIELE', N'SACCOGABRIELE2002@GMAIL.COM', CAST(N'2002-06-14' AS Date), N'PALERMO', N'', N'', N'VIA CASALINI N.192', N'PALERMO', N'PA', N'90135', N'3284769975', N'3495629957', 6, N'4', 0, N'MATEMATICA', CAST(N'2020-02-13' AS Date), CAST(N'2020-02-13' AS Date), 0, 1, 1, 1, CAST(N'2020-02-13' AS Date), 1, 489860, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 206, N'SAIDOUBABA DANIELE', N'DANIELESAIDOUBABA@GMAIL.COM', CAST(N'2005-10-26' AS Date), N'PALERMO', N'', N'', N'VIA G.PITRE- N.104', N'PALERMO', N'PA', N'90135', N'3293829666', N'3272134451', 35, N'1', 0, N'INGLESE MATEMATICA', CAST(N'2020-01-29' AS Date), CAST(N'2020-01-29' AS Date), 0, 1, 1, 1, CAST(N'2020-01-29' AS Date), 0, 110537, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 131, N'SAIDOUBABA ISSAC MAIGA', N'SAIDOUISSAC@GMAIL.COM', CAST(N'2004-08-11' AS Date), N'PALERMO', N'', N'', N'VIA N. CENTO 16', N'PALERMO', N'PA', N'90135', N'3914181100', N'3272134451', 22, N'2', 0, N'MATEMATICA', CAST(N'2019-09-23' AS Date), CAST(N'2019-09-23' AS Date), 0, 1, 1, 1, CAST(N'2019-09-23' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 84, N'SALANITRI LUIGI', N'SALANITRI.LUIGI@GMAIL.COM', CAST(N'2005-01-05' AS Date), N'PALERMO', N'', N'', N'VIA CASALINI 158', N'PALERMO', N'PA', N'90135', N'3914715399', N'3383247622', 37, N'1', 0, N'MATEMATICA INGLESE CHIMICA', CAST(N'2019-02-27' AS Date), CAST(N'2019-02-27' AS Date), 1, 1, 1, 1, CAST(N'2019-02-27' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 85, N'SANALITRO ALESSANDRO', N'ALESSANDROSANALITRO@ICLOUD.COM', CAST(N'2003-12-27' AS Date), N'PALERMO', N'', N'', N'VIA PRINCIPE DI PALAGONIA 6', N'PALERMO', N'PA', N'90145', N'3348216037', N'3200322806', 28, N'2', 0, N'MATEMATICA LATINO', CAST(N'2018-10-03' AS Date), CAST(N'2018-10-10' AS Date), 1, 1, 1, 1, CAST(N'2018-10-10' AS Date), 1, 217997, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 86, N'SANFRATELLO GIORGIA', N'GIORGISAN@ICLOUD.COM', CAST(N'2005-03-13' AS Date), N'PALERMO', N'', N'', N'VIA GIUSEPPE LA MASA 37', N'PALERMO', N'PA', N'90139', N'3293828450', N'3389695357', 16, N'1', 0, N'GRECO LATINO', CAST(N'2018-10-23' AS Date), CAST(N'2018-10-23' AS Date), 1, 1, 1, 1, CAST(N'2018-10-23' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 210, N'SANSONE SIMONA', N'SANSONESIMONA1@GMAIL.COM', CAST(N'2004-03-02' AS Date), N'PALERMO', N'', N'', N'VIA CANNOLICCHIO 11', N'PALERMO', N'PA', N'90100', N'3666526662', N'3477750011', 7, N'3', 0, N'MATEMATICA', CAST(N'2020-02-04' AS Date), CAST(N'2020-02-05' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 762036, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 87, N'SANTONOCITO LUCIA', N'ADELEZARZANA@GMAIL.COM', CAST(N'2004-08-06' AS Date), N'PALERMO', N'', N'', N'VIA NICOLÒ CENTO N.18', N'PALERMO', N'PA', N'90135', N'3899159382', N'3288004235', 28, N'1', 0, N'STORIA MATEMATICA GEOGRAFIA', CAST(N'2018-11-08' AS Date), CAST(N'2018-11-08' AS Date), 1, 1, 1, 1, CAST(N'2018-11-08' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 211, N'SARCONA FILIPPO', N'SARCONAFILIPPO@GMAIL.COM', CAST(N'2006-01-29' AS Date), N'PALERMO', N'', N'', N'VIA G.PICCINI N.34', N'PALERMO', N'PA', N'90144', N'3318432350', N'3201772424', 37, N'1', 0, N'FISICA', CAST(N'2020-02-07' AS Date), CAST(N'2020-02-18' AS Date), 0, 1, 1, 1, CAST(N'2020-02-07' AS Date), 1, 108570, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 88, N'SARDO ELVIS', N'ELVISSARDO@GMAIL.COM', CAST(N'2002-05-26' AS Date), N'SERBIA', N'', N'', N'CORSO PIETRO PISANI 306', N'PALERMO', N'PA', N'90129', N'3515638412', N'3296864709', 14, N'3', 0, N'MATEMATICA', CAST(N'2018-09-27' AS Date), CAST(N'2020-02-17' AS Date), 0, 1, 1, 1, CAST(N'1900-01-01' AS Date), 1, 674231, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 182, N'SCALIA GIUSEPPE GIANLUCA', N'MASSIMOSCALIA@TISCALI.IT', CAST(N'2005-10-31' AS Date), N'PALERMO', N'SCLGPP05R31G273G', N'', N'VIA BISAZZA  79', N'PALERMO', N'PA', N'90145', N'3385816467', N'3894486446', 37, N'1', 0, N'MATEMATICA- FISICA- CHIMICA', CAST(N'2019-12-12' AS Date), CAST(N'2019-12-13' AS Date), 0, 1, 1, 1, CAST(N'2019-12-12' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 190, N'SCALICI CHIARA', N'SAMJ3FN2018@GMAIL.COM', CAST(N'2005-06-08' AS Date), N'MODENA', N'SCLCHR05H48F257C', N'', N'VIA CASTROGIOVANNI 1', N'PALERMO', N'PA', N'90100', N'3511178419', N'3880547702', 19, N'1', 0, N'GRECO', CAST(N'2020-01-10' AS Date), CAST(N'2020-01-10' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 89, N'SCALISI SUSANNA MARIA PIA', N'ORLANDOELENA@VIRGILIO.IT', CAST(N'2003-02-10' AS Date), N'PALERMO', N'', N'', N'LARGO PIETRO CALAMANDREI N.1', N'PALERMO', N'PA', N'90145', N'3804919146', N'3443807603', 22, N'2', 0, N'ITALIANO LATINO', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01' AS Date), 1, 1, 1, 1, CAST(N'2019-03-01' AS Date), 0, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 174, N'SCICHILI PLACIDO', N'DINOSCICHILI@GMAIL.COM', CAST(N'2000-12-20' AS Date), N'PALERMO', N'', N'', N'VIA FILIPPO BRUNELLESCHI N.4', N'PALERMO', N'PA', N'90145', N'3275660647', N'3420756060', 4, N'5', 0, N'MECCANICA INGLESE', CAST(N'2019-11-27' AS Date), CAST(N'2019-11-27' AS Date), 0, 1, 1, 1, CAST(N'2019-11-27' AS Date), 1, 711443, N'1', N'1.18', CAST(N'2019-10-31' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 175, N'SCICHILI STEFANO', N'STEFANOSCICHILI18@GMAIL.COM', CAST(N'2000-12-20' AS Date), N'PALERMO', N'', N'', N'VIA FILIPPO BRUNELLESCHI N.4', N'PALERMO', N'PA', N'90145', N'3276788526', N'3420756060', 6, N'5', 0, N'MECCANICA INGLESE', CAST(N'2019-11-27' AS Date), CAST(N'2019-11-27' AS Date), 0, 1, 1, 1, CAST(N'2019-11-27' AS Date), 1, 490342, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 90, N'SCIORTINO ANDREA', N'PLUTOSHIN.OFFICIAL@GMAIL.COM', CAST(N'2002-07-18' AS Date), N'PALERMO', N'', N'', N'VIA AQUINO 70 A', N'MONREALE', N'PA', N'90046', N'3317345468', N'3933715194', 7, N'3', 0, N'ITALIANO STORIA FILOSOFIA CHIMICA', CAST(N'2019-03-21' AS Date), CAST(N'2019-03-21' AS Date), 1, 1, 1, 1, CAST(N'2019-03-11' AS Date), 1, 725875, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 91, N'SCIORTINO FRANCESCO', N'FRANCESCOSCIORT04@GMAIL.COM', CAST(N'2004-10-10' AS Date), N'PALERMO', N'', N'', N'VIA PONTEPRCO N.45-F', N'MONREALE -AQUINO-', N'PA', N'90046', N'3917949272', N'3669716698', 7, N'2', 0, N'LATINO CHIMICA', CAST(N'2019-06-19' AS Date), CAST(N'2019-10-30' AS Date), 0, 1, 1, 1, CAST(N'2018-11-12' AS Date), 1, 865982, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 195, N'SCIRÈ ALBERTO', N'ALBY.SCIRE@GMAIL.COM', CAST(N'1992-09-16' AS Date), N'ASTI', N'', N'', N'CORSO PISANI 286', N'PALERMO', N'PA', N'90129', N'3917036062', N'3473888640', 14, N'5', 0, N'ECONOMIA AZIENDALE INGLESE FRANCESE', CAST(N'2020-01-16' AS Date), CAST(N'2020-01-16' AS Date), 0, 1, 1, 1, CAST(N'2020-01-16' AS Date), 1, 784247, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 162, N'SCORDATO LEONARDO', N'LEONARDO.SCORDATO@GMAIL.COM', CAST(N'2003-05-20' AS Date), N'PALERMO', N'', N'', N'VIA GUGLIELMO IL BUONO 131', N'PALERMO', N'PA', N'90100', N'3315335809', N'3931121525', 27, N'3', 0, N'FISICA LATINO', CAST(N'2019-10-28' AS Date), CAST(N'2019-10-28' AS Date), 0, 1, 1, 1, CAST(N'2019-10-28' AS Date), 1, 776122, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 134, N'SELVANAYGAM NIDEESAN', N'NITHISEN90@GMAIL.COM', CAST(N'2001-04-23' AS Date), N'PALERMO', N'', N'', N'VIA TOMMASO MONCADA N.12', N'PALERMO', N'PA', N'90145', N'3511875585', N'3511125688', 38, N'4', 0, N'ITALIANO ECONOMIA AZIENDALE', CAST(N'2019-09-23' AS Date), CAST(N'2019-09-23' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 1, 195748, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 127, N'SEMINARA MARTA', N'CARMELA.ORETO@VIRGILIO.IT', CAST(N'2000-08-03' AS Date), N'PALERMO', N'', N'', N'VIA D. RUSSO 30', N'PALERMO', N'PA', N'90131', N'3892456551', N'3281621189', 6, N'5', 0, N'ITALIANO STORIA MATEMATICA', CAST(N'2019-02-25' AS Date), CAST(N'2019-10-01' AS Date), 0, 1, 1, 1, CAST(N'2019-02-26' AS Date), 0, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 92, N'SEMINARA MICHELA', N'MICHELASEMINARA@LIBERO.IT', CAST(N'2000-07-21' AS Date), N'PALERMO', N'SMNMHL00L61G273Q', N'', N'VIA DEI REDENTORISTI N.43', N'PALERMO', N'PA', N'90145', N'3895947867', N'3280444209', 27, N'5', 0, N'', CAST(N'2018-10-01' AS Date), CAST(N'2018-10-01' AS Date), 1, 1, 1, 1, CAST(N'2018-10-01' AS Date), 1, 338646, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 128, N'SIRAGUSA GIULIA', N'GIULIASIRAGUSA27@LIBERO.IT', CAST(N'2000-08-27' AS Date), N'PALERMO', N'', N'', N'VIA CAVOUR 45', N'VILLABATE', N'PA', N'90039', N'3274399449', N'3272229352', 24, N'5', 0, N'MATEMATICA FISICA', CAST(N'2019-01-18' AS Date), CAST(N'2019-01-18' AS Date), 1, 1, 1, 1, CAST(N'2019-01-18' AS Date), 1, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 93, N'SPATARO ANNALISA', N'ANNALISPAT2002@GMAIL.COM', CAST(N'2002-11-04' AS Date), N'PALERMO', N'', N'', N'VIA G. SCIUTI 180', N'PALERMO', N'PA', N'90144', N'3401445465', N'3393721714', 17, N'3', 0, N'', CAST(N'2018-10-05' AS Date), CAST(N'2018-10-08' AS Date), 1, 1, 1, 1, CAST(N'2018-10-08' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 94, N'SPATOLA ASIA', N'ASIASPATOLA2001@GMAIL.COM', CAST(N'2001-07-30' AS Date), N'PALERMO', N'', N'', N'VIA W.KONRAD ROENTGEN 16', N'PALERMO', N'PA', N'90146', N'3270779122', N'3497646232', 10, N'4', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2018-10-30' AS Date), CAST(N'2018-10-30' AS Date), 1, 1, 1, 1, CAST(N'2018-10-30' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 212, N'SPEZZANO DANIELA', N'DADA22072002@GMAIL.COM', CAST(N'2002-07-22' AS Date), N'PALERMO', N'', N'', N'VIA MARIO ORSO CORVINO 11', N'PALERMO', N'PA', N'90127', N'3334708173', N'3357269802', 36, N'3', 0, N'MATEMATICA INGLESE FRANCESE', CAST(N'2020-02-10' AS Date), CAST(N'2020-02-10' AS Date), 0, 1, 1, 0, NULL, 1, 313161, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 95, N'SPINELLI FLAVIA', N'FLAVIUCCIA78S@GMAIL.COM', CAST(N'2000-06-21' AS Date), N'PALERMO', N'', N'', N'VIA FONDO VITALE 3 E', N'PALERMO', N'PA', N'90135', N'3272876274', N'3281037081', 23, N'5', 0, N'MATEMATICA INGLESE', CAST(N'2019-04-29' AS Date), CAST(N'2019-05-24' AS Date), 1, 1, 1, 1, CAST(N'2019-05-24' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 96, N'SPINELLI SIMONA', N'SIMONASPINELLI63@GMAIL.COM', CAST(N'2003-06-27' AS Date), N'PALERMO', N'', N'', N'VIA FONDO VITALE 3 E', N'PALERMO', N'PA', N'90135', N'3801208990', N'3281037081', 17, N'3', 0, N'MATEMATICA GRECO FISICA', CAST(N'2019-04-29' AS Date), CAST(N'2019-09-26' AS Date), 0, 1, 1, 1, CAST(N'2019-04-29' AS Date), 1, 125425, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 132, N'STABILE FRANCESCO', N'FRANCYAPPLE05@GMAIL.COM', CAST(N'2005-01-27' AS Date), N'PALERMO', N'', N'', N'VIA MONTEPELLEGRINO 144', N'PALERMO', N'PA', N'90142', N'3663281844', N'3294215245', 16, N'2', 0, N'GRECO', CAST(N'2019-09-23' AS Date), CAST(N'2019-10-22' AS Date), 0, 1, 1, 1, CAST(N'2019-09-23' AS Date), 1, 695331, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 97, N'STRUNA ALJAZ', N'STUDENTE3@SCUOLA.IT', CAST(N'2000-08-29' AS Date), N'BENFIVA', N'', N'', N'VIA CAMPOLO 3', N'PALERMO', N'PA', N'90100', N'1234678', N'32165478', 29, N'4', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2019-08-27' AS Date), 1, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 133, N'TAORMINA DARIO', N'DARIOTAORMINA01@GMAIL.COM', CAST(N'2004-12-20' AS Date), N'PALERMO', N'', N'', N'VIA CRUILLAS 121', N'PALERMO', N'PA', N'90146', N'3804793388', N'3395740379', 35, N'2', 0, N'ITALIANO- MATEMATICA- INGLESE', CAST(N'2019-09-23' AS Date), CAST(N'2019-09-24' AS Date), 0, 1, 1, 1, CAST(N'1900-01-01' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 98, N'TAORMINA EMILIA', N'EMILIATAORMINA@GMAIL.COM', CAST(N'2003-04-17' AS Date), N'PALERMO', N'', N'', N'VIA RUTELLI 26', N'PALERMO', N'PA', N'90146', N'3245435874', N'3208592315', 16, N'3', 0, N'GRECO LATINO MATEMATICA', CAST(N'2018-12-18' AS Date), CAST(N'2020-01-14' AS Date), 0, 1, 1, 1, CAST(N'2018-12-19' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 99, N'TERRANOVA RICCARDO', N'RICCARDOTERRANOVA2004@GMAIL.COM', CAST(N'2004-09-29' AS Date), N'PALERMO', N'', N'', N'VIA DEI NEBRODI N.45', N'PALERMO', N'PA', N'90146', N'3421407079', N'3409677586', 28, N'1', 0, N'MATEMATICA FISICA INGLESE', CAST(N'2019-01-31' AS Date), CAST(N'2019-01-31' AS Date), 1, 1, 1, 1, CAST(N'2019-01-31' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 100, N'TOGNETTI ANTONINO', N'ANTONYINTER214@GMAIL.COM', CAST(N'2003-09-04' AS Date), N'PALERMO', N'', N'', N'VIA V. DI PAVIA 43', N'PALERMO', N'PA', N'90138', N'3405216477', N'3286540297', 11, N'1', 0, N'MATEMATICA INGLESE FRANCESE', CAST(N'2019-02-07' AS Date), CAST(N'2019-02-25' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 292040, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 208, N'TORRES ANTONIO', N'ANTONIO.TORRES.AT402@GMAIL.COM', CAST(N'2004-09-10' AS Date), N'PALERMO', N'', N'', N'VIA GIOVANNI DA VERRAZZANO', N'PALERMO', N'PA', N'90142', N'3937367846', N'3491221595', 37, N'2', 0, N'MATEMATICA FISICA CHIMICA ITALIANO INFORMATICA', CAST(N'2020-02-03' AS Date), CAST(N'2020-02-03' AS Date), 0, 1, 1, 0, NULL, 1, 324005, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 101, N'TRAJKOVSKI ALEKSANDER', N'TRAJKOVSKI@PF.COM', CAST(N'1999-08-31' AS Date), N'TIRANA', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90123', N'2222222222', N'111111111111', 16, N'3', 0, N'', CAST(N'2018-02-01' AS Date), CAST(N'2019-09-18' AS Date), 1, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 168, N'TRAPANI ANDREA', N'TRAPANI.ANDREA2003@GMAIL.COM', CAST(N'2003-08-03' AS Date), N'PALERMO', N'', N'', N'VIA PARUTA 13-A', N'PALERMO', N'PA', N'90131', N'3515726804', N'3208707797', 37, N'2', 0, N'MATEMATICA FISICA', CAST(N'2019-11-13' AS Date), CAST(N'2019-11-13' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 165, N'TRAPANI MIRKO', N'MIRKOTRAPANI07@GMAIL.COM', CAST(N'2002-04-29' AS Date), N'PALERMO', N'', N'', N'VIA UMBRIA N.12', N'PALERMO', N'PA', N'90144', N'3664552364', N'3298540263', 26, N'3', 0, N'MATEMATICA E FISICA', CAST(N'2019-10-30' AS Date), CAST(N'2019-10-30' AS Date), 0, 1, 1, 1, CAST(N'2019-10-30' AS Date), 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 202, N'TUCCIO FILIPPO FORTUNATO', N'TUCCIOFILIPPO2016@LIBERO.IT', CAST(N'2002-05-04' AS Date), N'PALERMO', N'', N'', N'VIA COLOMBA 52', N'PALERMO', N'PA', N'90127', N'3319644920', N'3457451624', 12, N'3', 0, N'INGLESE', CAST(N'2020-01-24' AS Date), CAST(N'2020-01-24' AS Date), 0, 1, 1, 1, CAST(N'2020-01-24' AS Date), 1, 103570, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 201, N'TUCCIO ROSALIA', N'ROSALIATUCCIO2014@LIBERO.IT', CAST(N'2001-02-13' AS Date), N'PALERMO', N'', N'', N'VIA COLOMBA 52', N'PALERMO', N'PA', N'90127', N'3384605609', N'3457451624', 30, N'5', 0, N'INGLESE MATEMATICA FISICA', CAST(N'2020-01-24' AS Date), CAST(N'2020-01-24' AS Date), 0, 1, 1, 1, CAST(N'2020-01-24' AS Date), 1, 632378, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 159, N'TUTTOILMONDO CHIARA', N'CHIAAATIM@GMAIL.COM', CAST(N'2002-10-01' AS Date), N'PALERMO', N'', N'', N'VIA GIOVANNI CAMPISI 24', N'PALERMO', N'PA', N'90124', N'3294148531', N'3803807871', 38, N'4', 0, N'TEDESCO', CAST(N'2019-10-24' AS Date), CAST(N'2019-10-24' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 1, 0, N'2', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 187, N'TUZZOLINO GIULIO MARIA', N'GIULIOMARIATUZZO@GMAIL.COM', CAST(N'2003-09-30' AS Date), N'PALERMO', N'', N'', N'PASSAGGIO GINO MARINUZZI 3', N'PALERMO', N'PA', N'90129', N'3278140956', N'3392098995', 30, N'3', 0, N'ITALIANO LATINO', CAST(N'2019-12-18' AS Date), CAST(N'2019-12-18' AS Date), 0, 1, 1, 1, CAST(N'2019-12-18' AS Date), 1, 100534, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 102, N'UDDIN PARVEZ', N'PARBEZU893@GMAIL.COM', CAST(N'2002-06-01' AS Date), N'BANGLADESH', N'', N'', N'VIA NICOLÒ- TUDISCO N.8', N'PALERMO', N'PA', N'90100', N'3290214367', N'3286151339', 22, N'4', 0, N'ITALIANO MATEMATICA INGLESE', CAST(N'2018-09-26' AS Date), CAST(N'2020-02-14' AS Date), 0, 1, 1, 1, CAST(N'2018-09-26' AS Date), 1, 869022, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 137, N'UDDIN TAMANNA', N'UDDIN.TAMANNA12@GMAIL.COM', CAST(N'2004-10-17' AS Date), N'PALERMO', N'DDNTNN04R57G273M', N'', N'VIA GIUSEPPE VACCARI 44', N'PALERMO', N'PA', N'90100', N'3512706807', N'3510038491', 26, N'2', 0, N'LATINO- FISICA- MATEMATICA', CAST(N'2019-09-24' AS Date), CAST(N'2019-12-09' AS Date), 0, 1, 1, 1, CAST(N'2019-09-24' AS Date), 0, 308972, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 213, N'VACCARO AURORA', N'VACCARO.FABRIZIO@HOTMAIL.IT', CAST(N'2004-02-21' AS Date), N'PALERMO', N'', N'', N'VIA DI CRISTOFALO 19', N'PALERMO', N'PA', N'90142', N'3713652144', N'3896446434', 10, N'2', 0, N'ECONOMIA AZIENDALE FRANCESE MATEMATICA', CAST(N'2020-02-10' AS Date), CAST(N'2020-02-10' AS Date), 0, 1, 1, 1, CAST(N'2020-02-10' AS Date), 1, 437030, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 163, N'VAGLICA NICOLA GIUSEPPE', N'LOLLO.LOL@OUTLOOK.IT', CAST(N'2001-05-30' AS Date), N'PALERMO', N'', N'', N'VIA SANTA VENERA 29', N'PALERMO', N'PA', N'90131', N'3921619549', N'3209716725', 38, N'4', 0, N'MATEMATICA ITALIANO STORIA', CAST(N'2019-10-28' AS Date), CAST(N'2019-10-28' AS Date), 0, 1, 1, 0, NULL, 1, 220584, N'12', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 103, N'VALENTI FRANCESCA', N'VALENTIFRANCESCA673@GMAIL.COM', CAST(N'2000-09-07' AS Date), N'PALERMO', N'', N'', N'VIA XXVII MAGGIO 28', N'PALERMO', N'PA', N'90123', N'3400697190', N'3511735054', 6, N'5', 0, N'INGLESE', CAST(N'2018-10-19' AS Date), CAST(N'2018-10-19' AS Date), 1, 1, 1, 1, CAST(N'2018-10-19' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 104, N'VINCENZA CALTABELLOTTA', N'D.DICARLO@TISCALI.IT', CAST(N'2000-09-01' AS Date), N'PALERMO', N'CLTVCN00P41G273Y', N'', N'VIA ANTONIO PACINOTTI N.34', N'PALERMO', N'PA', N'90145', N'3206303296', N'3494401599', 19, N'5', 0, N'', CAST(N'2018-10-01' AS Date), CAST(N'2018-12-17' AS Date), 1, 1, 1, 1, CAST(N'2018-10-01' AS Date), 0, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 142, N'VITALE GIOVANNA', N'GIOVYPENNY@GMAIL.COM', CAST(N'2002-08-26' AS Date), N'PALERMO', N'VTLGNN02M66G273J', N'', N'VIALE REGIONE SICILIANA- 2507', N'PALERMO', N'PA', N'90145', N'3884830616', N'3405752300', 23, N'3', 0, N'MATEMATICA-INGLESE', CAST(N'2019-09-25' AS Date), CAST(N'2019-09-25' AS Date), 0, 1, 1, 0, NULL, 1, 0, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 105, N'ZAPPULLA FABRIZIO', N'FEDEZAPPULLA@HOTMAIL.IT', CAST(N'2003-02-21' AS Date), N'PALERMO', N'', N'', N'VIALE REGIONE SICILIANA 2347', N'PALERMO', N'PA', N'90145', N'3701223044', N'3391401660', 28, N'4', 0, N'INGLESE- MATEMATICA E FISICA', CAST(N'2018-06-22' AS Date), CAST(N'2019-10-01' AS Date), 0, 1, 1, 1, CAST(N'2018-09-29' AS Date), 1, 570668, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 106, N'ZARCONE GIULIA', N'GIULIH2O@LIBERO.IT', CAST(N'2000-12-17' AS Date), N'PALERMO', N'', N'', N'VIA LENIN MANCUSO 13', N'PALERMO', N'PA', N'90131', N'3247899426', N'3488733390', 16, N'5', 0, N'BIOLOGIA CHIMICA LATINO', CAST(N'2018-10-23' AS Date), CAST(N'2018-10-23' AS Date), 1, 1, 1, 1, CAST(N'2018-10-23' AS Date), 1, NULL, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (1, 143, N'ZICCONE DIANA', N'DIANAZIC4@GMAIL.COM', CAST(N'2004-09-13' AS Date), N'PALERMO', N'', N'', N'VIALE REGIONE SICILIANA 2507', N'PALERMO', N'PA', N'90145', N'3479748442', N'3476192258', 17, N'2', 0, N'GRECO LATINO', CAST(N'2019-09-25' AS Date), CAST(N'2019-09-25' AS Date), 0, 1, 1, 0, NULL, 1, 473349, N'1', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 219, N'ALEESAMI HAITAM', N'ALEES@VALERIOMCSE.EU', CAST(N'2018-09-25' AS Date), N'PALERMO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'12345', N'321654', 76, N'2', 0, N'', CAST(N'2018-02-05' AS Date), CAST(N'2020-07-15' AS Date), 0, 1, 1, 1, CAST(N'2019-12-10' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 1, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 220, N'CIOCEV STEFAN', N'CIOCE@VALERIOMCSE.EU', CAST(N'1998-09-09' AS Date), N'BULGARIA', N'', N'', N'VIA CAMPOLO 4', N'PALERMO', N'PA', N'90145', N'32112345678', N'3215468', 65, N'1', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-19' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 221, N'CORONADO IGOR', N'CORON@VALERIOMCSE.EU', CAST(N'2018-09-05' AS Date), N'PALERMO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'TAGLIATO', N'AVERLO', 71, N'2', 0, N'', CAST(N'2018-02-06' AS Date), CAST(N'2020-07-15' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 222, N'JAJALO MATO', N'JAJAL@VALERIOMCSE.EU', CAST(N'2018-09-06' AS Date), N'PALERMO', N'', N'', N'VIA CAMPOLO 5', N'PALERMO', N'PA', N'90100', N'321456218', N'321234584', 71, N'3', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, 627722, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 223, N'MESSI LEO', N'MESSI@VALERIOMCSE.EU', CAST(N'2000-08-02' AS Date), N'SANTA FE', N'', N'', N'MAGARI', N'PALERMO', N'PA', N'90100', N'0000', N'00', 69, N'5', 2, N'', CAST(N'2018-03-12' AS Date), CAST(N'2020-07-19' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 2, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 224, N'MOREO STEFANO', N'MOREO@VALERIOMCSE.EU', CAST(N'2009-08-13' AS Date), N'VERONA', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'12', N'21', 65, N'1', 1, N'', CAST(N'2018-02-26' AS Date), CAST(N'2020-07-20' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, 850840, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 225, N'NESTOROVSKI ILIJA', N'NESTO@VALERIOMCSE.EU', CAST(N'1989-04-19' AS Date), N'LUBJANA', N'', N'', N'VIA LATTEA', N'GALASSIA', N'PA', N'90100', N'00000000', N'000000000', 72, N'1', 0, N'', CAST(N'2018-01-27' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 226, N'POMINI PIETRO', N'POMIN@VALERIOMCSE.EU', CAST(N'1990-11-28' AS Date), N'TRENTO', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90100', N'124578', N'215487', 68, N'1', 0, N'', CAST(N'2018-02-15' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 227, N'POSAVEC JOSIF', N'POSAV@VALERIOMCSE.EU', CAST(N'1996-07-19' AS Date), N'SVALIA', N'', N'', N'CORSO PORTA CHIUSA', N'PALERMO', N'PA', N'90100', N'32112345678', N'3212345678', 46, N'1', 1, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-19' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 1, 1)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 228, N'RISPOLI ANDREA', N'RISPO@VALERIOMCSE.EU', CAST(N'1990-09-19' AS Date), N'BRESCIA', N'', N'', N'VIALE DELLA PROMOZIONE', N'PALERMO', N'PA', N'90100', N'12332165478', N'12332165478', 73, N'2', 0, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 0, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 229, N'STRUNA ALJAZ', N'STRUN@VALERIOMCSE.EU', CAST(N'2000-08-29' AS Date), N'BENFIVA', N'', N'', N'VIA CAMPOLO 3', N'PALERMO', N'PA', N'90100', N'1234678', N'32165478', 64, N'4', 1, N'', CAST(N'2018-01-04' AS Date), CAST(N'2020-07-15' AS Date), 0, 0, 0, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 1, 0)
GO
INSERT [dbo].[pf_anagrafeStudenti] ([idRS], [idStudente], [nomeStud], [emailStud], [dataNascitaStud], [luogoNascitaStud], [codiceFiscaleStud], [codiceFiscaleGen], [indirizzoStud], [comuneStud], [provStud], [capStud], [tel1Stud], [tel2Stud], [idIstituto], [anno], [idSpecial], [notaStud], [dataCreate], [dataUpdate], [deleted], [privacyStud], [liberaStud], [firmaStud], [firmaDataStud], [emailCheck], [checkCode], [sediStud], [versione], [dataVersione], [idOrigineStud], [regolamentoStud]) VALUES (14, 230, N'TRAJKOVSKI ALEKSANDER', N'TRAJK@VALERIOMCSE.EU', CAST(N'1999-08-31' AS Date), N'TIRANA', N'', N'', N'VIALE DEL FANTE', N'PALERMO', N'PA', N'90123', N'2222222222', N'111111111111', 62, N'3', 3, N'', CAST(N'2018-02-01' AS Date), CAST(N'2020-07-15' AS Date), 0, 1, 1, 0, CAST(N'1900-01-01' AS Date), 0, NULL, N'3', N'0.0', CAST(N'2000-01-01' AS Date), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[pf_anagrafeStudenti] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_parAssociazioni] ON 
GO
INSERT [dbo].[pf_parAssociazioni] ([idRS], [ragioneSociale], [sedeLegaleIndirizzo], [sedeLegaleLuogo], [sedeLegalePR], [sedeLegaleCAP], [sedeLegaleTEL1], [sedeLegaleTEL2], [sedeLegaleEmail], [sedeLegalePEC], [sedeLegaleCF], [registroNR], [registroData], [sedeLegaleLogo], [imgPath], [deletedAss]) VALUES (14, N'ASSOCIAZIONE DI SVILUPPO E TEST', N'', N'', N'', N'', N'000', N'', N'SVILUPPO@VALERIOMCSE.EU', N'', N'SVILUPPOETEST', N'', CAST(N'1900-01-01' AS Date), NULL, N'/img/logo/', 0)
GO
INSERT [dbo].[pf_parAssociazioni] ([idRS], [ragioneSociale], [sedeLegaleIndirizzo], [sedeLegaleLuogo], [sedeLegalePR], [sedeLegaleCAP], [sedeLegaleTEL1], [sedeLegaleTEL2], [sedeLegaleEmail], [sedeLegalePEC], [sedeLegaleCF], [registroNR], [registroData], [sedeLegaleLogo], [imgPath], [deletedAss]) VALUES (1, N'ASSOCIAZIONE DI VOLONTARIATO PORTOFRANCO PALERMO', N'VIA E. TORRICELLI 3', N'PALERMO', N'PA', N'90145', N'091 12345678', N'300 33333', N'PORTOFRANCOPA@VALERIOMCSE.EU', N'', N'97325720825', N'2008', CAST(N'2017-11-21' AS Date), N'', N'/img/logo/', 0)
GO
SET IDENTITY_INSERT [dbo].[pf_parAssociazioni] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_parAule] ON 
GO
INSERT [dbo].[pf_parAule] ([idSede], [idAula], [aula], [posti]) VALUES (0, 1, N'Aula 0', 10)
GO
INSERT [dbo].[pf_parAule] ([idSede], [idAula], [aula], [posti]) VALUES (0, 2, N'Aula 1', 4)
GO
INSERT [dbo].[pf_parAule] ([idSede], [idAula], [aula], [posti]) VALUES (0, 3, N'Aula 2', 2)
GO
SET IDENTITY_INSERT [dbo].[pf_parAule] OFF
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'0', CAST(N'2020-08-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-10-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-11-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-23' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-24' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-25' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-26' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-27' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-30' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2019-12-31' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-01-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-02-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-03-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-13' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-04-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-05-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-02' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-06-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'1', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-02-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-05' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-06' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-03-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-13' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-04-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-05-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-02' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-06-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'2', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-10-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-11-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-25' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-26' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2019-12-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-06' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-01-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-02-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-03-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-13' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-04-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-05-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-02' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-06-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'3', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-10-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-11-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-25' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-26' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2019-12-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-06' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-01-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-02-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-03-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-02' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-13' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-04-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-01' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-05-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-01' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-02' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-15' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'4', CAST(N'2020-06-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'5', CAST(N'2020-08-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'6', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'9', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-08' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'B', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'C', CAST(N'2020-08-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-09' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-15' AS Date), -1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-16' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-22' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-23' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-29' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-30' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-07-31' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-03' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-04' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-05' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-06' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-07' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-10' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-11' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-12' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-13' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-14' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-17' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-18' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-19' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-20' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-21' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-24' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-25' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-26' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-27' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-28' AS Date), 1)
GO
INSERT [dbo].[pf_parCalendario] ([idSede], [giorno], [attivo]) VALUES (N'D', CAST(N'2020-08-31' AS Date), 1)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (0, 11, 1, 2019, CAST(N'2019-11-01' AS Date), 5, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (0, 12, 8, 2019, CAST(N'2019-12-08' AS Date), 7, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (0, 12, 25, 2019, CAST(N'2019-12-25' AS Date), 3, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (0, 12, 26, 2019, CAST(N'2019-12-26' AS Date), 4, 1, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 1, 1, 2020, CAST(N'2020-01-01' AS Date), 3, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 1, 6, 2020, CAST(N'2020-01-06' AS Date), 1, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 4, 13, 2020, CAST(N'2020-04-13' AS Date), 1, 0, 1)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 4, 25, 2020, CAST(N'2020-04-25' AS Date), 6, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 5, 1, 2020, CAST(N'2020-05-01' AS Date), 5, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 6, 2, 2020, CAST(N'2020-06-02' AS Date), 2, -1, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 7, 15, 2020, CAST(N'2020-07-15' AS Date), 3, 0, 0)
GO
INSERT [dbo].[pf_parFestivi] ([inizio], [mm], [gg], [aa], [dataFestivo], [giornoSettimanaFestivo], [ponteFestivo], [la]) VALUES (1, 8, 15, 2020, CAST(N'2020-08-15' AS Date), 6, 0, 0)
GO
INSERT [dbo].[pf_parFrequenza] ([frequenza], [frequenzaSet]) VALUES (N'M', 3)
GO
INSERT [dbo].[pf_parFrequenza] ([frequenza], [frequenzaSet]) VALUES (N'Q', 2)
GO
INSERT [dbo].[pf_parFrequenza] ([frequenza], [frequenzaSet]) VALUES (N'S', 1)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (1, N'Lunedì', 3)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (2, N'Martedì', 3)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (3, N'Mercoledì', 3)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (4, N'Giovedì', 3)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (5, N'Venerdì', 3)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (6, N'Sabato', 0)
GO
INSERT [dbo].[pf_parGiorni] ([idGiorno], [giorno], [ore]) VALUES (7, N'Domenica', 0)
GO
SET IDENTITY_INSERT [dbo].[pf_parMaterie] ON 
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (1, N'FILOSOFIA', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (5, N'FRANCESE', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (11, N'GEOSTORIA', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (2, N'GRECO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (6, N'INGLESE', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (9, N'ITALIANO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (3, N'LATINO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (36, N'LATINO - NO LICEO CLASSICO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (4, N'LINGUA E CULTURA STRANIERA -ALTRO-', 1, 1)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (7, N'SPAGNOLO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (10, N'STORIA', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (8, N'TEDESCO', 1, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (34, N'Analisi Matematica 2', 2, 1)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (39, N'BIOLOGIA', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (38, N'CHIMICA', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (12, N'CHIMICA GENERALE', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (13, N'FISICA', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (31, N'GEOGRAFIA ASTRONOMICA', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (41, N'MATEMATICA DI BASE', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (14, N'MATEMATICA TUTTI GLI INDIRIZZI', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (40, N'SCIENZA DELLA TERRA SCIENZE DELLA NATURA', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (15, N'SCIENZE NATURALI  BIOLOGIA CHIMICA SCIENZE', 2, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (35, N'Religione', 3, 1)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (16, N'RELIGIONE CATTOLICA O ATTIVITÀ ALTERNATIVE', 3, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (17, N'SCIENZE UMANE  PSICOLOGIA - ANTROPOLOGIA - PEDAGOG', 3, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (18, N'Discipline turistiche e aziendali', 4, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (19, N'Economia aziendale', 4, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (20, N'Geografia turistica', 4, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (37, N'DIRITTO', 5, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (21, N'Diritto e legislazione turistica', 5, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (22, N'Diritto ed Economia Politica', 5, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (23, N'Relazione internazionali', 5, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (24, N'Discipline geometriche', 6, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (25, N'Discipline grafiche e pittoriche', 6, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (26, N'Discipline plastiche e scultoree', 6, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (33, N'Educazione culinaria', 6, 1)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (27, N'Informatica', 6, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (28, N'Tecnologie della comunicazione', 6, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (29, N'Arte e territorio', 7, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (32, N'Educazione Artistica', 7, 0)
GO
INSERT [dbo].[pf_parMaterie] ([idMateria], [materia], [idGruppo], [deleted]) VALUES (30, N'Storia dell’arte', 7, 0)
GO
SET IDENTITY_INSERT [dbo].[pf_parMaterie] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_parMaterieGruppo] ON 
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (7, N'Artistico', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (5, N'Diritto', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (4, N'Economia', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (1, N'Letterario', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (2, N'Scientifico', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (6, N'Tecnico', 0)
GO
INSERT [dbo].[pf_parMaterieGruppo] ([idGruppo], [gruppo], [deleted]) VALUES (3, N'Umanistico', 0)
GO
SET IDENTITY_INSERT [dbo].[pf_parMaterieGruppo] OFF
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 1, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 1, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 1, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 1, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 1, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 2, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 2, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 2, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 2, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 2, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 3, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 3, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 3, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 3, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 3, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 4, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 4, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 4, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 4, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 4, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 5, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 5, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 5, 3, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 5, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'1', 5, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 1, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 1, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 1, 3, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 1, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 1, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 2, 1, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 2, 2, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 2, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 2, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 2, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 3, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 3, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 3, 3, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 3, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 3, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 4, 1, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 4, 2, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 4, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 4, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 4, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 5, 1, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 5, 2, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 5, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 5, 4, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'2', 5, 5, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 1, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 1, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 1, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 1, 4, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 1, 5, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 2, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 2, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 2, 3, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 2, 4, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 2, 5, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 3, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 3, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 3, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 3, 4, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 3, 5, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 4, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 4, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 4, 3, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 4, 4, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 4, 5, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 5, 1, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 5, 2, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 5, 3, 0)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 5, 4, 1)
GO
INSERT [dbo].[pf_parOrari] ([idSede], [idGiorno], [idOra], [impegno]) VALUES (N'3', 5, 5, 1)
GO
INSERT [dbo].[pf_parOrdinali] ([idOra], [ordinale]) VALUES (1, N'Prima')
GO
INSERT [dbo].[pf_parOrdinali] ([idOra], [ordinale]) VALUES (2, N'Seconda')
GO
INSERT [dbo].[pf_parOrdinali] ([idOra], [ordinale]) VALUES (3, N'Terza')
GO
INSERT [dbo].[pf_parOrdinali] ([idOra], [ordinale]) VALUES (4, N'Quarta')
GO
INSERT [dbo].[pf_parOrdinali] ([idOra], [ordinale]) VALUES (5, N'Quinta')
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'1', 1, CAST(N'14:45:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'1', 2, CAST(N'15:45:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'1', 3, CAST(N'16:45:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'1', 4, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'1', 5, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'2', 1, CAST(N'15:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'2', 2, CAST(N'16:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'2', 3, CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'2', 4, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (1, N'2', 5, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (14, N'3', 1, CAST(N'15:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (14, N'3', 2, CAST(N'16:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (14, N'3', 3, CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (14, N'3', 4, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parOre] ([idRS], [idSede], [idOra], [ora]) VALUES (14, N'3', 5, CAST(N'00:00:00' AS Time))
GO
INSERT [dbo].[pf_parSedi] ([idRS], [idSede], [descrizioneSede], [indirizzoSede], [luogoSede], [capSede], [provSede], [tel1Sede], [tel2Sede], [emailSede], [imgPath], [imgFile], [deleted]) VALUES (1, N'2', N'PARROCCHIA S. BASILIO', N'VIA PARUTA 44', N'PALERMO', N'90139', N'PA', N'091 1234560', N'091', N'INFO.BASILIO@VALERIOMCSE.EU', N'/img/logo/', N'logoPF.png', 0)
GO
INSERT [dbo].[pf_parSedi] ([idRS], [idSede], [descrizioneSede], [indirizzoSede], [luogoSede], [capSede], [provSede], [tel1Sede], [tel2Sede], [emailSede], [imgPath], [imgFile], [deleted]) VALUES (1, N'1', N'PARROCCHIA S. ERNESTO', N'VIA CAMPOLO 11', N'PALERMO', N'90145', N'PA', N'091 9876543', N'091', N'INFO.ERNESTO@VALERIOMCSE.EU', N'/img/logo/', N'logoPF.png', 0)
GO
INSERT [dbo].[pf_parSedi] ([idRS], [idSede], [descrizioneSede], [indirizzoSede], [luogoSede], [capSede], [provSede], [tel1Sede], [tel2Sede], [emailSede], [imgPath], [imgFile], [deleted]) VALUES (14, N'3', N'SEDE DI SVILUPPO', N'CORSO DELLO SVILUPPO 221', N'TEST', N'90100', N'XX', N'', N'', N'SVILUPPO@VALERIOMCSE.EU', N'/img/logo/', N'logoPF.png', 0)
GO
SET IDENTITY_INSERT [dbo].[pf_parSpecial] ON 
GO
INSERT [dbo].[pf_parSpecial] ([idSpecial], [special]) VALUES (2, N'BES')
GO
INSERT [dbo].[pf_parSpecial] ([idSpecial], [special]) VALUES (3, N'DSA')
GO
INSERT [dbo].[pf_parSpecial] ([idSpecial], [special]) VALUES (4, N'Famiglie Monoparentali')
GO
INSERT [dbo].[pf_parSpecial] ([idSpecial], [special]) VALUES (0, N'Nessuno')
GO
INSERT [dbo].[pf_parSpecial] ([idSpecial], [special]) VALUES (1, N'Sostegno Scolastico')
GO
SET IDENTITY_INSERT [dbo].[pf_parSpecial] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_parStatusOfferte] ON 
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (0, N'---', N'0', 0, 0, 0, 0, 0)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (1, N'Disponibile', N'1', 0, 1, 0, 0, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (2, N'Prenotata', N'12', 0, 2, 0, 1, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (3, N'Erogata', N'23', 1, 3, 0, 0, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (4, N'Disdetta da Studente', N'2', 0, 1, 1, 0, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (5, N'Disdetta da Professore', N'125', 1, 5, 0, 1, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (6, N'Annullata dalla Segreteria', N'26', 1, 1, 0, 0, 0)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (7, N'Annullata per Studente Assente', N'2', 0, 1, 1, 0, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (8, N'Spostata ad altra data - ora', N'1', 0, 1, 1, 0, 0)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (9, N'Spostata ad altra data - ora', N'2', 0, 2, 1, 1, 0)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (10, N'Cancellata dal calendario', N'0', 1, 0, 0, 1, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (11, N'In Attesa...', N'0', 0, 11, 0, 0, 1)
GO
INSERT [dbo].[pf_parStatusOfferte] ([idStatusOfferta], [statusOfferta], [wfOfferta], [insertZero], [idStatusOffertaFinale], [badLog], [annullaAttesa], [report]) VALUES (12, N'Inevasa', N'0', 0, 12, 0, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[pf_parStatusOfferte] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_pianoLezioni] ON 
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 457, 44, 37, 41, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 458, 44, 37, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 455, 44, 41, 41, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 456, 44, 41, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 453, 45, 13, 11, N'12', N'S', CAST(N'2020-07-14' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 454, 45, 13, 12, N'12', N'S', CAST(N'2020-07-14' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 498, 45, 13, 51, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 499, 45, 13, 52, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 500, 45, 13, 53, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 451, 45, 14, 11, N'12', N'S', CAST(N'2020-07-14' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 452, 45, 14, 12, N'12', N'S', CAST(N'2020-07-14' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 501, 45, 14, 51, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 502, 45, 14, 52, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'1', 503, 45, 14, 53, N'12', N'S', CAST(N'2020-07-17' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 459, 98, 1, 11, N'12345', N'M', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 504, 98, 1, 12, N'12345', N'M', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 505, 98, 1, 31, N'12345', N'M', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 506, 98, 1, 32, N'12345', N'M', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 511, 98, 10, 11, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 512, 98, 10, 12, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 507, 98, 10, 31, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 508, 98, 10, 32, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 461, 98, 19, 11, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 462, 98, 19, 12, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 509, 98, 19, 31, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 510, 98, 19, 32, N'345', N'S', CAST(N'2020-07-19' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 463, 99, 1, 21, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 464, 99, 1, 22, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 465, 99, 10, 21, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 466, 99, 10, 22, N'345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 469, 100, 10, 22, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 470, 100, 10, 23, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 471, 100, 10, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 472, 100, 10, 43, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 467, 100, 11, 22, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 468, 100, 11, 23, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 473, 100, 11, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 474, 100, 11, 43, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 479, 101, 12, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 480, 101, 12, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 483, 101, 15, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 484, 101, 15, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 477, 101, 38, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 478, 101, 38, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 475, 101, 39, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 476, 101, 39, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 481, 101, 40, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 482, 101, 40, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 485, 102, 12, 41, N'12', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 486, 102, 12, 42, N'12', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 487, 102, 12, 43, N'12', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 488, 102, 13, 41, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 489, 102, 13, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 490, 102, 13, 43, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 491, 102, 14, 41, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 492, 102, 14, 42, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 493, 102, 14, 43, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 496, 106, 14, 31, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 497, 106, 14, 32, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 494, 106, 14, 51, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
INSERT [dbo].[pf_pianoLezioni] ([idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [anni], [frequenza], [dataCreazione], [deleted]) VALUES (N'3', 495, 106, 14, 52, N'12345', N'S', CAST(N'2020-07-15' AS Date), 0)
GO
SET IDENTITY_INSERT [dbo].[pf_pianoLezioni] OFF
GO
SET IDENTITY_INSERT [dbo].[pf_pianoOfferte] ON 
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4793, N'1', 451, 45, 14, 11, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'12', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4794, N'1', 451, 45, 14, 11, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4795, N'1', 452, 45, 14, 12, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'12', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4796, N'1', 452, 45, 14, 12, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4797, N'1', 453, 45, 13, 11, CAST(N'2020-07-20' AS Date), 79, 3, 0, N'12', N'S', 1, N'', N'')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4798, N'1', 453, 45, 13, 11, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4799, N'1', 454, 45, 13, 12, CAST(N'2020-07-20' AS Date), 24, 3, 0, N'12', N'S', 1, N'', N'')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4800, N'1', 454, 45, 13, 12, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4801, N'1', 455, 44, 41, 41, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4802, N'1', 455, 44, 41, 41, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4803, N'1', 455, 44, 41, 41, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4804, N'1', 456, 44, 41, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4805, N'1', 456, 44, 41, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4806, N'1', 456, 44, 41, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4807, N'1', 457, 44, 37, 41, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4808, N'1', 457, 44, 37, 41, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4809, N'1', 457, 44, 37, 41, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4810, N'1', 458, 44, 37, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4811, N'1', 458, 44, 37, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4812, N'1', 458, 44, 37, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5050, N'1', 498, 45, 13, 51, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5051, N'1', 498, 45, 13, 51, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5052, N'1', 498, 45, 13, 51, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5053, N'1', 499, 45, 13, 52, CAST(N'2020-07-17' AS Date), 24, 3, 0, N'12', N'S', 1, N'', N'gli insiemi')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5054, N'1', 499, 45, 13, 52, CAST(N'2020-07-24' AS Date), 24, 2, 0, N'12', N'S', 1, N'', N'le grandezze cinematiche')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5055, N'1', 499, 45, 13, 52, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5056, N'1', 500, 45, 13, 53, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5057, N'1', 500, 45, 13, 53, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5058, N'1', 500, 45, 13, 53, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5059, N'1', 501, 45, 14, 51, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5060, N'1', 501, 45, 14, 51, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5061, N'1', 501, 45, 14, 51, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5062, N'1', 502, 45, 14, 52, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5063, N'1', 502, 45, 14, 52, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5064, N'1', 502, 45, 14, 52, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5065, N'1', 503, 45, 14, 53, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5066, N'1', 503, 45, 14, 53, CAST(N'2020-07-24' AS Date), 24, 2, 1, N'12', N'S', 1, N'altri studenti della stessa classe     forse', N'')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5067, N'1', 503, 45, 14, 53, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5068, N'3', 459, 98, 1, 11, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'12345', N'M', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4813, N'3', 461, 98, 19, 11, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4814, N'3', 461, 98, 19, 11, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4815, N'3', 461, 98, 19, 11, CAST(N'2020-08-03' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4816, N'3', 461, 98, 19, 11, CAST(N'2020-08-10' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4817, N'3', 461, 98, 19, 11, CAST(N'2020-08-17' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4818, N'3', 461, 98, 19, 11, CAST(N'2020-08-24' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4819, N'3', 462, 98, 19, 12, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4820, N'3', 462, 98, 19, 12, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4821, N'3', 462, 98, 19, 12, CAST(N'2020-08-03' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4822, N'3', 462, 98, 19, 12, CAST(N'2020-08-10' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4823, N'3', 462, 98, 19, 12, CAST(N'2020-08-17' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4824, N'3', 462, 98, 19, 12, CAST(N'2020-08-24' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4825, N'3', 463, 99, 1, 21, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4826, N'3', 463, 99, 1, 21, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4827, N'3', 463, 99, 1, 21, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4828, N'3', 463, 99, 1, 21, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4829, N'3', 463, 99, 1, 21, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4830, N'3', 463, 99, 1, 21, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4831, N'3', 464, 99, 1, 22, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4832, N'3', 464, 99, 1, 22, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4833, N'3', 464, 99, 1, 22, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4834, N'3', 464, 99, 1, 22, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4835, N'3', 464, 99, 1, 22, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4836, N'3', 464, 99, 1, 22, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4837, N'3', 465, 99, 10, 21, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4838, N'3', 465, 99, 10, 21, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4839, N'3', 465, 99, 10, 21, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4840, N'3', 465, 99, 10, 21, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4841, N'3', 465, 99, 10, 21, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4842, N'3', 465, 99, 10, 21, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4843, N'3', 466, 99, 10, 22, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4844, N'3', 466, 99, 10, 22, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4845, N'3', 466, 99, 10, 22, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4846, N'3', 466, 99, 10, 22, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4847, N'3', 466, 99, 10, 22, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4848, N'3', 466, 99, 10, 22, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4849, N'3', 467, 100, 11, 22, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'12345', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4850, N'3', 467, 100, 11, 22, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4851, N'3', 467, 100, 11, 22, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4852, N'3', 467, 100, 11, 22, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4853, N'3', 467, 100, 11, 22, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4854, N'3', 467, 100, 11, 22, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4855, N'3', 468, 100, 11, 23, CAST(N'2020-07-21' AS Date), 0, 1, 0, N'12345', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4856, N'3', 468, 100, 11, 23, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4857, N'3', 468, 100, 11, 23, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4858, N'3', 468, 100, 11, 23, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4859, N'3', 468, 100, 11, 23, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4860, N'3', 468, 100, 11, 23, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4861, N'3', 469, 100, 10, 22, CAST(N'2020-07-21' AS Date), 222, 2, 0, N'12345', N'S', 1, N'', N'carlo magno')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4862, N'3', 469, 100, 10, 22, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4863, N'3', 469, 100, 10, 22, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4864, N'3', 469, 100, 10, 22, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4865, N'3', 469, 100, 10, 22, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4866, N'3', 469, 100, 10, 22, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4867, N'3', 470, 100, 10, 23, CAST(N'2020-07-21' AS Date), 228, 2, 1, N'12345', N'S', 1, N'insieme ad alesami e jajalo', N'')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4868, N'3', 470, 100, 10, 23, CAST(N'2020-07-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4869, N'3', 470, 100, 10, 23, CAST(N'2020-08-04' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4870, N'3', 470, 100, 10, 23, CAST(N'2020-08-11' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4871, N'3', 470, 100, 10, 23, CAST(N'2020-08-18' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4872, N'3', 470, 100, 10, 23, CAST(N'2020-08-25' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4873, N'3', 471, 100, 10, 42, CAST(N'2020-07-16' AS Date), 219, 3, 1, N'12345', N'S', 1, N'insieme con moreo stefano e pomini pietro', N'la repubblica di roma')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4874, N'3', 471, 100, 10, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4875, N'3', 471, 100, 10, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4876, N'3', 471, 100, 10, 42, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4877, N'3', 471, 100, 10, 42, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4878, N'3', 471, 100, 10, 42, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4879, N'3', 471, 100, 10, 42, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4880, N'3', 472, 100, 10, 43, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4881, N'3', 472, 100, 10, 43, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4882, N'3', 472, 100, 10, 43, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4883, N'3', 472, 100, 10, 43, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4884, N'3', 472, 100, 10, 43, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4885, N'3', 472, 100, 10, 43, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4886, N'3', 472, 100, 10, 43, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4887, N'3', 473, 100, 11, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4888, N'3', 473, 100, 11, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4889, N'3', 473, 100, 11, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4890, N'3', 473, 100, 11, 42, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4891, N'3', 473, 100, 11, 42, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4892, N'3', 473, 100, 11, 42, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4893, N'3', 473, 100, 11, 42, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4894, N'3', 474, 100, 11, 43, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4895, N'3', 474, 100, 11, 43, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4896, N'3', 474, 100, 11, 43, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4897, N'3', 474, 100, 11, 43, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4898, N'3', 474, 100, 11, 43, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4899, N'3', 474, 100, 11, 43, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4900, N'3', 474, 100, 11, 43, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4901, N'3', 475, 101, 39, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4902, N'3', 475, 101, 39, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4903, N'3', 475, 101, 39, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4904, N'3', 475, 101, 39, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4905, N'3', 475, 101, 39, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4906, N'3', 475, 101, 39, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4907, N'3', 476, 101, 39, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4908, N'3', 476, 101, 39, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4909, N'3', 476, 101, 39, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4910, N'3', 476, 101, 39, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4911, N'3', 476, 101, 39, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4912, N'3', 476, 101, 39, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4913, N'3', 477, 101, 38, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4914, N'3', 477, 101, 38, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4915, N'3', 477, 101, 38, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4916, N'3', 477, 101, 38, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4917, N'3', 477, 101, 38, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4918, N'3', 477, 101, 38, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4919, N'3', 478, 101, 38, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4920, N'3', 478, 101, 38, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4921, N'3', 478, 101, 38, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4922, N'3', 478, 101, 38, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4923, N'3', 478, 101, 38, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4924, N'3', 478, 101, 38, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4925, N'3', 479, 101, 12, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4926, N'3', 479, 101, 12, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4927, N'3', 479, 101, 12, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4928, N'3', 479, 101, 12, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4929, N'3', 479, 101, 12, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4930, N'3', 479, 101, 12, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4931, N'3', 480, 101, 12, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4932, N'3', 480, 101, 12, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4933, N'3', 480, 101, 12, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4934, N'3', 480, 101, 12, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4935, N'3', 480, 101, 12, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4936, N'3', 480, 101, 12, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4937, N'3', 481, 101, 40, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4938, N'3', 481, 101, 40, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4939, N'3', 481, 101, 40, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4940, N'3', 481, 101, 40, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4941, N'3', 481, 101, 40, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4942, N'3', 481, 101, 40, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4943, N'3', 482, 101, 40, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4944, N'3', 482, 101, 40, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4945, N'3', 482, 101, 40, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4946, N'3', 482, 101, 40, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4947, N'3', 482, 101, 40, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4948, N'3', 482, 101, 40, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4949, N'3', 483, 101, 15, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4950, N'3', 483, 101, 15, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4951, N'3', 483, 101, 15, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4952, N'3', 483, 101, 15, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4953, N'3', 483, 101, 15, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4954, N'3', 483, 101, 15, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4955, N'3', 484, 101, 15, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4956, N'3', 484, 101, 15, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4957, N'3', 484, 101, 15, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4958, N'3', 484, 101, 15, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4959, N'3', 484, 101, 15, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4960, N'3', 484, 101, 15, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4961, N'3', 485, 102, 12, 41, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4962, N'3', 485, 102, 12, 41, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4963, N'3', 485, 102, 12, 41, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4964, N'3', 485, 102, 12, 41, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4965, N'3', 485, 102, 12, 41, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4966, N'3', 485, 102, 12, 41, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4967, N'3', 485, 102, 12, 41, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4968, N'3', 486, 102, 12, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4969, N'3', 486, 102, 12, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4970, N'3', 486, 102, 12, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4971, N'3', 486, 102, 12, 42, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4972, N'3', 486, 102, 12, 42, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4973, N'3', 486, 102, 12, 42, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4974, N'3', 486, 102, 12, 42, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4975, N'3', 487, 102, 12, 43, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4976, N'3', 487, 102, 12, 43, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4977, N'3', 487, 102, 12, 43, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4978, N'3', 487, 102, 12, 43, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4979, N'3', 487, 102, 12, 43, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4980, N'3', 487, 102, 12, 43, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4981, N'3', 487, 102, 12, 43, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4982, N'3', 488, 102, 13, 41, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4983, N'3', 488, 102, 13, 41, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4984, N'3', 488, 102, 13, 41, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4985, N'3', 488, 102, 13, 41, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4986, N'3', 488, 102, 13, 41, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4987, N'3', 488, 102, 13, 41, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4988, N'3', 488, 102, 13, 41, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4989, N'3', 489, 102, 13, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4990, N'3', 489, 102, 13, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4991, N'3', 489, 102, 13, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4992, N'3', 489, 102, 13, 42, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4993, N'3', 489, 102, 13, 42, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4994, N'3', 489, 102, 13, 42, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4995, N'3', 489, 102, 13, 42, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4996, N'3', 490, 102, 13, 43, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4997, N'3', 490, 102, 13, 43, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4998, N'3', 490, 102, 13, 43, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 4999, N'3', 490, 102, 13, 43, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5000, N'3', 490, 102, 13, 43, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5001, N'3', 490, 102, 13, 43, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5002, N'3', 490, 102, 13, 43, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5003, N'3', 491, 102, 14, 41, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5004, N'3', 491, 102, 14, 41, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5005, N'3', 491, 102, 14, 41, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5006, N'3', 491, 102, 14, 41, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5007, N'3', 491, 102, 14, 41, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5008, N'3', 491, 102, 14, 41, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5009, N'3', 491, 102, 14, 41, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5010, N'3', 492, 102, 14, 42, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5011, N'3', 492, 102, 14, 42, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5012, N'3', 492, 102, 14, 42, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5013, N'3', 492, 102, 14, 42, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5014, N'3', 492, 102, 14, 42, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5015, N'3', 492, 102, 14, 42, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5016, N'3', 492, 102, 14, 42, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5017, N'3', 493, 102, 14, 43, CAST(N'2020-07-16' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5018, N'3', 493, 102, 14, 43, CAST(N'2020-07-23' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5019, N'3', 493, 102, 14, 43, CAST(N'2020-07-30' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5020, N'3', 493, 102, 14, 43, CAST(N'2020-08-06' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5021, N'3', 493, 102, 14, 43, CAST(N'2020-08-13' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5022, N'3', 493, 102, 14, 43, CAST(N'2020-08-20' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5023, N'3', 493, 102, 14, 43, CAST(N'2020-08-27' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5024, N'3', 494, 106, 14, 51, CAST(N'2020-07-17' AS Date), 0, 12, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5025, N'3', 494, 106, 14, 51, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5026, N'3', 494, 106, 14, 51, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5027, N'3', 494, 106, 14, 51, CAST(N'2020-08-07' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5028, N'3', 494, 106, 14, 51, CAST(N'2020-08-14' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5029, N'3', 494, 106, 14, 51, CAST(N'2020-08-21' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5030, N'3', 494, 106, 14, 51, CAST(N'2020-08-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5031, N'3', 495, 106, 14, 52, CAST(N'2020-07-17' AS Date), 224, 3, 0, N'12345', N'S', 1, N'', N'operazioni sui polinomi')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5032, N'3', 495, 106, 14, 52, CAST(N'2020-07-24' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5033, N'3', 495, 106, 14, 52, CAST(N'2020-07-31' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5034, N'3', 495, 106, 14, 52, CAST(N'2020-08-07' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5035, N'3', 495, 106, 14, 52, CAST(N'2020-08-14' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5036, N'3', 495, 106, 14, 52, CAST(N'2020-08-21' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5037, N'3', 495, 106, 14, 52, CAST(N'2020-08-28' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5038, N'3', 496, 106, 14, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5039, N'3', 496, 106, 14, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5040, N'3', 496, 106, 14, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5041, N'3', 496, 106, 14, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5042, N'3', 496, 106, 14, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5043, N'3', 496, 106, 14, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5044, N'3', 497, 106, 14, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5045, N'3', 497, 106, 14, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5046, N'3', 497, 106, 14, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5047, N'3', 497, 106, 14, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5048, N'3', 497, 106, 14, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5049, N'3', 497, 106, 14, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'12345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5070, N'3', 507, 98, 10, 31, CAST(N'2020-07-22' AS Date), 222, 2, 0, N'345', N'S', 1, N'', N'vassali e valvassori')
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5071, N'3', 507, 98, 10, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5072, N'3', 507, 98, 10, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5073, N'3', 507, 98, 10, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5074, N'3', 507, 98, 10, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5075, N'3', 507, 98, 10, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5076, N'3', 508, 98, 10, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5077, N'3', 508, 98, 10, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5078, N'3', 508, 98, 10, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5079, N'3', 508, 98, 10, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5080, N'3', 508, 98, 10, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5081, N'3', 508, 98, 10, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5082, N'3', 509, 98, 19, 31, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'345', N'S', 0, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5083, N'3', 509, 98, 19, 31, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5084, N'3', 509, 98, 19, 31, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5085, N'3', 509, 98, 19, 31, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5086, N'3', 509, 98, 19, 31, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5087, N'3', 509, 98, 19, 31, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5088, N'3', 510, 98, 19, 32, CAST(N'2020-07-22' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5089, N'3', 510, 98, 19, 32, CAST(N'2020-07-29' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5090, N'3', 510, 98, 19, 32, CAST(N'2020-08-05' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5091, N'3', 510, 98, 19, 32, CAST(N'2020-08-12' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5092, N'3', 510, 98, 19, 32, CAST(N'2020-08-19' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5093, N'3', 510, 98, 19, 32, CAST(N'2020-08-26' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5094, N'3', 511, 98, 10, 11, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5095, N'3', 511, 98, 10, 11, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5096, N'3', 511, 98, 10, 11, CAST(N'2020-08-03' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5097, N'3', 511, 98, 10, 11, CAST(N'2020-08-10' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5098, N'3', 511, 98, 10, 11, CAST(N'2020-08-17' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5099, N'3', 511, 98, 10, 11, CAST(N'2020-08-24' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5100, N'3', 512, 98, 10, 12, CAST(N'2020-07-20' AS Date), 0, 12, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5101, N'3', 512, 98, 10, 12, CAST(N'2020-07-27' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5102, N'3', 512, 98, 10, 12, CAST(N'2020-08-03' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5103, N'3', 512, 98, 10, 12, CAST(N'2020-08-10' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5104, N'3', 512, 98, 10, 12, CAST(N'2020-08-17' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
INSERT [dbo].[pf_pianoOfferte] ([idRS], [idOfferta], [idSede], [idLezione], [idProfessore], [idMateria], [idOrario], [dataOfferta], [idStudente], [idStatusOfferta], [gruppoStud], [anni], [frequenza], [attivo], [notaOfferta], [argomentoOfferta]) VALUES (0, 5105, N'3', 512, 98, 10, 12, CAST(N'2020-08-24' AS Date), 0, 1, 0, N'345', N'S', 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[pf_pianoOfferte] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_pf_anagrafeProfessori]    Script Date: 26/07/2020 09:00:22 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_pf_anagrafeProfessori] ON [dbo].[pf_anagrafeProfessori]
(
	[idRS] ASC,
	[emailProf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_pf_anagrafeStudenti]    Script Date: 26/07/2020 09:00:22 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_pf_anagrafeStudenti] ON [dbo].[pf_anagrafeStudenti]
(
	[idRS] ASC,
	[emailStud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_pf_parGiorni]    Script Date: 26/07/2020 09:00:22 ******/
ALTER TABLE [dbo].[pf_parGiorni] ADD  CONSTRAINT [PK_pf_parGiorni] UNIQUE NONCLUSTERED 
(
	[idGiorno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idSede_pf_parSedi]    Script Date: 26/07/2020 09:00:22 ******/
CREATE UNIQUE NONCLUSTERED INDEX [idSede_pf_parSedi] ON [dbo].[pf_parSedi]
(
	[idSede] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_pf_pianoAssemblee_tipoAss]  DEFAULT ('S') FOR [idTipoAss]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_pf_pianoAssemblee_dataAss]  DEFAULT (getdate()) FOR [dataAss]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_admAssemblee_oraAss]  DEFAULT ('12:00') FOR [oraAss]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_admAssemblee_luogoAss]  DEFAULT ('Palermo') FOR [luogoAss]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_admAssemblee_indirizzoAss]  DEFAULT ('Via Campolo') FOR [indirizzoAss]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_admAssemblee_inviata]  DEFAULT ((0)) FOR [inviata]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  CONSTRAINT [DF_admAssemblee_os]  DEFAULT ((0)) FOR [straord]
GO
ALTER TABLE [dbo].[admAssemblee] ADD  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_idCat]  DEFAULT ((0)) FOR [idCat]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_idSottCat]  DEFAULT ((0)) FOR [idSottCat]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_causale]  DEFAULT ('descrizione causale') FOR [descCausale]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_segno]  DEFAULT ((0)) FOR [segno]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_ruolo]  DEFAULT ((0)) FOR [ruolo]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_banca]  DEFAULT ((0)) FOR [banca]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  DEFAULT ((0)) FOR [giro]
GO
ALTER TABLE [dbo].[admCassaDocumento] ADD  CONSTRAINT [DF_admCassaDocumento_segno]  DEFAULT ((0)) FOR [segno]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF__admCassaMo__idRS__44952D46]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_idRicevuta]  DEFAULT ((0)) FOR [idProg]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_idCausale]  DEFAULT ((0)) FOR [idCausale]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_idTipoCassa]  DEFAULT ((1)) FOR [idTipoCassa]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_Table_1_data]  DEFAULT (getdate()) FOR [dataMov]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_importoOfferta]  DEFAULT ((0)) FOR [importoMov]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_soggettoMov]  DEFAULT ('soggetto') FOR [soggettoMov]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_deleted]  DEFAULT ((0)) FOR [deletedMov]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_idUtente]  DEFAULT ((0)) FOR [idUtente]
GO
ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_timeStampa]  DEFAULT (getdate()) FOR [timeStamp]
GO
ALTER TABLE [dbo].[admTipoSocio] ADD  CONSTRAINT [DF_admSoci_tipoSocio]  DEFAULT ('Ordinario') FOR [tipoSocio]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__idRS__123EB7A3]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_cambiaPassword]  DEFAULT ((1)) FOR [cambiaPassword]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_scadenza]  DEFAULT (getdate()) FOR [scadenza]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_registra]  DEFAULT (getdate()) FOR [registra]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_ultimo]  DEFAULT (getdate()) FOR [ultimo]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_attivo]  DEFAULT ((0)) FOR [attivo]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_ID_Ruolo]  DEFAULT ((4)) FOR [idRuolo]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_idSocio]  DEFAULT ((0)) FOR [idTipoSocioUser]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__priva__02FC7413]  DEFAULT ((0)) FOR [privacyUser]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__adv__03F0984C]  DEFAULT ((0)) FOR [liberaUser]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_firmaUser]  DEFAULT ((0)) FOR [firmaUser]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__check__04E4BC85]  DEFAULT ((0)) FOR [checkCode]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_emailCheck]  DEFAULT ((0)) FOR [emailCheck]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF_admUtenti_sediUser]  DEFAULT ((0)) FOR [sediUser]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__versi__10566F31]  DEFAULT ('0.0') FOR [versione]
GO
ALTER TABLE [dbo].[admUtenti] ADD  CONSTRAINT [DF__admUtenti__dataV__114A936A]  DEFAULT (getdate()) FOR [dataVersione]
GO
ALTER TABLE [dbo].[pf_anagrafeIstituti] ADD  CONSTRAINT [DF__pf_anagraf__idRS__4589517F]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_anagrafeIstituti] ADD  CONSTRAINT [DF_pf_anagrafeIstituti_CODICE]  DEFAULT ((0)) FOR [CODICE]
GO
ALTER TABLE [dbo].[pf_anagrafeIstituti] ADD  CONSTRAINT [DF_pf_anagrafeIstituti_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagraf__idRS__467D75B8]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_tel1Prof]  DEFAULT ((91)) FOR [tel1Prof]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_dataInsert]  DEFAULT (getdate()) FOR [dataCreate]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_dataUpdate]  DEFAULT (getdate()) FOR [dataUpdate]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_idSocio]  DEFAULT ((0)) FOR [idTipoSocioProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__idTip__208CD6FA]  DEFAULT ((0)) FOR [idTipoProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__priva__0D44F85C]  DEFAULT ((0)) FOR [privacyProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__liber__0E391C95]  DEFAULT ((0)) FOR [liberaProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__firma__0F2D40CE]  DEFAULT ((0)) FOR [firmaProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__email__10216507]  DEFAULT ((0)) FOR [emailCheck]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__check__11158940]  DEFAULT ((0)) FOR [checkCode]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF_pf_anagrafeProfessori_sediProf]  DEFAULT ((0)) FOR [sediProf]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__versi__6FBF826D]  DEFAULT ('0.0') FOR [versione]
GO
ALTER TABLE [dbo].[pf_anagrafeProfessori] ADD  CONSTRAINT [DF__pf_anagra__dataV__70B3A6A6]  DEFAULT (getdate()) FOR [dataVersione]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagraf__idRS__477199F1]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_idIstituto]  DEFAULT ((0)) FOR [idIstituto]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_anno]  DEFAULT ((1)) FOR [anno]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_idSpecial]  DEFAULT ((0)) FOR [idSpecial]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_dataCreate]  DEFAULT (getdate()) FOR [dataCreate]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_dataUpdate]  DEFAULT (getdate()) FOR [dataUpdate]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__priva__30F848ED]  DEFAULT ((0)) FOR [privacyStud]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__liber__31EC6D26]  DEFAULT ((0)) FOR [liberaStud]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__firma__32E0915F]  DEFAULT ((0)) FOR [firmaStud]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__email__33D4B598]  DEFAULT ((0)) FOR [emailCheck]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__check__160F4887]  DEFAULT ((0)) FOR [checkCode]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF_pf_anagrafeStudenti_sediStud]  DEFAULT ((0)) FOR [sediStud]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__versi__2B0A656D]  DEFAULT ('0.0') FOR [versione]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__dataV__2BFE89A6]  DEFAULT (getdate()) FOR [dataVersione]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__idOri__2CF2ADDF]  DEFAULT ((0)) FOR [idOrigineStud]
GO
ALTER TABLE [dbo].[pf_anagrafeStudenti] ADD  CONSTRAINT [DF__pf_anagra__regol__2DE6D218]  DEFAULT ((0)) FOR [regolamentoStud]
GO
ALTER TABLE [dbo].[pf_parAssociazioni] ADD  CONSTRAINT [DF_pf_parAssociazioni_imgPath]  DEFAULT ('/img/logo/') FOR [imgPath]
GO
ALTER TABLE [dbo].[pf_parAssociazioni] ADD  CONSTRAINT [DF_pf_parAssociazioni_deletedAss]  DEFAULT ((0)) FOR [deletedAss]
GO
ALTER TABLE [dbo].[pf_parAule] ADD  CONSTRAINT [DF_pf_parAule_idSede]  DEFAULT ((0)) FOR [idSede]
GO
ALTER TABLE [dbo].[pf_parAule] ADD  CONSTRAINT [DF__pf_parAul__posti__17036CC0]  DEFAULT ((1)) FOR [posti]
GO
ALTER TABLE [dbo].[pf_parCalendario] ADD  CONSTRAINT [DF_pf_parCalendario_attivo]  DEFAULT ((1)) FOR [attivo]
GO
ALTER TABLE [dbo].[pf_parFestivi] ADD  CONSTRAINT [DF_pf_parFestivi_mm]  DEFAULT ((1)) FOR [mm]
GO
ALTER TABLE [dbo].[pf_parFestivi] ADD  CONSTRAINT [DF_pf_parFestivi_gg]  DEFAULT ((1)) FOR [gg]
GO
ALTER TABLE [dbo].[pf_parFestivi] ADD  CONSTRAINT [DF_pf_parFestivi_la]  DEFAULT ((0)) FOR [la]
GO
ALTER TABLE [dbo].[pf_parGiorni] ADD  DEFAULT ((2)) FOR [ore]
GO
ALTER TABLE [dbo].[pf_parMaterie] ADD  CONSTRAINT [DF_pf_anagrafeMaterie_gruppo]  DEFAULT ((0)) FOR [idGruppo]
GO
ALTER TABLE [dbo].[pf_parMaterie] ADD  CONSTRAINT [DF_pf_parMaterie_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_parMaterieGruppo] ADD  CONSTRAINT [DF_pf_parMaterieGruppo_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_parOrari] ADD  CONSTRAINT [DF_pf_parOrari_idSede]  DEFAULT ((0)) FOR [idSede]
GO
ALTER TABLE [dbo].[pf_parOrari] ADD  CONSTRAINT [DF_pf_parOrari_impegno]  DEFAULT ((0)) FOR [impegno]
GO
ALTER TABLE [dbo].[pf_parOre] ADD  CONSTRAINT [DF_pf_parOre_idRS]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_parOre] ADD  CONSTRAINT [DF_pf_parOre_idSede]  DEFAULT ((0)) FOR [idSede]
GO
ALTER TABLE [dbo].[pf_parSedi] ADD  CONSTRAINT [DF_pf_parSedi_idLuogo]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_parSedi] ADD  CONSTRAINT [DF_pf_parSedi_pathImg]  DEFAULT ('/img/logo/') FOR [imgPath]
GO
ALTER TABLE [dbo].[pf_parSedi] ADD  CONSTRAINT [DF_pf_parSedi_imgFile]  DEFAULT ('logoPF.png') FOR [imgFile]
GO
ALTER TABLE [dbo].[pf_parSedi] ADD  CONSTRAINT [DF_pf_parSedi_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_parStatusOfferte] ADD  CONSTRAINT [DF_pf_parStatusRichieste_attiva_1]  DEFAULT ((1)) FOR [insertZero]
GO
ALTER TABLE [dbo].[pf_parStatusOfferte] ADD  CONSTRAINT [DF_pf_parStatusOfferte_idStatusOffertaFinale]  DEFAULT ((0)) FOR [idStatusOffertaFinale]
GO
ALTER TABLE [dbo].[pf_parStatusOfferte] ADD  CONSTRAINT [DF_pf_parStatusOfferte_badLog]  DEFAULT ((0)) FOR [badLog]
GO
ALTER TABLE [dbo].[pf_parStatusOfferte] ADD  CONSTRAINT [DF_pf_parStatusOfferte_annullaAttesa]  DEFAULT ((0)) FOR [annullaAttesa]
GO
ALTER TABLE [dbo].[pf_parStatusOfferte] ADD  DEFAULT ((0)) FOR [report]
GO
ALTER TABLE [dbo].[pf_pianoLezioni] ADD  CONSTRAINT [DF__pf_pianoLe__anni__4222D4EF]  DEFAULT ((12345)) FOR [anni]
GO
ALTER TABLE [dbo].[pf_pianoLezioni] ADD  CONSTRAINT [DF_pf_pianoLezioni_frequenza]  DEFAULT ('S') FOR [frequenza]
GO
ALTER TABLE [dbo].[pf_pianoLezioni] ADD  CONSTRAINT [DF_pf_pianoLezioni_dataCreazione]  DEFAULT (getdate()) FOR [dataCreazione]
GO
ALTER TABLE [dbo].[pf_pianoLezioni] ADD  CONSTRAINT [DF_pf_pianoLezioni_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_idRS]  DEFAULT ((0)) FOR [idRS]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_idStudente]  DEFAULT ((0)) FOR [idStudente]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_idStatusOfferta]  DEFAULT ((1)) FOR [idStatusOfferta]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_gruppo]  DEFAULT ((0)) FOR [gruppoStud]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_anni]  DEFAULT ((12345)) FOR [anni]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF_pf_pianoOfferte_frequenza]  DEFAULT ('S') FOR [frequenza]
GO
ALTER TABLE [dbo].[pf_pianoOfferte] ADD  CONSTRAINT [DF__pf_pianoO__attiv__2704CA5F]  DEFAULT ((1)) FOR [attivo]
GO
ALTER TABLE [dbo].[pf_pianoRichieste] ADD  CONSTRAINT [DF__pf_pianoR__idSta__48CFD27E]  DEFAULT ((1)) FOR [idStatusOfferta]
GO
ALTER TABLE [dbo].[pf_pianoRichieste] ADD  CONSTRAINT [DF_pf_pianoRichieste_idOfferta]  DEFAULT ((0)) FOR [idOfferta]
GO
