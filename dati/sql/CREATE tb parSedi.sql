USE [MSSql171182]
GO

/****** Object:  Table [dbo].[pf_parSedi]    Script Date: 02/02/2019 09:43:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pf_parSedi](
	[idSede] [int] IDENTITY(1,1) NOT NULL,
	[descrizioneSede] [varchar](200) NOT NULL,
	[indirizzoSede] [varchar](250) NOT NULL,
	[luogoSede] [varchar](200) NOT NULL,
	[capSede] [varchar](5) NOT NULL,
	[provSede] [varchar](2) NOT NULL,
 CONSTRAINT [PK_pf_parSedi] PRIMARY KEY CLUSTERED 
(
	[descrizioneSede] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


