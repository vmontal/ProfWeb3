USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_dbItaliaProfessori]    Script Date: 12/01/2022 17:25:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pf_dbItaliaProfessori](
	[idRS] [int] NOT NULL,
	[attivo] [int] NOT NULL,
	[pensione] [int] NOT NULL,
	[studente] [int] NOT NULL,
	[altro] [int] NOT NULL,
 CONSTRAINT [PK_pf_dbItaliaProfessori] PRIMARY KEY CLUSTERED 
(
	[idRS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pf_dbItaliaProfessori] ADD  CONSTRAINT [DF_pf_dbItaliaProfessori_idRS]  DEFAULT ((0)) FOR [idRS]
GO

ALTER TABLE [dbo].[pf_dbItaliaProfessori] ADD  CONSTRAINT [DF_pf_dbItaliaProfessori_attivo]  DEFAULT ((0)) FOR [attivo]
GO

ALTER TABLE [dbo].[pf_dbItaliaProfessori] ADD  CONSTRAINT [DF_pf_dbItaliaProfessori_pensione]  DEFAULT ((0)) FOR [pensione]
GO

ALTER TABLE [dbo].[pf_dbItaliaProfessori] ADD  CONSTRAINT [DF_pf_dbItaliaProfessori_studente]  DEFAULT ((0)) FOR [studente]
GO

ALTER TABLE [dbo].[pf_dbItaliaProfessori] ADD  CONSTRAINT [DF_pf_dbItaliaProfessori_altro]  DEFAULT ((0)) FOR [altro]
GO


