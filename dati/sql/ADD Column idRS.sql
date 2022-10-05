--ALTER TABLE admAssemblee ADD idRS int NOT NULL DEFAULT (0)
--ALTER TABLE admCassaMovimenti ADD idRS int NOT NULL DEFAULT (0)
--ALTER TABLE pf_anagrafeIstituti ADD idRS int NOT NULL DEFAULT(0)
--ALTER TABLE pf_anagrafeProfessori ADD idRS int NOT NULL DEFAULT(0)
--ALTER TABLE pf_anagrafeStudenti ADD idRS int NOT NULL DEFAULT(0)

--ALTER view admAssembleeVista
--ALTER view admCassaMovimentiVista -- admBilancioVista admBilancioVistaRollup
--ALTER view pf_anagrafeProfessoriVista -- pf_anagrafeStudentiVista -- pf_admAuth
--ALTER view pf_pianoLezioniOrariVista pf_pianoLezioniVista
--ALTER view pf_pianoOffertePrenotateVista pf_pianoOfferteVista
--ALTER view pf_anagrafeSociVista
--ALTER view pf_parSediVista

--ALTER view pf_reportDocentiVista pf_reportMaterieVista pf_reportStudentiVista

--ALTER sp admAssembleeRead admAssembleeUpdate
--ALTER sp admBilancioRead 
--ALTER sp admCassaMovimentiRead admCassaMovimentiUpdate
--ALTER sp admLogin admPasswordReset admPasswordUpdate admResetUtente admUtentiRead admUtentiUpdate
--ALTER sp admVerificaMail admVersione

--ALTER sp pf_anagrafeGeneraleCheck pf_anagrafeGeneraleRead
--ALTER sp pf_anagrafeIstitutiCreate pf_anagrafeIstitutiRead pf_anagrafeIstitutiUpdate
--ALTER sp pf_anagrafeProfessoriMaterieRead pf_anagrafeProfessoriRead
--ALTER sp pf_anagrafeSociRead
--ALTER sp pf_anagrafeStudentiAuguri pf_anagrafeStudentiRead pf_anagrafeStudentiUpdate
--ALTER sp pf_anagrafeProfessoriRead pf_anagrafeProfessoriUpdate
--ALTER sp pf_parSediRead pf_parSediUpdate

--ALTER sp pf_pianoLezioniUpdate
--ALTER sp pf_pianoOfferteOggiRead pf_pianoOffertePrenotateReadApp pf_pianoOfferteUpdate

--ALTER sp pf_reportRichiesteDocenti pf_reportRichiesteMaterie pf_reportRichiesteStudenti

