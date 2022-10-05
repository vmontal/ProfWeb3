USE [MSSql171182]
GO
/****** Object:  Table [dbo].[admCassaCausali]    Script Date: 05/02/2020 17:27:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admCassaCausali](
	[idCausale] [int] IDENTITY(1,1) NOT NULL,
	[idCat] [int] NOT NULL,
	[idSottCat] [int] NOT NULL,
	[descCausale] [varchar](250) NOT NULL,
	[segno] [int] NOT NULL,
	[ruolo] [varchar](4) NOT NULL,
	[banca] [varchar](1) NOT NULL,
 CONSTRAINT [PK_admCassaCausali_1] PRIMARY KEY CLUSTERED 
(
	[segno] DESC,
	[idCat] ASC,
	[idSottCat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[admCassaDocumento]    Script Date: 05/02/2020 17:27:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admCassaDocumento](
	[idDoc] [int] IDENTITY(1,1) NOT NULL,
	[descDoc] [varchar](50) NOT NULL,
	[segno] [int] NOT NULL,
 CONSTRAINT [PK_admCassaDocumento] PRIMARY KEY CLUSTERED 
(
	[segno] ASC,
	[descDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admCassaCausali] ON 
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (45, 2, 0, N'CONTRIBUTI INGRESSO', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (1, 2, 1, N'CONTRIBUTI PER PROGETTI E/O ATTIVITA (art. 5 L. 266/91)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (72, 3, 0, N'CONTRIBUTI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (2, 3, 1, N'QUOTA ASSOCIATIVA ANNUALE DA SOCI ', 1, N'12', N'1')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (3, 3, 2, N'EROGAZIONI LIBERALI DA NON SOCI', 1, N'123', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (4, 3, 3, N'CONTRIBUTI DA CSV E COMITATO DI GESTIONE', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (5, 3, 4, N'CONTRIBUTI  DA ENTI PUBBLICI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (6, 3, 5, N'CONTRIBUTI DA COMUNITÀ EUROPEA E DA ALTRI ORGANISMI INTERNAZIONALI ', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (7, 3, 6, N'CONTRIBUTI DA ALTRE OdV', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (8, 3, 7, N'CONTRIBUTI DAL CINQUE PER MILLE', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (9, 3, 8, N'CONTRIBUTI ALTRO ', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (46, 4, 0, N'DONAZIONI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (10, 4, 1, N'DONAZIONI DA SOCI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (11, 4, 2, N'DONAZIONI DA NON SOCI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (47, 5, 0, N'RIMBORSI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (12, 5, 1, N'RIMBORSI DERIVANTI DA CONVENZIONI CON ENTI PUBBLICI - ART. 5 L.266/91', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (48, 6, 0, N'ENTRATE DA ATTIVITÀ', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (13, 6, 1, N'ENTRATE DA ATTIVITÀ DI VENDITE OCCASIONALI O INIZIATIVE OCCASIONALI DI SOLIDARIETÀ (D.M. 1995 LETT.A) ES.EVENTI, CASSETTINA OFFERTE, TOMBOLE, SPETTACOLI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (14, 6, 2, N'ENTRATE DA ATTIVITÀ DI VENDITA DI BENI ACQUISITI DA TERZI A TITOLO GRATUITO A FINI DI SOVVENZIONE  (D.M. 1995 LETT.B)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (15, 6, 3, N'ENTRATE DA ATTIVITÀ DI SOMMINISTRAZIONE DI ALIMENTI E BEVANDE IN OCCASIONE DI MANIFESTAZIONI E SIMILI A CARATTERE OCCASIONALE  (D.M. 1995 LETT.D)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (49, 7, 0, N'ENTRATE DA SERVIZI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (16, 7, 1, N'ENTRATE DA CESSIONE DI BENI PRODOTTI DAGLI ASSISTITI E DAI VOLONTARI SEMPRECHÉ LA VENDITA DEI PRODOTTI SIA CURATA DIRETTAMENTE DALL''ORGANIZZAZIONE SENZA ALCUN INTERMEDIARIO (D.M. 1995 LETT.C)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (17, 7, 2, N'ENTRATE DA ATTIVITÀ DI PRESTAZIONE DI SERVIZI RESE IN CONFORMITÀ ALLE FINALITÀ ISTITUZIONALI, NON RICONDUCIBILI NELL''AMBITO APPLICATIVO DELL''ART. 111, COMMA 3 (D.M. 1995 LETT. E)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (50, 8, 0, N'RENDITE', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (18, 8, 1, N'RENDITE PATRIMONIALI (FITTI,…)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (19, 8, 2, N'RENDITE FINANZIARIE (INTERESSI, DIVIDENDI)', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (20, 8, 3, N'ALTRO: SPECIFICARE ', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (51, 9, 0, N'ANTICIPAZIONI', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (21, 9, 1, N'ANTICIPAZIONI DI CASSA', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (52, 10, 0, N'PARTITE DI GIRO ENTRATE', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (22, 10, 1, N'PARTITE IN ENTRATE', 1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (73, 1, 0, N'RIMBORSI SPESE', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (23, 1, 1, N'RIMBORSI SPESE AI VOLONTARI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (53, 2, 0, N'ASSICURAZIONI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (24, 2, 1, N'ASSICURAZIONE VOLONTARI - ART. 4 L.266/90', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (25, 2, 2, N'ASSICURAZIONI ALTRE: ES. VEICOLI, IMMOBILI ...', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (54, 3, 0, N'PERSONALE', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (26, 3, 1, N'PERSONALE DIPENDENTI ', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (27, 3, 2, N'PERSONALE ATIPICI E OCCASIONALI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (28, 3, 3, N'CONSULENTI ', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (55, 4, 0, N'ACQUISTI DI SERVIZI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (29, 4, 1, N'ACQUISTI DI SERVIZI  (MANUTENZIONE, TRASPORTI, SERVICE, CONSULENZA FISCALE...)', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (30, 5, 0, N'UTENZE ', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (56, 5, 1, N'LUCE, ACQUA, GAS, TELEFONIA, ETC...', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (57, 6, 0, N'MATERIALE DI CONSUMO', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (31, 6, 1, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER STRUTTURA OdV', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (32, 6, 2, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER ATTIVITÀ', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (33, 6, 3, N'MATERIALE DI CONSUMO (CANCELLERIA, POSTALI ...) PER SOGGETTI SVANTAGGIATI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (58, 7, 0, N'GODIMENTO BENI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (34, 7, 1, N'GODIMENTO BENI DI TERZI (AFFITTI, NOLEGGIO ATTREZZATURE, DIRITTI SIAE,....)', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (59, 8, 0, N'ONERI FINANZIARI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (35, 8, 1, N'ONERI FINANZIARI E PATRIMONIALI (INTERESSI PASSIVI SU MUTUI, PRESTITI, C/C BANCARIO…)', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (60, 9, 0, N'BENI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (36, 9, 1, N'BENI DUREVOLI ', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (62, 10, 0, N'IMPOSTE', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (37, 10, 1, N'IMPOSTE E TASSE', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (63, 11, 0, N'FUNDRAISING', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (38, 11, 1, N'RACCOLTE FONDI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (66, 12, 0, N'CONTRIBUTI VERSO TERZI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (39, 12, 1, N'CONTRIBUTI A SOGGETTI SVANTAGGIATI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (40, 12, 2, N'QUOTE ASSOCIATIVE A FEDERAZIONE OdV - MILANO', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (41, 12, 3, N'VERSATE AD ALTRE OdV', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (42, 12, 4, N'ORGANIZZAZIONE EVENTI', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (43, 12, 5, N'ALTRO', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (69, 13, 0, N'PARTITE DI GIRO USCITE', -1, N'12', N'0')
GO
INSERT [dbo].[admCassaCausali] ([idCausale], [idCat], [idSottCat], [descCausale], [segno], [ruolo], [banca]) VALUES (44, 13, 1, N'PARTITE IN USCITE', -1, N'12', N'0')
GO
SET IDENTITY_INSERT [dbo].[admCassaCausali] OFF
GO
SET IDENTITY_INSERT [dbo].[admCassaDocumento] ON 
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (3, N'Fattura', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (2, N'Ricevuta Fiscale', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (1, N'Scontrino Fiscale', -1)
GO
INSERT [dbo].[admCassaDocumento] ([idDoc], [descDoc], [segno]) VALUES (5, N'Ricevuta', 1)
GO
SET IDENTITY_INSERT [dbo].[admCassaDocumento] OFF
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_idCat]  DEFAULT ((0)) FOR [idCat]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_idSottCat]  DEFAULT ((0)) FOR [idSottCat]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_causale]  DEFAULT ('descrizione causale') FOR [descCausale]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_segno]  DEFAULT ((0)) FOR [segno]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_ruolo]  DEFAULT ((0)) FOR [ruolo]
GO
ALTER TABLE [dbo].[admCassaCausali] ADD  CONSTRAINT [DF_admCassaCausali_banca]  DEFAULT ((0)) FOR [banca]
GO
ALTER TABLE [dbo].[admCassaDocumento] ADD  CONSTRAINT [DF_admCassaDocumento_segno]  DEFAULT ((0)) FOR [segno]
GO
