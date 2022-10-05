USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_anagrafeStudenti_transfer]    Script Date: 22/02/2022 11:44:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_anagrafeStudenti_transfer](
	[idRS] [int] NOT NULL,
	[idStudente] [int] NOT NULL,
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
	[docTipoStud] [int] NULL,
	[docNumeroStud] [varchar](30) NULL,
	[docRilascioStud] [varchar](50) NULL,
	[docDataEStud] [date] NULL,
	[docDataSStud] [date] NULL,
	[docTipoGen] [int] NULL,
	[docNumeroGen] [varchar](30) NULL,
	[docRilascioGen] [varchar](50) NULL,
	[docDataEGen] [date] NULL,
	[docDataSGen] [date] NULL,
	[emailStudAltro] [varchar](200) NULL,
	[materiaStud] [varchar](50) NULL,
 CONSTRAINT [PK_pf_anagrafeStudenti_transfer] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[nomeStud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


