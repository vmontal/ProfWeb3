select idSede, idStudente, nomeStud, 'data:' + CONVERT(VARCHAR(10), dataOfferta, 105) + ', prof:' + nomeProf + ', materia:' + materia + ', nota:' + notaOfferta AS nota
from pf_pianooffertevista 
where idstatusofferta = 3
order by idStudente, dataOfferta