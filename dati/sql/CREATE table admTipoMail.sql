USE [MSSqlProfWeb30]
GO

/****** Object:  Table [dbo].[admTipoAss]    Script Date: 02/07/2021 17:26:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[admTipoMail](
	[idTipoMail] [varchar](1) NOT NULL,
	[tipoMail] [varchar](50) NOT NULL,
 CONSTRAINT [PK_pf_admTipoMail] PRIMARY KEY CLUSTERED 
(
	[tipoMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


