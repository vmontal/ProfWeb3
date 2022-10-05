USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_dbItaliaMaterie]    Script Date: 13/01/2022 10:12:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_dbItaliaMaterie](
	[idRS] [int] NOT NULL,
	[idMateria] [int] NOT NULL,
	[oreErogate] [int] NOT NULL,
 CONSTRAINT [PK_pf_dbItaliaMaterie] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC,
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pf_dbItaliaMaterie] ADD  CONSTRAINT [DF_pf_dbItaliaMaterie_idRS]  DEFAULT ((0)) FOR [idRS]
GO

ALTER TABLE [dbo].[pf_dbItaliaMaterie] ADD  CONSTRAINT [DF_pf_dbItaliaMaterie_idMateria]  DEFAULT ((0)) FOR [idMateria]
GO

ALTER TABLE [dbo].[pf_dbItaliaMaterie] ADD  CONSTRAINT [DF_pf_dbItaliaMaterie_oreErogate]  DEFAULT ((0)) FOR [oreErogate]
GO


