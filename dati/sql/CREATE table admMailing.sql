USE [MSSqlProfWeb30]
GO

/****** Object:  Table [dbo].[admAssemblee]    Script Date: 02/07/2021 17:12:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[admMailing](
	[idRS] [int] NOT NULL,
	[idMail] [int] IDENTITY(1,1) NOT NULL,
	[idTipoMail] [varchar](1) NOT NULL,
	[oggettoMail] [varchar](200) NOT NULL,
	[testoMail] [varchar](max) NOT NULL,
	[dataInvioMail] [date] NOT NULL,
	[inviataMail] [bit] NOT NULL,

 CONSTRAINT [PK_admMailing] PRIMARY KEY CLUSTERED 
(
	[dataInvioMail] ASC,
	[idMail] ASC,
	[idRS]  ASC
)

WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[admMailing] ADD  CONSTRAINT [DF_admMailing_dataInvioMail]  DEFAULT (getdate()) FOR [dataInvioMail]
GO

ALTER TABLE [dbo].[admMailing] ADD  CONSTRAINT [DF_admMailing_inviata]  DEFAULT ((0)) FOR [inviataMail]
GO

ALTER TABLE [dbo].[admMailing] ADD  DEFAULT ((0)) FOR [idRS]
GO


