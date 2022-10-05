//------------------------------Begin ctrl-main controller--------------------------------------------//
'use strict';

(function () {

    var master = angular.module("dbItalia", []);

    master.controller("ctrl-dbItalia", function ($scope, $http, dataUser, Auth) {
        
        $("#dbItalia").show();
        console.log(dataUser);
        console.log(dataUser.idRS);
        $scope.userID = dataUser.userID;
        $scope.idRuolo = dataUser.idRuolo;
        $scope.ragioneSociale = dataUser.ragioneSociale;
        $scope.mainInfo = false;
        $scope.totaleStud = $scope.primo + $scope.secondo + $scope.terzo + $scope.quarto + $scope.quinto;
        $scope.totaleProf = $scope.attivo + $scope.pensione + $scope.studente + $scope.altro;
        const larghezza = parseInt($("#divDBItalia").width() * 1);
        const modal = "tabella";
        var jsonOutput;
        var drop = 0;

        var myEvent;

        const pardbStud = {
            idKey: "idOrigineStud",
            campoID: { "idRS": dataUser.idRS , "idOrigineStud": 0},
            tabella: "Stud",
            scheda: "schedadbStud",
            spRead: "pf_dbItaliaStudentiRead",
            spUpdate: "pf_dbItaliaStudentiUpdate",
            elencoCampi: ["idOrigineStud", "idRS", "origineStud", "primo", "secondo", "terzo", "quarto", "quinto", "totaleStud"],
            campiTabella: [
                { title: " ", field: "idRS", visible: false },
                { title: " ", field: "idOrigineStud", visible: false },
                { title: "Origine", field: "origineStud", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: false },
                { title: "Primo", field: "primo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false},
                { title: "Secondo", field: "secondo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false },
                { title: "Terzo", field: "terzo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false},
                { title: "Quarto", field: "quarto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false },
                { title: "Quinto", field: "quinto", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false },
                { title: "Totale", field: "totaleStud", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false },
                { title: "AGG.", field: "dtAGG", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: false },
            ],
            hTabella: "200px",
            campiCheck: [],
            campiRichiesti: ["primo", "secondo", "terzo", "quarto", "quinto"],
            livello: true
            
        };

        const pardbProf = {
            idKey: "idTipo",
            campoID: { "idRS": dataUser.idRS, "idTipo":0},
            tabella: "Prof",
            scheda: "schedadbProf",
            spRead: "pf_dbItaliaProfessoriRead",
            spUpdate: "pf_dbItaliaProfessoriUpdate",
            elencoCampi: ["idRS", "attivo", "pensione", "studente", "altro", "totaleProf"],
            campiTabella: [
                { title: " ", field: "idRS", visible: false },
                { title: "In Attività", field: "attivo", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                { title: "In Pensione", field: "pensione", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                { title: "Studente", field: "studente", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                { title: "Altro", field: "altro", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                { title: "Totale", field: "totaleProf", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", headerFilter: false },
                { title: "AGG.", field: "dtAGG", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: false }
            ],
            hTabella: "200px",
            campiCheck: [],
            campiRichiesti: ["attivo", "pensione", "studente", "altro"],
            livello: true

        };

        const pardbMat = {
            idKey: "idMateria",
            campoID: { "idRS": dataUser.idRS, "idMateria": 0 },
            tabella: "Mat",
            scheda: "schedadbMat",
            spRead: "pf_dbItaliaMaterieRead",
            spUpdate: "pf_dbItaliaMaterieUpdate",
            elencoCampi: ["idMateria", "idRS",  "materia", "gruppo", "oreErogate"],
            campiTabella: [
                { title: " ", field: "idRS", visible: false },
                { title: " ", field: "idMateria", visible: false },
                { title: "Materia", field: "materia", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true },
                { title: "Gruppo", field: "gruppo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true },
                { title: "Ore Erogate", field: "oreErogate", width: parseInt(larghezza * 0.10), sorter: "number", align: "center", bottomCalc: "sum", headerFilter: false },
                { title: "AGG.", field: "dtAGG", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: false }
            ],
            hTabella: "400px",
            campiCheck: [],
            campiRichiesti: ["oreErogate"],
            livello: true

        };

        //parUtenti = {
        //    idKey: "id",
        //    campoID: { id: 0, idRS: dataUser.idRS, idSede: Auth.idSede, idRuolo: dataUser.idRuolo },
        //    spUpdate: "admUtentiUpdate",
        //    elencoCampi: ["id", "cognome", "nome", "idRuolo", "idTipoSocioUser", "attivo", "emailUser", "emailCheck", "tel1User", "tel2User", "indirizzoUser", "comuneUser", "provUser", "capUser", "codiceFiscaleUser", "dataNascitaUser", "luogoNascitaUser", "sediUser", "privacyUser", "liberaUser", "firmaUser", "firmaDataUser"],
        //    campiRichiesti: ["cognome", "nome", "emailUser"],
        //    campiCheck: ["attivo", "privacyUser", "liberaUser", "firmaUser"],
        //    campiDefault: { idRuolo: "1", idTipoSocioUser: "0" },
        //    scheda: "schedaUser",
        //    pdf: true,
        //    codiceFiscale: true,
        //    campoCodiceFiscale: "codiceFiscaleUser",
        //    drop: true,
        //    dropGet: [parRuoli, parTipoSocio, parSedi],
        //    dropElenco: "elencoUtenti",
        //    plan: false,
        //    campoSede: "sediUser",
        //    campoRS: ["idRS"],
        //    login: { user: "username", pass: "password", email: "emailUser" },
        //    user: true
        //};

        Auth.db = "DB_ProfWeb30";
        $scope.mainMenu = true;
        $scope.db = Auth.db;
        $scope.versione = adesso();

        $(".tempo").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: "1M"
        });

        $(".tempo").datepicker($.datepicker.regional["it"]);

        var idKey = 0;
        var parametri;

        $scope.scheda = (setTab) => {
            $scope.cambia = false;
            $scope.mainInfo = true;
            idKey = 0;
            console.log(setTab);
            switch (setTab) {
                case "S":
                    $scope.titoloReport = "Studenti per Origine e Anno";
                    parametri = pardbStud;
                    break;

                case "P":
                    $scope.titoloReport = "Professori per tipologia";
                    parametri = pardbProf;
                    break;

                case "M":
                    $scope.titoloReport = "Ore erogate per materie";
                    parametri = pardbMat;
                    break;
                
            };

            console.log(parametri);

            //if (setTab !== "Z") {
            let id = parametri.idKey;
            parametri.campoID[id] = 0;
            $scope[parametri.scheda] = false;
            $scope.tabMenu = setTab;
            //};

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

        var style = new styleCell();

        const creaTabella = (larghezza, parametri, callback) => {
            //console.log(parametri);
            let tabella = parametri.tabella;
            let elencoCampi = parametri.elencoCampi;
            let campiTabella = parametri.campiTabella;
            let scheda = parametri.scheda;

            //let gruppo = !parametri.campoGruppo ? "" : parametri.campoGruppo;
            let rowHigh = !parametri.rowHigh ? "auto" : parametri.rowHigh;
            //console.log(parametri.campiTabella);
            $scope[scheda] = false;
            $("#tabella" + tabella).tabulator({
                height: parametri.hTabella,
                responsiveLayout: true,
                //layout: "fitColumns",
                resizableColumns: false,
                //groupBy: gruppo,
                sortable: false,
                colVertAlign: "center",
                selectable: 0,

                columns: campiTabella,

                index: elencoCampi[0],

                //groupToggleElement: "header",
                //groupStartOpen: false,
                //groupHeader: function (value, count, data, group) {
                //    //var testo = (count === 1 ? " Lezione Schedulata" : " Lezioni Prenotate");
                //    //return value + "<span style='color:#d00; margin-left:10px;'>(" + count + testo + ")</span>";
                //    return value + "<span style='color:#d00; margin-left:10px;'></span>";
                //},
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
                        //if (!orarioCambia && !prenotaCambia && !calendarioCambia) {
                            //console.log(parametri);
                            //console.log($scope.causaleEntrata());
                        $scope[scheda] = true;
                            //$scope.stampaPDF = $scope[scheda] * parametri.pdf;
                            //$scope.nuovaEmail = false;
                            //$scope.framePDF = false;
                            //$scope.frameRicevuta = false;
                            //$scope.tabellaCassa = true;
                        idKey = data[elencoCampi[0]];
                        var id = parametri.idKey;
                        parametri.campoID[id] = idKey;
                        console.log(data); console.log(elencoCampi[0]); console.log(id);
                        console.log(parametri);
                        drop = 1;
                        getAnagrafe(parametri);
                        Auth[id] = idKey;
                            //$scope.fileLogo = window.location.origin + "/img/logo/" + "assId" + Auth.idRS + "-sedeId" + Auth.idSede + ".jpg?ver=" + adesso();
                        $scope.$apply();
                        //};
                    } else {
                        infoDialog("Attenzione", "Non hai autorizzazione ad eseguire l'operazione");
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

            //if (parametri.campiEditor) {
            //    let campiEditor = parametri.campiEditor;
            //    campiEditor.forEach(campi => {
            //        if (!$("#container-" + campi).has(".Editor-container")[0]) {
            //            //$("#" + campi).Editor();
            //            $("#" + campi).Editor({
            //                "unlink": false, "insert_link": false, "insert_img": false, "insert_table": false,
            //                "block_quote": false, "print": false, "togglescreen": false, "source": false,
            //            });
            //        };
            //    });
            //};

            //if (parametri.campiEditor) {
            //    $(".Editor-editor").focusin(function () {
            //        $scope.cambia = true;
            //        $scope.$apply();
            //    });
            //};

            //$scope.insert = parametri.insert;

            //$scope.verificaCF = function (tipo) {
            //    if (parametri.codiceFiscale && $scope[parametri.scheda]) {
            //        let myCF = $("#codiceFiscale" + tipo).val();
            //        return controllaCF(myCF);
            //    };
            //};

        //};

        $scope.mainBack = () => {
            //$scope.avvio = true;
            //$scope.luogo = Auth.luogo;
            //window.location.href = "#/main";

        };

        const getAnagrafe = (parametri, modal, callback) => {
            let ricerca = {};
            ricerca.spRead = parametri.spRead;
            ricerca.tabella = parametri.tabella;
            ricerca.drop = drop;
            if (parametri.campoSede) {
                parametri.campoID.idSede = Auth.idSede;
            };
            $.extend(ricerca, parametri.campoID);
            //if (ricerca.id == 0 && !$scope.admin && !$scope.gestione && parametri.user) {
            //    ricerca.id = dataUser.userID;
            //};

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
                //console.log(jsonData);
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
                drop = 0;
                console.log(myData); console.log(contaRecord(myData)); console.log(id);
                switch (parseInt(id)) {

                    case -1:
                        jsonOutput = pqa + JSON.stringify(myData) + pqc;
                        tabella = "tabella" + archivio;
                        $("#" + tabella).tabulator("setData", jsonOutput);

                        $scope.cambia = false;
                        $scope[scheda] = true;
                        $scope.$apply();
                        break;

                    case 0:
                        $scope.cambia = false;
                        tabella = modal + archivio;
                        if (contaRecord(myData) > 0) {
                            jsonOutput = pqa + JSON.stringify(myData) + pqc;
                            $("#" + tabella).tabulator("setData", jsonOutput);
                        } else {
                            $("#" + tabella).tabulator("clearData");
                            jsonOutput = undefined;
                        };

                        //if (parametri.drop) {
                        //    let dropGet = parametri.dropGet;
                        //    dropGet.forEach(function (dropParametri) {
                        //        getDropElenco(dropParametri, 1, Auth.db, (dropElenco) => {
                        //            $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                        //            if (contaRecord(dropElenco) == 1) {
                        //                let tempElenco = new Array();
                        //                tempElenco.push(dropElenco)
                        //                $scope[dropParametri.dropElenco] = tempElenco;
                        //            };
                        //            //console.log(dropParametri.dropElenco);
                        //            //console.log($scope[dropParametri.dropElenco]);
                        //            if (parametri.tabella == "Calendario" && avvioCalendario) {
                        //                $scope.idMese = (parseInt(d.getMonth() + 1)).toString();
                        //                avvioCalendario = false;
                        //            };
                        //            $scope.$apply();
                        //        });
                        //    });
                        //};
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

                        //if (parametri.campiNumerici) {
                        //    let campiNumerici = parametri.campiNumerici;
                        //    campiNumerici.forEach(numero => {
                        //        $("#" + numero).val(accounting.formatMoney(myData[numero], "€ ", 2, ".", ","));
                        //        $scope[numero] = $("#" + numero).val();
                        //    });
                        //};

                        //if (parametri.campiText) {
                        //    let campiText = parametri.campiText;
                        //    campiText.forEach(campo => {
                        //        $("#" + campo).text(myData[campo]);
                        //        $scope[campo] = $("#" + campo).text();
                        //        $scope.$apply();
                        //    });
                        //};

                        //if (parametri.campiEditor) {
                        //    let campiEditor = parametri.campiEditor;
                        //    let xmlDoc = $.parseXML(response.d);
                        //    let xml = $(xmlDoc);

                        //    campiEditor.forEach(campo => {
                        //        $("#" + campo).Editor("setText", $(xml).find(campo).text()); //myData[campo]);
                        //        $scope[campo] = $("#" + campo).Editor("getText");
                        //    });

                        //    $scope.editConvocazione = true;
                        //    $scope.$apply();
                        //};

                        if (parametri.campiCheck) {
                            let campiCheck = parametri.campiCheck;
                            campiCheck.forEach((campo) => {
                                let deleted = myData[campo] == "true" || myData[campo] == 1 ? 1 : 0;
                                let campoDeleted = $("#" + campo);
                                deleted == 1 ? campoDeleted.prop("checked", true) : campoDeleted.prop("checked", false);
                                $scope[campo] = deleted == 1 ? true : false;
                            });
                        };

                        //$scope.emailCheck = () => {
                        //    emailValidata = myData["emailCheck"] == "true" ? true : false;
                        //    return (myData["emailCheck"] == "true" ? "OK" : "NV");
                        //};

                        //if (parametri.campoSede) {
                        //    let campoSede = parametri.campoSede;
                        //    let campo = myData[campoSede];
                        //    let elencoSedi = $scope.elencoSedi;
                        //    elencoSedi.forEach(function (sede) {
                        //        $("#" + campoSede + sede.idSede).prop("checked", campo.indexOf(sede.idSede) > -1 ? true : false)
                        //    })
                        //};

                        //if (parametri.campoMateriaStud) {
                        //    let campoMaterie = parametri.campoMateriaStud;
                        //    let campo = "@" + myData[campoMaterie] + "@";
                        //    let elencoMaterie = $scope.elencoMaterie;

                        //    elencoMaterie.forEach(materia => {
                        //        $("#" + campoMaterie + materia.idMateria).prop("checked", campo.indexOf("@" + materia.idMateria + "@") > -1 ? true : false)
                        //        //console.log(campo.indexOf("@" + materia.idMateria + "@"));
                        //    });
                        //};

                        //let orario = $(".orario").val().replace("-", ":");
                        //$(".orario").val(orario);

                        //if (parametri.campoMaterie) {
                        //    let campoMaterie = parametri.campoMaterie;
                        //    let elencoMaterie = $scope.elencoMaterie;

                        //    $(".selectMateriaAnni").text("");
                        //    $(".annoS").removeClass("si");
                        //    elencoMaterie.forEach((materie) => {
                        //        $("#" + campoMaterie + materie.idMateria).prop("checked", false);
                        //        $("#anni" + materie.idMateria).hide();
                        //        $("#freq" + materie.idMateria).hide();
                        //    });


                        //    let campoElenco = myData[campoMaterie].split("@");
                        //    if (campoElenco[0]) {
                        //        let campo = new Array();
                        //        let campoAnni = new Array();
                        //        campoElenco.forEach((materiaAnno) => {
                        //            campo.push(materiaAnno.split(";")[0].split("#")[1]);
                        //            campoAnni.push([materiaAnno.split(";")[0].split("#")[1], materiaAnno.split(";")[1].split("#")[1], materiaAnno.split(";")[2].split("#")[1]])
                        //        });

                        //        elencoMaterie.forEach((materie) => {
                        //            if (campo.includes(materie.idMateria)) {
                        //                $("#" + campoMaterie + materie.idMateria).prop("checked", true)
                        //                $("#anni" + materie.idMateria).show();
                        //                $("#freq" + materie.idMateria).show();

                        //                let campoAnniSel = campoAnni.filter(function (filtroMateria) {
                        //                    return filtroMateria[0] == materie.idMateria;
                        //                });
                        //                $(".scegliAnno" + materie.idMateria).each(function () {
                        //                    if (campoAnniSel[0][1].includes($(this).text())) {
                        //                        $(this).addClass("si");
                        //                    };
                        //                });
                        //                $("#selectFreqMat" + materie.idMateria).val(campoAnniSel[0][2]);

                        //                $("#anniSelect" + materie.idMateria).text("idMateria#" + materie.idMateria + "; idAnno#" + campoAnniSel[0][1] + "; idFreq#" + campoAnniSel[0][2]);
                        //            };
                        //        });
                        //    };
                        //};

                        //if (parametri.campoLezioni) {
                        //    let lezioniPrenotate = parametri.campoLezioni;
                        //    let elencoMaterie = $scope.elencoMaterie;
                        //    let campoElenco = myData[lezioniPrenotate] ? myData[lezioniPrenotate].split("@") : ["idMateria#-1;numLez#0"];
                        //    console.log(campoElenco);
                        //    if (campoElenco[0]) {
                        //        let campo = new Array();
                        //        //let campoAnni = new Array();
                        //        campoElenco.forEach((materiaAnno) => {
                        //            campo.push(materiaAnno.split(";")[0].split("#")[1]);
                        //            //campoAnni.push([materiaAnno.split(";")[0].split("#")[1], materiaAnno.split(";")[1].split("#")[1], materiaAnno.split(";")[2].split("#")[1]])
                        //        });
                        //        console.log(campo);
                        //        elencoMaterie.forEach((materie) => {

                        //            //let idMateria = materie.idMateria;
                        //            $scope.lezioniAttive = (idMateria) => {
                        //                if (campo.includes(idMateria)) {
                        //                    return true;
                        //                } else {
                        //                    return false;
                        //                };
                        //            };
                        //        });
                        //    };

                        //};

                        $scope.$apply();
                        break;
                };

                if (callback && typeof callback === "function") {
                    callback();
                };

            };

            //closeDialog();
        };

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
                aggiorna.path = parametri.path;
                aggiorna.filename = "assId" + Auth.idRS + ".jpg";

                let criterio = JSON.stringify(aggiorna);
                //console.log(criterio);
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
                        $scope.fileLogo = window.location.origin + "/img/logo/" + "assId" + Auth.idRS + ".jpg?ver=" + adesso();
                        fileText.value = "";
                        $scope.$apply();
                    }, //readPDF(path); },
                    error: (err) => { console.log(err.responseText) }

                });
            };

            reader.readAsDataURL(input.files[0]);
        };

        const updData = (parametri, callBack) => {
            
            let elencoCampi = parametri.elencoCampi;
            let campiCheck = parametri.campiCheck;
            let aggiorna = new Object();
            let campiTesto = "";

            aggiorna.spUpdate = parametri.spUpdate;

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
                        aggiorna[campo] = campoVal.replace(/([*+?^=!',:${}()|\[\]\/\\])/g, "-").toUpperCase();
                        break;
                };
            });

            campiCheck.forEach(campo => {
                aggiorna[campo] = $("#" + campo).is(":checked") ? 1 : 0;
            });


            //if (parametri.login) {
            //    let login = parametri.login;
            //    aggiorna[login.user] = aggiorna[login.email].split("@")[0];
            //    aggiorna[login.pass] = hash(aggiorna[login.email].split("@")[0]);
            //    $scope.newAss = false;
            //};

            //if ($scope.newAss) {
            //    let email = $("#sedeLegaleEmail").val();
            //    aggiorna.adminUser = email.split("@")[0];
            //    aggiorna.adminPass = hash(email.split("@")[0]);
            //    $scope.newAss = false;
            //} else {
            //    aggiorna.adminUser = " ";
            //    aggiorna.adminPass = " ";
            //};


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
                //beforeSend: openDialog,
                success: updData_success(aggiorna, callBack),
                error: (xhr, status, error) => {
                    errorDialog(xhr, status, error)
                }
            });
        };

        const updData_success = (aggiorna, callBack) => {
            return (response) => {
                let esito = parseInt(response.d);
                //console.log(aggiorna);
                //$("#p_text").text("").hide();
                switch (esito) {
                    case 1:
                        var msgText = "Scheda inserita correttamente!";

                        //getDropElenco(parametri, -1, Auth.db, function (dropElenco) {
                        //    if (contaRecord(dropElenco) == 1) {
                        //        let tempElenco = new Array();
                        //        tempElenco.push(dropElenco)
                        //        $scope[parametri.dropElenco] = tempElenco;
                        //    } else {
                        //        $scope[parametri.dropElenco] = dropElenco;
                        //    };

                        //    $scope.selectAss(aggiorna.idRS);

                        //    $scope.$apply();
                           
                        //});
                        
                        break;

                    case 2:
                        var msgText = "Dati già presente in archivio!";

                        break;

                    case 3:
                        var msgText = "Dati aggiornati con successo!";
                        //getDropElenco(parametri, -1, Auth.db, function (dropElenco) {
                        //    if (contaRecord(dropElenco) == 1) {
                        //        let tempElenco = new Array();
                        //        tempElenco.push(dropElenco)
                        //        $scope[parametri.dropElenco] = tempElenco;
                        //    } else {
                        //        $scope[parametri.dropElenco] = dropElenco;
                        //    };

                        //    $scope.selectAss(aggiorna.idRS);

                        //    $scope.$apply();
                            
                        //});

                        break;

                };

                //$("#p_text").text(msgText).fadeIn(500).fadeOut(4000, function () {
                //    $("#p_text").text("---").show();
                //});

                $scope.cambia = false;
                //infoDialog("Informazione di Sistema", msgText);
                $scope.$apply();

                if (callBack && typeof (callBack) === "function") {
                    callBack();
                };
            };

        };

        //getDropElenco (parametri, -1, Auth.db, (dropElenco) => {
        //    if (contaRecord(dropElenco) == 1) {
        //        let tempElenco = new Array();
        //        tempElenco.push(dropElenco)
        //        $scope[parametri.dropElenco] = tempElenco;
        //    } else {
        //        $scope[parametri.dropElenco] = dropElenco;
        //    };
        //    //console.log(dropElenco);
        //    $scope.versione = adesso();
        //    $scope.$apply();
        //});

        //$scope.unSelect = (modulo) => {
        //    return $scope.vista !== modulo && $scope.elencoAss;
        //};

        //$scope.selectAss = (ass) => {
        //    fileText.value = "";
        //    let elencoCampi = parametri.elencoCampi;
        //    let campiCheck = parametri.campiCheck;

        //    if (ass > 0) {
        //        let elencoAss = $scope[parametri.dropElenco];
        //        let selectAss = elencoAss.filter((myAss) => {
        //            return myAss.idRS == ass;
        //        });

        //        let myData = selectAss[0];

        //        Auth.idRS = myData.idRS;
        //        console.log(myData);
        //        //let elencoCampi = parametri.elencoCampi;
        //        elencoCampi.forEach(campo => {
        //            $("#" + campo).val(myData[campo]);
        //            $scope[campo] = myData[campo];
        //        });


        //        campiCheck.forEach(campo => {
        //            $("#" + campo).prop("checked", myData[campo] == "true" ? true : false);
        //            $scope[campo] = myData[campo] == "true" ? true : false;
        //        });

        //        $scope.fileLogo = window.location.origin + myData.imgPath + "assId" + myData.idRS + ".jpg?ver=" + adesso();

        //        let campiRichiesti = parametri.campiRichiesti;
        //        campiRichiesti.forEach(campo => {
        //            $("#" + campo).addClass("activeTab");
        //        });

        //        $scope.logoAss = undefined;
        //        $("#logoAss").val(undefined);

        //        $scope.cambia = false;
        //        $scope.mainMenu = false;

        //    } else if (ass == 0 && dataUser.idRuolo != 9) {
        //        $scope.newAss = true;

        //        elencoCampi.forEach(campo => {
        //            $("#" + campo).val("");
        //            $scope[campo] = "";
        //        });

        //        campiCheck.forEach(campo => {
        //            $("#" + campo).prop("checked", false);
        //            $scope[campo] = false;
        //        });

        //        $scope.fileLogo = window.location.origin + "assId0.jpg?ver=" + adesso();

        //        let campiRichiesti = parametri.campiRichiesti;
        //        campiRichiesti.forEach(campo => {
        //            $("#" + campo).addClass("activeTab");
        //        });

        //        $scope.logoAss = undefined;
        //        $("#logoAss").val(undefined);

        //        $scope.cambia = false;
        //        $scope.mainMenu = false;

        //    } else if (ass == 'IT') {
        //        console.log(ass)
        //        window.location.href = "#/controlloItalia";
        //    };

            //let campiRichiesti = parametri.campiRichiesti;
            //campiRichiesti.forEach(campo => {
            //    $("#" + campo).addClass("activeTab");
            //});

            //$scope.logoAss = undefined;
            //$("#logoAss").val(undefined);

            //$scope.cambia = false;
            //$scope.mainMenu = false;


            //console.log($scope.fileLogo);
            //$scope.$apply();

        //};

        //$scope.mainBack = () => {
        //    fileText.value = "";
        //    $("#upload").prop("disabled", false);
        //    $("#upload").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Carica File e aggiorna DB');
        //    $("#btn_loadFile").hide();

        //    $(".tab-pane").each(function() {
        //        $(this).removeClass("in active");
        //    });
        //    $("#anagrafeAss").addClass("in active");

        //    $(".barMenuCmd").each(function () {
        //        $(this).removeClass("active");
        //    });
        //    $(".primo").addClass("active");

        //    $scope.versione = adesso();
        //    $scope.cambia = false;
        //    $scope.mainMenu = true;
        //};

        $scope.salvaInfo = (idRS) => {
            $scope.cambia = false;
            $scope[parametri.scheda] = false;
            updData(parametri, () => {
                let id = parametri.idKey;
                parametri.campoID[id] = 0;
                getAnagrafe(parametri, "tabella", () => {
                    $("#tabella" + parametri.tabella).tabulator("redraw");
                });
            });
        };

        $scope.annullaInfo = (idRS) => {
            $scope.cambia = false;
            $scope[parametri.scheda] = false;
            let id = parametri.idKey;
            parametri.campoID[id] = 0;
            getAnagrafe(parametri);
        };

        $scope.chiudiInfo = () => {
            $scope.cambia = false;
            $scope.mainInfo = false;
            $scope.$apply();
        };

        $scope.backHome = () =>  {
            //$scope.luogo = "";
            //Auth.luogo = "";
            window.location.href = "#/main";
        };


        $scope.campiValidati = () => {
            let campiRichiesti = parametri.campiRichiesti;
            let campiCompilati = 1

            campiRichiesti.forEach((campo) => {
                campiCompilati = campiCompilati * (!$scope[campo] ? 0 : 1);
            });

            return campiCompilati === 0 ? false : true;
        };

        $("#fileUpload").change((e) => {
            e.preventDefault();
            var myFile = fileUpload.value;
            console.log(myFile);

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

        $scope.logoutUser = () =>  {
            Auth.userLogged = false;
            $scope.userLogged = Auth.userLogged;
            $scope.cambia = false;


            $scope.admin = false;
            $scope.gestione = false;
            $scope.lettura = false;
            $scope.modifica = false;

            Auth.ruoloCambia = false;
            Auth.avvio = false;

            dataUser = {};

            $("#typeConnect").text("Disconnesso");
            $("#iconConnect").html("<span class='glyphicon glyphicon-remove'></span>");
            $("#nameUser").text(" ");
            $("#ruoloUser").text(" ");
            $("#iconUser").text(" ");

            window.location.href = "#/utentiLogin";

        };
    
    });

    //------------------------------End ctrl-main controller--------------------------------------------//


})();