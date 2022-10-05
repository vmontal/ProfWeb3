USE [MSSql171182]
GO

/****** Object:  Table [dbo].[admCassaMovimenti]    Script Date: 05/02/2020 17:29:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[admCassaMovimenti](
	[idMov] [int] IDENTITY(1,1) NOT NULL,
	[idProg] [varchar](10) NOT NULL,
	[idCausale] [int] NOT NULL,
	[idDoc] [int] NOT NULL,
	[idTipoCassa] [int] NOT NULL,
	[dataMov] [date] NOT NULL,
	[importoMov] [float] NOT NULL,
	[soggettoMov] [varchar](200) NOT NULL,
	[codiceFiscaleMov] [varchar](16) NULL,
	[deletedMov] [bit] NOT NULL,
	[notaMov] [varchar](300) NULL,
	[idUtente] [int] NOT NULL,
	[timeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_admBilancio] PRIMARY KEY CLUSTERED 
(
	[idMov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_idRicevuta]  DEFAULT ((0)) FOR [idProg]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_idCausale]  DEFAULT ((0)) FOR [idCausale]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_idTipoCassa]  DEFAULT ((1)) FOR [idTipoCassa]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_Table_1_data]  DEFAULT (getdate()) FOR [dataMov]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_importoOfferta]  DEFAULT ((0)) FOR [importoMov]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_soggettoMov]  DEFAULT ('soggetto') FOR [soggettoMov]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_deleted]  DEFAULT ((0)) FOR [deletedMov]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admBilancio_idUtente]  DEFAULT ((0)) FOR [idUtente]
GO

ALTER TABLE [dbo].[admCassaMovimenti] ADD  CONSTRAINT [DF_admCassaMovimenti_timeStampa]  DEFAULT (getdate()) FOR [timeStamp]
GO


