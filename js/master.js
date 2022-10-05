//------------------------------Begin ctrl-main controller--------------------------------------------//
'use strict';

(function () {

    var master = angular.module("master", []);

    master.controller("ctrl-master", function ($scope, $http, dataUser, Auth) {
        
        $("#master").show();
        console.log(dataUser);
        Auth.idRS = 0;
        $scope.userID = dataUser.userID;
        $scope.idRuolo = dataUser.idRuolo;

        var myEvent;

        const parAss = {
            idKey: "idRS",
            campoID: { "idRS": 0 },
            tabella: "Associazioni",
            spRead: "pf_parAssociazioniRead",
            spUpdate: "pf_parAssociazioniUpdate",
            elencoCampi: ["idRS", "ragioneSociale", "sedeLegaleIndirizzo", "sedeLegaleLuogo", "sedeLegalePR", "sedeLegaleCAP", "sedeLegaleTEL1", "sedeLegaleTEL2", "sedeLegaleEmail", "sedeLegalePEC", "sedeLegaleCF", "sedeLegaleWEB", "registroNR", "registroDataGMA", "imgPath", "deletedAss", "prof"],
            campiCheck: ["deletedAss", "prof"],
            campiRichiesti: ["ragioneSociale", "sedeLegaleCF", "sedeLegaleEmail", "sedeLegaleTEL1"],
            dropElenco: "elencoAss",
            path: "img/logo/"
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
        $scope.newAss = false;

        $(".tempo").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: "1M"
        });

        $(".tempo").datepicker($.datepicker.regional["it"]);

        var parametri = parAss;

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

            if ($scope.newAss) {
                let email = $("#sedeLegaleEmail").val();
                aggiorna.adminUser = email.split("@")[0];
                aggiorna.adminPass = hash(email.split("@")[0]);
                $scope.newAss = false;
            } else {
                aggiorna.adminUser = " ";
                aggiorna.adminPass = " ";
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
                $("#p_text").text("").hide();
                switch (esito) {
                    case 1:
                        var msgText = "Scheda inserita correttamente!";

                        getDropElenco(parametri, -1, Auth.db, function (dropElenco) {
                            if (contaRecord(dropElenco) == 1) {
                                let tempElenco = new Array();
                                tempElenco.push(dropElenco)
                                $scope[parametri.dropElenco] = tempElenco;
                            } else {
                                $scope[parametri.dropElenco] = dropElenco;
                            };
                            
                            $scope.selectAss(aggiorna.idRS);

                            $scope.$apply();
                           
                        });
                        
                        break;

                    case 2:
                        var msgText = "Dati già presente in archivio!";

                        break;

                    case 3:
                        var msgText = "Dati aggiornati con successo!";
                        getDropElenco(parametri, -1, Auth.db, function (dropElenco) {
                            if (contaRecord(dropElenco) == 1) {
                                let tempElenco = new Array();
                                tempElenco.push(dropElenco)
                                $scope[parametri.dropElenco] = tempElenco;
                            } else {
                                $scope[parametri.dropElenco] = dropElenco;
                            };

                            $scope.selectAss(aggiorna.idRS);

                            $scope.$apply();
                            
                        });

                        break;

                };

                $("#p_text").text(msgText).fadeIn(500).fadeOut(4000, function () {
                    $("#p_text").text("---").show();
                });

                //if ($scope.newAss) {
                //    updData(parUtenti);
                //}; // = false;
            };

        };

        getDropElenco (parametri, -1, Auth.db, (dropElenco) => {
            if (contaRecord(dropElenco) == 1) {
                let tempElenco = new Array();
                tempElenco.push(dropElenco)
                $scope[parametri.dropElenco] = tempElenco;
            } else {
                $scope[parametri.dropElenco] = dropElenco;
            };
            console.log(dropElenco);
            $scope.versione = adesso();
            $scope.$apply();
        });

        $scope.unSelect = (modulo) => {
            return $scope.vista !== modulo && $scope.elencoAss;
        };

        $scope.selectAss = (ass) => {
            fileText.value = "";
            let elencoCampi = parametri.elencoCampi;
            let campiCheck = parametri.campiCheck;

            if (ass > 0) {
                let elencoAss = $scope[parametri.dropElenco];
                let selectAss = elencoAss.filter((myAss) => {
                    return myAss.idRS == ass;
                });

                let myData = selectAss[0];

                Auth.idRS = myData.idRS;
                console.log(myData);
                //let elencoCampi = parametri.elencoCampi;
                elencoCampi.forEach(campo => {
                    $("#" + campo).val(myData[campo]);
                    $scope[campo] = myData[campo];
                });


                campiCheck.forEach(campo => {
                    $("#" + campo).prop("checked", myData[campo] == "true" ? true : false);
                    $scope[campo] = myData[campo] == "true" ? true : false;
                });

                $scope.fileLogo = window.location.origin + myData.imgPath + "assId" + myData.idRS + ".jpg?ver=" + adesso();

                let campiRichiesti = parametri.campiRichiesti;
                campiRichiesti.forEach(campo => {
                    $("#" + campo).addClass("activeTab");
                });

                $scope.logoAss = undefined;
                $("#logoAss").val(undefined);

                $scope.cambia = false;
                $scope.mainMenu = false;

            } else if (ass == 0 && dataUser.idRuolo != 9) {
                $scope.newAss = true;

                elencoCampi.forEach(campo => {
                    $("#" + campo).val("");
                    $scope[campo] = "";
                });

                campiCheck.forEach(campo => {
                    $("#" + campo).prop("checked", false);
                    $scope[campo] = false;
                });

                $scope.fileLogo = window.location.origin + "assId0.jpg?ver=" + adesso();

                let campiRichiesti = parametri.campiRichiesti;
                campiRichiesti.forEach(campo => {
                    $("#" + campo).addClass("activeTab");
                });

                $scope.logoAss = undefined;
                $("#logoAss").val(undefined);

                $scope.cambia = false;
                $scope.mainMenu = false;

            } else if (ass == 'IT') {
                console.log(ass)
                window.location.href = "#/controlloItalia";
            };

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

        };

        $scope.mainBack = () => {
            fileText.value = "";
            $("#upload").prop("disabled", false);
            $("#upload").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Carica File e aggiorna DB');
            $("#btn_loadFile").hide();

            $(".tab-pane").each(function() {
                $(this).removeClass("in active");
            });
            $("#anagrafeAss").addClass("in active");

            $(".barMenuCmd").each(function () {
                $(this).removeClass("active");
            });
            $(".primo").addClass("active");

            $scope.versione = adesso();
            $scope.cambia = false;
            $scope.mainMenu = true;
        };

        $scope.salvaAss = () => {            
            if ($scope.newAss) {
                $("#idRS").val(0);
                $scope.idRS = 0;
            };
            updData(parametri);
        };

        $scope.backHome = () =>  {
            $scope.luogo = "";
            Auth.luogo = "";
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