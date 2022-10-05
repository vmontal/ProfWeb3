select idRS, dataOfferta, idProfessore, nomeProf, nomeStud, materia, orario 
from pf_pianoOfferteVista 
where idStatusOfferta = 2 
group by idRS, dataOfferta, idProfessore, nomeProf, orario, idStudente, nomeStud, materia