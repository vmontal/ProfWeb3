//------------------------------Begin ctrl-anagrafe controller--------------------------------------------//
'use strict';

(function () {

    var prenota = angular.module("prenota", []);

    prenota.controller("ctrl-prenota", function ($scope, $http, dataUser, Auth, mask) {

        $(".titoloSezione").text("Gestione Prenotazione Lezioni");

        const largo = $(window).width();
        //const alto = $(window).height();
        const mobile = largo < 768 ? true : false;
        const idRS = dataUser.idRS;

        if (Auth.userLogged && Auth.ruoloModifica && !mobile) {
            $("#schedaGestione").show();
            const larghezza = $("#hPrenota").width() * 0.99;

            $scope.cambia = false;
            $scope.schedaNew = false;
            $scope.dateOK = false;
            $scope.dataIniziale = $("#dataIniziale").val();
            $scope.dataFinale = $("#dataFinale").val();
            $scope.offertaErrata = true;
            $scope.erogataFuturo = false;
            $scope.erogataPassato = false;
            $scope.erogata = false;
            $scope.prenotata = false;
            $scope.annullata = false;
            $scope.riprogramma = false;

            $scope.luogo = Auth.luogo;
            $scope.db = Auth.db;
            $scope.idSede = Auth.idSede;
            $scope.versione = adesso();

            $scope.admin = Auth.ruoloAdmin;
            $scope.gestione = Auth.ruoloGestione;
            $scope.modifica = Auth.ruoloModifica;
            $scope.lettura = Auth.ruoloLettura;
            $scope.idRS = dataUser.idRS;
            $scope.path = dataUser.path;

            //const myTest = Auth.locale ? 1 : 0;
            const myTest = 0;

            var modal = "tabella";
            var idKey = 0;
            var idStatusOfferta = 0;
            var idStatusOffertaIniziale = 0;
            var idStudenteR = 0;
            var idMateriaR = 0;
            var aggiornaData = 0;
            console.log(Auth.elencoOre, Auth.idSede)
            const getOra = () => {
                let elencoOre = Auth.elencoOre;
                elencoOre = elencoOre.filter((record) => {
                    return record.idSede == Auth.idSede;
                });
                return elencoOre;
            };

            const getOfferta = function (e, cell) {
                
                let value = cell.getValue();
                //let data = cell.getData();
                let valori = value.split(",");
                let idStatus = valori.filter(function (campo) {
                    return campo.split(":")[0].replace(/"/g, "") === "idStatus";
                });
                //var idStatusR = parseInt(data.idStatusOfferta);
                let idStatusR = parseInt(idStatus[0].split(":")[1].replace(/"/g, ""));
                idStatusOfferta = idStatusR;
                idStatusOffertaIniziale = idStatusR;
                console.log(value);
                if (value) {

                    var numElement = valori.length;

                    if (idStatusR === 11) {
                        var materia = valori.filter(function (campo) {
                            return campo.split(":")[0].replace(/"/g, "") === "materia";
                        });
                        var Studente = valori.filter(function (campo) {
                            return campo.split(":")[0].replace(/"/g, "") === "Studente";
                        });
                        if (materia.length > 0) {
                            $scope.materia = materia[0].split(":")[1].replace(/"/g, "");
                        };
                        if (Studente.length > 0) {
                            $scope.Studente = Studente[0].split(":")[1].replace(/"/g, "");
                        };
                        $scope.riprogramma = true;
                        idStudenteR = parseInt(valori[numElement - 1].split(":")[1])
                    };

                    var prof = valori[0].split(":")[0];
                    if (prof == "prof") {
                        aggiornaData = 0;
                        idKey = valori[numElement - 2].split(":")[1];
                    } else {
                        idKey = -2;
                    };
                } else {
                    idKey = -1;
                };
                var id = parametri.idKey;
                parametri.campoID[id] = idKey;
            };

            //const getStruttura = function (table) {
            //    let cerca = {};
            //    cerca.sp = "getStruttura";
            //    cerca.table = table;

            //    let elencoCampi = [];

            //    let criterio = {
            //        data: JSON.stringify(cerca),
            //        db: Auth.db
            //    };
            //    criterio = JSON.stringify(criterio);
            //    $.ajax({
            //        type: "POST",
            //        url: "/dati/aspnet/appGetData.aspx/getData",
            //        data: criterio,
            //        cache: false,
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (response) {
            //            var tabella = xml2json(response.d).NewDataSet[table];
            //            tabella.forEach(function (record) {
            //                elencoCampi.push(record.COLUMN_NAME);
            //            });
            //            console.log(elencoCampi);
            //            return elencoCampi;
            //        },
            //        error: function () {
            //            console.log(elencoCampi);
            //            return elencoCampi;
            //        }
            //    });

            //};

            //var getStrutturaDati = new Promise(function (resolve, reject) {
            //    let table = "pf_pianoOfferteVista"
            //    //const getStruttura = function(table) {
            //    let cerca = {};
            //    cerca.sp = "getStruttura";
            //    cerca.table = table;

            //    let elencoCampi = [];

            //    let criterio = {
            //        data: JSON.stringify(cerca),
            //        db: Auth.db
            //    };
            //    criterio = JSON.stringify(criterio);
            //    $.ajax({
            //        type: "POST",
            //        url: "/dati/aspnet/appGetData.aspx/getData",
            //        data: criterio,
            //        cache: false,
            //        contentType: "application/json; charset=utf-8",
            //        dataType: "json",
            //        success: function (response) {
            //            let tabella = xml2json(response.d).NewDataSet[table];
            //            tabella.forEach(function (record) {
            //                elencoCampi.push(record.COLUMN_NAME);
            //            });
            //            //console.log(elencoCampi);
            //            resolve(elencoCampi);
            //        },
            //        error: function () {
            //            //console.log(elencoCampi);
            //            reject(elencoCampi);
            //        }
            //    });

            //    //};
            //});

            //var getElenco = function () {
            //    getStrutturaDati
            //        .then(function (elenco) { console.log(elenco); return elenco; })
            //        .catch(function (error) { console.log("errore"); })
            //};

            //var myData = {
            //    message: "text",
            //    tpoa: "PortofrancoPA",
            //    recipient: [{
            //        msisdn: "tel1",
            //        msisdn: "tel2"
            //    }]
            //};

            const trovaCampo = function (aggiorna, soggetto, campo) {
                let idKeyCampo = soggetto.idKey;
                //let campo = soggetto[tipo];
                let id = aggiorna[idKeyCampo];

                let elenco = $scope[soggetto.dropElenco];

                elenco = elenco.filter((record) => {
                    return parseInt(record[idKeyCampo]) === parseInt(id);
                });

                return !elenco[0] ? "--------------" : elenco[0][campo];
            };

            //const trovaMail = function (aggiorna, soggetto) {
            //    let idKeyMail = soggetto.idKey;
            //    let campoEmail = soggetto.campoEmail;
            //    let id = aggiorna[idKeyMail];

            //    let elenco = $scope[soggetto.dropElenco];

            //    elenco = elenco.filter(function (record) {
            //        return parseInt(record[idKeyMail]) === parseInt(id);
            //    });

            //    return !elenco[0] ? "portofranco.pa@gmail.com" : elenco[0][campoEmail];
            //};

            const sendMail = (aggiorna, callBack) => {
                aggiorna.emailStud = trovaCampo(aggiorna, parStudenti, "emailStud");
                aggiorna.emailProf = trovaCampo(aggiorna, parProfessori, "emailProf");
                aggiorna.tel1Stud = trovaCampo(aggiorna, parStudenti, "tel1Stud")
                aggiorna.luogo = Auth.luogo;
                aggiorna.dataOffertaGMA = aggiorna.giorno + " " + aggiorna.dataOffertaGMA;

                let textModal = "Invio Mail in corso..."
                let imgModal = "gear1.gif";

                let criterio = {
                    data: JSON.stringify(aggiorna),
                    emailStud: aggiorna.emailStud,
                    emailProf: aggiorna.emailProf,
                    emailSede: Auth.emailSede,
                    ragioneSociale: dataUser.ragioneSociale,
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/SendMail",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: runDialog(textModal, imgModal),
                    success: closeDialog,
                    error: errorDialog
                });

                if (callBack && typeof callBack === "function") {
                    callBack();
                };
            };

            const sendSMS = (aggiorna) => {
                let messageText;
                const materia = aggiorna.materia;
                const dataOfferta = aggiorna.dataOffertaGMA;
                const orario = aggiorna.orario;
                const status = aggiorna.statusOfferta;
                const prof = aggiorna.nomeProf;
                const stud = aggiorna.nomeStud;

                messageText = "Ti segnalo che è stata " + status.toUpperCase() + " la lezione di " + materia + " per il giorno " + dataOfferta + " delle ore " + orario + " con prof: " + prof + " per stud: " + stud

                var myData = {
                    message: messageText,
                    tpoa: "Portofranco",
                    recipient: [
                        {
                            msisdn: "39" + trovaCampo(aggiorna, parStudenti, "tel1Stud")
                        },
                        {
                            msisdn: "39" + trovaCampo(aggiorna, parProfessori, "tel1Prof")
                        },
                    ],
                    test: myTest
                };

                let criterio = {
                    myData: JSON.stringify(myData),
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/SendSMS",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: runDialog(textModal, imgModal),
                    success: (response) => {
                        console.log(response.d);
                    },
                    error: errorDialog
                });

            };

            const parCalendario = {
                idKey: "idGiorno",
                campoID: { idGiorno: 0, giorno: oggi(-20), idMese: 0, idSede: Auth.idSede, idRS: Auth.idRS },
                tabella: "Calendario",
                spRead: "pf_parCalendarioRead",
                dropElenco: "elencoCalendario",
                drop: 2
            };

            var parOrari = {
                idKey: "idOrario",
                campoID: { idOrario: 0, idSede: Auth.idSede },
                tabella: "Orari",
                spRead: "pf_parOrariRead",
                dropElenco: "elencoOrari",
                drop: 1
            };

            var parMaterie = {
                idKey: "idMateria",
                campoID: { idMateria: 0, idRS: dataUser.idRS },
                tabella: "Materie",
                spRead: "pf_parMaterieRead",
                dropElenco: "elencoMaterie",
                drop: 1
            };

            var parStudenti = {
                idKey: "idStudente",
                campoID: { idStudente: 0, idSede: Auth.idSede, idRS: dataUser.idRS },
                campoEmail: "emailStud",
                tabella: "Studenti",
                spRead: "pf_anagrafeStudentiRead",
                dropElenco: "elencoStudenti",
                drop: 1,
                campiCheck: ["istitutoTipo", "anno", "tel1Stud", "tel2Stud", "emailStud", "disdetteStud", "Prenotata", "Disdetta", "Erogata"],
            };

            var parProfessori = {
                idKey: "idProfessore",
                campoID: { idProfessore: 0, idSede: Auth.idSede, idRS: dataUser.idRS },
                campoEmail: "emailProf",
                tabella: "Professori",
                spRead: "pf_anagrafeProfessoriRead",
                drop: 1,
                dropElenco: "elencoProfessori",
            };

            var parStatusOfferte = {
                idKey: "idStatusOfferta",
                campoID: { idStatusOfferta: 0 },
                tabella: "StatusOfferta",
                spRead: "pf_parStatusOfferteRead",
                dropElenco: "statusOfferte",
                drop: 1
                //dropPush: { "idStatusOfferta": "0", "statusOfferta": "--" }
            };

            var parOfferte = {
                idKey: "idOfferta",
                campoID: { idOfferta: 0, idProfessore: 0, idMateria: 0, idStatusOfferta: 0, dataIniziale: oggi(0), dataFinale: oggi(30), delete: 0, idSede: Auth.idSede, idRS: Auth.idRS },
                tabella: "Offerte",
                spCreate: "pf_pianoOfferteCreate",
                spRead: "pf_pianoOfferteRead",
                spUpdate: "pf_pianoOfferteUpdate",
                spDelete: "pf_pianoOfferteDelete",
                spAttiva: "pf_pianoOfferteAttiva",
                elencoCampi: ["idOfferta", "dataOffertaGMA", "nomeProf", "materia", "anni", "statusOfferta", "nomeStud", "idStatusOfferta", "idLezione", "idProfessore", "idMateria", "gruppoStud", "idOrario", "orario", "idGiorno", "giorno", "idOra", "attivo", "notaOfferta", "argomentoOfferta", "idStudente", "anno", "istitutoTipo", "tel1Stud", "tel2Stud", "emailStud", "tel1Prof", "tel2Prof", "emailProf", "distanza", "modoLezione"],
                campiTabella: [
                    { title: "Data", field: "dataOffertaGMA", headerSort: false, formatter: mask.cellBold10, width: parseInt(larghezza * 0.08), headerFilter: true, responsive: 0 },
                    { title: getOra()[0].oraAttiva == 1 ? getOra()[0].ora : "", field: getOra()[0].oraAttiva == 1 ? "Ora1" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[0].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta }, //width: parseInt(larghezza * 0.19),
                    { title: getOra()[1].oraAttiva == 1 ? getOra()[1].ora : "", field: getOra()[1].oraAttiva == 1 ? "Ora2" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[1].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta },
                    { title: getOra()[2].oraAttiva == 1 ? getOra()[2].ora : "", field: getOra()[2].oraAttiva == 1 ? "Ora3" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[2].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta },
                    { title: getOra()[3].oraAttiva == 1 ? getOra()[3].ora : "", field: getOra()[3].oraAttiva == 1 ? "Ora4" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[3].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta },
                    { title: getOra()[4].oraAttiva == 1 ? getOra()[4].ora : "", field: getOra()[4].oraAttiva == 1 ? "Ora5" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[4].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta },
                    { title: getOra()[5].oraAttiva == 1 ? getOra()[5].ora : "", field: getOra()[5].oraAttiva == 1 ? "Ora6" : "", headerSort: false, width: parseInt(larghezza * 0.15), formatter: mask.celltext, headerFilter: getOra()[4].oraAttiva == 1 ? true : false, responsive: 0, cellClick: getOfferta },
                ],
                campiCheck: ["distanza", "gruppoStud"],
                campoGroupBy: "dataOffertaGMA",
                idFormat: "idStatusOfferta",
                scheda: "schedaOff",
                sendEmail: ["idStudente", "idProfessore"],
                drop: true,
                dropGet: [parStudenti, parStatusOfferte, parProfessori, parOrari, parMaterie, parCalendario],
                dropGetFilter: [parStatusOfferte],
                dropElenco: ""
            };

            var elenco;
            const imgKO = "ack-KO.png";
            const imgOK = "ack-OK.png";

            $(".tempo").datepicker({
                changeMonth: true,
                changeYear: true,
                minDate: "0D",
                maxDate: "90D"
            });

            $(".tempo").datepicker($.datepicker.regional["it"]);

            const elencoCampiGenera = ["dataIniziale", "dataFinale", "sospendiInizio", "sospendiFine", "sospendiInizioE", "sospendiFineE", "ponteFestivo", "preFestivo", "riattivaInizioC", "riattivaFineC", "riattivaInizio", "riattivaFine"];
            const elencoCampiProfessore = ["idProfessoreS", "idProfessoreC", "idProfessoreA", "idProfessoreE"];
            const parametri = parOfferte;

            $scope.scheda = function (setTab) {
                $scope.riprogramma = false;
                $scope.tabMenu = setTab;
                $scope.cambia = false;
                idKey = 0;
                parametri.spRead = "pf_pianoOfferteRead";

                switch (setTab) {
                    case "G":
                        $scope.tabTime = 'Z';

                        idStatusOfferta = 0;
                        parametri.campoID.idStatusOfferta = 0;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.dataIniziale = oggi(-300);
                        parametri.campoID.dataFinale = oggi(365);
                        parametri.campoID.delete = 0;
                        break;

                    case "I":
                        idStatusOfferta = 1;
                        //$scope.riprogramma = false;
                        parametri.campoID.idStatusOfferta = 1;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.dataIniziale = oggi(0);
                        parametri.campoID.dataFinale = oggi(30);
                        parametri.campoID.delete = 0;
                        break;

                    case "P":
                        idStatusOfferta = 2;
                        //$scope.riprogramma = false;
                        parametri.campoID.idStatusOfferta = 2;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.dataIniziale = oggi(0);
                        parametri.campoID.dataFinale = oggi(30);
                        parametri.campoID.delete = 0;
                        break;

                    case "E":
                        idStatusOfferta = 3;
                        //$scope.riprogramma = false;
                        parametri.campoID.idStatusOfferta = 3;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.dataIniziale = oggi(-90);
                        parametri.campoID.dataFinale = oggi(0);
                        parametri.campoID.delete = 1;
                        break;

                    case "X":
                        $scope.tabTime = 'Z';

                        idStatusOfferta = 11;
                        parametri.campoID.dataIniziale = oggi(-30);
                        parametri.campoID.dataFinale = oggi(300);
                        parametri.campoID.idStatusOfferta = 11;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.delete = 1;
                        break;

                    case "W":
                        //$scope.tabTime = 'Z';
                        parametri.spRead ="pf_pianoOfferteTotaliRead"
                        idStatusOfferta = 2;
                        parametri.campoID.dataIniziale = oggi(-30);
                        parametri.campoID.dataFinale = oggi(300);
                        parametri.campoID.idStatusOfferta = 2;
                        parametri.campoID.idMateria = 0;
                        parametri.campoID.delete = 1;
                        break;

                };

                var id = parametri.idKey;
                parametri.campoID[id] = idKey;

                if (!$("#tabella" + parametri.tabella).hasClass("tabulator")) {
                    tabella(larghezza, parametri, function () {
                        getOfferte(parametri, modal, function () {
                            //$("#tabella" + parametri.tabella).tabulator("redraw");
                            if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                                $("#tabella" + parametri.tabella).addClass("table-center");
                            };
                        });
                    });
                } else {
                    getOfferte(parametri, modal, function () {
                        //$("#tabella" + parametri.tabella).tabulator("redraw");
                        if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                            $("#tabella" + parametri.tabella).addClass("table-center");
                        };
                    });
                };
            };

            $scope.schedaTime = function (setTime, giorni) {
                $scope.tabTime = setTime;
                $scope.cambia = false;
                idKey = 0;

                switch (setTime) {
                    case "O":
                        parametri.campoID.dataIniziale = oggi();
                        parametri.campoID.dataFinale = oggi(+giorni);
                        break;

                    case "S":
                        parametri.campoID.dataIniziale = oggi();
                        parametri.campoID.dataFinale = oggi(+giorni);
                        break;

                    case "M":
                        parametri.campoID.dataIniziale = oggi();
                        parametri.campoID.dataFinale = oggi(+giorni);
                        break;

                    case "R":

                        break;

                };

                var id = parametri.idKey;
                parametri.campoID[id] = idKey;

                var modal = "tabella";
                if (!$("#tabella" + parametri.tabella).hasClass("tabulator")) {
                    tabella(larghezza, parametri, function () {
                        getOfferte(parametri, modal, function () {
                            //$("#tabella" + parametri.tabella).tabulator("redraw");
                            if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                                $("#tabella" + parametri.tabella).addClass("table-center");
                            };
                        });
                    });
                } else {
                    getOfferte(parametri, modal, function () {
                        //$("#tabella" + parametri.tabella).tabulator("redraw");
                        if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                            $("#tabella" + parametri.tabella).addClass("table-center");
                        };
                    });
                };
            };

            $scope.isSelected = function (checkTab) {
                return $scope.tabMenu === checkTab;
            };

            $scope.isTime = function (checkTime) {
                return $scope.tabTime === checkTime;
            };

            //getStatus();

            const getOfferte = (parametri, modal, callback) => {
                var cerca = {};
                cerca.spRead = parametri.spRead;
                cerca.tabella = parametri.tabella;
                cerca.drop = 0;
                $.extend(cerca, parametri.campoID);

                var criterio = {
                    data: JSON.stringify(cerca),
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
                    success: getOfferte_success(parametri, modal, callback),
                    error: errorDialog
                });
            };

            const getOfferte_success = (parametri, modal, callback) => {
                return (response) => {
                    let jsonData = JSON.stringify(xml2json(response.d));
                    let nrc = jsonData.slice(-3);
                    let pqa = (nrc == "]}}" ? "" : "[");
                    let pqc = (nrc == "]}}" ? "" : "]");
                    let elencoCampi = parametri.elencoCampi;
                    let idKey = parametri.idKey;
                    let id = parametri.campoID[idKey];
                    let archivio = parametri.tabella;
                    let tabella = modal + archivio;
                    let scheda = parametri.scheda;
                    //console.log(parametri.elencoCampi);
                    var myData = xml2json(response.d).NewDataSet[archivio];
                    console.log(myData);
                    if (id === 0) {
                        if (jsonData.length > 100) {
                            var jsonOutput = pqa + JSON.stringify(myData) + pqc;
                            $("#" + tabella).tabulator("setData", jsonOutput);
                        } else {
                            $("#" + tabella).tabulator("clearData");
                        };

                        if (parametri.drop) {
                            var dropGet = parametri.dropGet;
                            dropGet.forEach(function (dropParametri) {
                                var dropPush = dropParametri.dropPush;
                                getDropElenco(dropParametri, dropParametri.drop, Auth.db, function (dropElenco) {
                                    if (dropPush) {
                                        dropElenco.push(dropPush);
                                    };
                                    dropElenco = contaRecord(dropElenco) === 1 ? JSON.parse("[" + JSON.stringify(dropElenco) + "]") : dropElenco;
                                    $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";                                                                        
                                    console.log(dropElenco);
                                });
                            });
                        };

                    } else {
                        
                        $scope.cambia = false;
                        $scope[scheda] = true;

                        if (idStatusOfferta == 3 && parseData(myData.dataOffertaGMA) <= parseData(oggi())) {
                            $scope.elencoCalendario.push({ idSede: Auth.idSede, giornoGMA: myData.dataOffertaGMA, nomeGiorno: myData.giorno, giornoSettimana: myData.idGiorno })
                            $scope.$apply();
                        };

                        elencoCampi.forEach(function (campo) {
                            $("#" + campo).val(myData[campo]);
                            $scope[campo] = $("#" + campo).val();
                            console.log(campo + ": " + $("#" + campo).val());
                        });

                        if (parametri.campiCheck) {
                            let campiCheck = parametri.campiCheck;
                            campiCheck.forEach((campo) => {
                                let campoCK = $("#" + campo);
                                $scope[campo] = myData[campo] == "true";
                                campoCK.prop("checked", myData[campo] == "true");
                                console.log(campo, myData[campo], myData[campo] == "true");                                
                            });
                            $scope.$apply();
                        };

                        if ($("#idStudente").val() == null || $("#idStudente").val().indexOf("null") > 0) {
                            $("#idStudente").val("0");
                            $scope.idStudente = $("#idStudente").val();
                        };

                        if (idStudenteR !== 0) {
                            $scope.riprogramma = true;
                            $("#idStudente").val(idStudenteR);
                            $scope.idStudente = $("#idStudente").val();
                            $("#idStatusOfferta").val(2);
                            idStatusOfferta = 2;
                            $scope.idStatusOfferta = $("#idStatusOfferta").val();
                            idStudenteR = 0;
                            $scope.cambia = true;
                            //console.log($scope.riprogramma, $("#idStatusOfferta").prop("disabled"));
                        } else {
                            $scope.riprogramma = false;
                        };

                        var idStudente = parseInt($("#idStudente").val());
                        var idProfessore = parseInt($("#idProfessore").val());

                        studenteCheck(idStudente);

                        var anniOK = anniCheck();

                        $scope.dataBloccata = idStatusOfferta != 8 && idStatusOfferta != 9;
                        $scope.erogataFuturo = idStatusOfferta == 3 && parseData($("#dataOffertaGMA").val()) > parseData(oggi());
                        $scope.erogataPassato = annullaAttesa(idStatusOfferta) === 1 && parseData($("#dataOffertaGMA").val()) < parseData(oggi());
                        $scope.offertaErrata = (idStudente == 0 && (idStatusOfferta >= 2 && idStatusOfferta <= 4)) ||
                            (idStudente != 0 && (idStatusOfferta == 1 || idStatusOfferta == 0)) ||
                            (idProfessore == 0) ||
                            (anniOK && idStatusOfferta == 2);
                        $scope.prenotata = idStatusOfferta == 2;
                        $scope.erogata = idStatusOfferta == 3;
                        $scope.annullata = idStatusOfferta == 5 || idStatusOfferta == 6 || idStatusOfferta == 10;

                        $scope.$apply();
                        $("#idStatusOfferta").prop("disabled", $scope.erogata || $scope.annullata || $scope.erogataPassato || $scope.riprogramma)
                        $("#idStudente").prop("disabled", $scope.erogata || $scope.prenotata || $scope.annullata || $scope.riprogramma || $scope.erogataPassato)
                        console.log($scope.elencoCalendario);
                        console.log(idStatusOfferta);
                        console.log($scope.erogata);
                    };

                    if ($("#modoLezione").val() == 2) {
                        $("#distanza").prop("checked", true);
                    };
                    //$("#distanza").prop("checked", $("#modoLezione").val() == 2 ? true: false ) <-- Non Utilizzare


                    if (callback && typeof callback === "function") {
                        callback();
                    };

                };

                //closeDialog();
            };

            const updOfferta = (parametri, azione) => {
                let aggiorna = {};
                let campiTesto = "";
                switch (azione) {
                    case 'U':
                        aggiorna.spUpdate = parametri.spUpdate;
                        var elencoCampi = parametri.elencoCampi;
                        elencoCampi.forEach(function (campo) {
                            if ($("#" + campo).val() === undefined) {
                                aggiorna[campo] = " ";
                                //console.log("undefined-->" + campo + ":" + aggiorna[campo] + " - val:" + $("#" + campo).val());
                            } else if ($("#" + campo).val() == null || $("#" + campo).val().indexOf("null") > 0) {
                                aggiorna[campo] = 0;
                                //console.log("null -->" + campo + ":" + aggiorna[campo] + " - val:" + $("#" + campo).val());
                            } else {
                                aggiorna[campo] = $("#" + campo).val().replace(/([.*+?^=!:,${}()|\[\]\\])/g, " ");
                                //console.log("else-->" + campo + ":" + aggiorna[campo] + " - val:" + $("#" + campo).val());
                            };
                            //aggiorna[campo] = $("#" + campo).val() === undefined ? " " : !$("#" + campo).val() ? "0" : $("#" + campo).val().replace(/([.*+?^=!:,${}()|\[\]\\])/g, " ");

                        });
                        //console.log("idStudente: " + aggiorna.idStudente);
                        //aggiorna.idStudente = $("#istitutoTipo").val();
                        aggiorna.aggiornaData = aggiornaData;
                        aggiorna.nomeStud = $("#idStudente>option:selected").text();
                        aggiorna.statusOfferta = $("#idStatusOfferta>option:selected").text();
                        let orario = $("#idOra>option:selected").text();
                        orario = orario.split(":")[0] + "-" + orario.split(":")[1];
                        aggiorna.orario = orario;
                        aggiorna.riprogramma = $scope.riprogramma ? 1 : 0;                        
                        break;

                    case 'C':
                        aggiorna.spCreate = parametri.spCreate;
                        aggiorna.dataIniziale = parametri.campoID.dataIniziale;
                        aggiorna.dataFinale = parametri.campoID.dataFinale;
                        aggiorna.ponteFestivo = parametri.ponteFestivo;
                        aggiorna.preFestivo = parametri.preFestivo;
                        break;

                    case 'D':
                        aggiorna.spDelete = parametri.spDelete;
                        aggiorna.dataIniziale = parametri.campoID.dataIniziale;
                        aggiorna.dataFinale = parametri.campoID.dataFinale;
                        aggiorna.idProfessore = parametri.campoID.idProfessore;
                        aggiorna.erase = parametri.erase;
                        break;

                    case 'R':
                        aggiorna.spAttiva = parametri.spAttiva;
                        aggiorna.dataIniziale = parametri.campoID.dataIniziale;
                        aggiorna.dataFinale = parametri.campoID.dataFinale;
                        aggiorna.idProfessore = parametri.campoID.idProfessore;
                        aggiorna.idStatusAttiva = parametri.idStatusAttiva;
                        break;
                };

                if (parametri.campiCheck) {
                    let campiCheck = parametri.campiCheck;
                    campiCheck.forEach(campo => {
                        aggiorna[campo] = $("#" + campo).is(":checked") ? 1 : 0;
                    });
                };

                //let modoLezione = parseInt($("#modoLezione").val());
                //switch (modoLezione) {
                //    case 1:
                //        aggiorna.distanza = 0;
                //        break;

                //    case 2:
                //        aggiorna.distanza = 1;
                //        break;
                //};


                aggiorna.idSede = parametri.campoID.idSede;
                aggiorna.idRS = idRS;
                $scope.riprogramma = false;

                var criterio = {
                    data: JSON.stringify(aggiorna),
                    html: campiTesto,
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/updData",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog, 
                    success: updOfferta_success(parametri, aggiorna),
                    error: errorDialog
                });
            };

            const updOfferta_success = (parametri, aggiorna) => {
                //closeDialog();
                return (response) => {
                    console.log(response);
                    var esito = parseInt(response.d);

                    switch (esito) {

                        case 1:
                            var msgTipo = "";
                            var msgText = "Il Piano è stato generato correttamente!";
                            var msgImg = imgOK;
                            var idKey = parametri.idKey;
                            parametri.campoID[idKey] = 0
                            getOfferte(parametri, "tabella", function () {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                            });
                            break;

                        case 2:
                            $scope.cambia = false;
                            var msgTipo = "La lezione si sovrappone ad un'altra nello stesso orario e data";
                            var msgText = "Impossibile Prenotare la Lezione!"
                            var msgImg = imgKO;
                            var idKey = parametri.idKey;
                            parametri.campoID[idKey] = 0
                            break;

                        case 3:
                            var msgTipo = "Invio eMail in corso per docente e studente";
                            var msgText = "La lezione è stata prenotata";
                            var msgImg = imgOK;
                            var idKey = parametri.idKey;
                            parametri.campoID[idKey] = 0
                            getOfferte(parametri, "tabella", function () {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                                if (aggiorna.idStatusOfferta != 3) {
                                    sendMail(aggiorna, () => {
                                        console.log(Auth.locale);
                                        //if (!Auth.locale) { //riattivare la negazione ! in produzione
                                            console.log("Sending SMS...")
                                            //sendSMS(aggiorna);
                                            //sendNotification(aggiorna);
                                        //};
                                    });
                                };
                            });
                            break;

                        case 4:                            
                            var msgTipo = "Invio eMail in corso per docente e studente";
                            var msgText = "La lezione è stata spostata";
                            var msgImg = imgOK;
                            var idKey = parametri.idKey;
                            parametri.campoID[idKey] = 0
                            getOfferte(parametri, "tabella", function () {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                                if (aggiorna.idStatusOfferta != 3) {
                                    sendMail(aggiorna);
                                };
                            });
                            break;
                    };

                    $scope.$apply();

                    if (esito != 3) { infoDialog(msgText, msgTipo, msgImg, largo) };
                };
            };

            const updAttivo = (id) => {
                var aggiorna = {};
                aggiorna.ID = id;
                aggiorna.attivo = $("#Attivo").is(":checked") ? 1 : 0;
                aggiorna.livello = "A";
                aggiorna.db = Auth.db;
                var criterio = JSON.stringify(aggiorna);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/updAttivo",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: function (response) {
                        var esito = parseInt(response.d);
                        if (esito == 1) {
                            insert = true;
                        };
                    },
                    error: errorDialog
                });
            };

            const tabella = (larghezza, parametri, callback) => {
                var tabella = parametri.tabella;
                var elencoCampi = parametri.elencoCampi;
                var campiTabella = parametri.campiTabella;
                var campoGroupBy = parametri.campoGroupBy;
                var scheda = parametri.scheda;

                $("#tabella" + tabella).tabulator({
                    height: "500px", // "400px",
                    responsiveLayout: false,
                    colResizable: false,
                    columnVertAlign: "center",
                    selectable: 0,
                    //groupBy: campoGroupBy,
                    columns: campiTabella,
                    index: parametri.idKey,

                    groupToggleElement: "header",
                    groupStartOpen: false,
                    groupHeader: function (value, count, data, group) {
                        return value + "<span style='color:#d00; margin-left:10px;'></span>";
                    },

                    rowClick: function (e, row) {
                        var id = parametri.idKey;
                        if (parametri.campoID[id] > 0) {
                            var data = row.getData();
                            //idStatusOfferta = parseInt(data[parametri.idFormat]);
                            //console.log(idStatusOfferta);
                            //idKey = data[id];
                            //parametri.campoID[id] = idKey;
                            if (parametri.dropGetFilter) {
                                var dropGetFilter = parametri.dropGetFilter;
                                dropGetFilter.forEach(function (dropParametri) {
                                    var dropPush = dropParametri.dropPush;
                                    var idDropKey = dropParametri.idKey;
                                    //dropParametri.campoID[idDropKey] = data[idDropKey];
                                    dropParametri.campoID[idDropKey] = idStatusOfferta;
                                    getDropElenco(dropParametri, 1, Auth.db, function (dropElenco) {
                                        if (dropPush) {
                                            dropElenco.push(dropPush);
                                        };
                                        //console.log(dropParametri);
                                        //console.log(dropParametri.dropElenco);
                                        //console.log(dropElenco);
                                        $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                                        $scope.$apply();
                                    });
                                });
                            };
                            if (idStatusOfferta === 11) {
                                parametri.campoID["idMateria"] = parseInt(data["idMateria"]);
                                parametri.campoID[id] = 0;
                                parametri.campoID["dataIniziale"] = oggi();
                                parametri.campoID["dataFinale"] = oggi(30);
                                parametri.campoID["idSede"] = Auth.idSede;
                                $scope.schedaTime("X");

                            } else if (idStatusOfferta === 12 || idStatusOfferta === 5) {
                                var nonFareNulla = 0;

                            } else {
                                parametri.campoID["idMateria"] = 0;
                                $scope[scheda] = true;
                                $("#idStatusOfferta").prop("disabled", $scope.riprogramma);
                                setTimeout(function () {
                                    console.log(parametri);
                                    getOfferte(parametri);
                                }, 200);
                            };
                        };
                    },

                });

                if (callback && typeof callback === "function") {
                    callback();
                };

            };

            //var modal = "tabella";

            tabella(larghezza, parametri, () => {
                $scope.erogata = false;
                getOfferte(parametri, modal, () => {
                    $("#tabella" + parametri.tabella).tabulator("redraw");
                });
            });

            //------------------------------Begin Gestione download-------------------------------------------//

            $scope.download_xls = () => {
                $("#tabella" + parametri.tabella).tabulator("download", "xlsx", "pf_elencoOfferte.xlsx");
            };

            $scope.download_csv = () => {
                $("#tabella" + parametri.tabella).tabulator("download", "csv", "pf_elencoOfferte.csv", { delimiter: "|" });
            };

            //-----------------------------End Gestione download----------------------------------------------//

            $("#Attivo").change(function () {
                updAttivo(dataCliente.IDCliente);
            });

            var anniCheck = function () {
                var anni = $("#anni").val();
                var anno = $("#anno").val();

                if (anni.indexOf(anno) < 0) {
                    $("#anno").addClass("alertAnno");
                    return true;

                } else {
                    $("#anno").removeClass("alertAnno");
                    return false;
                };
            };

            var studenteCheck = (idStudente) => {
                var elenco = $scope.elencoStudenti;
                elenco = elenco.filter((studente) => {
                    return studente.idStudente == idStudente;
                });
                if (elenco[0]) {
                    var campiCheck = parStudenti.campiCheck;
                    campiCheck.forEach((campo) => {
                        $("#" + campo).val(elenco[0][campo]);
                    });
                    return true;
                } else {
                    return false;
                };
            };

            var annullaAttesa = (idStatus) => {
                var elenco = $scope.statusOfferte;
                elenco = elenco.filter((stato) => {
                    return stato.idStatusOfferta == idStatus;
                });
                return elenco[0] ? elenco[0].annullaAttesa ? 1 : 0 : 0;
            };

            $scope.offertaCheck = function () {
                $scope.cambia = true;
                let idStudente = parseInt($("#idStudente").val());
                let idProfessore = parseInt($("#idProfessore").val());
                let idStatusOfferta = parseInt($("#idStatusOfferta").val());
                $("#idStatusOfferta").prop("disabled", false);
                $("#idStudente").prop("disabled", false);

                studenteCheck(idStudente);

                if (idStatusOfferta === 3) {
                    $("#idStatusOfferta").prop("disabled", true);
                    $("#idStudente").prop("disabled", true);
                };

                if (idStudente !== 0 && (idStatusOfferta === 1 || idStatusOfferta === 2)) {
                    $("#idStatusOfferta").val(2);
                    idStatusOfferta = parseInt($("#idStatusOfferta").val());
                    $scope.idStatusOfferta = $("#idStatusOfferta").val();
                    $("#idStatusOfferta").prop("disabled", true);
                };

                if (idStatusOffertaIniziale === 1 && (idStatusOfferta === 5 || idStatusOfferta === 8)) {
                    $("#idStudente").val(0);
                    idStudente = 0;
                    $("#idStudente").prop("disabled", true);
                };

                if (idStatusOffertaIniziale === 2 || $scope.riprogramma) {
                    $("#idStudente").prop("disabled", true);
                };

                if (idStatusOffertaIniziale === 11) {
                    $("#idStudente").prop("disabled", true);
                };

                var anniOK = anniCheck();

                //setTimeout(function () {
                    $scope.dataBloccata = idStatusOfferta !== 8 && idStatusOfferta !== 9;
                    $scope.erogataFuturo = idStatusOfferta == 3 && parseData($("#dataOffertaGMA").val()) > parseData(oggi());
                    $scope.erogataPassato = annullaAttesa(idStatusOfferta) === 1 && parseData($("#dataOffertaGMA").val()) < parseData(oggi());
                    $scope.offertaErrata = (idStatusOfferta >= 2 && idStatusOfferta <= 4 && idStudente == 0) ||
                        //(idStatusOfferta == 1 && idStudente != 0) || (idStatusOfferta == 1 && idStudente == 0) ||
                        (idStatusOfferta == 3 && parseData($("#dataOffertaGMA").val()) > parseData(oggi())) ||
                        (annullaAttesa(idStatusOfferta) === 1 && parseData($("#dataOffertaGMA").val()) < parseData(oggi())) ||
                        (idStatusOfferta === 11) || (idStatusOfferta === 1) ||
                        (idProfessore == 0) ||
                        (anniOK && idStatusOfferta === 2);
                    //$scope.$apply();
                    
                //}, 500);  
        };

            $scope.updateData = function () {
                $scope.cambia = true;
                aggiornaData = 1;
            };

            $scope.dateOK = function () {
                let inserisci = $("#dataIniziale").val().length !== 0; // && $("#dataFinale").val().length !== 0;
                let sospendiC = $("#sospendiInizio").val().length !== 0; // && $("#sospendiFine").val().length !== 0;
                let sospendiE = $("#sospendiInizioE").val().length !== 0; // && $("#riattivaFineC").val().length !== 0;
                let riattiva = $("#riattivaInizio").val().length !== 0; // && $("#riattivaFine").val().length !== 0;
                let riattivaC = $("#riattivaInizioC").val().length !== 0; // && $("#riattivaFineC").val().length !== 0;
                let idProfessoreS = $("#idProfessoreS").val() ? true: false;
                //console.log($("#idProfessoreS").val());
                return (inserisci || sospendiC || sospendiE || riattiva || riattivaC) && idProfessoreS;
            };

            $scope.aggiornaOrario = function () {
                var giornoSettimana = ["Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato"];
                var nuovaData = $("#dataOffertaGMA").val().split("-");
                var newDay = new Date(nuovaData[2], nuovaData[1]-1, nuovaData[0])
                //var nuovoOrario = giornoSettimana[newDay.getDay()] + " - " + $("#orario").val().split(" - ")[1];
                //$("#orario").val(nuovoOrario);
                //var nuovoOrario = giornoSettimana[newDay.getDay()];
                $("#idGiorno").val(newDay.getDay());
                $scope.idGiorno = $("#idGiorno").val();
                $("#giorno").val(giornoSettimana[newDay.getDay()]);

                //var id = parametri.idKey;
                //parametri.campoID[id] = idKey;
                //getOfferte(parametri);
            };

            $scope.nuovaScheda = function () {
                $scope[parametri.scheda] = true;
                $scope.schedaNew = true;
            
                elencoCampiGenera.forEach(function (campo) {
                    $scope[campo] = undefined;
                    $("#" + campo).val(undefined);
                });

                elencoCampiProfessore.forEach(function (campo) {
                    $scope[campo] = 0;
                    $("#" + campo).val(0);
                });
                $scope.aggiorna = 0;

                idKey = 0;
                var id = parametri.idKey;
                parametri.campoID[id] = idKey;

                var elencoCampi = parametri.elencoCampi;
                elencoCampi.forEach(function (campo) {
                    $("#" + campo).val("");
                    $scope[campo] = $("#" + campo).val();
                });

                //$("#Attivo").prop("checked", false)
            };

            $scope.salvaScheda = function (azione, aggiornaPiano) {
                $scope.cambia = false;
                $scope.schedaNew = false;
                //$scope.riprogramma = false;
                $scope[parametri.scheda] = false;

                switch (parseInt(aggiornaPiano)) {
                    case 1:
                        parametri.campoID.dataIniziale = $("#dataIniziale").val();
                        parametri.campoID.dataFinale = $("#dataFinale").val();
                        parametri.campoID.idProfessore = 0;
                        parametri.ponteFestivo = $scope.ponteFestivo ? 1 : 0;
                        parametri.preFestivo = $scope.preFestivo ? 1 : 0;
                        azione = "C";
                        break;

                    case 2:
                        parametri.campoID.dataIniziale = $("#sospendiInizio").val();
                        parametri.campoID.dataFinale = $("#sospendiFine").val();
                        parametri.campoID.idProfessore = $("#idProfessoreS").val().indexOf("number") > 0 ? 0 : $("#idProfessoreS").val();
                        parametri.erase = 0;
                        azione = "D";
                        break;

                    case 3:
                        parametri.campoID.dataIniziale = $("#sospendiInizioE").val();
                        parametri.campoID.dataFinale = $("#sospendiFineE").val();
                        parametri.campoID.idProfessore = $("#idProfessoreE").val().indexOf("number") > 0 ? 0 : $("#idProfessoreE").val();
                        parametri.erase = 1;
                        azione = "D";
                        console.log(typeof $("#idProfessoreE").val());
                        console.log($("#idProfessoreE").val());
                        break;

                    case 4:
                        parametri.campoID.dataIniziale = $("#riattivaInizio").val();
                        parametri.campoID.dataFinale = $("#riattivaFine").val();
                        parametri.campoID.idProfessore = $("#idProfessoreA").val().indexOf("number") > 0 ? 0 : $("#idProfessoreA").val();
                        parametri.idStatusAttiva = 5;
                        azione = "R";
                        break;

                    case 5:
                        parametri.campoID.dataIniziale = $("#riattivaInizioC").val();
                        parametri.campoID.dataFinale = $("#riattivaFineC").val();
                        parametri.campoID.idProfessore = $("#idProfessoreC").val().indexOf("number") > 0 ? 0 : $("#idProfessoreC").val();
                        parametri.idStatusAttiva = 5;
                        azione = "R";
                        break;
                };

                updOfferta(parametri, azione);
            };

            $scope.annullaScheda = function () {
                $scope.schedaNew = false;
                elencoCampiGenera.forEach(function (campo) {
                    $scope[campo] = undefined;
                    $("#" + campo).val(undefined);
                });

                elencoCampiProfessore.forEach(function (campo) {
                    $scope[campo] = 0;
                    $("#" + campo).val(0);
                });
                $scope.aggiorna = 0;

                if ($scope.riprogramma) {
                    $scope.riprogramma = false;
                    $scope[parametri.scheda] = false;
                    $scope.cambia = false;
                    idStudenteR = 0;
                    $scope.scheda("X");
             
                } else {
                    if (!parametri || !$scope[parametri.scheda]) {
                        idKey = 0;
                        $scope.cambia = false;
                        $scope.userLogged = false;
                        window.location.href = "#/main";
                    } else {
                        if ($scope.cambia) {
                            var id = parametri.idKey;
                            parametri.campoID[id] = idKey;
                            //console.log(idKey);
                            getOfferte(parametri);
                        } else {
                            idKey = 0;
                            $scope[parametri.scheda] = false;
                        };
                    };
                };
                //console.log($scope.riprogramma);
            };

        } else {
            Auth.from = "#/prenota";
            window.location.href = mobile ? "#/main" : "#/utentiLogin";
        };

    });
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();