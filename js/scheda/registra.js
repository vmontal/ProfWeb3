//------------------------------Begin ctrl-anagrafe controller--------------------------------------------//
'use strict';

(function () {

    var registra = angular.module("registra", []);
    //console.log("anagrafe: " + versione);
    registra.controller("ctrl-registra", function ($scope, $http, dataUser, Auth, mask) {
        //Auth.userLogged = true;

        var largo = $(window).width();
        var alto = $(window).height();

        var mobile = largo < 750 ? true : false;
        $(".fuoriMenu").hide();

        Auth.userPublic = true;
        $scope.formRegistra = false;

        if (Auth.userPublic) {
            $("#registraWeb").show();
            //console.log($scope.from);
            var larghezza = parseInt($("#divMenu").width() * 0.75);
            $scope.cambia = true;

            //$scope.delete = false;
            //$scope.selectStud = false;  //isolato verificare utilizzo!     

            //var insert = true;
            //var lezione = false;
            //var orarioCambia = false;
            var imgKO = "ack-KO.png";
            var imgOK = "ack-OK.png";


            $http.get("/dati/json/privacy.json?ver=" + versione).then(function (response) {
                $scope.dropPrivacy = response.data;
            });

            $scope.scelta = false;

            $scope.sede = function (sede) {
                switch (sede) {
                    case 'E':
                        Auth.db = "DB_Ernesto";
                        $scope.luogo = "Via Campolo presso Parrocchia S. Ernesto";
                        break;

                    case 'B':
                        Auth.db = "DB_Basilio";
                        $scope.luogo = "Via Paruta presso Parrocchia S. Basilio";
                        break;
                };

                $scope.scelta = true;
                $scope.formRegistra = true;

                var dropGet = parametri.dropGet;
                dropGet.forEach(function (dropParametri) {
                    getDropElenco(dropParametri, 1, Auth.db, function (dropElenco) {
                        $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                        //console.log($scope[dropParametri.dropElenco]);
                    });
                });

            };

            $scope.verificaCF = function () {
                var myCF = $("#codiceFiscaleStud").val();
                var checkCF = controllaCF(myCF);
                if (checkCF == "OK") {
                    $scope.cambia = true;
                };
                return checkCF;
            };

            var mail_success = function (parInvio) {
                //closeDialog();
                $scope.formRegistra = false;
                $scope.annullaScheda();
                $scope.$apply();
            };

            var parIstituti = {
                idKey: "CODICEISTITUTO",
                campoID: { "CODICEISTITUTO": 0 },
                tabella: "Istituti",
                spCreate: "pf_anagrafeIstitutiCreate",
                spRead:   "pf_anagrafeIstitutiRead",
                spUpdate: "pf_anagrafeIstitutiUpdate",
                spDelete: "pf_anagrafeIstitutiDelete",
                elencoCampi: ["CODICEISTITUTO", "ISTITUTO", "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA", "INDIRIZZO", "CAP", "COMUNE", "PROVINCIA", "REGIONE", "INDIRIZZOEMAILSCUOLA", "INDIRIZZOPECSCUOLA", "SITOWEBSCUOLA"],
                campiTabella: [
                    { title: "CODICE", field: "CODICEISTITUTO", visible: false },
                    //{ title: "Elenco " + parametri.tabella, field: "elenco", mutator: function (value, data, type, mutatorParams, cell) { return data[elencoCampi[1]] + " - " + data[elencoCampi[2]] + " - " + data[elencoCampi[3]] + " - " + data[elencoCampi[4]]; }, width: parseInt(larghezza * 0.80) * mobile, sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                    { title: "Elenco Istituti", field: "ISTITUTO", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                    { title: "Tipo", field: "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                    { title: "Indirizzo", field: "INDIRIZZO", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 3 },
                ],
                campiRichiesti: ["CODICEISTITUTO", "ISTITUTO", "DESCRIZIONETIPOLOGIAGRADOISTRUZIONESCUOLA"],
                scheda: "schedaIst",
                drop: false,
                dropElenco: "elencoIstituti"
            };

            var parStudenti = {
                idKey: "idStudente",
                campoID: { "idStudente": 0 },
                tabella: "Studenti",
                spRead: "pf_anagrafeStudentiRead",
                spUpdate: "pf_anagrafeStudentiUpdate",
                spDelete: "pf_anagrafeStudentiDelete",
                elencoCampi: ["idStudente", "nomeStud", "istitutoNome", "istitutoTipo", "emailStud", "emailCheck", "tel1Stud", "tel2Stud", "indirizzoStud", "comuneStud", "provStud", "capStud", "anno", "codiceFiscaleStud", "dataNascitaStud", "luogoNascitaStud", "notaStud", "idIstituto", "privacyStud", "liberaStud", "firmaStud", "firmaDataStud"],
                campiTabella: [
                    { title: "", field: "idStudente", visible: false },
                    //{ title: "Elenco " + parametri.tabella, field: "elenco", mutator: function (value, data, type, mutatorParams, cell) { return data[elencoCampi[1]] + " - " + data[elencoCampi[2]] + " - " + data[elencoCampi[3]] + " - " + data[elencoCampi[4]]; }, width: parseInt(larghezza * 0.80) * mobile, sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                    { title: "Elenco Studenti", field: "nomeStud", width: parseInt(larghezza * 0.30), sorter: "string", align: "left", headerFilter: true, responsive: 0 },
                    { title: "Istituto", field: "istitutoNome", width: parseInt(larghezza * 0.25), sorter: "string", align: "left", headerFilter: true, responsive: 2 },
                    { title: "Indirizzo", field: "istitutoTipo", width: parseInt(larghezza * 0.20), sorter: "string", align: "left", headerFilter: true, responsive: 3 },
                    { title: "Anno", field: "anno", width: parseInt(larghezza * 0.10), sorter: "string", align: "center", headerFilter: true, responsive: 4 },
                    { title: "Attivo", field: "deletedStud", formatter: mask.cellAttiva, headerFilter: false} //, formatter: "tickCross" }
                ],
                campiRichiesti: ["nomeStud", "idIstituto", "anno", "emailStud", "tel1Stud", "tel2Stud", "comuneStud", "provStud", "capStud", "indirizzoStud", "dataNascitaStud", "luogoNascitaStud", "privacyStud", "liberaStud"],
                campiCheck: ["privacyStud", "liberaStud", "firmaStud"],
                codiceFiscale: true,
                scheda: "schedaStud",
                drop: true,
                dropGet: [parIstituti],
                dropElenco: ""
            };

            $(".tempo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: "1D"
            });

            $(".tempo").datepicker($.datepicker.regional["it"]);

            var idKey = 0;
            var parametri = parStudenti;

            var campiRichiesti = parametri.campiRichiesti;
            campiRichiesti.forEach(function (campo) {
                $("#" + campo).addClass("activeTab");
            });

            $scope.campiValidati = function () {
                var campiRichiesti = parametri.campiRichiesti;
                var compilati = 1;
                var campiCompilati = 1;
                campiRichiesti.forEach(function (campo) {
                    campiCompilati = campiCompilati * (!$scope[campo] ? 0 : 1);
                });

                var myCF = $("#codiceFiscaleStud").val();
                var cf = !myCF ? 1 : controllaCF(myCF) == "OK" ? 1 : 0;

                compilati = campiCompilati * cf;

                return (compilati === 0 ? false : true);
            };

            var updAnagrafe = function (parametri) {
                var elencoCampi = parametri.elencoCampi;

                var aggiorna = {};
                aggiorna.spUpdate = parametri.spUpdate;
                aggiorna.delete = 0;
                aggiorna.deletedStud = 0;

                elencoCampi.forEach(function (campo) {
                    var campoVal = $("#" + campo).val();
                    switch (campoVal) {
                        case undefined:
                            aggiorna[campo] = " ";
                            break;

                        case null:
                            aggiorna[campo] = 0;
                            break;

                        default:
                            aggiorna[campo] = campoVal.replace(/([*+?^=!':,${}()|\[\]\/\\])/g, "-").toUpperCase();
                    };

                    if (parametri.campiCheck) {
                        var campiCheck = parametri.campiCheck;
                        campiCheck.forEach(function (campo) {
                            aggiorna[campo] = $("#" + campo).is(":checked") ? 1 : 0;
                        });
                    };
                });

                var criterio = {
                    data: JSON.stringify(aggiorna),
                    db: Auth.db
                };
                criterio = JSON.stringify(criterio);
                //console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/appGetData.aspx/updData",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog, 
                    success: updAnagrafe_success(parametri, aggiorna),
                    error: errorDialog
                });
            };

            var updAnagrafe_success = function (parametri, aggiorna) {
                return function (response) {
                    var esito = parseInt(response.d);
                    var scheda = parametri.scheda;
                    aggiorna.db = Auth.db;

                    switch (esito) {

                        case 1:
                            $scope.formRegistra = false
                            var form = "Stud";                            
                            //var msgTipo = "";
                            //var msgText = "Scheda inserita correttamente!";
                            //var msgImg = imgOK;
                            //$scope.annullaScheda();
                            $scope.$apply();
                            sendMailInsert(parametri, aggiorna, form, true);
                            break;

                        case 2:
                            var msgTipo = "";
                            var msgText = "Scheda già presente in archivio - Indirizzo email duplicato!"
                            var msgImg = imgKO;
                            infoDialog(msgText, msgTipo, msgImg, largo);
                            break;

                        case 3:
                            var msgTipo = "";
                            var msgText = "Dati aggiornati con successo!";
                            var msgImg = imgOK;
                            infoDialog(msgText, msgTipo, msgImg, largo);
                            break;

                    };

                };
            };


            $scope.salvaScheda = function () {
                updAnagrafe(parametri);
            };

            $scope.annullaScheda = function () {
                console.log("click");
                var elencoCampi = parametri.elencoCampi;
                var campiRichiesti = parametri.campiRichiesti;

                elencoCampi.forEach(function (campo) {
                    $("#" + campo).val(undefined);
                    $scope[campo] = $("#" + campo).val();
                });

                //campiRichiesti.forEach(function (campo) {
                //    $("#" + campo).addClass("activeTab");
                //});

                $scope.formRegistra = false;
                $scope.scelta = false;

            };

            $(window).resize(function () {
                larghezza = parseInt($("#divHeader").width() * 0.75);
                mobile = largo < 768 ? true : false;
            });

        };
    });
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();