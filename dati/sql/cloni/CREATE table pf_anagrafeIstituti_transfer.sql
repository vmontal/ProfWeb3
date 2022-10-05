USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_anagrafeIstituti_transfer]    Script Date: 22/02/2022 11:43:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_anagrafeIstituti_transfer](
	[idRS] [int] NOT NULL,
	[CODICEISTITUTO] [int] NOT NULL,
	[CODICE] [varchar](10) NULL,
	[ISTITUTO] [varchar](200) NOT NULL,
	[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA] [varchar](150) NOT NULL,
	[INDIRIZZO] [varchar](50) NOT NULL,
	[CAP] [varchar](5) NOT NULL,
	[COMUNE] [varchar](50) NOT NULL,
	[PROVINCIA] [varchar](50) NOT NULL,
	[REGIONE] [varchar](50) NOT NULL,
	[INDIRIZZOEMAILSCUOLA] [varchar](40) NULL,
	[INDIRIZZOPECSCUOLA] [varchar](40) NULL,
	[SITOWEBSCUOLA] [varchar](50) NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_pf_anagrafeIstituti_transfer] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA] ASC,
	[ISTITUTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


