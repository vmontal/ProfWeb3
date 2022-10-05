//------------------------------Begin ctrl-controllo controller--------------------------------------------//
'use strict';

(function () {

    var controlloItalia = angular.module("controlloItalia", []);

    controlloItalia.controller("ctrl-controlloItalia", function ($scope, $http, dataUser, Auth, mask) {

        const largo = $(window).width();
        var alto = $(window).height();
        var dataInizio;
        var dataFinale;
        var presidente;
        var header;
        var parametri;
        var parametriPDF = new Object();
        var barStruttura = new Array();        
        var imageChart;
        var imageWidth;      

        google.charts.load("current", { packages: ['corechart', 'bar', 'gauge'], "language": "it" });

        var mobile = largo < 768 ? true : false;

        if (!mobile) { //Auth.userLogged && Auth.ruoloAdmin &&
            $("#schedaControlloItalia").show();

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
            var chartWidth = parseInt(larghezza * 0.8);
            var chartHeight;

            $scope.framePDF = false;
            $scope.showMenu = false;
            $scope.pivot = false;

            $scope.luogo = Auth.luogo;
            $scope.db = Auth.db;
            $scope.idRS = "0";
            $scope.path = dataUser.path;
            $scope.versione = adesso();

            $scope.annullaScheda = function () {
                $scope.cambia = false;
                $scope.framePDF = false;
                window.location.href = "#/master";
            };

            const imgKO = "ack-KO.png";
            const imgOK = "ack-OK.png";

            var parReportItaliaStudenti, parReportItaliaProfessori, parReportItaliaMaterie;
            var parReportItaliaStudentiSintesi, parReportItaliaStudentiSedi, parReportItaliaMaterieSintesi, parReportItaliaMaterieGruppo, parReportItaliaStudentiRatio;
            var parReportItaliaProfessoriSedi, parReportItaliaProfessoriTipo;
            var parAssociazioni, parSoci;
            //var parBilancio;

            parAssociazioni = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                campoZero: {idRS: "0", ragioneSociale: "Tutte"},
                tabella: "elencoAsso",
                spRead: "pf_parAssociazioniRead"
            };

            parSoci = {
                idKey: "ID",
                campoID: { ID: 3, idRS: 0 },
                tabella: "presidente",
                spRead: "pf_anagrafeSociRead"
            };

            //parBilancio = {
            //    idKey: "Anno",
            //    campoID: { Anno: 2020, idRS: dataUser.idRS },
            //    tabella: "Bilancio",
            //    spRead: "admBilancioRead",
            //    elencoCampi: ["Anno"],
            //    campiTabella: [
            //        { title: "Anno", field: "Anno", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
            //        { title: "Causale", field: "Causale", width: parseInt(larghezza * 0.40), sorter: "string", align: "left", headerFilter: true },
            //        { title: "Banca", field: "Banca", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
            //        { title: "Cassa", field: "Cassa", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
            //        { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: false },
            //    ],
            //    campiStampa: [
            //        ["Causale", "Banca", "Cassa", "Totale"],
            //        ["Causale", "Banca", "Cassa", "Totale"],
            //        ["*", 80, 80, 80],
            //        ["string", "money", "money", "money"]
            //    ],
            //    marginiStampa: [20, 20],
            //    posizStampa: "landscape",
            //    titleStampa: "Rendiconto finanziario anno: ",
            //    rollup: true
            //};

            parReportItaliaStudenti = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "Studenti",            
                spRead: "pf_reportItaliaStudenti",
                elencoCampi: ["idRS", "ragioneSociale", "origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "dtAGG", "prof"],
                campiTabella: [
                    { title: "", field: "idRS", width: parseInt(larghezza * 0), sorter: "number", align: "center", headerFilter: false, responsive: 0, visible: false },
                    { title: "Associazione", field: "ragioneSociale", width: parseInt(larghezza * 0.20), sorter: "date", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Origine", field: "origineStud",  width: parseInt(larghezza * 0.13), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Primo",   field: "Primo",   width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo",   field: "Terzo",   width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto",  field: "Quarto",  width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto",  field: "Quinto",  width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale",  field: "Totale",  width: parseInt(larghezza * 0.08), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Agg.",    field: "dtAGG",   width: parseInt(larghezza * 0.08), sorter: "string", align: "center",  headerFilter: false, responsive: 1 },
                    { title: "Prof", field: "prof", width: parseInt(larghezza * 0.04), sorter: "boolean", align: "center", formatter: "tickCross" }
                ],
                campiStampa: [
                    ["ragioneSociale", "origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale", "dtAGG", "prof"],
                    ["Ragione Sociale", "Origine", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale", "Agg.", "PROF"],
                    ["*", 70, 55, 55, 55, 55, 55, 55, 75, 30],
                    [false, false,true,true,true, true, true, true, false, false],
                ],
                oggetto: " ",
                marginiStampa: [20, 20],
                posizStampa: "landscape",
                titleStampa: "Report Studenti "
            };

            parReportItaliaStudentiSedi = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "StudentiSedi",
                spRead: "pf_reportItaliaStudentiSedi",
                elencoCampi: ["ragioneSociale", "Primo", "Secondo", "Terzo", "Quarto", "Quinto"],
                campiTabella: [
                    { title: "Associazione", field: "ragioneSociale", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campiStampa: [
                    ["ragioneSociale", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Associazione", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                    [false, true, true, true, true, true, true],
                ],
                oggetto: " ",
                marginiStampa: [20, 20],
                posizStampa: "portrait",
                titleStampa: "Studenti per Sede",
                grafico: true,
                campiGrafico: ["ragioneSociale", "Totale"],
                areaDiv: "graficoItaliaStudentiSedi",
                hChart: 1.0
            };

            parReportItaliaStudentiSintesi = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "StudentiSintesi",
                spRead: "pf_reportItaliaStudentiSintesi",
                elencoCampi: ["origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto"],
                campiTabella: [
                    { title: "Origine", field: "origineStud", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Primo", field: "Primo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Secondo", field: "Secondo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Terzo", field: "Terzo", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quarto", field: "Quarto", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Quinto", field: "Quinto", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.1), sorter: "string", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campiStampa: [
                    ["origineStud", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["Origine", "Primo", "Secondo", "Terzo", "Quarto", "Quinto", "Totale"],
                    ["*", 60, 60, 60, 60, 60, 60],
                    [false, true, true, true, true, true, true],
                ],
                oggetto: " ",
                marginiStampa: [10, 10],
                posizStampa: "portrait",
                titleStampa: "Studenti per Origine",
                grafico: true,
                campiGrafico: ["origineStud", "Totale"],
                areaDiv: "graficoItaliaStudentiSintesi",
                hChart: 0.5
            };

            parReportItaliaStudentiRatio = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "StudentiRatio",
                spRead: "pf_reportItaliaStudentiRatio",
                elencoCampi: ["ragioneSociale", "totStudenti", "totProfessori", "totOreErogate", "ratioStud", "ratioOre"],
                campiTabella: [
                    { title: "Associazione", field: "ragioneSociale", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Studenti", field: "totStudenti", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Professori", field: "totProfessori", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Ore Erogate", field: "totOreErogate", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Stud / Prof", field: "ratioStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false, responsive: 1 },
                    { title: "Ore / Stud", field: "ratioOre", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false, responsive: 1 },
                ],
                campiStampa: [
                    ["ragioneSociale", "totStudenti", "totProfessori", "totOreErogate", "ratioStud", "ratioOre"], //elencoCampi
                    ["Ragione Sociale", "Studenti", "Professori", "Ore Erogate", "Stud / Prof", "Ore / Stud"], //elencoLabel
                    ["*", 70, 70, 70, 70, 70], //elencoLarghezza
                    [false, true, true, true, false, false] //stampaTotali
                ],
                oggetto: " ",
                marginiStampa: [20, 20],
                posizStampa: "portrait",
                titleStampa: "Report Analisi Studenti"
            };

            parReportItaliaProfessori = {
                idKey: "idRS",
                campoID: { idRS: 0},
                tabella: "Professori",
                spRead: "pf_reportItaliaProfessori",
                elencoCampi: ["idRS", "ragioneSociale", "Attivo", "Pensione", "Studente", "Altro", "Totale", "dtAGG", "prof"],
                campiTabella: [
                    { title: "", field: "idRS", width: parseInt(larghezza * 0), sorter: "string", align: "left", responsive: 0, visible: false },
                    { title: "Ragione Sociale", field: "ragioneSociale", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Attivo",   field: "Attivo",   width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Pensione", field: "Pensione", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Studente", field: "Studente", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Altro",    field: "Altro",    width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Agg.", field: "dtAGG", width: parseInt(larghezza * 0.08), sorter: "string", align: "center", headerFilter: false, responsive: 1 },
                    { title: "Prof", field: "prof", width: parseInt(larghezza * 0.05), sorter: "boolean", align: "center", formatter: "tickCross" }
                ],
                campiStampa: [
                    ["ragioneSociale", "Attivo", "Pensione", "Studente", "Altro", "Totale","dtAGG", "prof"],
                    ["Docente", "Attivo", "Pensione", "Studente", "Altro", "Totale", "Agg.", "PROF"],
                    ["*", 55, 55, 55, 55, 55, 70, 30],
                    [false, true, true, true, true, true, false, false],
                ],
                marginiStampa: [40, 20],
                posizStampa: "portrait",
                titleStampa: "Report Docenti"
            };

            parReportItaliaProfessoriSedi = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "ProfessoriSedi",
                spRead: "pf_reportItaliaProfessori",
                elencoCampi: ["idRS", "ragioneSociale", "Attivo", "Pensione", "Studente", "Altro", "Totale"],
                campiTabella: [
                    { title: "", field: "idRS", width: parseInt(larghezza * 0), sorter: "string", align: "left", responsive: 0, visible: false },
                    { title: "Ragione Sociale", field: "ragioneSociale", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Attivo", field: "Attivo", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Pensione", field: "Pensione", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Studente", field: "Studente", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Altro", field: "Altro", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.08), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 }
                ],
                campiStampa: [
                    ["ragioneSociale", "Attivo", "Pensione", "Studente", "Altro", "Totale"],
                    ["Docente", "Attivo", "Pensione", "Studente", "Altro", "Totale"],
                    ["*", 55, 55, 55, 55, 55],
                    [false, true, true, true, true, true],
                ],
                marginiStampa: [20, 20],
                posizStampa: "portrait",
                titleStampa: "Docenti per Sede",
                oggetto: " ",
                grafico: true,
                campiGrafico: ["ragioneSociale", "Totale"],
                areaDiv: "graficoItaliaProfessoriSedi",
                hChart: 1.2
            };

            parReportItaliaProfessoriTipo = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "ProfessoriTipo",
                spRead: "pf_reportItaliaProfessoriTipo",
                elencoCampi: ["Tipo", "Totale"],
                campiTabella: [
                    { title: "Tipo", field: "Tipo", width: parseInt(larghezza * 0.5), sorter: "string", align: "left", responsive: 0},
                    { title: "Totale", field: "Totale", width: parseInt(larghezza * 0.2), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 }
                ],
                campiStampa: [
                    ["Tipo", "Totale"],
                    ["Tipo", "Totale"],
                    ["*", 100],
                    [false, true],
                ],
                marginiStampa: [20, 20],
                posizStampa: "portrait",
                titleStampa: "Docenti per Tipo",
                oggetto: " ",
                grafico: true,
                campiGrafico: ["Tipo", "Totale"],
                areaDiv: "graficoItaliaProfessoriTipo",
                hChart: 0.7
            };

            parReportItaliaMaterie = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "Materie",
                spRead: "pf_reportItaliaMaterie",
                elencoCampi: ["idRS", "ragioneSociale", "materia", "gruppo", "NR", "dtAGG", "prof"],
                campiTabella: [
                    { title: "Ragione Sociale", field: "ragioneSociale", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Gruppo", field: "gruppo", width: parseInt(larghezza * 0.10), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Ore Erogate", field: "NR", width: parseInt(larghezza * 0.06), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },                    
                    { title: "", field: "NR", width: parseInt(larghezza * 0.10), hozAlign: "left", formatter: "progress", responsive: 1 },
                    { title: "Agg.", field: "dtAGG", width: parseInt(larghezza * 0.08), sorter: "string", align: "center", headerFilter: false, responsive: 1 },
                    { title: "Prof", field: "prof", width: parseInt(larghezza * 0.05), sorter: "boolean", align: "center", formatter: "tickCross" }
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["ragioneSociale",  "materia", "gruppo", "NR", "dtAGG", "prof"], 
                    ["Ragione Sociale", "Materia", "Gruppo", "Ore Erogate", "AGG", "PROF"],
                    ["*", "*", 70, 40, 70, 30],
                    [false, false, false, true, false],
                ],
                marginiStampa: [40, 20],
                posizStampa: "landscape",
                oggetto: " ",
                titleStampa: "Report Materie",
                scheda: "repoMateria"
                //pivot: [parReportMateriePivot]
            };

            parReportItaliaMaterieSintesi = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "MaterieSintesi",
                spRead: "pf_reportItaliaMaterieSintesi",
                elencoCampi: ["materia", "gruppo", "oreErogare"],
                campiTabella: [                    
                    { title: "Materia", field: "materia", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Gruppo", field: "gruppo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Ore Erogate", field: "oreErogate", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["materia", "gruppo", "oreErogate"],
                    ["Materia", "Gruppo", "Ore Erogate"],
                    ["*", "*", 50],
                    [false, false, true],
                ],
                marginiStampa: [40, 20],
                posizStampa: "portrait",
                oggetto: " ",
                titleStampa: "Ore Erogate per Materia",
                scheda: "repoMateriaSintesi",
                grafico: true,
                campiGrafico: ["materia", "oreErogate"],
                areaDiv: "graficoItaliaMaterieSintesi",
                hChart: 1.5
                //pivot: [parReportMateriePivot]
            };

            parReportItaliaMaterieGruppo = {
                idKey: "idRS",
                campoID: { idRS: 0 },
                tabella: "MaterieGruppo",
                spRead: "pf_reportItaliaMaterieGruppo",
                elencoCampi: ["gruppo", "oreErogate"],
                campiTabella: [
                    //{ title: "Materia", field: "materia", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Gruppo", field: "gruppo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                    { title: "Ore Erogate", field: "oreErogate", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false, responsive: 1 },
                ],
                campoTotale: "materia",
                campiStampa: [
                    ["gruppo", "oreErogate"],
                    ["Gruppo", "Ore Erogate"],
                    ["*", 50],
                    [false, true],
                ],
                marginiStampa: [20, 20],
                posizStampa: "portrait",
                oggetto: " ",
                titleStampa: "Ore Erogare per Tipologia",
                scheda: "repoMateriaGruppo",
                grafico: true,
                campiGrafico: ["gruppo", "oreErogate"],
                areaDiv: "graficoItaliaMaterieGruppo",
                hChart: 1.0
                //pivot: [parReportMateriePivot]
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
                        case "RS":
                            parametri = parReportItaliaStudenti;
                            break;

                        case "RP":
                            parametri = parReportItaliaProfessori;
                            break;

                        case "RM":
                            parametri = parReportItaliaMaterie;
                            break;

                        case "RMS":
                            parametri = parReportItaliaMaterieSintesi;
                            break;

                        case "RMG":
                            parametri = parReportItaliaMaterieGruppo;
                            break;

                        case "RDS":
                            parametri = parReportItaliaProfessoriSedi;
                            break;

                        case "RDT":
                            parametri = parReportItaliaProfessoriTipo;
                            break;

                        case "RSS":
                            parametri = parReportItaliaStudentiSintesi;
                            break;

                        case "RSA":
                            parametri = parReportItaliaStudentiSedi;
                            break;

                        case "RRT":
                            parametri = parReportItaliaStudentiRatio;
                            break;
                    };

                    console.log(parametri);
                    let id = parametri.idKey;
                    parametri.campoID[id] = parametri.rollup ? parametri.campoID[id] : $scope.idRS;
                    parametri.campoID["idSede"] = $scope.idSede;
                    $scope[parametri.scheda] = true;
                    $scope.showMenu = true;
                    $scope.dettaglio = parametri.titleStampa;

                    let modal = "reportItalia";
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

            //getDropElenco(parSoci, 0, Auth.db, (dropElenco) => {
            //    presidente = dropElenco.nominativo;
            //});

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
                    success: getData_success(parametri, callback),
                    error: errorDialog
                });
            };

            const getData_success = (parametri, callback) => {
                return (response) => {
                    //console.log(response.d);
                    let elencoTemp = (xml2json(response.d).NewDataSet.elencoAsso);
                    elencoTemp.push(parametri.campoZero);
                    $scope.elencoSedi = elencoTemp;
                    console.log($scope.elencoSedi);
                    if (callback && typeof callback == "function"){
                        callback();
                    };
                    //console.log($scope.elencoSedi);
                };
            };

            getData(parAssociazioni, () => {
                $scope.idSede = "0";
                $scope.$apply();
            });

            const getReport = (parametri, modal, callback) => {
                $scope.grafico = false;
                imageChart = undefined;
                imageWidth = 10;
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
                    let grafico = parametri.grafico;
                    let campiGrafico = parametri.campiGrafico;

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

                        if (grafico) {   
                            barStruttura = new Array();
                            myData.forEach((record) => {
                                //console.log(record);
                                barStruttura.push([record[campiGrafico[0]], parseInt(record[campiGrafico[1]]), "color:yellow", record[campiGrafico[1]] ])
                            });
                            //console.log(barStruttura);
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

            $scope.reportTotali = () => {
                var tabDownload = parametri.tabella;                
                $("#reportItalia" + tabDownload).tabulator("download", "xlsx", "reportItalia" + tabDownload + ".xlsx");
            };

            $scope.reportPivot = () => {
                var tabDownload = parametri.tabella;
                $("#pivot" + tabDownload).tabulator("download", "xlsx", $scope.dettaglio +  ".xlsx");
            };

            $scope.reportPDF = () => {
                const rollup = parametri.rollup;
                if (parametriPDF.myData && !rollup) {
                    creaReport();
                } else if (parametriPDF.myData && rollup) {
                    creaBilancio();
                };
            };

            $scope.graficoTotali = () => {
                $scope.grafico = true;
                chartHeight = parseInt(chartWidth * parametri.hChart);
                //console.log(chartWidth);
                //console.log(parametri.hChart);
                //console.log(chartHeight);
                imageWidth = 750;
                imageChart = drawBar(barStruttura, chartWidth, chartHeight, parametri.areaDiv, parametri.titleStampa).getImageURI();
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

            const creaReport = () => {
                $scope.framePDF = false;
                let dataReport = parametriPDF.myData;
                parametri = parametriPDF.parametri;

                var datiScheda = new Array();
                var elencoCampi = parametri.campiStampa[0];
                var elencoLabel = parametri.campiStampa[1];
                var elencoTotali = parametri.campiStampa[3];

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
                    dataReport.forEach((record) => {
                        let row = new Array();
                        let recordTable = new Object();
                        let styleCell;
                        elencoCampi.forEach((campo, i) => {
                            let textCell = !record[campo] ? 0 : record[campo];
                            if (textCell >= 0) {
                                styleCell = "tableNumber";
                                totali[campo] = !totali[campo] ? parseInt(textCell) : (parseInt(totali[campo]) + parseInt(textCell)) * elencoTotali[i]; // parseInt(textCell)
                                //console.log(typeof (totali[campo]), totali[campo]);
                            } else {
                                totali[campo] = " "; // + (i + 1);
                                styleCell = "tableBody";
                            };
                            recordTable = JSON.parse('{"text": "' + textCell + '", "style": "' + styleCell + '"}');
                            row.push(recordTable);
                        });

                        datiScheda.push(row);
                    });
                    
                    totali = JSON.parse("[" + JSON.stringify(totali) + "]");
                    //console.log(totali);
                    let row = new Array();
                    let recordTotali = new Object;

                    totali.forEach(function(record){
                        elencoCampi.forEach(function(campo){
                            //console.log(typeof record[campo]);
                            let styleCell = typeof record[campo] === "number" ? "tableNumberTotal" : "tableBodyTotal";
                            recordTotali = JSON.parse('{"text": "' + record[campo] + '", "style": "' + styleCell + '"}');
                            row.push(recordTotali);
                        });
                    });

                    datiScheda.push(row);
                };

                chartHeight = parseInt(chartWidth * parametri.hChart);
                //console.log(chartWidth);
                //console.log(parametri.hChart);
                //console.log(chartHeight);
                imageWidth = 750;
                imageChart = drawBar(barStruttura, chartWidth, chartHeight, parametri.areaDiv, parametri.titleStampa).getImageURI();

                const iFrameWidth = parseInt($("#hControllo").width());
                const myIframe = document.getElementById("frameReportPDF");
                myIframe.width = iFrameWidth;
                myIframe.height = iFrameWidth * 1.1;
                myIframe.src = "";

                //const imgHeader = $.get("img/base64/Portofranco.Logo-png.B64.txt");
                //var imgLoader = $.when(imgHeader);
                //imgHeader.done(() => {
                const sfondo = false;
                const rs = "Portofranco - dbItalia"; // dataUser.ragioneSociale;
                const posizione = parametri.posizStampa;
                const titolo = parametri.titleStampa + parametri.oggetto;
                const subTitolo = "Anno Scolastico: " + $scope.as; // + (parseInt($scope.idSede) == 0 ? " " : " - Sede di: " + $("#idSede>option:selected").text()); //+ $("#idSede>option:selected").text() 
                const larghezza = parametri.campiStampa[2];
                const margini = parametri.marginiStampa;
                const formula = "";
                const footerText = ""; //Auth.luogo;
                    //imgHeader.responseText,
                pdfReportItalia(rs, sfondo, posizione, titolo, subTitolo, datiScheda, larghezza, margini, formula, footerText, imageChart, imageWidth, myIframe);
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
                    const footerText = ""; // presidente;

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
            Auth.from = "#/controlloItalia";
            window.location.href = "#/main"; // mobile ? "#/main" : "#/utentiLogin";
        };

    });
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();