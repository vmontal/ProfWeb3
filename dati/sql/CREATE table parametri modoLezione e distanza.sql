USE [MSSql171182]
GO
/****** Object:  Table [dbo].[pf_parDistanza]    Script Date: 07/02/2022 16:21:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parDistanza](
	[distanza] [int] NOT NULL,
	[distanzaDesc] [varchar](20) NOT NULL,
 CONSTRAINT [PK_pf_parDistanza] PRIMARY KEY CLUSTERED 
(
	[distanza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pf_parModoLezione]    Script Date: 07/02/2022 16:21:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pf_parModoLezione](
	[modoLezione] [int] NOT NULL,
	[modoLezioneDesc] [varchar](30) NOT NULL,
 CONSTRAINT [PK_pf_parModoLezione] PRIMARY KEY CLUSTERED 
(
	[modoLezione] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[pf_parDistanza] ([distanza], [distanzaDesc]) VALUES (0, N'Presenza')
GO
INSERT [dbo].[pf_parDistanza] ([distanza], [distanzaDesc]) VALUES (1, N'Distanza')
GO
INSERT [dbo].[pf_parModoLezione] ([modoLezione], [modoLezioneDesc]) VALUES (0, N'Completa')
GO
INSERT [dbo].[pf_parModoLezione] ([modoLezione], [modoLezioneDesc]) VALUES (1, N'Presenza')
GO
INSERT [dbo].[pf_parModoLezione] ([modoLezione], [modoLezioneDesc]) VALUES (2, N'Distanza')
GO
