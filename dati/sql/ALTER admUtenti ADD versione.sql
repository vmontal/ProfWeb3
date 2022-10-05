--aggiornare tabelle
--pf_anagrafeStudenti
--pf_anagrafeProfessori
--adm_Utenti

alter table pf_anagrafeProfessori add versione varchar(5) not null default '0.0'
alter table pf_anagrafeProfessori add dataVersione date not null default getdate()
select * from pf_anagrafeProfessori

--aggiornare Viste
--pf_anagrafeProfessoriVista
--pf_anagrafeStudentiVista
--admAuth
--pf_anagrafeGeneraleVista

--aggiornare sp
--pf_anagrafeGeneraleCheck

