USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_dbItaliaStudenti]    Script Date: 11/01/2022 19:02:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_dbItaliaStudenti](
	[idRS] [int] NOT NULL,
	[idOrigineStud] [int] NOT NULL,
	[primo] [int] NOT NULL,
	[secondo] [int] NOT NULL,
	[terzo] [int] NOT NULL,
	[quarto] [int] NOT NULL,
	[quinto] [int] NOT NULL,
 CONSTRAINT [PK_pf_dbItaliaStudenti] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[idOrigineStud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_idOrigineStud]  DEFAULT ((0)) FOR [idOrigineStud]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_primo]  DEFAULT ((0)) FOR [primo]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_secondo]  DEFAULT ((0)) FOR [secondo]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_terzo]  DEFAULT ((0)) FOR [terzo]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_quarto]  DEFAULT ((0)) FOR [quarto]
GO

ALTER TABLE [dbo].[pf_dbItaliaStudenti] ADD  CONSTRAINT [DF_pf_dbItaliaStudenti_quinto]  DEFAULT ((0)) FOR [quinto]
GO


