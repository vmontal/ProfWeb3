//------------------------------Begin ctrl-anagrafe controller--------------------------------------------//
'use strict';

(() => {

    var anagrafe = angular.module("anagrafe", []);

    anagrafe.controller("ctrl-anagrafe", ($scope, $http, dataUser, Auth, mask) => {
        //Auth.userLogged = true;
        //console.log(dataUser.userID);
        var largo = $(window).width();
        //var alto = $(window).height();

        var mobile = largo < 768 ? true : false;

        if (Auth.userLogged && Auth.ruoloModifica && !mobile) {
            $("#schedaAnagrafe").show();
            //console.log($scope.from);
            const larghezza = parseInt($("#hAnagrafe").width() * 1);

            $scope.cambia = false;
            $scope.cambiaRicevuta = false;
            $scope.nuovaEmail = false;
            $scope.delete = false;
            $scope.selectStud = false;  //isolato verificare utilizzo!    
            $scope.framePDF = false;
            //$scope.frameRicevuta = false;
            $scope.schedaLezNew = false;
            $scope.tabMenu = "x";
            $scope.msgResetPW = false;
            $scope.editConvocazione = false;
            $scope.tabellaCassa = true;
            //console.log(Auth.idSede);
            $scope.luogo = Auth.luogo;
            $scope.db = Auth.db;
            $scope.as = Auth.as;
            $scope.loggedUser = dataUser.userID;
            $scope.versione = adesso();
            $scope.vista = (vista) => {
                return vista == Auth.vista;
            };

            $scope.admin = Auth.ruoloAdmin;
            $scope.gestione = Auth.ruoloGestione;
            $scope.modifica = Auth.ruoloModifica;
            $scope.lettura = Auth.ruoloLettura;
            $scope.ragioneSociale = dataUser.ragioneSociale;
            $scope.idRS = dataUser.idRS;
            $scope.path = dataUser.path;
            $scope.insert = false;

            var parametri;
            var insert = false;
            var lezione = false;
            var orarioCambia = false;
            var calendarioCambia = false;
            var prenotaCambia = false;
            var imgKO = "ack-KO.png";
            var imgOK = "ack-OK.png";
            var anniSelect = "";
            var idKeyClick = {};
            var emailValidata = true;
            var jsonOutput;
            var avvioCalendario;
            var myEvent;
            const modal = "tabella";
            const d = new Date();

            const openFile = (myEvent) => {
                let input = myEvent.target;
                let dataURL = new String;

                let reader = new FileReader();
                reader.onload = function () {
                    dataURL = reader.result;
                };

                reader.onloadend = function () {
                    let aggiorna = {};
                    aggiorna.file = dataURL.replace(/^[^,]*,/, '');
                    aggiorna.path = dataUser.path; // parametri.path;
                    aggiorna.filename = "assId" + Auth.idRS + "-sedeId" + Auth.idSede + ".jpg";

                    let criterio = JSON.stringify(aggiorna);
                    console.log(criterio);
                    $.ajax({
                        type: "POST",
                        url: "/dati/aspnet/appGetData.aspx/uploadFile",
                        data: criterio,
                        cache: false,
                        contentType: "application/json;",
                        dataType: "json",
                        success: (response) => {
                            console.log(response.d);
                            $("#upload").prop("disabled", false);
                            $("#upload").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Carica File e aggiorna DB');
                            $("#btn_loadFile").hide();
                            $scope.fileLogo = window.location.origin + "/img/logo/" + "assId" + Auth.idRS + "-sedeId" + Auth.idSede + ".jpg?ver=" + adesso();
                            $scope.$apply();
                        }, //readPDF(path); },
                        error: (err) => { console.log(err.responseText) }

                    });
                };

                reader.readAsDataURL(input.files[0]);
            };

            const elencoOreZero = [
                { idSede: "0", idOra: "1", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" },
                { idSede: "0", idOra: "2", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" },
                { idSede: "0", idOra: "3", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" },
                { idSede: "0", idOra: "4", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" },
                { idSede: "0", idOra: "5", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" },
                { idSede: "0", idOra: "6", ora: "00:00:00", Lezioni: "0", oraAttiva: "0" }
                ];

            const getOra = () => {
                let elencoOre = Auth.elencoOre;
                    elencoOre = elencoOre.filter((record) => {
                    return record.idSede == Auth.idSede;
                });
                //console.log(elencoOre, elencoOre.length);
                return elencoOre.length !== 0 ? elencoOre : elencoOreZero;
            };

            const getLezione = (e, cell) => {
                let value = cell.getValue();
                orarioCambia = true;
                if (value) {
                    //console.log(value);
                    let idKey = value.split("id:")[1];
                    let id = parametri.idKey;
                    let nomeProf = value.split(",")[0].split(":")[1];
                    let materiaLez = value.split(",")[1].split(":")[1];
                    let anniLez = value.split(",")[2].split(":")[1];
                    let freqLez = value.split(",")[3].split(":")[1];

                    let elencoProf = $scope.elencoProfessori;
                    $scope.elencoProfessoriLez = elencoProf.filter(function (prof) {
                        return prof.nomeProf == nomeProf;
                    });
                    let elencoProfLez = $scope.elencoProfessoriLez;
                    $scope.selectProf = elencoProfLez[0].idProfessore;

                    let elencoMat = $scope.elencoMaterie;
                    $scope.elencoMaterieLez = elencoMat.filter(function (mat) {
                        return mat.materia == materiaLez;
                    });
                    let elencoMaterieLez = $scope.elencoMaterieLez;
                    $scope.selectMat = elencoMaterieLez[0].idMateria;

                    $scope.selectAnni = anniLez;
                    $scope.selectFreq = freqLez;

                    parametri = parPlan;
                    parametri.campoID[id] = -1;
                    parametri.campoID["idProfessore"] = $scope.selectProf;
                    parametri.campoID["idMateria"] = $scope.selectMat;
                    $scope.scheda("Z");
                    $scope.$apply();
                };
            };

            const orarioToggle = function (e, cell) {
                if ($scope.gestione){
                    let data = cell.getData();
                    let field = cell.getField();
                    let value = parseInt(cell.getValue());

                    let newOrario = {};
                    newOrario.idSede = data.idSede;
                    newOrario.idGiorno = data.idGiorno;
                    newOrario.idOra = field.split("Ora")[1];
                    console.log(value);
                    if (value === -1) {
                        value = 1;
                        newOrario.value = value;
                        updAnagrafe(parametri, false, false, true, newOrario, false, false);
                    } else if (value === 0) {
                        value = 0;
                        newOrario.value = value;
                        updAnagrafe(parametri, false, false, true, newOrario, false, false);
                    } else if (value) {
                        infoDialog("Attenzione","Questa operazione non può essere eseguita per la presenza di lezioni prenotabili!")
                    } else {
                        
                    };
                    orarioCambia = true;
                } else {
                   infoDialog("Attenzione","Operazione non autorizzata con il tuo profilo");
                };
            };

            const calendarioToggle = function (e, cell) {
                if ($scope.gestione) {
                    let data = cell.getData();
                    let campo = !cell.getValue() ? "*" : cell.getValue();
                    //var field = cell.getField();
                    let value = parseInt(campo.split("*")[0]);
                    let lezioni = parseInt(campo.split("L")[1]);
                    //console.log(data);
                    //console.log(value);
                    //console.log(lezioni);
                    if (lezioni == 0){
                        let setCalendario = {};
                        setCalendario.idSede = data.idSede;
                        setCalendario.idRS = Auth.idRS;
                        setCalendario.giorno = creaData(data.anno, data.idMese, value < 0 ? value*(-1) : value);
                        //setCalendario.giorno = value < 0 ? value*(-1) : value;
                        //setCalendario.idMese = data.idMese;
                        //setCalendario.anno = data.anno;
                        console.log(value);
                        if (value < 0) {
                            setCalendario.attivo = 1;
                            updAnagrafe(parametri, false, false, true, setCalendario, false, false);
                        } else if (value > 0) {
                            setCalendario.attivo = -1;
                            updAnagrafe(parametri, false, false, true, setCalendario, false, false);
                        } else {
                            infoDialog("Attenzione","Giornata non lavorativa")
                        };                       
                    } else if (lezioni) {
                        infoDialog("Attenzione", "Non puoi eseguire il comando perché sono presenti delle prenotazioni per la giornata selezionata")
                    } else {
                        
                    };
                    calendarioCambia = true;
                } else {
                    infoDialog("Attenzione","Operazione non autorizzata con il tuo profilo");
                };
            };

            const prenotaToggle = (e, cell) => {
                e.preventDefault();
                let data = cell.getData();
                let field = cell.getField();
                let value = parseInt(cell.getValue().split("//")[1]);
                prenotaCambia = true;
                //console.log(value);
                if (value == -1 || value == 0) {
                    data.idOrario = data.idGiorno + field.split("Ora")[1];
                    data.value = cell.getValue().split("//")[0];
                    data.idRS = Auth.idRS;
                    let elimina = value == "0" ? true : false;
                    updAnagrafe(parametri, false, true, false, data, elimina, false);
                } else if (value > 0){
                    infoDialog("Attenzione","Non puoi completare l'operazione per la presenza di lezioni già prenotate!")
                };
            };

            var parStudenti, parProfessori, parUtenti, parSoci, parRuoli, parTipoSocio, parTipoProf, parOrigine,
                parSedi, parIstituti, parMaterie, parGruppi, parLezioni,
                parCassa, parCausali, parDoc, parTipoCassa, parSpecial,
                parOre, parGiorni, parMesi, parElenco, parCalendario, parOrari, parPlan,
                parAssemblee, parComunicazioni;

            $http.get("/dati/json/privacy_idRS" + dataUser.idRS + ".json?ver=" + adesso())
                .then((response) => {
                    //console.log("/dati/json/privacy_idRS" + dataUser.idRS + ".json?ver=" + adesso());

                    $scope.dropPrivacy = response.data;

                    parSedi = {
                        idKey: "idSede",
                        campoID: { idSede: 0, idRS: dataUser.idRS },
                        tabella: "Sedi",
                        //spCreate: "pf_parSediCreate",
                        spRead: "pf_parSediRead",
                        spUpdate: "pf_parSediUpdate",
                        //spDelete: "pf_parSediDelete",
                        elencoCampi: ["idSede", "descrizioneSede", "indirizzoSede", "luogoSede", "capSede", "provSede", "tel1Sede", "tel2Sede", "emailSede", "deletedSede"],
                        campiTabella: [
                            { title: "", field: "idSede", visible: false },
                            { title: "Elenco Sedi", field: "descrizioneSede", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Indirizzo", field: "indirizzoSede", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Luogo", field: "luogoSede", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                            { title: "Telefono 1", field: "tel1Sede", width: parseInt(larghezza * 0.15), sorter: "string", align: "center", headerFilter: true, responsive: 3 },
                            { title: "Telefono 2", field: "tel2Sede", width: parseInt(larghezza * 0.15), sorter: "string", align: "center", headerFilter: true, responsive: 4 },
                        ],
                        campiRichiesti: ["descrizioneSede", "indirizzoSede", "luogoSede", "emailSede"],
                        campiCheck: ["deletedSede"],
                        campoRS: ["idRS"],
                        sede: true,
                        scheda: "schedaSede",
                        drop: false,
                        dropElenco: "elencoSedi",
                        plan: false,
                        livello: $scope.admin,
                        insert: $scope.admin
                    };

                    parSoci = {
                        idKey: "ID",
                        campoID: { ID: 0, idRS: dataUser.idRS },
                        tabella: "Soci",
                        //spCreate: "",
                        spRead: "pf_anagrafeSociRead",
                        //spUpdate: "",
                        //spDelete: "",
                        elencoCampi: ["ID", "nominativo", "email", "idTipo", "capSede", "tipoSocio", "sedi"],
                        campiTabella: [
                            { title: "", field: "ID", visible: false, responsive: 1 },
                            { title: "Nominativo", field: "nominativo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Email", field: "email", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Telefono", field: "tel1", width: parseInt(larghezza * 0.10), sorter: "string", align: "right", headerFilter: true, responsive: 1 },
                            { title: "Ruolo", field: "tipoSocio", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Tipo", field: "tipo", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                        ],
                        campiRichiesti: ["nominativo", "email", "idTipo"],
                        //campiCheck: [""],
                        sede: true,
                        scheda: "schedaSocio",
                        drop: false,
                        dropElenco: "elencoSoci",
                        plan: false,
                        livello: false,
                        insert: false
                    };

                    parAssemblee = {
                        idKey: "idAss",
                        campoID: { idAss: 0, idRS: dataUser.idRS, idTipoAss: 'x', tipoAss: "Ass" },
                        tabella: "Assemblee",
                        //spCreate: "",
                        spRead: "admAssembleeRead",
                        spUpdate: "admAssembleeUpdate",
                        //spDelete: "",
                        elencoCampi: ["idAss", "dataAss", "oraAss", "luogoAss", "indirizzoAss", "oggettoAss", "dataInvio", "inviata", "straord", "conferma"],
                        campiTabella: [
                            { title: "", field: "idAss", visible: false },
                            { title: "Convocazione", field: "tipoAss", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Data", field: "dataAss", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                            { title: "Ora", field: "oraAss", width: parseInt(larghezza * 0.05), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                            { title: "Luogo", field: "luogoAss", width: parseInt(larghezza * 0.10), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Indirizzo", field: "indirizzoAss", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Oggetto", field: "oggettoAss", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Data Invio", field: "dataInvio", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                            { title: "Inviata", field: "inviata", width: parseInt(larghezza * 0.10), formatter: mask.cellDisattiva, headerFilter: false, responsive: 1 },

                        ],
                        campiText: ["idTipoAss", "tipoAss", "dataAssPrima"],
                        campiEditor: ["odgAss"],
                        campiRichiesti: ["dataAss", "oraAss", "luogoAss", "indirizzoAss", "oggettoAss"],
                        campiCheck: ["inviata", "straord"],
                        campoRS: ["idRS"],
                        sede: true,
                        scheda: "schedaAssemblea",
                        drop: true,
                        dropGet: [parSoci],
                        dropElenco: "elencoAssemblee",
                        plan: false,
                        livello: $scope.admin,
                        insert: $scope.admin
                    };

                    parComunicazioni = {
                        idKey: "idAss",
                        campoID: { idAss: 0, idRS: dataUser.idRS, idTipoAss: 'C', tipoAss: "Con"},
                        tabella: "Assemblee",
                        //spCreate: "",
                        spRead: "admAssembleeRead",
                        spUpdate: "admAssembleeUpdate",
                        //spDelete: "",
                        elencoCampi: ["idAss", "oggettoAss", "dataInvio", "inviata", "conferma"],
                        campiTabella: [
                            { title: "", field: "idAss", visible: false},                           
                            { title: "Oggetto", field: "oggettoAss", width: parseInt(larghezza * 0.70), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Data Invio", field: "dataInvio", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: true, responsive: 1 },
                            { title: "Inviata", field: "inviata", width: parseInt(larghezza * 0.10), formatter: mask.cellDisattiva, headerFilter: false, responsive: 1 },
                        ],
                        campiText: ["idTipoAss", "tipoAss", "dataAssPrima"],
                        campiEditor: ["odgAss"],
                        campiRichiesti: ["oggettoAss"],
                        campiCheck: ["inviata", "straord"],
                        campoRS: ["idRS"],
                        sede: true,
                        scheda: "schedaAssemblea",
                        drop: true,
                        dropGet: [parStudenti],
                        dropElenco: "elencoAssemblee",
                        plan: false,
                        livello: $scope.admin,
                        insert: $scope.admin
                    };

                    parIstituti = {
                        idKey: "CODICEISTITUTO",
                        campoID: { CODICEISTITUTO: 0, idRS: dataUser.idRS },
                        tabella: "Istituti",
                        spCreate: "pf_anagrafeIstitutiCreate",
                        spRead: "pf_anagrafeIstitutiRead",
                        spUpdate: "pf_anagrafeIstitutiUpdate",
                        spDelete: "pf_anagrafeIstitutiDelete",
                        elencoCampi: ["CODICEISTITUTO", "ISTITUTO", "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA", "INDIRIZZO", "CAP", "COMUNE", "PROVINCIA", "REGIONE", "INDIRIZZOEMAILSCUOLA", "INDIRIZZOPECSCUOLA", "SITOWEBSCUOLA", "deleteI"],
                        campiTabella: [
                            { title: "", field: "CODICEISTITUTO", visible: false },
                            { title: "Elenco Istituti", field: "ISTITUTO", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Tipo", field: "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                            { title: "Indirizzo", field: "INDIRIZZO", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 3 },
                        ],
                        campiRichiesti: ["ISTITUTO", "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"],
                        campiCheck: ["deleteI"],
                        campoRS: ["idRS"],
                        scheda: "schedaIst",
                        drop: false,
                        dropElenco: "elencoIstituti",
                        plan: false,
                        livello: $scope.modifica,
                        insert: $scope.modifica
                    };

                    parCausali = {
                        idKey: "idCausale",
                        campoID: { idCausale: 0, idRuolo: dataUser.idRuolo },
                        tabella: "Causali",
                        spRead: "admCassaCausaliRead",
                        elencoCampi: ["idCausale", "descCausale"],
                        dropElenco: "elencoCausali"
                    };

                    parSpecial = {
                        idKey: "idSpecial",
                        campoID: { idSpecial: 0 },
                        tabella: "Special",
                        spRead: "pf_parSpecialRead",
                        elencoCampi: ["idSpecial", "special"],
                        dropElenco: "elencoSpecial"
                    };

                    parDoc = {
                        idKey: "idDoc",
                        campoID: { idDoc: 0 },
                        tabella: "Documento",
                        spRead: "admCassaDocRead",
                        elencoCampi: ["idDoc", "descDoc"],
                        dropElenco: "elencoDoc"
                    };

                    parTipoCassa = {
                        idKey: "idRuolo",
                        campoID: { idRuolo: dataUser.idRuolo, idRS: dataUser.idRS },
                        tabella: "TipoCassa",
                        spRead: "admCassaTipoRead",
                        elencoCampi: ["idSede", "descrizioneSede", "ruolo"],
                        dropElenco: "elencoTipoCassa"
                    };

                    parCassa = {
                        idKey: "idMov",
                        campoID: { idMov: 0, idRuolo: dataUser.idRuolo, idRS: dataUser.idRS},
                        tabella: "Cassa",
                        spRead: "admCassaMovimentiRead",
                        spUpdate: "admCassaMovimentiUpdate",
                        elencoCampi: ["idMov", "idProg", "idCausale", "idDoc", "idTipoCassa", "dataMovGMA", "importoMov", "soggettoMov", "codiceFiscaleMov", "notaMov", "deletedMov", "banca"],
                        campiTabella: [
                            { title: "Nr Doc", field: "idProg", width: parseInt(larghezza * 0.07), align: "center", headerFilter: true, responsive: 1 },
                            { title: "Data", field: "dataMovGMA", width: parseInt(larghezza * 0.07), sorter: "string", align: "center", headerFilter: true, responsive: 0 },
                            { title: "Nominativo", field: "soggettoMov", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Causale", field: "descCausale", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Tipo Doc", field: "descDoc", width: parseInt(larghezza * 0.10), sorter: "string", align: "left", headerFilter: true, responsive: 1 },
                            { title: "Importo", field: "importoMov", width: parseInt(larghezza * 0.10), formatter: mask.moneyFormatter, sorter: "number", align: "right", headerFilter: true, responsive: 1 },
                            { title: "Segno", field: "segno", width: parseInt(larghezza * 0.07), formatter: mask.cellSegno, headerFilter: false },
                            { title: "Status", field: "deletedMov", width: parseInt(larghezza * 0.07), formatter: mask.cellAnnullata, headerFilter: false },

                        ],
                        dropElenco: "elencoCassa",
                        campiCheck: ["deletedMov"],
                        campiRichiesti: ["dataMovGMA", "idCausale", "idDoc", "idTipoCassa", "importoMov", "soggettoMov"],
                        campiNumerici: ["importoMov"],
                        codiceFiscale: true,
                        campoCodiceFiscale: "codiceFiscaleMov",
                        drop: true,
                        scheda: "schedaCassa",
                        pdf: true, // $scope.causaleEntrata(), //
                        dropGet: [parCausali, parDoc, parTipoCassa],
                        schedaNuova: parCassa,
                        plan: false,
                        livello: true,
                        insert: true,
                        ricevuta: true,
                        framePDF: "frameReportPDFCassa",
                    };

                    parRuoli = {
                        idKey: "idRuolo",
                        campoID: { idRuolo: 0 },
                        tabella: "Ruoli",
                        spRead: "admRuoliRead",
                        elencoCampi: ["idRuolo", "ruolo"],
                        dropElenco: "elencoRuoli"
                    };

                    parOrigine = {
                        idKey: "idOrigine",
                        campoID: { idOrigineStud: 0 },
                        tabella: "Origine",
                        spRead: "admOrigineStudRead",
                        elencoCampi: ["idOrigineStud", "origineStud"],
                        dropElenco: "elencoOrigine"
                    };

                    parTipoSocio = {
                        idKey: "idTipoSocio",
                        campoID: { idTipoSocio: 0 },
                        tabella: "Soci",
                        spRead: "admTipoSocioRead",
                        elencoCampi: ["idTipoSocio", "tipoSocio"],
                        dropElenco: "elencoTipoSocio"
                    };

                    parTipoProf = {
                        idKey: "idTipoProf",
                        campoID: { idTipoProf: 0 },
                        tabella: "Tipo",
                        spRead: "admTipoProfRead",
                        elencoCampi: ["idTipoProf", "tipoProf"],
                        dropElenco: "elencoTipoProf"
                    };

                    parUtenti = {
                        idKey: "id",
                        campoID: { id: 0, idRS: dataUser.idRS, idSede: Auth.idSede, idRuolo: dataUser.idRuolo },
                        tabella: "Utenti",
                        spCreate: "",
                        spRead: "admUtentiRead",
                        spUpdate: "admUtentiUpdate",
                        spDelete: "",
                        elencoCampi: ["id", "cognome", "nome", "idRuolo", "idTipoSocioUser", "attivo", "emailUser", "emailCheck", "tel1User", "tel2User", "indirizzoUser", "comuneUser", "provUser", "capUser", "codiceFiscaleUser", "dataNascitaUser", "luogoNascitaUser", "sediUser", "privacyUser", "liberaUser", "firmaUser", "firmaDataUser"],
                        campiTabella: [
                            { title: "id",       field: "id", visible: false },
                            { title: "Cognome",  field: "cognome",  width: parseInt(larghezza * 0.12), sorter: "string", headerFilter: true  },
                            { title: "Nome",     field: "nome",     width: parseInt(larghezza * 0.12), sorter: "string", headerFilter: true },
                            //{ title: "UserName", field: "username", width: parseInt(larghezza * 0.15), headerFilter: true },
                            { title: "Email",  field: "emailUser",width: parseInt(larghezza * 0.20), sorter: "string", headerFilter: true },
                            { title: "Ruolo",  field: "ruolo",    width: parseInt(larghezza * 0.08), sorter: "string", headerFilter: true },
                            { title: "Primo Accesso", field: "registra", width: parseInt(larghezza * 0.08), sorter: "date", align: "center" },
                            { title: "Ultimo Accesso",field: "ultimo",   width: parseInt(larghezza * 0.08), sorter: "date", align: "center" },
                            { title: "Privacy", field: "privacyUser", width: parseInt(larghezza * 0.08), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Email Validata", field: "emailCheck", width: parseInt(larghezza * 0.08), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Attivo", field: "attivo", width: parseInt(larghezza * 0.08), formatter: mask.cellDisattiva, headerFilter: false }, //   width: parseInt(larghezza * 0.08), align: "center", headerFilter: true, formatter: "tickCross" },
                        ],
                        campiRichiesti: ["cognome", "nome", "emailUser"],
                        campiPrivacy: [
                            ["privacyUser", "liberaUser", "firmaUser", "firmaDataUser"],
                            [$scope.dropPrivacy.informativa.text, $scope.dropPrivacy.trattamento.text, "Modulo firmato", "Data Firma"]
                        ],
                        campiStampa: [
                            ["cognome", "nome", "emailUser", "tel1User", "tel2User", "indirizzoUser", "comuneUser", "provUser", "capUser", "dataNascitaUser", "luogoNascitaUser", "codiceFiscaleUser"],
                            ["Cognome", "Nome", "Email", "Telefono Principale", "Telefono Altro", "Indirizzo", "Comune", "Prov.", "CAP", "Data di Nascita", "Luogo di Nascita", "Codice Fiscale"]
                        ],
                        titoloReport: "Modulo Adesione Volontario - Anno Scolastico: " + $scope.as,
                        framePDF: "frameReportPDFUser",
                        campiCheck: ["attivo", "privacyUser", "liberaUser", "firmaUser"],
                        campiDefault: {idRuolo: "4", idTipoSocioUser: "0"},
                        scheda: "schedaUser",
                        pdf: true,
                        codiceFiscale: true,
                        campoCodiceFiscale: "codiceFiscaleUser",
                        drop: true,
                        dropGet: [parRuoli, parTipoSocio, parSedi],
                        dropElenco: "elencoUtenti",
                        plan: false,
                        campoSede: "sediUser",
                        campoRS: ["idRS"],
                        login:{user: "username", pass: "password", email: "emailUser"},
                        user: true,
                        livello: $scope.modifica,
                        insert: $scope.gestione,
                        ricevuta: false
                    };

                    parGruppi = {
                        idKey: "idGruppo",
                        campoID: { idGruppo: 0 },
                        tabella: "Gruppi",
                        spRead: "pf_parMaterieGruppoRead",
                        spUpdate: "pf_parMaterieGruppoUpdate",
                        elencoCampi: ["idGruppo", "gruppo"],
                        dropElenco: "elencoGruppi"
                    };

                    parGiorni = {
                        idKey: "idGiorno",
                        campoID: { idGiorno: 0 },
                        tabella: "Giorni",
                        spRead: "pf_parGiorniRead",
                        spUpdate: "pf_parGiorniUpdate",
                        elencoCampi: ["idGiorno", "giorno"],
                        campiTabella: [
                            { title: "ID", field: "idGiorno", width: parseInt(larghezza * 0.10), sorter: "string", align: "left", headerFilter: false, headerSort: false, responsive: 0 },
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, headerSort: false, responsive: 0 },
                        ],
                        campiRichiesti: ["idGiorno"],
                        scheda: "schedaGio",
                        drop: true,
                        dropGet: [parOre, parGiorni],
                        dropElenco: "elencoGiorni"
                    };

                    parMesi = {
                        idKey: "idMese",
                        campoID: { idMese: 0, idSede: Auth.idSede },
                        tabella: "Mesi",
                        spRead: "pf_parMesiRead",
                        dropElenco: "elencoMesi"
                    };

                    parElenco = {
                        idKey: "idOrario",
                        campoID: { idOrario: 0, idSede: Auth.idSede },
                        tabella: "Orari",
                        sede: true,
                        spRead: "pf_parOrariRead",
                        spUpdate: "pf_parOrariUpdate",
                        elencoCampi: ["idOrario", "orario", "idGiorno", "giorno", "idOra", "ora"],
                        campiTabella: [
                            { title: "ID", field: "idOrario", visible: false },
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza * 0.40), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Ora", field: "ora", width: parseInt(larghezza * 0.40), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                        ],
                        campiSelect: [
                            { title: "ID", field: "idOrario", width: parseInt(larghezza / 3 * 0.00), align: "left", headerFilter: false, headerSort: false, visible: false },
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza / 3 * 0.40), align: "left", headerFilter: true, headerSort: false, responsive: 0 },
                            { title: "Ora", field: "ora", width: parseInt(larghezza / 3 * 0.40), align: "left", headerFilter: true, headerSort: false, responsive: 0 },
                        ],
                        tabSelect: false,
                        campiSelectable: 1,
                        campiSelected: [],
                        tabellaSelect: "tabOrari",
                        tabellaHidden: [],
                        clearGet: [],
                        rowHigh: "50px",
                        campiRichiesti: ["idGiorno", "idOra"],
                        scheda: "schedaOrario",
                        drop: true,
                        dropGet: [parOre, parGiorni],
                        dropElenco: "elencoOrari",
                        livello: $scope.modifica,
                        insert: $scope.modifica
                    };

                    parCalendario = {
                        idKey: "idGiorno",
                        campoID: { idGiorno: 0, giorno: oggi(0), idMese: d.getMonth() + 1, idSede: Auth.idSede, idRS: Auth.idRS },
                        tabella: "Calendario",
                        sede: true,
                        spCreate: "pf_parCalendarioCreate",
                        spRead: "pf_parCalendarioRead",
                        spUpdate: "pf_parCalendarioUpdate",
                        elencoCampi: ["dataInizio", "dataFine"], // ["idSede", "giorno", "attivo"],
                        campiTabella: [                        
                            //{ title: "Mese",    field: "mese", width: parseInt(larghezza * 0.12), sorter: "string", align: "center", formatter: mask.cellBold,  headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Lunedì",    field: "LU", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Martedì",   field: "MA", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Mercoledì", field: "ME", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Giovedì",   field: "GI", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Venerdì",   field: "VE", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                            { title: "Sabato",    field: "SA", width: parseInt(larghezza * 0.11), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: calendarioToggle },
                        ],
                        campiRichiesti: ["dataInizio", "dataFine"],
                        campoRS: ["idRS", "idSede"],
                        rowHigh: "auto",
                        drop: true,
                        dropGet: [parMesi],
                        //campoGruppo: "mese",
                        scheda: "schedaCalendario",
                        livello: $scope.gestione,
                        insert: $scope.admin
                    };

                    parOre = {
                        idKey: "idOra",
                        campoID: { idOra: 0, idSede: Auth.idSede, idRS: dataUser.idRS },
                        tabella: "Ore",
                        sede: true,
                        spRead: "pf_parOreRead",
                        spUpdate: "pf_parOreUpdate",
                        elencoCampi: ["idOra", "ora", "Lezioni", "oraAttiva"],
                        campiTabella: [
                            { title: "Ora",    field: "idOra", width: parseInt(larghezza * 0.15), sorter: "string", align: "center", headerFilter: false, headerSort: false, responsive: 0 },
                            { title: "Orario", field: "ora", width: parseInt(larghezza * 0.25), sorter: "string", align: "center", headerFilter: false, headerSort: false, responsive: 0 },
                            { title: "Lezioni Prenotate", field: "Lezioni", width: parseInt(larghezza * 0.25), sorter: "number", align: "center", headerFilter: false, headerSort: false, responsive: 0 },
                        ],
                        rowHigh: "auto",
                        campiRichiesti: ["idOra", "ora"],
                        campiCheck: ["oraAttiva"],
                        scheda: "schedaOra",
                        campoRS: ["idSede"],
                        refresh: true,
                        drop: false,
                        dropGet: [parOre, parGiorni],
                        dropElenco: "elencoOre",
                        livello: $scope.gestione,
                        insert: false // $scope.admin
                    };

                    parOrari = {
                        idKey: "idOrario",
                        campoID: { idOrario: 0, idSede: Auth.idSede },
                        tabella: "Orari",
                        sede: true,
                        spRead: "pf_parOrariPivotRead",
                        spUpdate: "pf_parOrariUpdate",
                        spReadSelect: "pf_parOrariRead",
                        elencoCampi: ["idOrario", "orario", "idGiorno", "giorno", "idOra", "ora"],
                        campiTabella: [
                            //{ title: "ID", field: "idOrario", visible: false },
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellBold, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[0].oraAttiva == 1 ? getOra()[0].ora : "", field: "Ora1", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[1].oraAttiva == 1 ? getOra()[1].ora : "", field: "Ora2", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[2].oraAttiva == 1 ? getOra()[2].ora : "", field: "Ora3", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[3].oraAttiva == 1 ? getOra()[3].ora : "", field: "Ora4", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[4].oraAttiva == 1 ? getOra()[4].ora : "", field: "Ora5", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                            { title: getOra()[5].oraAttiva == 1 ? getOra()[5].ora : "", field: "Ora6", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellCheck, headerFilter: false, headerSort: false, responsive: 0, cellClick: orarioToggle },
                        ],
                        tabSelect: false,
                        campiSelectable: 1,
                        campiSelected: [],
                        tabellaSelect: "tabOrari",
                        tabellaHidden: [],
                        clearGet: [],
                        rowHigh: "auto",
                        //campiRichiesti: ["Ora1", "Ora2", "Ora3"], // ["idGiorno", "idOra"],
                        scheda: "schedaOrario",
                        drop: true,
                        dropGet: [parOre, parGiorni],
                        dropElenco: "elencoOrari",
                        livello: $scope.gestione,
                        insert: $scope.modifica
                    };

                    parPlan = {
                        idKey: "idLezione",
                        campoID: { idLezione: 0, idProfessore: 0, idMateria: 0, idSede: Auth.idSede, idRS: Auth.idRS },
                        tabella: "Plan",
                        plan: true,
                        spRead: "pf_pianoLezioniRead",
                        spUpdate: "pf_pianoLezioniUpdate",
                        elencoCampi: ["idLezione", "orario", "idGiorno", "giorno", "idOra", "ora"],
                        campiTabella: [
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellBold, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[0].oraAttiva == 1 ? getOra()[0].ora : "", field: "Ora1", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[1].oraAttiva == 1 ? getOra()[1].ora : "", field: "Ora2", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[2].oraAttiva == 1 ? getOra()[2].ora : "", field: "Ora3", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[3].oraAttiva == 1 ? getOra()[3].ora : "", field: "Ora4", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[4].oraAttiva == 1 ? getOra()[4].ora : "", field: "Ora5", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                            { title: getOra()[5].oraAttiva == 1 ? getOra()[5].ora : "", field: "Ora6", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", formatter: mask.cellPrenota, headerFilter: false, headerSort: false, responsive: 0, cellClick: prenotaToggle },
                        ],
                        tabSelect: false,
                        rowHigh: "auto",
                        scheda: "schedaLez",
                        livello: $scope.modifica
                    };

                    parMaterie = {
                        idKey: "idMateria",
                        campoID: { idMateria: 0, idRS: Auth.idRS },
                        tabella: "Materie",
                        spRead: "pf_parMaterieRead",
                        spUpdate: "pf_parMaterieUpdate",
                        spDelete: "pf_parMaterieDelete",
                        spReadSelect: "pf_parMaterieRead",
                        elencoCampi: ["idMateria", "materia", "idGruppo", "gruppo", "deleteM", "idRS", "richiesteStud", "richiesteProf"],
                        campiTabella: [
                            { title: "", field: "idMateria", visible: false },
                            //{ title: "Elenco " + parametri.tabella, field: "elenco", mutator: function (value, data, type, mutatorParams, cell) { return data[elencoCampi[1]] + " - " + data[elencoCampi[2]] + " - " + data[elencoCampi[3]] + " - " + data[elencoCampi[4]]; }, width: parseInt(larghezza * 0.80) * mobile, sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Materia", field: "materia", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Gruppo", field: "gruppo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                            { title: "Richiesta Studenti", field: "richiesteStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", formatter: mask.cellRichiestaStud, bottomCalc: "sum", headerFilter: false, responsive: 2 },
                            { title: "Offerta Professori", field: "richiesteProf", width: parseInt(larghezza * 0.10), sorter: "number", align: "center",                                    bottomCalc: "sum", headerFilter: false, responsive: 2 },
                        ],
                        campiCheck: ["deleteM"],
                        filtro: { elenco: "elencoProfessori", campoKey: "idProfessore", campoValue: "materiaProf" },
                        elencoFiltro: "elencoMaterieProf",
                        campiSelectable: 1,
                        tabellaSelect: "tabMaterie",
                        tabellaHidden: ["tabOrari"],
                        tabSelect: false,
                        clearGet: [parElenco],
                        campiSelect: [
                            { title: "id", field: "idMateria", width: parseInt(larghezza / 3 * 0.00), sorter: "string", align: "left", headerFilter: false, headerSort: false, visible: false }, //
                            { title: "Materia", field: "materia", width: parseInt(larghezza / 3 * 0.80), sorter: "string", align: "left", headerFilter: true, headerSort: false, responsive: 0 },
                        ],
                        campiSelected: [],
                        campiRichiesti: ["materia", "idGruppo"],
                        campoRS: ["idRS"],
                        scheda: "schedaMat",
                        drop: true,
                        dropGet: [parGruppi],
                        dropElenco: "elencoMaterie",
                        livello: $scope.modifica,
                        insert: $scope.modifica
                    };

                    parProfessori = {
                        idKey: "idProfessore",
                        campoID: { idProfessore: 0, idSede: Auth.idSede, idRS: dataUser.idRS },
                        tabella: "Professori",
                        spRead: "pf_anagrafeProfessoriRead",
                        spUpdate: "pf_anagrafeProfessoriUpdate",
                        spDelete: "pf_anagrafeProfessoriDelete",
                        spReadSelect: "pf_anagrafeProfessoriRead",
                        spVerificaEmail: "pf_anagrafeProfessoriVerificaEmail",
                        elencoCampi: ["idProfessore", "nomeProf", "emailProf", "emailCheck", "tel1Prof", "tel2Prof", "indirizzoProf", "comuneProf", "provProf", "capProf", "sediProf", "idTipoSocioProf", "idTipoProf", "dataNascitaProf", "luogoNascitaProf", "codiceFiscaleProf", "materiaProf", "lezioniPrenotate", "modoLezione", "privacyProf", "liberaProf", "firmaProf", "firmaDataProf", "notaProf", "deletedProf", "docTipoProf", "docNumeroProf", "docRilascioProf", "docDataEProf", "docDataSProf"],
                        campiTabella: [
                            { title: " ", field: "idProfessore", visible: false },
                            //{ title: "Elenco " + parametri.tabella, field: "elenco", mutator: function (value, data, type, mutatorParams, cell) { return data[elencoCampi[1]] + " - " + data[elencoCampi[2]] + " - " + data[elencoCampi[3]] + " - " + data[elencoCampi[4]]; }, width: parseInt(larghezza * 0.80) * mobile, sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Elenco Professori", field: "nomeProf", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "eMail", field: "emailProf", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                            { title: "Telefono", field: "tel1Prof", width: parseInt(larghezza * 0.10), sorter: "string", align: "left", headerFilter: true, responsive: 3 },
                            { title: "Tipo Prof", field: "tipoProf", width: parseInt(larghezza * 0.15), sorter: "string", align: "left", headerFilter: true, responsive: 4 },
                            //{ title: "Attivo",  field: "deletedProf", formatter: mask.cellAttiva,    headerFilter: false },
                            { title: "Privacy", field: "privacyProf", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Firma", field: "firmaProf", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Email", field: "emailCheck", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false },
                        ],
                        campiSelect: [
                            { title: "id", field: "idProfessore", width: parseInt(larghezza / 3 * 0.00), sorter: "string", align: "left", headerFilter: false, headerSort: false, visible: false },
                            { title: "Professori", field: "nomeProf", width: parseInt(larghezza / 3 * 0.80), sorter: "string", align: "left", headerFilter: true, headerSort: false, responsive: 0 },
                        ],
                        campiPrivacy: [
                            ["privacyProf", "liberaProf", "firmaProf", "firmaDataProf"],
                            [$scope.dropPrivacy.informativa.text, $scope.dropPrivacy.trattamento.text, "Modulo firmato", "Data Firma"]
                        ],
                        campiStampa: [
                            ["nomeProf", "emailProf", "tel1Prof", "tel2Prof", "indirizzoProf", "comuneProf", "provProf", "capProf", "dataNascitaProf", "luogoNascitaProf", "codiceFiscaleProf", "docTipoProf", "docNumeroProf", "docRilascioProf", "docDataEProf", "docDataSProf"],
                            ["Docente", "Email", "Telefono Principale", "Telefono Altro", "Indirizzo", "Comune", "Prov.", "CAP", "Data di Nascita", "Luogo di Nascita", "Codice Fiscale", "Documento", "Numero", "Rilasciato da", "In data", "Valido fino al" ]
                        ],
                        titoloReport: "Modulo Adesione Docente Volontario - Anno Scolastico: " + $scope.as,
                        framePDF: "frameReportPDFProf",
                        campiSelectable: 1,
                        campiSelected: [],
                        tabSelect: false,
                        //clearGet: [parMaterie, parElenco],
                        tabellaSelect: "tabProf",
                        tabellaHidden: ["tabMaterie", "tabOrari"],
                        campiRichiesti: ["nomeProf", "emailProf", "tel1Prof"],
                        campiCheck: ["deletedProf", "privacyProf", "liberaProf", "firmaProf"],
                        codiceFiscale: true,
                        campoCodiceFiscale: "codiceFiscaleProf",
                        scheda: "schedaProf",
                        pdf: true,
                        drop: true,
                        dropGet: [parMaterie, parGruppi, parSedi, parTipoSocio, parTipoProf],
                        dropElenco: "elencoProfessori",
                        campoMaterie: "materiaProf",
                        campoLezioni:"lezioniPrenotate",
                        campoSede: "sediProf",
                        campoRS: ["idRS"],
                        plan: false,
                        schedaNuova: parProfessori,
                        livello: $scope.modifica,
                        insert: $scope.modifica,
                        ricevuta: false
                    };

                    parLezioni = {
                        idKey: "idLezione",
                        campoID: { idLezione: 0, idProfessore: 0, idMateria: 0, idSede: Auth.idSede, idRS: Auth.idRS },
                        tabella: "Lezioni",
                        plan: true,
                        spRead: "pf_pianoLezioniRead",
                        spUpdate: "pf_pianoLezioniUpdate",
                        spDelete: "pf_pianoLezioniDelete",
                        elencoCampi: ["idLezione", "nomeProf", "materia", "orario", "anni", "idProfessoreLez", "idMateriaLez", "idOrarioLez"],
                        campiTabella: [
                            { title: "Giorno", field: "giorno", width: parseInt(larghezza * 0.06), formatter: mask.cellBold10, sorter: "string", align: "left", headerSort: false, headerFilter:true, responsive:0},
                            { title: getOra()[0].oraAttiva == 1 ? getOra()[0].ora : "", field: "Ora1", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[0].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                            { title: getOra()[1].oraAttiva == 1 ? getOra()[1].ora : "", field: "Ora2", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[1].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                            { title: getOra()[2].oraAttiva == 1 ? getOra()[2].ora : "", field: "Ora3", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[2].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                            { title: getOra()[3].oraAttiva == 1 ? getOra()[3].ora : "", field: "Ora4", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[3].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                            { title: getOra()[4].oraAttiva == 1 ? getOra()[4].ora : "", field: "Ora5", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[4].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                            { title: getOra()[5].oraAttiva == 1 ? getOra()[5].ora : "", field: "Ora6", width: parseInt(larghezza * 0.15), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: getOra()[4].oraAttiva == 1 ? true : false, headerSort: false, responsive: 0, cellClick: getLezione },
                        ],
                        campiRichiesti: ["idProfessoreLez", "idMateriaLez", "idOrarioLez", "anni"],
                        //campoGruppo: "giorno",
                        scheda: "schedaLez",
                        schedaNuova: parPlan,
                        tabSelect: false,
                        drop: true,
                        dropGet: [parProfessori, parMaterie],
                        dropElenco: "",
                        livello: $scope.modifica,
                        insert: $scope.modifica
                    };

                    parStudenti = {
                        idKey: "idStudente",
                        campoID: { idStudente: 0, idSede: Auth.idSede, idRS: dataUser.idRS },
                        tabella: "Studenti",
                        spRead: "pf_anagrafeStudentiRead",
                        spUpdate: "pf_anagrafeStudentiUpdate",
                        spDelete: "pf_anagrafeStudentiDelete",
                        spVerificaEmail: "pf_anagrafeStudentiVerificaEmail",
                        elencoCampi: ["idStudente", "nomeStud", "istitutoNome", "istitutoTipo", "emailStud", "emailStudAltro", "emailCheck", "tel1Stud", "tel2Stud", "indirizzoStud", "comuneStud", "provStud", "capStud", "anno", "codiceFiscaleStud", "codiceFiscaleGen", "dataNascitaStud", "luogoNascitaStud", "idOrigineStud", "notaStud", "sediStud", "materiaStud", "idIstituto", "idSpecial", "deletedStud", "privacyStud", "regolamentoStud", "liberaStud", "firmaStud", "firmaDataStud", "docTipoStud", "docNumeroStud", "docRilascioStud", "docDataEStud", "docDataSStud", "docTipoGen", "docNumeroGen", "docRilascioGen", "docDataEGen", "docDataSGen"],
                        campiTabella: [
                            { title: " ", field: "idStudente", visible: false },
                            //{ title: "Elenco " + parametri.tabella, field: "elenco", mutator: function (value, data, type, mutatorParams, cell) { return data[elencoCampi[1]] + " - " + data[elencoCampi[2]] + " - " + data[elencoCampi[3]] + " - " + data[elencoCampi[4]]; }, width: parseInt(larghezza * 0.80) * mobile, sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Elenco Studenti", field: "nomeStud", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                            { title: "Istituto", field: "istitutoNomeTipo" , width: parseInt(larghezza * 0.19), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                            { title: "Riferimenti", field: "contactStud", width: parseInt(larghezza * 0.19), formatter: mask.celltext, sorter: "string", align: "left", headerFilter: true, responsive: 3 },
                            { title: "Anno", field: "anno", width: parseInt(larghezza * 0.07), sorter: "number", align: "center", headerFilter: true, headerSort: false },
                            //{ title: "Attivo",  field: "deletedStud", formatter: mask.cellAttiva,    headerFilter: false },
                            { title: "Privacy", field: "privacyStud", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Regolamento", field: "regolamentoStud", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false },
                            { title: "Firma", field: "firmaStud", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false }, //, formatter: "tickCross" }
                            { title: "Email", field: "emailCheck", width: parseInt(larghezza * 0.05), formatter: mask.cellDisattiva, headerFilter: false }
                        ],
                        campiRichiesti: ["nomeStud", "idIstituto", "anno", "emailStud", "tel1Stud", "tel2Stud", "comuneStud", "provStud", "capStud", "indirizzoStud", "dataNascitaStud", "luogoNascitaStud", "idOrigineStud", "idSpecial"],
                        campiCheck: ["deletedStud", "privacyStud", "regolamentoStud", "liberaStud", "firmaStud"],
                        campiStampa: [
                            ["nomeStud", "idIstituto", "anno", "emailStud", "tel1Stud", "tel2Stud", "indirizzoStud", "comuneStud", "provStud", "capStud", "dataNascitaStud", "luogoNascitaStud", "codiceFiscaleStud", "codiceFiscaleGen", "idSpecial", "docTipoStud", "docNumeroStud", "docRilascioStud", "docDataEStud", "docDataSStud" ],
                            ["Studente", "Istituto Scolastico", "Anno", "Email", "Telefono Studente", "Telefono Genitore / Altro", "Indirizzo", "Comune", "Prov.", "CAP", "Data di Nascita", "Luogo di Nascita", "Codice Fiscale Studente", "Codice Fiscale Genitore", "Bisogni Speciali", "Documento", "Numero", "Rilasciato da", "In data", "Valido fino al"]
                        ],
                        titoloReport: "Modulo Iscrizione - Anno Scolastico: " + $scope.as,
                        framePDF: "frameReportPDFStud",
                        campiPrivacy: [
                            ["privacyStud", "liberaStud", "regolamentoStud", "campo", "campo", "firmaDataStud"],
                            [$scope.dropPrivacy.informativa.text, $scope.dropPrivacy.trattamento.text, $scope.dropPrivacy.firmaStudente.text, $scope.dropPrivacy.firmaStudente.studente, $scope.dropPrivacy.firmaStudente.genitore, "Data Firma"]
                        ],
                        codiceFiscale: true,
                        campoCodiceFiscale: "codiceFiscaleStud",
                        scheda: "schedaStud",
                        pdf: true,
                        drop: true,
                        dropGet: [parIstituti, parSedi, parOrigine, parCassa, parSpecial, parMaterie, parGruppi],
                        dropElenco: "",
                        campoSede: "sediStud",
                        campoMateriaStud: "materiaStud",
                        campoRS: ["idRS"],
                        plan: false,
                        schedaNuova: parStudenti,
                        livello: $scope.modifica,
                        insert: $scope.modifica,
                        ricevuta: false
                    };

            });

            $(".tempo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: "1M"
            });

            $(".tempoFuturo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: "11Y"
            });

            $(".calendario").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: "9M"
            });

            $(".tempo .calendario").datepicker($.datepicker.regional["it"]);

            var idKey = 0;

            $scope.scheda = (setTab) => {
                $scope.cambia = false;
                idKey = 0;
                console.log(setTab);
                switch (setTab) {
                    case "V":
                        parametri = parSedi;
                        break;

                    case "I":
                        parametri = parIstituti;
                        break;

                    case "M":
                        parametri = parMaterie;
                        break;

                    case "S":
                        parametri = parStudenti;
                        break;

                    case "P":
                        parametri = parProfessori;
                        break;

                    case "B":
                        parametri = parCassa;
                        break;

                    case "U":
                        parametri = parUtenti;
                        break;

                    case "A":
                        parametri = parSoci;
                        break;

                    case "C":
                        parametri = parCalendario;
                        avvioCalendario = true;
                        break;

                    case "O":
                        parametri = parOrari;
                        break;

                    case "H":
                        parametri = parOre;
                        break;

                    case "L":
                        parametri = parLezioni;
                        break;

                    case "AA":
                        parametri = parAssemblee;
                        parametri.campoID.idTipoAss = "S";
                        parametri.campoID.tipoAss = "Assemblea";
                        break;

                    case "AD":
                        parametri = parAssemblee;
                        parametri.campoID.idTipoAss = "D";
                        parametri.campoID.tipoAss="Direttivo"
                        break;

                    case "CO":
                        parametri = parComunicazioni;
                        parametri.campoID.idTipoAss = "C";
                        parametri.campoID.tipoAss = "Comunicazioni"
                        break;

                    case "Z":
                        //parametri = parPlan;
                        break;

                };
                console.log(parametri);

                if (setTab !== "Z") {
                    var id = parametri.idKey;
                    parametri.campoID[id] = 0;
                    $scope[parametri.scheda] = false;
                    $scope.tabMenu = setTab;
                };

                if (!$("#tabella" + parametri.tabella).hasClass("tabulator")) {
                    creaTabella(larghezza, parametri, () => {
                        getAnagrafe(parametri, modal, () => {
                            if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                                $("#tabella" + parametri.tabella).addClass("table-center");
                            };
                        });
                    });

                } else {
                    getAnagrafe(parametri, modal, () => {
                        if (!$("#tabella" + parametri.tabella).hasClass("table-center")) {
                            $("#tabella" + parametri.tabella).addClass("table-center");
                        };
                    });
                };

                if (parametri.campiEditor) {
                    let campiEditor = parametri.campiEditor;
                    campiEditor.forEach(campi => {
                        if (!$("#container-" + campi).has(".Editor-container")[0]) {
                            //$("#" + campi).Editor();
                            $("#" + campi).Editor({
                                "unlink": false, "insert_link": false, "insert_img": false, "insert_table": false,
                                "block_quote": false, "print": false, "togglescreen": false, "source":false,
                            });
                        };
                    });
                };

                if (parametri.campiEditor) {
                    $(".Editor-editor").focusin(function () {
                        $scope.cambia = true;
                        $scope.$apply();
                    });
                };

                $scope.insert = parametri.insert;

                $scope.verificaCF = function (tipo) {
                    if (parametri.codiceFiscale && $scope[parametri.scheda]) {
                        let myCF = $("#codiceFiscale" + tipo).val();
                        return controllaCF(myCF);
                    };
                };

            };

            $scope.isSelected = (checkTab) => {
                return $scope.tabMenu === checkTab;
            };

            $scope.showMenu = function () {
                if (!parametri) {
                    return !$scope.cambia;
                } else {
                    return !$scope.cambia && !$scope[parametri.scheda];
                };
            };

            $scope.showNew = function () {
                if (parametri.insert) {
                    return !$scope[parametri.scheda];                    
                } else {                    
                    return false;
                };
            };

            $scope.campiValidati = () => {
                let campiRichiesti = parametri.campiRichiesti;
                let campoCodiceFiscale = parametri.campoCodiceFiscale;
                let compilati = 1;
                let campiCompilati = 1
                campiRichiesti.forEach((campo) => {
                    campiCompilati = campiCompilati * (!$scope[campo] ? 0 : 1);
                    //console.log(campo, !$scope[campo], campiCompilati);
                });
                compilati = compilati * campiCompilati;

                if (parametri.codiceFiscale) {
                    let myCF = $("#" + campoCodiceFiscale).val();
                    let cf = !myCF ? 1 : controllaCF(myCF) == "OK" ? 1 : 0;
                    compilati = campiCompilati * cf;
                };

                if (parametri.campoSede) {
                    let sedeValidata = ($("#" + parametri.campoSede).val()).length > 0 ? 1 : 0;
                    compilati = compilati * sedeValidata;
                    console.log("campo:"+parametri.campoSede, "campoSedeVal:"+ $("#" + parametri.campoSede).val(), "sedeValidata:"+sedeValidata);
                };
                //console.log(compilati);
                //console.log($scope.elencoSelect);
                //console.log($scope.schedaLezNew);
                //console.log($scope.delete);
                return ((compilati === 0 ? false : true) && $scope[parametri.scheda] && !$scope.schedaLezNew) || $scope.deletedStud;
            };

            $scope.emailValida = (tipo) => {
                let aggiorna = {};
                aggiorna["deleted" + tipo] = 0;
                aggiorna["email" + tipo] = $("#email" + tipo).val();
                aggiorna["nome" + tipo] = aggiorna["email" + tipo].split("@")[0]; // $("#nome" + tipo).val();
                aggiorna.db = Auth.db;
                console.log(aggiorna);
                sendMailInsert(parametri, aggiorna, tipo, false, dataUser.ragioneSociale, Auth.emailSede);
            };

            $scope.causaleEntrata = () => {
                let causale = $("#idCausale>option:selected").text()
                let tipoMov = causale.substring(0, 1);

                if ($scope.elencoDoc) {
                    let idDoc = $("#idDoc").val();
                    let elencoDoc = $scope.elencoDoc;
                    elencoDoc = elencoDoc.filter((docTipo) => {
                        return docTipo.idDoc === idDoc;
                    });

                    if (elencoDoc[0]) {

                        if (elencoDoc[0].segno == 0) {
                            return true;
                        };
                    };
                };

                return tipoMov == "E" ? true : false;
            };

            $scope.tipoDoc = () => {
                let idCausale = $("#idCausale").val();
                if ($scope.elencoCausali) {
                    let elencoCausali = $scope.elencoCausali;
                    elencoCausali = elencoCausali.filter((causale) => {
                        return causale.idCausale === idCausale;
                    });

                    if (elencoCausali[0]) {

                        if (elencoCausali[0].giro != 0) {
                            return "0";
                        } else {
                            let descCausale = $("#idCausale>option:selected").text()
                            let tipoDoc = descCausale.substring(0, 1);

                            return tipoDoc == "E" ? "1" : "-1";
                        };
                    };
                };
            };

            $scope.tipoBanca = () => {
                let idCausale = $("#idCausale").val();
                if ($scope.elencoCausali) {
                    let elencoCausali = $scope.elencoCausali;
                    elencoCausali = elencoCausali.filter((causale) => {
                        return causale.idCausale === idCausale;
                    });

                    if (elencoCausali[0]) {
                        let tipoBanca = elencoCausali[0].banca;
                        return tipoBanca;
                    } else {
                        return "0";
                    };

                } else {
                    return "0";
                };
            };

            $scope.calcolaCF = () => {
                $scope.cambia = true;
                var cf = new CodiceFiscale({
                    name: "Enzo",
                    surname: "Righi",
                    gender: "M",
                    day: 24,
                    month: 7,
                    year: 1957,
                    birthplace: "Napoli",
                    birthplaceProvincia: "NA" // Optional
                });
            };

            $("#fileUpload").change((e) => {
                e.preventDefault();
                var myFile = fileUpload.value;

                if (myFile) {
                    fileText.value = myFile.substr(myFile.lastIndexOf("\\") + 1);
                    $("#btn_loadFile").show();
                    myEvent = e;
                } else {
                    fileText.value = "";
                    $("#btn_loadFile").hide();
                };
            });

            $("#upload").click((e) => {
                e.preventDefault();

                if (fileText.value) {
                    let myFile = fileUpload.value;
                    fileText.value = myFile.substr(myFile.lastIndexOf("\\") + 1);

                    $("#upload").prop("disabled", true);
                    $("#upload").html('<i class="fa fa-spinner fa-spin"></i> Aggiornamento in corso...');

                    openFile(myEvent);

                } else {
                    $("#btn_loadFile").hide();
                    $("#errorText").text("ATTENZIONE! Non hai selezionato alcun file");
                };
            });

            $(document).on("click", ".selSede", function () { // () => la fat row NON funzione perché il DOM è generato da AngularJS; ricorda sempre di fare document.off ("..","..")
                //$(".selSediStud").click(function() { // NON funzione perché il DOM è generato da AngularJS ("ng-repeat")
                let campoSede = parametri.campoSede;
                let elencoSedi = $scope.elencoSedi;
                //if (contaRecord(elencoSedi) == 1) {
                //    let tempElenco = new Array();
                //    tempElenco.push(elencoSedi)
                //    elencoSedi = tempElenco;
                //};
                console.log(elencoSedi);
                let campoSedeVal = "";
                elencoSedi.forEach((sede) => {
                    campoSedeVal += $("#" + campoSede + sede.idSede).is(":checked") ? sede.idSede : "";
                });

                $("#" + campoSede).val(campoSedeVal);
                // Inserito remmark per anomalia dopo selezione sede su Studenti e Docenti

                if (parametri.campoSede == "sediUser") {
                    Auth.idSede = campoSedeVal; 
                };
                   

                $scope.cambia = true;
                $scope.$apply();
            });

            $(document).on("click", ".selMateriaStud", function () { // () => la fat row NON funzione perché il DOM è generato da AngularJS; ricorda sempre di fare document.off ("..","..")
                //$(".selSediStud").click(function() { // NON funzione perché il DOM è generato da AngularJS ("ng-repeat")
                console.log(parametri);
                let campoMateria = parametri.campoMateriaStud;
                let elencoMaterie = $scope.elencoMaterie;
                console.log(elencoMaterie);
                let campoMateriaVal = "";
                let separa = "@";
                elencoMaterie.forEach((materia) => {
                    campoMateriaVal += $("#" + campoMateria + materia.idMateria).is(":checked") ? separa + materia.idMateria : "";                    
                });

                $("#" + campoMateria).val(campoMateriaVal.slice(1));
                //Auth.idSede = campoSedeVal;

                $scope.cambia = true;
                $scope.$apply();
            });

            $(document).on("click", ".selMateriaProf", function () { // () => la fat row NON funzione perché il DOM è generato da AngularJS; ricorda sempre di fare document.off ("..","..")
            //$(".selMateriaProf").click(function() { // NON funziona perché il DOM è generato da AngularJS ("ng-repeat")
                //e.preventDefault;
                let campoMaterie = parametri.campoMaterie;
                let elencoMaterie = $scope.elencoMaterie;
                let campoMaterieVal = "";
                console.log($(this).prop("id"));
                console.log($(this).prop("checked"), campoMaterie);

                let keyMateriaID = $(this).prop("id").split(campoMaterie)[1]; // e.currentTarget.id.split(campoMaterie)[1];
                let keyMateriaValue = $(this).prop("checked"); //e.toElement.checked; //

                if (keyMateriaValue) {
                    $("#anni" + keyMateriaID).show(200);
                    $("#freq" + keyMateriaID).show(200);
                } else {
                    $("#anni" + keyMateriaID).hide(200);
                    $("#freq" + keyMateriaID).hide(200);
                };

                elencoMaterie.forEach((materia) => {
                    //console.log($("#" + campoMaterie + materia.idMateria).is(":checked"), materia.idMateria)
                    if ($("#" + campoMaterie + materia.idMateria).is(":checked")) {
                        campoMaterieVal = "";
                        $("#selectFreqMat" + materia.idMateria).val("S");
                    } else {
                        $scope.cambia = true;
                        campoMaterieVal = "";
                        $(".scegliAnno" + materia.idMateria).removeClass("si");
                    };
                });

                $("#anniSelect" + keyMateriaID).text(campoMaterieVal);

                let tempSelect = "";
                let separaString = "";
                $(".selectMateriaAnni").each(function() {
                    console.log($(this));
                    if ($(this).text().trim().length > 0) { //.trim().length > 0
                        tempSelect += separaString + $(this).text().trim();
                        separaString = "@"
                    };
                });

                $("#" + campoMaterie).val(tempSelect);

                $scope.$apply();
            });

            $(document).on("click", ".annoS", function() { //[class*='scegliAnno']
                $(this).toggleClass("si");
                let campoMaterie = parametri.campoMaterie;
                let idMateria = $(this).prop("class").split("scegliAnno")[1].split(" si")[0];
                let idFreq = $("#selectFreqMat" + idMateria).val();
                let campoAnniVal = "";
                $(".scegliAnno" + idMateria).each(function () {
                    if ($(this).hasClass("si")) {
                        campoAnniVal += $(this).text();
                    };
                });
                let campoMaterieVal = campoAnniVal.length == 0 ? "" : "idMateria#" + idMateria.trim() + ";idAnno#" + campoAnniVal.trim() + ";idFreq#" + idFreq.trim();
                $("#anniSelect" + idMateria).text(campoMaterieVal)

                let tempSelect = "";
                let separaString = "";
                $(".selectMateriaAnni").each(function () {
                    if ($(this).text().trim().length > 0) {
                        tempSelect += separaString + $(this).text().trim();
                        separaString = "@"
                    };
                });

                $("#" + campoMaterie).val(tempSelect);

                $scope.cambia = true;
                $scope.$apply();
            });

            $(document).on("change", ".selectFreq", function () {
                let campoMaterie = parametri.campoMaterie;
                let idMateria = $(this).prop("id").split("selectFreqMat")[1];
                let idFreq = $("#selectFreqMat" + idMateria).val();
                let campoAnniVal = "";

                $(".scegliAnno" + idMateria).each(function () {
                    if ($(this).hasClass("si")) {
                        campoAnniVal += $(this).text();
                    };
                });
                let campoMaterieVal = campoAnniVal.length == 0 ? "" : "idMateria#" + idMateria + ";idAnno#" + campoAnniVal + ";idFreq#" + idFreq;
                $("#anniSelect" + idMateria).text(campoMaterieVal.trim())

                let tempSelect = "";
                let separaString = "";
                $(".selectMateriaAnni").each(function () {
                    if ($(this).text().trim().length > 0) {
                        tempSelect += separaString + $(this).text().trim();
                        separaString = "@"
                    };
                });

                $("#" + campoMaterie).val(tempSelect);

                $scope.cambia = true;
                $scope.$apply();
            });

            var style = new styleCell();

            const creaTabella = (larghezza, parametri, callback) => {
                //console.log(parametri);
                let tabella = parametri.tabella;
                let elencoCampi = parametri.elencoCampi;
                let campiTabella = parametri.campiTabella;
                let scheda = parametri.scheda;
                
                let gruppo = !parametri.campoGruppo ? "" : parametri.campoGruppo;
                let rowHigh = !parametri.rowHigh ? "auto" : parametri.rowHigh;
                //console.log(parametri.campiTabella);
                $scope[scheda] = false;
                $("#tabella" + tabella).tabulator({
                    height: "450px",
                    responsiveLayout: true,
                    //layout: "fitColumns",
                    resizableColumns: false,
                    groupBy: gruppo,
                    sortable: false,
                    colVertAlign: "center",
                    selectable: 0,

                    columns: campiTabella,

                    index: elencoCampi[0],

                    groupToggleElement: "header",
                    groupStartOpen: false,
                    groupHeader: function (value, count, data, group) {
                        //var testo = (count === 1 ? " Lezione Schedulata" : " Lezioni Prenotate");
                        //return value + "<span style='color:#d00; margin-left:10px;'>(" + count + testo + ")</span>";
                        return value + "<span style='color:#d00; margin-left:10px;'></span>";
                    },
                    //cellEdited: function (cell) {
                    //    var value = cell.getValue();
                    //    var data = cell.getData();
                    //    //console.log(elencoCampi);
                    //    //console.log(data);
                    //    updAnagrafe(parametri, false, false, true, data);
                    //    //updateOrario = updateOrario.filter-(function (record) {
                    //    //    return data.idGiorno !== record.idGiorno;
                    //    //});
                    //    //updateOrario.push(data);
                    //    //$scope.cambia = true;
                    //    //console.log(updateOrario);
                    //},

                    rowClick: function (e, row) {
                        e.preventDefault();
                        if (parametri.livello) {
                            var data = row.getData();
                            $scope.insert = false;
                            if (!orarioCambia && !prenotaCambia && !calendarioCambia) {
                                //console.log(parametri);
                                //console.log($scope.causaleEntrata());
                                $scope[scheda] = true;
                                $scope.stampaPDF = $scope[scheda] * parametri.pdf;
                                $scope.nuovaEmail = false;
                                $scope.framePDF = false;
                                //$scope.frameRicevuta = false;
                                $scope.tabellaCassa = true;
                                idKey = data[elencoCampi[0]];
                                var id = parametri.idKey;
                                parametri.campoID[id] = idKey;
                                getAnagrafe(parametri);
                                Auth[id] = idKey;
                                $scope.fileLogo = window.location.origin + "/img/logo/" + "assId" + Auth.idRS + "-sedeId" + Auth.idSede + ".jpg?ver=" + adesso();
                                $scope.$apply();
                            };
                        } else {
                            infoDialog("Attenzione","Non hai autorizzazione ad eseguire l'operazione");
                        };
                    },

                    rowFormatter: function (row) {
                        let data = row.getData();
                        let cell = row.getElement();
                        //console.log(data);
                        cell.css({
                            height: rowHigh,
                            backgroundColor: data.segno ? (data.deletedMov == "true" ? "lightgray" : (data.segno == "1" ? "black" : "red")) : (data.deleted == "true" || data.attivo == "false" || data.deleted == 1 ? "red" : "green"),
                            color: data.segno ? (data.deletedMov == "true" ? "lightgray" : (data.segno == "1" ? "black" : "red")) : (data.deleted == "true" || data.attivo == "false" || data.deleted == 1 ? "lightgray" : style.color), 
                            fontWeight: style.fontWeight,
                            border: "1px solid",
                            borderColor: "lightgray"
                        });
                    },
                });

                if (callback && typeof callback === "function") {
                    callback();
                };

            };

            const getAnagrafe = (parametri, modal, callback) => {
                let ricerca = {};
                ricerca.spRead = parametri.spRead;
                ricerca.tabella = parametri.tabella;
                ricerca.drop = 0;
                if (parametri.campoSede) {
                    parametri.campoID.idSede = Auth.idSede;
                };                
                $.extend(ricerca, parametri.campoID);
                if (ricerca.id == 0 && !$scope.admin && !$scope.gestione && parametri.user) {
                    ricerca.id = dataUser.userID;
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
                    success: getAnagrafe_success(parametri, modal, callback),
                    error: errorDialog
                });
            };

            const getAnagrafe_success = (parametri, modal, callback) => {
                return (response) => {
                    //console.log((response.d));
                    closeDialog();
                    let jsonData = JSON.stringify(xml2json(response.d));
                    let nrc = jsonData.slice(-3);
                    let pqa = (nrc == "]}}" ? "" : "[");
                    let pqc = (nrc == "]}}" ? "" : "]");

                    let idKey = parametri.idKey;
                    let id = parametri.campoID[idKey];
                    let archivio = parametri.tabella;
                    let tabella;
                    let elencoCampi = parametri.elencoCampi;
                    let campiRichiesti = parametri.campiRichiesti;
                    let scheda = parametri.scheda;
                    let myData = xml2json(response.d).NewDataSet[archivio];
                    //console.log(myData); console.log(contaRecord(myData));
                    console.log(id);
                    switch (id) {

                        case -1:
                            jsonOutput = pqa + JSON.stringify(myData) + pqc;
                            tabella = "tabella" + archivio;
                            $("#" + tabella).tabulator("setData", jsonOutput);

                            $scope.cambia = false;
                            $scope[scheda] = true;
                            $scope.$apply();
                            break;

                        case 0:
                            tabella = modal + archivio;
                            if (contaRecord(myData) > 0) {
                                jsonOutput = pqa + JSON.stringify(myData) + pqc;                                
                                $("#" + tabella).tabulator("setData", jsonOutput);
                            } else {
                                $("#" + tabella).tabulator("clearData");
                                jsonOutput = undefined;
                            };

                            if (parametri.drop) {
                                let dropGet = parametri.dropGet;
                                dropGet.forEach(function (dropParametri) {
                                    getDropElenco(dropParametri, 1, Auth.db, (dropElenco) => {
                                        $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                                        if (contaRecord(dropElenco) == 1) {
                                            let tempElenco = new Array();
                                            tempElenco.push(dropElenco)
                                            $scope[dropParametri.dropElenco] = tempElenco;
                                        };
                                        //console.log(dropParametri.dropElenco);
                                        //console.log($scope[dropParametri.dropElenco]);
                                        if (parametri.tabella == "Calendario" && avvioCalendario) {
                                            $scope.idMese = (parseInt(d.getMonth() + 1)).toString();
                                            avvioCalendario = false;
                                        };
                                        $scope.$apply();
                                    });
                                });
                            };
                            //console.log(jsonOutput);
                            //if (parametri.tabella === "Cassa") {
                            //    $scope.elencoCassa = jsonOutput ? JSON.parse(jsonOutput) : jsonOutput;
                            //    $scope.$apply();
                            //};
                            break;

                        default:
                            $scope.cambia = false;
                            $scope[scheda] = true;

                            elencoCampi.forEach(function (campo) {
                                console.log(campo + ":" + myData[campo]);
                                $("#" + campo).val(myData[campo]);
                                $scope[campo] = $("#" + campo).val();

                                $scope.$apply();
                            });

                            campiRichiesti.forEach(campo => {
                                $("#" + campo).addClass("activeTab");
                            });

                            if (parametri.campiNumerici) {
                                let campiNumerici = parametri.campiNumerici;
                                campiNumerici.forEach(numero => {
                                    $("#" + numero).val(accounting.formatMoney(myData[numero], "€ ", 2, ".", ","));
                                    $scope[numero] = $("#" + numero).val();
                                });
                            };

                            if (parametri.campiText) {
                                let campiText = parametri.campiText;
                                campiText.forEach(campo => {
                                    $("#" + campo).text(myData[campo]);
                                    $scope[campo] = $("#" + campo).text();
                                    $scope.$apply();
                                });
                            };

                            if (parametri.campiEditor) {
                                let campiEditor = parametri.campiEditor;
								let xmlDoc = $.parseXML(response.d);
								let xml = $(xmlDoc);
								
                                campiEditor.forEach(campo => {
                                    $("#" + campo).Editor("setText", $(xml).find(campo).text()); //myData[campo]);
									$scope[campo] = $("#" + campo).Editor("getText");
                                });

                                $scope.editConvocazione = true;
                                $scope.$apply();
                            };

                            if (parametri.campiCheck) {
                                let campiCheck = parametri.campiCheck;
                                campiCheck.forEach((campo) => {
                                    let deleted = myData[campo] == "true" || myData[campo] == 1  ? 1 : 0;
                                    let campoDeleted = $("#" + campo);
                                    deleted == 1 ? campoDeleted.prop("checked", true) : campoDeleted.prop("checked", false);
                                    $scope[campo] = deleted == 1 ? true : false;
                                });
                            };

                            $scope.emailCheck = () => {
                                emailValidata = myData["emailCheck"] == "true" ? true : false;
                                return (myData["emailCheck"] == "true" ? "OK" : "NV");
                            };

                            if (parametri.campoSede) {
                                let campoSede = parametri.campoSede;
                                let campo = myData[campoSede];
                                let elencoSedi = $scope.elencoSedi;
                                elencoSedi.forEach(function (sede) {
                                    $("#" + campoSede + sede.idSede).prop("checked", campo.indexOf(sede.idSede) > -1 ? true : false)
                                })
                            };

                            if (parametri.campoMateriaStud) {
                                let campoMaterie = parametri.campoMateriaStud;
                                let campo = "@" + myData[campoMaterie] + "@";
                                let elencoMaterie = $scope.elencoMaterie;

                                elencoMaterie.forEach(materia => {
                                    $("#" + campoMaterie + materia.idMateria).prop("checked", campo.indexOf("@" + materia.idMateria + "@") > -1 ? true : false) 
                                    //console.log(campo.indexOf("@" + materia.idMateria + "@"));
                                });
                            };

                            let orario = $(".orario").val().replace("-", ":");
                            $(".orario").val(orario);

                            if (parametri.campoMaterie) {
                                let campoMaterie = parametri.campoMaterie;
                                let elencoMaterie = $scope.elencoMaterie;

                                $(".selectMateriaAnni").text("");
                                $(".annoS").removeClass("si");
                                elencoMaterie.forEach((materie) => {
                                    $("#" + campoMaterie + materie.idMateria).prop("checked", false);
                                    $("#anni" + materie.idMateria).hide();
                                    $("#freq" + materie.idMateria).hide();
                                });


                                let campoElenco = myData[campoMaterie].split("@");
                                if (campoElenco[0]) {
                                    let campo = new Array();
                                    let campoAnni = new Array();
                                    campoElenco.forEach((materiaAnno) => {
                                        campo.push(materiaAnno.split(";")[0].split("#")[1]);
                                        campoAnni.push([materiaAnno.split(";")[0].split("#")[1], materiaAnno.split(";")[1].split("#")[1], materiaAnno.split(";")[2].split("#")[1]])
                                    });

                                    elencoMaterie.forEach((materie) => {
                                        if (campo.includes(materie.idMateria)) {
                                            $("#" + campoMaterie + materie.idMateria).prop("checked", true)
                                            $("#anni" + materie.idMateria).show();
                                            $("#freq" + materie.idMateria).show();

                                            let campoAnniSel = campoAnni.filter(function (filtroMateria) {
                                                return filtroMateria[0] == materie.idMateria;
                                            });
                                            $(".scegliAnno" + materie.idMateria).each(function () {
                                                if (campoAnniSel[0][1].includes($(this).text())) {
                                                    $(this).addClass("si");
                                                };
                                            });
                                            $("#selectFreqMat" + materie.idMateria).val(campoAnniSel[0][2]);

                                            $("#anniSelect" + materie.idMateria).text("idMateria#" + materie.idMateria + "; idAnno#" + campoAnniSel[0][1] + "; idFreq#" + campoAnniSel[0][2] );
                                        };
                                    });
                                };
                            };

                            if (parametri.campoLezioni){
                                let lezioniPrenotate = parametri.campoLezioni;
                                let elencoMaterie = $scope.elencoMaterie;
                                let campoElenco = myData[lezioniPrenotate] ? myData[lezioniPrenotate].split("@") : ["idMateria#-1;numLez#0"];
                                console.log(campoElenco);
                                if (campoElenco[0]) {
                                    let campo = new Array();
                                    //let campoAnni = new Array();
                                    campoElenco.forEach((materiaAnno) => {
                                        campo.push(materiaAnno.split(";")[0].split("#")[1]);
                                        //campoAnni.push([materiaAnno.split(";")[0].split("#")[1], materiaAnno.split(";")[1].split("#")[1], materiaAnno.split(";")[2].split("#")[1]])
                                    });
                                    console.log(campo);
                                    elencoMaterie.forEach((materie) => {
                                       
                                        //let idMateria = materie.idMateria;
                                        $scope.lezioniAttive = (idMateria) => {
                                            if (campo.includes(idMateria)) {
                                                return true;
                                            } else {
                                                return false;
                                            };
                                        };
                                    });
                                };
                            
                            };
                            
                            $scope.$apply();
                            break;
                    };

                    if (callback && typeof callback === "function") {
                        callback();
                    };

                };

                //closeDialog();
            };

            const updAnagrafe = (parametri, insert, lezione, orario, data, elimina, assemblea) => {
                let elencoCampi = parametri.elencoCampi;
                let aggiorna = {};
                let campiTesto = "";
                aggiorna.spUpdate = (insert && parametri.spCreate ? parametri.spCreate : parametri.spUpdate);
                aggiorna.delete = elimina ? 1 : 0;

                if (lezione) {
                    aggiorna.idLezione = data.value;
                    aggiorna.idSede = Auth.idSede;
                    aggiorna.idProfessoreLez = $scope.selectProf;
                    aggiorna.idMateriaLez = $scope.selectMat;
                    aggiorna.idOrarioLez = data.idOrario;
                    aggiorna.anni = $scope.selectAnni;
                    aggiorna.frequenza = $scope.selectFreq;
                    aggiorna.idRS = Auth.idRS;
                    aggiorna.nomeProf = " ";
                    aggiorna.materia = " ";
                    aggiorna.orario = " ";

                } else if (orario) {
                    $.extend(aggiorna, data);

                } else {
                    elencoCampi.forEach(function (campo) {
                        let campoVal = $("#" + campo).val();
                        switch (campoVal) {
                            case undefined:
                                aggiorna[campo] = " ";
                                break;

                            case null:
                                aggiorna[campo] = 0;
                                break;

                            default:
                                if (campo == parametri.campoMaterie) {
                                    aggiorna[campo] = campoVal;
                                    $(".selectMateriaAnni").text("");
                                    $(".annoS").removeClass("si");
                                } else {
                                    aggiorna[campo] = campoVal.replace(/([*+?^=!',:${}()|\[\]\/\\])/g, "-").toUpperCase();
                                };
                                break;
                        };

                        if (campo == "emailCheck") {
                            aggiorna.emailCheck = $scope.nuovaEmail ? 0 : emailValidata ? 1 : 0;
                        };

                    });

                    if (parametri.campoRS) {
                        let campoRS = parametri.campoRS;
                        campoRS.forEach(campo => {
                            aggiorna[campo] = Auth[campo];
                        });
                    };

                    if (parametri.campiText) {
                        let campiText = parametri.campiText;
                        campiText.forEach(campo => {
                            aggiorna[campo] = $("#" + campo).text();
                        });
                    };

                    if (parametri.campiEditor) {
                        let campiEditor = parametri.campiEditor;
                        let separa = "";
                        campiEditor.forEach(campo => {
                            campiTesto += separa + campo + "#" + $("#" + campo).Editor("getText");
                            separa = "§";
                        });
                    };

                    if (parametri.campiCheck) {
                        let campiCheck = parametri.campiCheck;
                        campiCheck.forEach(campo => {
                            aggiorna[campo] = $("#" + campo).is(":checked") ? 1 : 0;
                        });
                    };

                    if (parametri.campiNumerici) {
                        let campiNumerici = parametri.campiNumerici;
                        campiNumerici.forEach(numero => {
                            aggiorna[numero] = formatoValuta(numero);
                        });
                    };

                    if (parametri.campiDefault && parametri.id == 0) {
                        let campiDefault = parametri.campiDefault;
                        $.each(campiDefault, (nome, valore) => {
                            aggiorna[nome] = valore;
                        });
                    };

                    if (parametri.login){
                        let login = parametri.login;
                        aggiorna[login.user] = aggiorna[login.email].split("@")[0];
                        aggiorna[login.pass] = hash(aggiorna[login.email].split("@")[0]);
                    };

                    if (parametri.idKey == "idAss") {
                        if (assemblea) {
                            aggiorna.dataInvio = oggi();
                            aggiorna.inviata = 1;
                        } else {
                            aggiorna.inviata = 0;
                        };
                    };

                    if (parametri.tabella === "Cassa") {
                        //console.log(formatoNumero("importoRicevuta"), typeof formatoNumero("importoRicevuta"))
                        $.extend(aggiorna, parametri.campoID);
                        aggiorna.importoRicevuta = formatoNumero("importoRicevuta");
                    };

                };

                let criterio = {
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
                    beforeSend: openDialog, 
                    success: updAnagrafe_success(parametri),
                    error: (xhr, status, error) => {
                        closeDialog();
                        $scope[parametri.scheda] = false;
                        $scope.schedaLezNew = false;
                        $scope.elencoSelect = false;
                        $scope.$apply();
                        errorDialog(xhr, status, error)
                    }
                });
            };

            const updAnagrafe_success = (parametri) => {
                //console.log(parametri);
                closeDialog();
                return function (response) {
                    let esito = parseInt(response.d);
                    let scheda = parametri.scheda;
                    console.log(esito);
                    switch (esito) {

                        case 1:
                            var msgTipo = "";
                            var msgText = "Scheda inserita correttamente!";
                            var msgImg = imgOK;
                            var idKey = parametri.idKey;

                            if (!parametri.plan) {
                                parametri.campoID[idKey] = 0;
                                $scope.cambia = false;
                                $scope[scheda] = false;
                                $scope.stampaPDF = $scope[scheda] * parametri.pdf;
                                $scope.schedaLezNew = false;
                                $scope.elencoSelect = false;
                            };

                            getAnagrafe(parametri, "tabella", ()=>  {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                            });
                            //infoDialog(msgTipo, msgText, msgImg);
                            break;

                        case 2:
                            var msgTipo = "";
                            var msgText = "Dati già presente in archivio!"
                            var msgImg = imgKO;

                            $scope.cambia = false;
                            $scope[scheda] = false;
                            $scope.stampaPDF = $scope[scheda] * parametri.pdf;
                            $scope.schedaLezNew = false;
                            $scope.elencoSelect = false;
                            infoDialog(msgTipo, msgText, msgImg);
                            break;

                        case 3:
                            var msgTipo = "";
                            var msgText = "Dati aggiornati con successo!";
                            var msgImg = imgOK;
                            //var idKey = parametri.idKey;
                            //parametri.campoID[idKey] = 0;

                            $scope.cambia = false;
                            $scope.delete = false;
                            //$scope[scheda] = false;
                            $scope.stampaPDF = $scope[scheda] * parametri.pdf;
                            $scope.schedaLezNew = false;
                            $scope.elencoSelect = false;

                            getAnagrafe(parametri, "tabella", () => {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                                //console.log("callBack");
                            });
                            //infoDialog(msgTipo, msgText, msgImg);
                            break;

                        case 4:
                            $scope.cambia = true;
                            var msgTipo = "";
                            var msgText = "CODICE ISTITUTO ERRATO"
                            var msgImg = imgKO;
                            break;

                        case 11:
                            //$scope.cambia = true;
                            var msgTipo = "";
                            var msgText = "Il docente è già impegnato su altra sede"
                            var msgImg = imgKO;
                            infoDialog(msgTipo, msgText, msgImg);
                            break;

                    };

                    insert = false;
                    $scope.$apply();

                    if (!orarioCambia && !prenotaCambia && !calendarioCambia) {
                        //infoDialog(msgText, msgTipo, msgImg, largo);
                    } else {
                        orarioCambia = false;
                        prenotaCambia = false;
                        calendarioCambia = false;
                    };

                    if (parametri.refresh) {
                        parametri.campoID.idSede = 0;
                        getDropElenco(parametri, 0, Auth.db, (dropElenco) => {                            
                            Auth[parametri.dropElenco] = dropElenco;
                            $scope.annullaScheda();
                        });
                    };
                };
            };

            //------------------------------Begin Gestione Tabella--------------------------------------------- ---//

            $scope.download_xlsx = function () {
                var tabDownload = parametri.tabella;
                $("#tabella" + tabDownload).tabulator("download", "xlsx", "elenco" + tabDownload + ".xlsx");
            };

            $("#btn_download").click(function () {
                var tabDownload = "elenco" + parametri.tabella;
                $("#tabella" + tabDownload).tabulator("download", "csv", "elenco" + tabDownload + ".csv", { delimiter: "|" });
            });

            //-----------------------------End Gestione Tabella----------------------------------------------//
            const sendMailResetPW = (aggiorna) => {
                let codice;
                aggiorna.user = aggiorna.email.split("@")[0];
                aggiorna.sede = dataUser.ragioneSociale;
                aggiorna.emailSede = Auth.emailSede;
                var criterio = {
                    data: JSON.stringify(aggiorna),
                    email: aggiorna.email,
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/sendMailResetPW",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: (response) => {
                        codice = parseInt(response.d);
                        if (codice === 1) {
                            $scope.msgReset += " - Mail di Reset password inviata con successo";
                            $scope.$apply();
                        } else {
                            $scope.msgReset += " - Non è stato possibile inviare la mail di conferma reset";
                            $scope.$apply();
                        };

                        //infoDialog(msgText, msgTipo, msgImg, largo);
                    },
                    error: (xhr, status, error) => {
                        codice = -1;
                        $scope.msgReset = xhr.responseJSON.Message;
                        $scope.$apply();
                    }
                });

            };

            $scope.fncResetPW = function () {
                $scope.msgReset = "";
                $scope.msgResetPW = true;
                //$scope.$apply();

                $("#btnResetPW").html('<i class="fa fa-spinner fa-spin"  aria-hidden="true"></i> Reset in corso...');
                $("#btnResetPW").prop("disabled", true);

                let newPass = "xY" + parseInt(Math.random()*10000) + "aBc";
                let aggiorna = {};
                aggiorna.sp = "admPasswordReset";               
                aggiorna.email = $("#emailUser").val();
                aggiorna.newPass = newPass;
                aggiorna.cryPass = hash(newPass);
                aggiorna.idRS = dataUser.idRS;

                var criterio = {
                    data: JSON.stringify(aggiorna),
                    html: "",
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
                    success: resetPassword(aggiorna),
                    error: function (xhr, status, error) {
                        //closeDialog();
                        $scope.resetPW = false;
                        
                        $scope.msgReset = xhr.responseJSON.Message; 
                        $("#btnResetPW").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Conferma Reset');
                        $("#btnResetPW").prop("disabled", true);
                        $scope.$apply();
                        }
                });
            };

            const resetPassword = function(aggiorna){
                return function(response){
                    let myData = parseInt(response.d);
                    //closeDialog();
                    //console.log(response.d);
                    //$scope.msgResetPW = true;
                    if (myData === 1) {
                        $scope.resetPW = false;
                        $scope.msgReset = "Reset avvenuto con successo; è stata inviata una password provvisoria all'indirizzo email dell'utente selezionato";
                        $scope.$apply();
                        sendMailResetPW(aggiorna);

                    } else {
                        $scope.msgReset = "Attenzione! Reset fallito";
                        $scope.$apply();
                    };
                    $("#btnResetPW").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Conferma Reset');
                    $("#btnResetPW").prop("disabled", true);
                };
            };

            $scope.selezionaMese = function(){
                //console.log($scope.idMese);
                parametri.campoID.idMese = $scope.idMese;
                getAnagrafe(parametri, "tabella", function () {
                    $("#tabella" + parametri.tabella).tabulator("redraw");
                });
            };
        
            $scope.mainBack = function () {
                $scope.avvio = true;
                $scope.luogo = Auth.luogo;
                window.location.href = "#/main";
            };

            $scope.aggiornaProf = function () {
                let elencoProf = $scope.elencoProfessoriLez;
                let myProf = elencoProf.filter(function (prof) {
                    return prof.idProfessore == $scope.selectProf;
                });
                //console.log(myProf);
                let elencoMaterieLez = $scope.elencoMaterie;
                let materieProfString = myProf[0].materiaProf;
                //console.log(materieProfString);
                $scope.materieProfTot = materieProfString.split("@");
                let materieProfTot = $scope.materieProfTot;
                let idMateria;
                let idMateriaElenco = new Array();
                materieProfTot.forEach(function (materia) {
                    //console.log(materia)
                    idMateria = materia.split(";")[0].split("#")[1];
                    idMateriaElenco.push(idMateria);
                });
                //console.log(idMateriaElenco)
                elencoMaterieLez = elencoMaterieLez.filter(function (materia) {
                    return idMateriaElenco.includes(materia.idMateria);
                });
                $scope.elencoMaterieLez = elencoMaterieLez;
                $scope.selectAnni = "";

            };

            $scope.aggiornaMat = function () {
                let materieProfTot = $scope.materieProfTot;
                let materieProf = materieProfTot.filter(function(materia){
                    return materia.split(";")[0].split("#")[1] == $scope.selectMat;
                });
                $scope.selectAnni = materieProf[0].split(";")[1].split("#")[1];
                $scope.selectFreq = materieProf[0].split(";")[2].split("#")[1];

                parametri = parPlan;
                parametri.campoID.idLezione = -1;
                parametri.campoID.idProfessore = $scope.selectProf;
                parametri.campoID.idMateria = $scope.selectMat;
                console.log(parametri);
                $scope.scheda("Z");
                $scope.schedaLez = true;
            };

            $scope.cambiaEmail = function(){
                $scope.cambia = true;
                $scope.nuovaEmail = true;
            };

            $scope.salvaScheda = function () {
                $scope.framePDF = false;

                $scope.cambia = false;
                $scope.delete = false;
                $scope.schedaNew = false;
                $scope.editConvocazione = false;
                //$scope.insert = parametri.insert;

                updAnagrafe(parametri, insert, $scope.schedaLezNew, false, "", false, false);
            };

            $scope.cancellaScheda = () => {
                $scope.framePDF = false;;

                $scope.cambia = false;
                $scope.delete = false;
                $scope.schedaNew = false;
                $scope.editConvocazione = false;
                $scope.insert = parametri.insert;

                updAnagrafe(parametri, false, false, false, "", true, false);
            };

            $scope.annullaScheda = () => {
                $scope.msgReset = "";
                $scope.msgResetPW = false;

                if ($scope.framePDF) {
                    $scope.framePDF = false;
                } else {
                    $scope.framePDF = false;
                    $scope.tabellaCassa = true;

                    $scope.editConvocazione = false;
                    orarioCambia = false;
                    prenotaCambia = false;
                    calendarioCambia = false;
                    //console.log(!parametri);
                    //console.log(parametri.scheda)
                    //console.log(!$scope[parametri.scheda]);
                    if(!parametri || !$scope[parametri.scheda]) {
                        idKey = 0;
                        $scope.cambia = false;
                        $scope.delete = false;
                        $scope.userLogged = false;
                        $scope.schedaLezNew = false;
                        $scope.schedaNew = false;
                        $scope.insert = !parametri ? false : parametri.insert;
                        Auth.avvio = true;
                        $scope.avvio = true;
                        $(document).off('click', ".selSede");
                        $(document).off('click', ".selMateriaProf");
                        $(document).off('click', ".selMateriaStud");
                        $(document).off('click', ".annoS")
                        $(document).off('change', ".selectFreq");
                        window.location.href = "#/main";
                    } else {
                    //console.log($scope.cambia)
                    //console.log(!$scope.schedaNew)
                    //console.log(!$scope.schedaLezNew)
                        if ($scope.cambia && !$scope.schedaNew && !$scope.schedaLezNew) {
                            $scope.delete = false;
                            var id = parametri.idKey;
                            parametri.campoID[id] = idKey;
                            getAnagrafe(parametri);
                        } else {
                            $scope.cambia = false;
                            $scope.delete = false;
                            idKey = 0;
                            var id = parametri.idKey;
                            parametri.campoID[id] = 0;
                            $scope[parametri.scheda] = false;
                            $scope.stampaPDF = $scope[parametri.scheda] * parametri.pdf;
                            $scope.schedaLezNew = false;
                            $scope.schedaNew = false;
                            $scope.insert = parametri.insert;
                            //console.log(parametri);
                            getAnagrafe(parametri, "tabella", () => {
                                $("#tabella" + parametri.tabella).tabulator("redraw");
                            });
                            if (parametri.plan) {
                                parametri = parLezioni;
                                var id = parametri.idKey;
                                parametri.campoID[id] = 0;
                                $scope.insert = parametri.insert;
                                getAnagrafe(parametri, "tabella", () => {
                                    $("#tabella" + parametri.tabella).tabulator("redraw");
                                });
                            };
                        };
                    };
                };                       
            };

            $scope.nuovaScheda = () => {
                $scope[parametri.scheda] = true;
                $scope.cambia = true;
                $scope.editConvocazione = true;
                $scope.schedaNew = true;
                $scope.framePDF = false;
                $scope.insert = false;

                idKey = 0;
                insert = true;
                var id = parametri.idKey;
                parametri.campoID[id] = idKey;
                //console.log(parametri);

                if (parametri.tabSelect) {
                    $scope.schedaLezNew = true;
                    var elencoTabelle = parametri.dropGet;
                    elencoTabelle.forEach(function (dominio) {
                        var tabellaSelect = dominio.tabellaSelect;
                        var elenco = dominio.dropElenco;
                        // ripulisco i vettori campiSelected 
                        dominio.campiSelected = [];
                        tabellaScelta(larghezza, dominio, function () {
                            setTimeout(function () {
                                $("#" + tabellaSelect).tabulator("setData", JSON.stringify($scope[elenco]));
                                $("#" + tabellaSelect).tabulator("deselectRow");
                            }, 200);
                        });
                    });

                    $(".anniSelect").each(function () {
                        $(this).prop("checked", false);
                    });
                    anniSelect = "";

                    elencoVerifica(false);

                } else if (parametri.plan) {
                    $scope.schedaLezNew = true;
                    $scope.selectProf = "0";
                    $scope.selectMat = "0";
                    let elencoProfessori = $scope.elencoProfessori;
                    let elencoProfessoriLez = new Array();
                    elencoProfessoriLez = elencoProfessori.filter(function(prof){
                        //console.log(prof.sediProf);
                        //console.log(Auth.idSede);
                        //console.log(prof.sediProf.indexOf(Auth.idSede));
                        return prof.materiaProf.indexOf("#") > 0; // && prof.sediProf.indexOf(Auth.idSede) > 0;
                    });
                    $scope.elencoProfessoriLez = elencoProfessoriLez;
                    $scope.elencoMaterieLez = [];
                    $scope.selectAnni = "";
                    $scope.selectFreq = "";

                } else {
                    let elencoCampi = parametri.elencoCampi;
                    let campiRichiesti = parametri.campiRichiesti;

                    elencoCampi.forEach(function (campo) {
                        $("#" + campo).val("");
                        $scope[campo] = $("#" + campo).val();
                    });

                    campiRichiesti.forEach(function (campo) {
                        $("#" + campo).addClass("activeTab");
                    });

                    if (parametri.campiText) {
                        let campiText = parametri.campiText;
                        campiText.forEach(campo => {
                            $("#" + campo).text(parametri.campoID[campo]);
                            $scope[campo] = $("#" + campo).text();
                            //$scope.$apply();
                        });
                    };

                    if (parametri.campiEditor) {
                        let campiEditor = parametri.campiEditor;
                        campiEditor.forEach(campi => {
                            $("#" + campi).Editor("setText", "");
                        });
                    };

                    if (parametri.campoMaterie) {
                        $scope.lezioniAttive = function (idMateria) {
                            return false;
                        };
                        $("#idTipoSocioProf").val("0")
                        $scope.idTipoSocioProf = "0";

                        $("#idTipoProf").val("0")
                        $scope.idTipoProf = "0";

                        $(".selMateriaProf").prop("checked", false);
                        $(".annoS").removeClass("si");
                        $(".scegliAnni").hide();
                        $(".scegliFreq").hide();
                        $(".slave").hide();

                    };

                    $(".selSede").prop("checked", false);

                    $("#idTipoSocioUser").val("0")
                    $scope.idTipoSocioUser = "0";

                    $("#idRuolo").val("4")
                    $scope.idRuolo = "4";

                    $("#docTipoStud").val("0")
                    $scope.docTipoStud = "0";

                    $("#docTipoGen").val("0")
                    $scope.docTipoGen = "0";

                    $("#docTipoProf").val("0")
                    $scope.docTipoProf = "0";

                    $("#modoLezione").val("0")
                    $scope.modoLezione = "0";


                };
            };

            $scope.sendMailConvoca = () => {
                let aggiorna = new Object();
                let html = new String();

                let elencoCampi = parametri.elencoCampi;
                let campiText = parametri.campiText;
                let campiEditor = parametri.campiEditor;

                let elencoSoci = $scope.elencoSoci;

                elencoCampi.forEach((campo) => {
                    aggiorna[campo] = $("#" + campo).val();
                });

                aggiorna.oraAss = $("#oraAss").val().replace(":", "-");
                aggiorna.dataInvio = oggi();
                aggiorna.inviata = 1;
                aggiorna.straord = $scope.straord ? "Straordinaria" : "Ordinaria";

                campiText.forEach((campo) => {
                    aggiorna[campo] = $("#" + campo).text().trim();
                });
                console.log(aggiorna)
                let separa = ""
                campiEditor.forEach((campo) => {
                    html += separa + campo + "#"+ $("#" + campo).Editor("getText");
                    separa = "§";
                });

                sendMailAssemblea(aggiorna, html, elencoSoci, Auth.db, function () {
                    $scope.editConvocazione = false;
                    updAnagrafe(parametri, false, false, false, "", false, true);
                });

                //if (sendMailAssemblea(aggiorna, html, elencoSoci, Auth.db)) {
                //    console.log(true);
                //} else {
                //    console.log(false);
                //};
            };

            const stampaRicevuta = () => {
                $scope.framePDF = true;
                let framePDF = parametri.framePDF;

                let datiScheda = new Object();
                let elencoCampi = parCassa.elencoCampi;
                elencoCampi.forEach((campo) => {
                    let type = $("#" + campo).prop("type");
                    switch (type) {
                        case "select-one":
                            datiScheda[campo] = $("#" + campo + ">option:selected").text();
                            break;

                        default:
                            datiScheda[campo] = $("#" + campo).val();
                            break;

                    };

                });

                const iFrameWidth = parseInt($("#formCassa").width());
                const myIframe = document.getElementById(framePDF);
                myIframe.width = iFrameWidth;
                myIframe.height = iFrameWidth * 0.6;
                myIframe.src = "";

                const imgHeader = $.get("img/base64/Portofranco.Logo-png.B64.txt?ver=" + versione);
                const imgTimbro = $.get("img/base64/Portofranco.Timbro.B64.txt?ver=" + versione);
                //const imgLoader = $.when(imgHeader);
                imgHeader.done(() => {
                    imgTimbro.done(() => {
                        $http.get("/dati/json/ricevuta.json?ver=" + adesso())
                            .then((response) => {
                                const header = response.data.header;
                                const corpo = response.data.corpo;
                                const footer = response.data.footer;
                                const parametri = response.data.parametri;

                                pdfRicevuta(imgHeader.responseText, imgTimbro.responseText, datiScheda, header, corpo, footer, parametri, myIframe);
                            });
                    });
                    imgTimbro.fail(() => {
                        infoDialog("Attenzione", "Errore codifica file Timbro");
                    });
                });
                imgHeader.fail(() => {
                    infoDialog("Attenzione", "Errore codifica file Logo");
                });
                //});
            };

            const stampaScheda = () => {
                $scope.framePDF = true;

                let datiScheda = new Array();
                let elencoCampi = parametri.campiStampa[0];
                let elencoLabel = parametri.campiStampa[1];
                let framePDF = parametri.framePDF;

                elencoCampi.forEach( (campo, i) => {
                    let type = $("#" + campo).prop("type");
                    console.log(type + " - " + campo)
                    switch (type) {
                        case "text":
                            let testo = $("#" + campo).val();
                            let testo4 = testo.substr(testo.length - 4) == "1900" ? "" : testo;
                            var record = [{text: elencoLabel[i], style: "tableSx"}, {text: testo4, style: "tableTextDx"}];
                            break;

                        case "email":
                            var record = [{ text: elencoLabel[i], style: "tableSx" }, { text: $("#" + campo).val(), style: "tableDx" }];
                            break;

                        case "select-one":
                            var record = [{ text: elencoLabel[i], style: "tableSx" }, { text: $("#" + campo + ">option:selected").text(), style: "tableDx" }];
                            break;

                        case "checkbox":
                            var record = [{ text: elencoLabel[i], style: "tableSx" }, { text: $("#" + campo).is(":checked") ? "SI" : "NO", style: "tableDx" }];
                            break;

                    };

                    datiScheda.push(record);

                });

                let datiPrivacy = new Array();
                var campiPrivacy = parametri.campiPrivacy[0];
                var labelPrivacy = parametri.campiPrivacy[1];

                campiPrivacy.forEach((campo, i) => {
                    const type = $("#" + campo).prop("type");
                    switch (type) {
                        case "text":
                            let testo = $("#" + campo).val();
                            let testo4 = testo.substr(testo.length - 4) == "1900" ? "": testo;
                            var record = [{ text: labelPrivacy[i], style: "tableBody" }, { text: testo4, style: "tableMd" }];
                            break;

                        case "email":
                            var record = [{ text: labelPrivacy[i], style: "tableBody" }, { text: $("#" + campo).val(), style: "tableMd" }];
                            break;

                        case "select-one":
                            var record = [{ text: labelPrivacy[i], style: "tableBody" }, { text: $("#" + campo + ">option:selected").text(), style: "tableMd" }];
                            break;

                        case "checkbox":
                            var record = [{ text: labelPrivacy[i], style: "tableBody" }, { text: $("#" + campo).is(":checked") ? "Do il consenso" : "Nego il consenso", style: "tableMd" }];
                            break;

                        default:
                            var record = [{ text: labelPrivacy[i], style: "tableBody" }, { text: "  ", style: "tableMd" }];
                            break;

                    };

                    datiPrivacy.push(record);

                });

                const iFrameWidth = parseInt($("#divAnagrafe").width());
                const myIframe = document.getElementById(framePDF);
                myIframe.width = iFrameWidth;
                myIframe.height = iFrameWidth * 1.1;
                myIframe.src = "";

                //const imgHeader = $.get("img/base64/assId" + dataUser.idRS + ".B64.txt");
                //const imgLoader = $.when(imgHeader);
                //imgHeader.done(function () {
                    const margini = [10, 5];
                    const sfondo = false;
                    const posizione = "portrait";
                    const rs = dataUser.ragioneSociale;
                    const titolo = parametri.titoloReport;
                    const subTitolo = "Sede di " + (dataUser.ragioneSociale || "Portofranco");
                    const larghezza = ['*', '*'];
                    const larghezzaPrivacy = [450, '*'];
                    const marginiPrivacy = [10,5];
                    const formula = "Autorizzazione Privacy";
                    const footerText = dataUser.ragioneSociale || " Portofranco Sede";
                    //imgHeader.responseText,
                    pdfModuloIscrizione(rs, sfondo, posizione, titolo, subTitolo, datiScheda, larghezza, margini, datiPrivacy, larghezzaPrivacy, marginiPrivacy, formula, footerText, myIframe);
                //});
                //imgHeader.fail(function () {
                //    infoDialog("Attenzione", "Errore nella decodifica file Logo");
                //});

            };

            $scope.stampa = () => {
                if (parametri.ricevuta && $scope.causaleEntrata()) {
                    stampaRicevuta();
                } else if (!parametri.ricevuta) {
                    stampaScheda();
                };
            };          

            $(window).resize(function () {
                //larghezza = parseInt($("#divHeader").width() * 0.75);
                mobile = largo < 750 ? true : false;
                //$("#tabella" + parametri.tabella).tabulator("redraw");
                //console.log(largo + " - " + larghezza + "  mobileResize:" + mobile);
            });

        } else {
            Auth.from = "#/anagrafe";
            window.location.href = mobile ? "#/main" : "#/utentiLogin";
        };

    });
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();