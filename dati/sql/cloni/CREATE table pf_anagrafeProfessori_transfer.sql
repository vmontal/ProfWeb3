USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_anagrafeProfessori_transfer]    Script Date: 22/02/2022 11:43:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_anagrafeProfessori_transfer](
	[idRS] [int] NOT NULL,
	[idProfessore] [int] NOT NULL,
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
	[distanza] [bit] NULL,
	[modoLezione] [int] NULL,
	[docTipoProf] [int] NULL,
	[docNumeroProf] [varchar](30) NULL,
	[docRilascioProf] [varchar](50) NULL,
	[docDataEProf] [date] NULL,
	[docDataSProf] [date] NULL,
 CONSTRAINT [PK_pf_anagrafeProfessori_transfer] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[nomeProf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


