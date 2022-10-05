SELECT pf_pianoLezioniOrariVista.*, CASE WHEN offerte.Prenotate IS NULL THEN 0 ELSE offerte.Prenotate END AS Prenotate FROM pf_pianoLezioniOrariVista
LEFT OUTER JOIN (SELECT idSede, idProfessore, idMateria, idOrario, COUNT(*) AS Prenotate FROM pf_pianoOffertePrenotateVista GROUP BY idSede, idProfessore, idMateria, idOrario) offerte
ON pf_pianoLezioniOrariVista.idSede = offerte.idSede AND 
   pf_pianoLezioniOrariVista.idProfessoreLez = offerte.idProfessore AND 
   pf_pianoLezioniOrariVista.idMateriaLez = offerte.idMateria AND
   pf_pianoLezioniOrariVista.idOrario = offerte.idOrario