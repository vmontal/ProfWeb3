//------------------------------Begin ctrl-controllo controller--------------------------------------------//
'use strict';

(function () {

    var controllo = angular.module("controllo", []);

    controllo.controller("ctrl-controllo", function ($scope, $http, dataUser, Auth, mask) {

        const largo = $(window).width();
        var alto = $(window).height();
        var dataInizio;
        var dataFinale;
        var presidente;
        var header;
        var parametriPDF = new Object();

        var mobile = largo < 768 ? true : false;

        if (Auth.userLogged && Auth.ruoloAdmin && !mobile) {
            $("#schedaControllo").show();

            $http.get("/dati/json/parametri.json?ver=" + versione)
                .then(function (response) {
                    $scope.as = response.data.as;
                    dataInizio = response.data.dataInizio;
                    dataFinale = response.data.dataFinale;
                });

            //$http.get("/dati/json/ricevuta.json?ver=" + parseInt(Math.random() * 100000))
            //    .then((response) => {
            //        header = response.data.header;
            //    });

            var larghezza = parseInt($("#hControllo").width() * 1);

            $scope.framePDF = false;
            $scope.showMenu = false;
            $scope.pivot = false;

            $scope.luogo = Auth.luogo;
            $scope.db = Auth.db;
            $scope.idRS = dataUser.idRS;
            $scope.path = dataUser.path;
            $scope.versione = adesso();

            $scope.annullaScheda = function () {
                $scope.cambia = false;
                $scope.framePDF = false;
                window.location.href = "#/main";
            };

            const imgKO = "ack-KO.png";
            const imgOK = "ack-OK.png";

            var parReportStudenti, parReportProfessori, parReportMaterie;
            var parReportStudentiPivot, parReportProfessoriPivot, parReportMateriePivot;
            var parReportRegistroStudenti;
            var parStatistaMaterie, parStatistaIstituto, parStatistaOrigine, parStatistaSpecial, parStatistaTipoProf, parStatisticaTipoLezione;
            var parAnagrafeProfessori, parAnagrafeVolontari, parAnagrafeStudenti;
            var parSedi, parSoci;
            var parBilancio;

            parSedi = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS},
                tabella: "elencoSedi",
                spRead: "pf_parSediRead",
            };

            parSoci = {
                idKey: "ID",
                campoID: { ID: 3, idRS: dataUser.idRS },
                tabella: "presidente",
                spRead: "pf_anagrafeSociRead"
            };

            parBilancio = {
                idKey: "Anno",
                campoID: { Anno: 2020, idRS: dataUser.idRS },
                tabella: "Bilancio",
                spRead: "admBilancioRead",
                elencoCampi: ["Anno"],
                campiTabella: [
                    { title: "Anno", field: "Anno", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                    { title: "Causale", field: "Causale", width: parseInt(larghezza * 0.40), sorter: "string", align: "left", headerFilter: true },
                    { title: "Banca", field: "Banca", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
                    { title: "Cassa", field: "Cassa", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
                ],
                campiStampa: [
                    ["Causale", "Banca", "Cassa", "Totale"],
                    ["Causale", "Banca", "Cassa", "Totale"],
                    ["*", 80, 80, 80],
                    ["string", "money", "money", "money"]
                ],
                marginiStampa: [20, 20],
                posizStampa: "landscape",
                titleStampa: "Rendiconto finanziario anno: ",
                rollup: true
            };

            parReportRegistroStudenti = {
                idKey: "idStudente",
                campoID: { idStudente: 0, idSede: 0, idRS: dataUser.idRS },
                tabella: "Studenti",            
                spRead: "pf_reportStudentiRegistro",
                elencoCampi: ["idStudente", "dataOfferta", "materia", "nomeProf", "notaOfferta", "argomentoOfferta"],
                campiTabella: [
                    { title: "", field: "idStudente", width: parseInt(larghezza * 0), sorter: "number", align: "center", headerFilter: false, responsive: 0, visible: false },
                    { title: "Data", field: "dataOfferta", width: parseInt(larghezza * 0.10), sorter: "date", align: "center", headerFilter: false, responsive: 1 },
                    { title: "Materia", field: "materia",  width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Docente", field: "nomeProf", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Argomento", field: "argomentoOfferta", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Nota", field: "notaOfferta", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                ],
            };

            parReportStudentiPivot = {
                idKey: "idStudente",
                campoID: { idStudente: 0, idSede: 0, idRS: dataUser.idRS},
                tabella: "Studenti",
                spRead: "pf_reportSLD",
                elencoCampi: ["idStudente", "materia", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                campiTabella: [
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Ott", field: "ott", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Nov", field: "nov", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Dic", field: "dic", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Gen", field: "gen", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Feb", field: "feb", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mar", field: "mar", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Apr", field: "apr", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mag", field: "mag", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Giu", field: "giu", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Lug", field: "lug", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                ],
                campiStampa: [
                    ["materia", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                    ["Materia", "Ott", "Nov", "Dic", "Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug"],
                    ["*", 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
                ],
                marginiStampa: [20, 20],
                posizStampa: "landscape",
                titleStampa: "Dettaglio Lezioni Erogate per Studente(ssa): "
            };

            parReportStudenti = {
                idKey: "idStudente",
                campoID: { idStudente: 0, idSede: 0, idRS: dataUser.idRS },
                tabella: "Studenti",
                spRead: "pf_reportRichiesteStudenti",
                elencoCampi: ["idStudente", "nomeStud", "prenotata", "erogata", "disdettaStud", "assente"],
                campiTabella: [
                    { title: "Studente", field: "nomeStud", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Prenotate", field: "prenotata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Erogate", field: "erogata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Disdette", field: "disdettaStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Assente", field: "assente", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "In Attesa", field: "attesa", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campiStampa: [
                    ["nomeStud", "prenotata", "erogata", "disdettaStud", "assente", "attesa"],
                    ["Studente", "Prenotate", "Erogate", "Disdette", "Assenti", "In Attesa"],
                    ["*", 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "portrait",
                titleStampa: "Report Studenti",
                campoTotale: "nomeStud",
                oggetto: " ",
                scheda: "repoStud",
                pivot: [parReportStudentiPivot]
            };

            parReportProfessoriPivot = {
                idKey: "idProfessore",
                campoID: { idProfessore: 0, idSede: 0, idRS: dataUser.idRS },
                tabella: "Professori",
                spRead: "pf_reportSDD",
                elencoCampi: ["idProfessore", "nomeStud", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                campiTabella: [
                    { title: "Studente", field: "nomeStud", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Ott", field: "ott", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Nov", field: "nov", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Dic", field: "dic", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Gen", field: "gen", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Feb", field: "feb", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mar", field: "mar", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Apr", field: "apr", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mag", field: "mag", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Giu", field: "giu", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Lug", field: "lug", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                ],
                campiStampa: [
                    ["nomeStud", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                    ["Studente", "Ott", "Nov", "Dic", "Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug"],
                    ["*", 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
                ],
                marginiStampa: [20, 20],
                posizStampa: "landscape",
                titleStampa: "Dettaglio Lezioni Erogate dal Docente: ",
            };

            parReportProfessori = {
                idKey: "idProfessore",
                campoID: { idProfessore: 0, idSede: 0, idRS: dataUser.idRS},
                tabella: "Professori",
                spRead: "pf_reportRichiesteDocenti",
                elencoCampi: ["idProfessore", "nomeProf", "disponibile", "prenotata", "erogata", "disdettaStud", "disdettaProf", "inevase"],
                campiTabella: [
                    { title: "Docente", field: "nomeProf", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Disponibili", field: "disponibile", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Prenotate", field: "prenotata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Erogate", field: "erogata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Disdette Studente", field: "disdettaStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Disdette Docente", field: "disdettaProf", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Inevase", field: "inevasa", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campiStampa: [
                    ["nomeProf", "disponibile", "prenotata", "erogata", "disdettaStud", "disdettaProf", "inevasa"],
                    ["Docente", "Disponibili", "Prenotate", "Erogate", "Disdette Studente", "Disdette Docente", "Inevase"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                titleStampa: "Report Docenti",
                campoTotale: "nomeProf",
                oggetto: " ",
                scheda: "repoProf",
                pivot: [parReportProfessoriPivot]
            };

            parReportMateriePivot = {
                idKey: "idMateria",
                campoID: { idMateria: 0, idSede: 0, idRS: dataUser.idRS },
                tabella: "Materie",
                spRead: "pf_reportSMD",
                elencoCampi: ["idMateria", "nomeStud", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                campiTabella: [
                    { title: "Studente", field: "nomeStud", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Ott", field: "ott", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Nov", field: "nov", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Dic", field: "dic", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Gen", field: "gen", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Feb", field: "feb", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mar", field: "mar", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Apr", field: "apr", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Mag", field: "mag", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Giu", field: "giu", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                    { title: "Lug", field: "lug", width: parseInt(larghezza * 0.06), align: "center", bottomCalc: "sum", headerFilter: false, headerSort: false, responsive: 1 },
                ],
                campiStampa: [
                    ["nomeStud", "ott", "nov", "dic", "gen", "feb", "mar", "apr", "mag", "giu", "lug"],
                    ["Studente", "Ott", "Nov", "Dic", "Gen", "Feb", "Mar", "Apr", "Mag", "Giu", "Lug"],
                    ["*", 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
                ],
                marginiStampa: [20, 20],
                posizStampa: "landscape",
                titleStampa: "Dettaglio Lezioni Erogate per la Materia: ",
            };

            parReportMaterie = {
                idKey: "idMateria",
                campoID: { idMateria: 0, idSede: 0, idRS: dataUser.idRS },
                tabella: "Materie",
                spRead: "pf_reportRichiesteMaterie",
                elencoCampi: ["idMateria", "materia", "disponibile", "prenotata", "erogata", "disdettaStud", "disdettaProf", "inevasa"],
                campiTabella: [
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Disponibili", field: "disponibile", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Prenotate", field: "prenotata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Erogate", field: "erogata", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Disdette Studente", field: "disdettaStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Disdette Docente", field: "disdettaProf", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Inevase", field: "inevasa", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["materia", "disponibile", "prenotata", "erogata", "disdettaStud", "disdettaProf", "inevasa"],
                    ["Materia", "Disponibili", "Prenotate", "Erogate", "Disdette Studente", "Disdette Docente", "Inevase"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Report Materie",
                scheda: "repoMateria",
                pivot: [parReportMateriePivot]
            };

            parStatistaMaterie = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "StatMaterie",
                spRead: "pf_statMaterieAnno",
                elencoCampi: ["idSede", "idMateria", "materia", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                campiTabella: [
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum",  headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["materia", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Materia", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica lezioni erogate per materia di studio",
                scheda: "statMateria"
            };

            parStatistaIstituto = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "StatIstituti",
                spRead: "pf_statIstitutoAnno",
                elencoCampi: ["Sede", "istitutoTipo", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                campiTabella: [
                    { title: "Istuto", field: "istitutoTipo", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "istitutoTipo",
                campiStampa: [
                    ["istitutoTipo", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Tipo di Indirizzo", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica lezioni erogate per tipologia di Istituto",
                scheda: "statIstituti"
            };

            parStatistaOrigine = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS  },
                tabella: "StatOrigine",
                spRead: "pf_statOrigineStudentiAnno_Erogate",
                elencoCampi: ["idOrigineStud", "origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                campiTabella: [
                    { title: "Nazionalità", field: "origineStud", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "origineStud",
                campiStampa: [
                    ["origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Nazionalità", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica lezioni erogate per nazionalità studenti",
                scheda: "statOrigine"
            };

            parStatistaSpecial = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "StatSpecial",
                spRead: "pf_statSpecialStudentiAnno_Erogate",
                elencoCampi: ["idSpecial", "special", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                campiTabella: [
                    { title: "Esigenza", field: "special", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "special",
                campiStampa: [
                    ["special", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Esigenza", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica lezioni erogare per Esigenze studenti",
                scheda: "statSpecial"
            };

            parStatistaTipoProf = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "StatTipoProf",
                spRead: "pf_statTipoProfMaterie",
                elencoCampi: ["idMateria", "materia", "Altro", "Attivo", "Pensione", "Studente", "Totale"],
                campiTabella: [
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "In Attività", field: "Attivo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "In Pensione", field: "Pensione", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Studente", field: "Studente", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Altro", field: "Altro", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["materia", "Attivo", "Pensione", "Studente", "Altro", "Totale"],
                    ["Materia", "In Attività", "In Pensione", "Studente", "Altro", "Totale"],
                    ["*", 80, 80, 80, 80, 80],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica materie erogate per tipo docenti",
                scheda: "statTipoProf"
            };

            parStatisticaTipoLezione = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "StatTipoLezioni",
                spRead: "pf_statTipoLezioneAnno",
                elencoCampi: ["idRS", "Tipo", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                campiTabella: [
                    { title: "Tipo Lezione", field: "Tipo", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "Tipo",
                campiStampa: [
                    ["Tipo", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Tipo Lezione", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Statistica lezioni erogate per tipo Didattica",
                scheda: "StatTipoLezioni"
            };

            parAnagrafeProfessori = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "AnagrafeProf",
                spRead: "pf_reportAnagrafeProf",
                elencoCampi: ["idProfessore", "nomeProf", "luogoNascitaProf", "dataNascitaProf", "indirizzoCompletoProf", "codiceFiscaleProf", "emailProf", "tel1Prof", "dataCreate"],
                campiTabella: [
                    { title: "Nominativo", field: "nomeProf", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Luogo di Nascita", field: "luogoNascitaProf", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Nato(a) il", field: "dataNascitaProf", width: parseInt(larghezza * 0.07), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                    { title: "Indirizzo", field: "indirizzoCompletoProf", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Codice Fiscale", field: "codiceFiscaleProf", width: parseInt(larghezza * 0.12), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                    { title: "Email", field: "emailProf", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Telefono", field: "tel1Prof", width: parseInt(larghezza * 0.08), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Iscrizione", field: "dataCreate", width: parseInt(larghezza * 0.07), sorter: "string", align: "center", headerFilter: true, responsive: 1 }
                ],
                campiStampa: [
                    ["nomeProf", "luogoNascitaProf", "dataNascitaProf", "indirizzoCompletoProf", "codiceFiscaleProf", "emailProf", "tel1Prof", "dataCreate"],
                    ["Docente", "Luogo di Nascita", "Nato(a) il", "Indirizzo", "Codice Fiscale", "Email", "Telefono", "Iscrizione"],
                    //["*", 130, 70, 180, 130, 70],
                    ["*", 80, 60, 100, 90, 110, 60, 60],
                ],
                marginiStampa: [10, 10],
                posizStampa: "landscape",
                titleStampa: "Anagrafe Docenti",
                //totali: false,
                //campoTotale: "nomeProf",
                oggetto: " ",
                scheda: "AnagrafeProf",
                font: true
            };

            parAnagrafeVolontari = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "AnagrafeUser",
                spRead: "pf_reportAnagrafeUser",
                elencoCampi: ["idUser", "nomeUser", "luogoNascitaUser", "dataNascitaUser", "indirizzoCompletoUser", "codiceFiscaleUser", "emailUser", "tel1User", "dataCreate"],
                campiTabella: [
                    { title: "Nominativo", field: "nomeUser", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Luogo di Nascita", field: "luogoNascitaUser", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Nato(a) il", field: "dataNascitaUser", width: parseInt(larghezza * 0.07), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Indirizzo", field: "indirizzoCompletoUser", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Codice Fiscale", field: "codiceFiscaleUser", width: parseInt(larghezza * 0.12), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Email", field: "emailUser", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Telefono", field: "tel1User", width: parseInt(larghezza * 0.08), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Iscrizione", field: "dataCreate", width: parseInt(larghezza * 0.07), sorter: "string", align: "center", headerFilter: true, responsive: 1 }
                ],
                campiStampa: [
                    ["nomeUser", "luogoNascitaUser", "dataNascitaUser", "indirizzoCompletoUser", "codiceFiscaleUser", "emailUser", "tel1User", "dataCreate"],
                    ["Nominativo", "Luogo di Nascita", "Nato(a) il", "Indirizzo", "Codice Fiscale","Email", "Telefono", "Iscrizione"],
                    ["*", 80, 60, 100, 90, 110, 60, 60],
                ],
                marginiStampa: [10, 10],
                posizStampa: "landscape",
                titleStampa: "Anagrafe Personale di Segreteria",
                //totali: false,
                //campoTotale: "nomeProf",
                oggetto: " ",
                scheda: "AnagrafeUser",
                font: true
            };

            parAnagrafeStudenti = {
                idKey: "idSede",
                campoID: { idSede: 0, idRS: dataUser.idRS },
                tabella: "AnagrafeStud",
                spRead: "pf_reportAnagrafeStud",
                elencoCampi: ["idStudente", "nomeStud", "luogoNascitaStud", "dataNascitaStud", "indirizzoCompletoStud", "codiceFiscaleStud", "emailStud", "tel1Stud", "dataCreate"],
                campiTabella: [
                    { title: "Nominativo", field: "nomeStud", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", bottomCalc: "count", headerFilter: true, responsive: 0 },
                    { title: "Luogo di Nascita", field: "luogoNascitaStud", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Nato(a) il", field: "dataNascitaStud", width: parseInt(larghezza * 0.07), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Indirizzo", field: "indirizzoCompletoStud", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Codice Fiscale", field: "codiceFiscaleStud", width: parseInt(larghezza * 0.12), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Email", field: "emailStud", width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Telefono", field: "tel1Stud", width: parseInt(larghezza * 0.08), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Iscrizione", field: "dataCreate", width: parseInt(larghezza * 0.07), sorter: "string", align: "center", headerFilter: true, responsive: 1 }
                ],
                campiStampa: [
                    ["nomeStud", "luogoNascitaStud", "dataNascitaStud", "indirizzoCompletoStud", "codiceFiscaleStud", "emailStud", "tel1Stud", "dataCreate"],
                    ["Nominativo", "Luogo di Nascita", "Nato(a) il", "Indirizzo", "Codice Fiscale", "Email", "Telefono", "Iscrizione"],
                    ["*", 80, 60, 100, 90, 110, 60, 60],
                ],
                marginiStampa: [10, 10],
                posizStampa: "landscape",
                titleStampa: "Anagrafe Studenti",
                //totali: false,
                //campoTotale: "nomeProf",
                oggetto: " ",
                scheda: "AnagrafeStud",
                font: true
            };

            $(".tempo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: "1D"
            });

            $(".tempo").datepicker($.datepicker.regional["it"]);

            var idKey = 0;
            var parametri;

            $scope.repo = (setTab) => {
                if (setTab) {
                    parametri = undefined;
                    $scope.tabMenu = setTab;
                    $scope.cambia = false;
                    $scope.pivot = false;
                    $scope.registro = false;
                    $scope.dettaglio = "";
                    $scope.framePDF = false;
                    idKey = 0;

                    switch (setTab) {
                        case "S":
                            parametri = parReportStudenti;
                            break;

                        case "P":
                            parametri = parReportProfessori;
                            break;

                        case "B":
                            parametri = parBilancio;
                            break;

                        case "M":
                            parametri = parReportMaterie;
                            break;

                        case "RM":
                            parametri = parStatistaMaterie;
                            break;

                        case "RI":
                            parametri = parStatistaIstituto;
                            break;

                        case "RO":
                            parametri = parStatistaOrigine;
                            break;

                        case "RS":
                            parametri = parStatistaSpecial;
                            break;

                        case "RT":
                            parametri = parStatistaTipoProf;
                            break;

                        case "RL":
                            parametri = parStatisticaTipoLezione;
                            break;

                        case "AD":
                            parametri = parAnagrafeProfessori;
                            break;

                        case "AV":
                            parametri = parAnagrafeVolontari;
                            break;

                        case "AS":
                            parametri = parAnagrafeStudenti;
                            break;
                    };

                    console.log(parametri);
                    let id = parametri.idKey;
                    parametri.campoID[id] = parametri.rollup ? parametri.campoID[id] : 0;
                    parametri.campoID["idSede"] = $scope.idSede;
                    $scope[parametri.scheda] = true;
                    $scope.showMenu = true;
                    $scope.dettaglio = parametri.titleStampa;

                    let modal = "report";
                    let tableName = modal + parametri.tabella;

                    if ($("#" + tableName).hasClass("tabulator")) {
                        getReport(parametri, modal)
                    } else {
                        tabella(larghezza, modal, parametri, getReport(parametri, modal));
                    };
                };
            };

            $scope.isSelected = (checkTab) =>  {
                return $scope.tabMenu === checkTab;
            };

            $scope.showTable = () =>  {
                if (!parametri || !parametri.scheda) {
                    return false;
                } else {
                    return !$scope[parametri.scheda];
                };
            };

            getDropElenco(parSoci, 0, Auth.db, (dropElenco) => {
                presidente = dropElenco.nominativo;
            });

            const getData = (parametri, callback) => {
                let ricerca = {};
                ricerca.spRead = parametri.spRead;
                ricerca.tabella = parametri.tabella;
                //ricerca.idSede = 0;
                $.extend(ricerca, parametri.campoID);
                ricerca.drop = 3;

                let criterio = {
                    data: JSON.stringify(ricerca),
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/getData",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: getData_success(callback),
                    error: errorDialog
                });
            };

            const getData_success = (callback) => {
                return (response) => {
                    $scope.elencoSedi = (xml2json(response.d).NewDataSet.elencoSedi);
                    if (callback && typeof callback == "function"){
                        callback();
                    };
                    //console.log($scope.elencoSedi);
                };
            };

            getData(parSedi, () => {
                $scope.idSede = "0";
                $scope.$apply();
            });

            const getReport = (parametri, modal, callback) => {
                let ricerca = {};
                ricerca.spRead = parametri.spRead;
                ricerca.tabella = parametri.tabella;
                $.extend(ricerca, parametri.campoID);
                if (modal === "pivot") {

                    ricerca.dataInizio = dataInizio;
                    ricerca.dataFinale = dataFinale;
                };
                let criterio = {
                    data: JSON.stringify(ricerca),
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/getData",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: getReport_success(parametri, modal, callback),
                    error: errorDialog
                });
            };

            const getReport_success = (parametri, modal, callback) => {
                return (response) => {
                    let myData = new Object();
                    let jsonData = JSON.stringify(xml2json(response.d));
                    let nrc = jsonData.slice(-3);
                    let pqa = (nrc == "]}}" ? "" : "[");
                    let pqc = (nrc == "]}}" ? "" : "]");

                    let idKey = parametri.idKey;
                    let id = parametri.campoID[idKey];
                    let archivio = parametri.tabella;
                    let tableName = modal + archivio;
                    let elencoCampi = parametri.elencoCampi;

                    console.log(tableName);
                    myData = xml2json(response.d).NewDataSet[archivio];
                    //console.log(myData);
                    if (myData){
                        parametriPDF = new Object();
                        parametriPDF.myData = pqa === "[" ? JSON.parse(pqa + JSON.stringify(myData) + pqc) : myData;
                        parametriPDF.parametri = parametri;
                        //console.log(myData, myData.length);
                        if (jsonData.length > 100) {
                            let jsonOutput = pqa + JSON.stringify(myData) + pqc;
                            
                            $("#" + tableName).tabulator("setData", jsonOutput);
                            //$("#" + tableName).tabulator("redraw");
                        };
                    } else {
                        parametriPDF = new Object();
                        $scope.framePDF = false;
                        $("#" + tableName).tabulator("clearData");                        
                    };

                    if (callback && typeof callback === "function") {
                        callback();
                    };

                };

            };

            $scope.reportRegistro = () => {
                const modal = "registro";
                $scope.registro = true;
                const tableName = modal + parametri.tabella;

                let parametriRegistro = parReportRegistroStudenti;
                let id = parametriRegistro.idKey;
                parametriRegistro.campoID[id] = idKey;

                if ($("#" + tableName).hasClass("tabulator")) {
                    getReport(parametriRegistro, modal);
                } else {
                    tabella(larghezza, modal, parametriRegistro, getReport(parametriRegistro, modal));
                };
            };

            //------------------------------Begin Gestione Tabella--------------------------------------------- ---//

            $scope.reportTotali = function () {
                var tabDownload = parametri.tabella;                
                $("#report" + tabDownload).tabulator("download", "xlsx", "report" + tabDownload + ".xlsx");
            };

            $scope.reportPivot = function () {
                var tabDownload = parametri.tabella;
                $("#pivot" + tabDownload).tabulator("download", "xlsx", $scope.dettaglio +  ".xlsx");
            };

            $scope.reportPDF = function () {
                const rollup = parametri.rollup;
                if (parametriPDF.myData && !rollup) {
                    creaReport();
                } else if (parametriPDF.myData && rollup) {
                    creaBilancio();
                };
            };

            $("#btn_download").click(function () {
                var tabDownload = "elenco" + parametri.tabella;
                $("#report" + tabDownload).tabulator("download", "csv", "report" + tabDownload + ".csv", { delimiter: "|" });
            });

            const styleEntrate = new styleCell("green");
            const styleUscite = new styleCell("red");
            const styleEntrateTot = new styleCell("green", "green", "bold")
            const styleUsciteTot = new styleCell("red", "red", "bold")

            const tabella = (larghezza, modal, parametri, callback) => {
                let tableName = modal + parametri.tabella;
                let elencoCampi = parametri.elencoCampi;
                let campiTabella = parametri.campiTabella;
                let scheda = parametri.scheda;
                let campoTotale = parametri.campoTotale;
                let gruppo = !parametri.campoGruppo ? "" : parametri.campoGruppo;
                let rowHigh = !parametri.rowHigh ? "auto" : parametri.rowHigh;

                $("#" + tableName).tabulator({
                    height: "400px",
                    responsiveLayout: true,
                    resizableColumns: false,
                    sortable: false,
                    colVertAlign: "center",
                    selectable: 0,

                    columns: campiTabella,
                    index: elencoCampi[0],

                    groupBy: gruppo,
                    groupToggleElement: "header",
                    groupStartOpen: false,

                    rowClick: function (e, row) {                        
                        let data = row.getData();
                        idKey = data[elencoCampi[0]];
                        if (parametri.pivot && idKey) {
                            $scope.pivot = true;
                            $scope.dettaglio = "Report " + parametri.tabella + ": " + data[campoTotale];

                            let modal = "pivot";
                            let parametriPivot = parametri.pivot[0];                            
                            let id = parametriPivot.idKey;
                            parametriPivot.campoID[id] = idKey;
                            parametriPivot.oggetto = data[campoTotale];
                            let tableName = modal + parametriPivot.tabella;
                            $scope.$apply();

                            if ($("#" + tableName).hasClass("tabulator")) {
                                getReport(parametriPivot, modal);
                            } else {
                                tabella(larghezza, modal, parametriPivot, getReport(parametriPivot, modal));
                            };
                        };
                    },

                    rowFormatter: function (row) {
                        if (parametri.rollup) {
                            var data = row.getData();
                            if (data["Totale"] > 0) {
                                if (data["Causale"].indexOf("SUBTO") > -1) {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleEntrateTot.backColor,
                                        color: styleEntrateTot.color,
                                        fontWeight: styleEntrateTot.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                } else if (data["Causale"].indexOf("TOTALE") > -1) {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleEntrateTot.backColor,
                                        color: styleEntrateTot.color,
                                        fontWeight: styleEntrateTot.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                } else {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleEntrate.backColor,
                                        color: styleEntrate.color,
                                        fontWeight: styleEntrate.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                };
                            } else {
                                if (data["Causale"].indexOf("SUBTO") > -1) {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleUsciteTot.backColor,
                                        color: styleUsciteTot.color,
                                        fontWeight: styleUsciteTot.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                } else if (data["Causale"].indexOf("TOTALE") > -1) {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleUsciteTot.backColor,
                                        color: styleUsciteTot.color,
                                        fontWeight: styleUsciteTot.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                } else {
                                    row.getElement().css({
                                        height: rowHigh,
                                        backgroundColor: styleUscite.backColor,
                                        color: styleUscite.color,
                                        fontWeight: styleUscite.fontWeight,
                                        border: "1px solid",
                                        borderColor: "lightgray"
                                    });
                                };
                            };
                            if (data["Causale"].indexOf("GENERALE") > -1) {
                                row.getElement().css({
                                    height: rowHigh,
                                    backgroundColor: "black",
                                    color: "red",
                                    fontWeight: "bold",
                                    fontSize: "40px",
                                    //border: "1px solid",
                                    borderColor: "yellow"
                                });
                            }
                        };
                    },
                });

                if (callback && typeof callback === "function") {
                    callback();
                };
                    
            };

            //-----------------------------End Gestione Tabella----------------------------------------------//

            const creaReport = function () {
                $scope.framePDF = false;
                let dataReport = parametriPDF.myData;
                let parametri = parametriPDF.parametri;

                var datiScheda = new Array();
                var elencoCampi = parametri.campiStampa[0];
                var elencoLabel = parametri.campiStampa[1];

                var row = new Array();
                var headerLabel = new Object();

                elencoLabel.forEach((label, item) => {
                    headerLabel = JSON.parse('{"text": "' + label + '", "style": "tableHeader"}');
                    row.push(headerLabel);
                });

                datiScheda.push(row);

                if (dataReport) {
                    $scope.framePDF = true;
                    let totali = new Object();
                    dataReport.forEach(function(record, i) {
                        let row = new Array();
                        let recordTable = new Object();
                        let styleCell;
                        elencoCampi.forEach((campo) => {
                            let textCell = !record[campo] ? 0 : record[campo];
                            if (textCell >= 0) {
                                styleCell = "tableNumber";
                                totali[campo] = !totali[campo] ? parseInt(textCell) : parseInt(totali[campo]) + parseInt(textCell);
                            } else {
                                totali[campo] = "TOTALI: " + (i + 1);
                                styleCell = "tableBody";
                            };
                            textCell = textCell == 0 ? '' : textCell;
                            styleCell = parametri.font ? "reportString" : styleCell;
                            recordTable = JSON.parse('{"text": "' + textCell + '", "style": "' + styleCell + '"}');
                            row.push(recordTable);
                        });

                        datiScheda.push(row);
                    });
                    console.log(datiScheda);
                    if (parametri.campoTotale) {
                        totali = JSON.parse("[" + JSON.stringify(totali) + "]");
                        //console.log(totali);
                        let row = new Array();
                        let recordTotali = new Object;

                        totali.forEach(function (record) {
                            elencoCampi.forEach(function (campo) {
                                //console.log(typeof record[campo]);
                                let styleCell = typeof record[campo] === "number" ? "tableNumberTotal" : "tableBodyTotal";
                                recordTotali = JSON.parse('{"text": "' + record[campo] + '", "style": "' + styleCell + '"}');
                                row.push(recordTotali);
                            });
                        });

                        datiScheda.push(row);
                    };
                };

                const iFrameWidth = parseInt($("#hControllo").width());
                const myIframe = document.getElementById("frameReportPDF");
                myIframe.width = iFrameWidth;
                myIframe.height = iFrameWidth * 1.1;
                myIframe.src = "";

                //const imgHeader = $.get("img/base64/Portofranco.Logo-png.B64.txt");
                //var imgLoader = $.when(imgHeader);
                //imgHeader.done(() => {
                const sfondo = false;
                const rs = dataUser.ragioneSociale;
                const posizione = parametri.posizStampa;
                const titolo = parametri.titleStampa + parametri.oggetto;
                const subTitolo = "Anno Scolastico: " + $scope.as + (parseInt($scope.idSede) == 0 ? " " : " - Sede di: " + $("#idSede>option:selected").text()); //+ $("#idSede>option:selected").text() 
                const larghezza = parametri.campiStampa[2];
                const margini = parametri.marginiStampa;
                const formula = "";
                const footerText = ""; //Auth.luogo;
                    //imgHeader.responseText,
                pdfReport(rs, sfondo, posizione, titolo, subTitolo, datiScheda, larghezza, margini, formula, footerText, myIframe);
                //});
                //imgHeader.fail(() => {
                //    infoDialog("Attenzione", "Errore codifica file Logo");
                //});
            };

            const creaBilancio = function () {
                $scope.framePDF = false;
                let dataReport = parametriPDF.myData;
                let parametri = parametriPDF.parametri;

                var datiScheda = new Array();
                const elencoCampi = parametri.campiStampa[0];
                const elencoLabel = parametri.campiStampa[1];
                const elencoStyle = parametri.campiStampa[3];

                // header della tabella
                var row = new Array();
                var headerLabel = new Object();

                elencoLabel.forEach((label, item) => {
                    headerLabel = JSON.parse('{"text": "' + label + '", "style": "tableHeader"}');
                    row.push(headerLabel);
                });
                datiScheda.push(row);

                // body della tabella
                if (dataReport) {
                    $scope.framePDF = true;
                    dataReport.forEach(function (record, i) {
                        let row = new Array();
                        let recordTable = new Object();
                        var style;
                        var subTot = false;
                        var subEnt = false;
                        var subUsc = false;
                        var subGen = false;
                        elencoCampi.forEach((campo, j) => {
                            var textCell = record[campo];
                            var styleCell = elencoStyle[j];

                            switch (styleCell) {
                                case "string":
                                    if (textCell.indexOf("SUBTO") > -1) {
                                        style = "tableTotCat";
                                        subTot = true;
                                    } else if (textCell.indexOf("ENTRATE") > -1) {
                                        style = "tableTotEnt";
                                        subEnt = true;
                                    } else if (textCell.indexOf("USCITE") > -1) {
                                        style = "tableTotUsc";
                                        subUsc = true;
                                    } else if (textCell.indexOf("GENERALE") > -1) {
                                        textCell = "UTILE / PERDITA DI ESERCIZIO";
                                        style = "tableTotGen";
                                        subGen = true;
                                    } else {
                                        style = "tableBody";
                                        subTot = false;
                                        subEnt = false;
                                        subUsc = false;
                                        subGen = false;
                                    };
                                    break;

                                case "money":
                                    if (subTot) {
                                        style = "tableMoneyTotCat";
                                    } else if (subEnt) {
                                        style = "tableMoneyTotEnt";
                                    } else if (subUsc) {
                                        style = "tableMoneyTotUsc"
                                    } else if (subGen) {
                                        style = "tableMoneyTotGen";
                                    } else {
                                        style = "tableMoney";
                                    };
                                    textCell = accounting.formatMoney(textCell, "€ ", 2, ".", ",")
                                    break;
                            };

                            recordTable = JSON.parse('{"text": "' + textCell + '", "style": "' + style + '"}');
                            row.push(recordTable);
                        });

                        datiScheda.push(row);
                    });

                };

                const iFrameWidth = parseInt($("#hControllo").width());
                const myIframe = document.getElementById("frameReportPDF");
                myIframe.width = iFrameWidth;
                myIframe.height = iFrameWidth * 1.1;
                myIframe.src = "";

                const imgHeader = $.get("img/base64/Portofranco.Logo-png.B64.txt");
                imgHeader.done(() => {
                    const sfondo = false;
                    const posizione = parametri.posizStampa;
                    const titolo = "";
                    const subTitolo = parametri.titleStampa + parametri.campoID["Anno"];
                    const larghezza = parametri.campiStampa[2];
                    const margini = parametri.marginiStampa;
                    const formula = dataUser;
                    const footerText = presidente;

                    pdfReport(imgHeader.responseText, sfondo, posizione, titolo, subTitolo, datiScheda, larghezza, margini, formula, footerText, myIframe);
                });
                imgHeader.fail(() => {
                    infoDialog("Attenzione", "Errore codifica file Logo");
                });
            };

            $(window).resize(function () {
                larghezza = parseInt($("#hControllo").width() * 0.75);
                mobile = largo < 768 ? true : false;
            });
          

        } else {
            Auth.from = "#/controllo";
            window.location.href = "#/main"; // mobile ? "#/main" : "#/utentiLogin";
        };

    });
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();