//------------------------------------ Begin ctrl-login controller----------------------------------------------//
'use strict';

(function () {

    var utentiLogin = angular.module("utentiLogin", []);
    //console.log("utentiLogin: " + versione);

    utentiLogin.controller("ctrl-login", function ($scope, $http, dataUser, Auth) {

        $("#schedaLogin").show();
        $("#accedi").prop("disabled", false);

        $scope.login = true;
        $scope.luogo = Auth.luogo;
        $scope.versione = adesso();

        $scope.utente = $("#utente").val();
        $scope.password = $("#password").val();
        $("#utente").focus();

        var checkApp = 0;
        var newPass = "";

        const clear_userID = (id, callback) => {
            dataUser.userID = 0;
            dataUser.idRuolo = 0;
            dataUser.cercaID = 0;
            dataUser.cercaUserName = "";
            dataUser.user = "";
            dataUser.ruolo = "";
            dataUser.username = "";
            dataUser.ID_Gruppo = 0;
            dataUser.record = {};
            dataUser.ragioneSociale = "";
            dataUser.path = "";
            dataUser.sedeLegaleEmail = "";
            $scope.utente = "";
            $("#utente").val("");
            $scope.password = "";
            $("#password").val("")

            $("#utente").focus();

            if (parseInt(id) < 0) {
                window.location.href = "#/main";
            };

            if (callback && typeof callback == "function") {
                callback()
            };
        };

        const parSedi = {
            idKey: "idSede",
            campoID: { idSede: 0, idRS: 0 },
            tabella: "Sedi",
            spRead: "pf_parSediRead",
            spUpdate: "pf_parSediUpdate",
            dropElenco: "elencoSedi"
        };

        const parOre = {
            idKey: "idOra",
            campoID: { idOra: 0, idSede: 0, idRS: 0 },
            tabella: "Ore",
            spRead: "pf_parOreRead",
            spUpdate: "pf_parOreUpdate",
            dropElenco: "elencoOre",
        };

        //-----------------------------Procedura di Login-------------------------//
        $scope.accedi = () => {
            $("#accedi, .verifica").prop("disabled", true);
            $("#accedi").html('<i class="fa fa-spinner fa-spin"></i> Verifica in corso...');

            setTimeout(() => {
                var criterio = {};
                criterio.utente = $.trim($("#utente").val());
                //criterio.password = $.trim($("#password").val());
                criterio.password = hash($.trim($("#password").val()));
                criterio.db = Auth.db;
                criterio = JSON.stringify(criterio);
                //console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/gestioneUtenti.aspx/admLogin",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: accedi_success,
                    error: (xhr, status, error) => {
                        let tipoAlert = xhr.responseJSON.Message;
                        let tipoMsg = "";
                        let tipoImg = "KO.png";
                        $("#accedi").html('<i class="fa fa-exclamation-triangle"></i> Accesso Negato!');  
                        $("#msgConnect").text(tipoAlert).fadeOut(2000, function () {clear_userID(-1); });                        
                        //errorDialog(xhr, status, error);
                    }
                });

            }, 100);
        };

        const accedi_success = (response) => {
            //console.log(response);
            let tipoAlert, tipoMsg, tipoImg;
            let dataLogin = xml2json(response.d).NewDataSet.Utente;
            //let dataLogin = (response.d).Utente;

            dataUser.userID = parseInt(dataLogin.id);
            console.log(dataLogin);
            let idRuolo = parseInt(dataLogin.idRuolo);
            switch (idRuolo) {
                case 9:
                    clear_userID(dataUser.userID, () => {
                        dataUser.idRuolo = parseInt(dataLogin.idRuolo);
                        $("#typeConnect").html("Connesso");
                        $("#iconConnect").html("<span class='glyphicon glyphicon-off'></span>");

                        $("#nameUser").html(">> " + dataLogin.username + " <<  ");
                        $("#ruoloUser").html(">> --- <<  ");

                        window.location.href = "#/master";
                    });
                    break;

                case 10:
                    clear_userID(dataUser.userID, () => {
                        dataUser.idRuolo = parseInt(dataLogin.idRuolo);
                        $("#typeConnect").html("Connesso");
                        $("#iconConnect").html("<span class='glyphicon glyphicon-off'></span>");

                        $("#nameUser").html(">> " + dataLogin.username + " <<  ");
                        $("#ruoloUser").html(">> --- <<  ");

                        window.location.href = "#/master";
                    });
                    break;

                case -1:
                    tipoAlert = "Verifica Utente e Password";
                    tipoMsg = "";
                    tipoImg = "KO.png";

                    $("#accedi").html('<i class="fa fa-exclamation-triangle"></i> Accesso Negato!');  
                    $("#msgConnect").text(tipoAlert).fadeOut(2500, () => {
                        clear_userID(dataUser.userID, () => {
                            window.location.reload();
                        });
                    });
                    break;

                case -2:
                    tipoAlert = "Utente non Attivo";
                    tipoMsg = "";
                    tipoImg = "KO.png";

                    $("#accedi").html('<i class="fa fa-exclamation-triangle"></i> Accesso Negato!');
                    $("#msgConnect").text(tipoAlert).fadeOut(2500, () => {
                        clear_userID(dataUser.userID, () => {
                            window.location.reload();
                        });
                    });
                    break;

                default:
                    Auth.modificaUtenti = false;
                    Auth.ruoloCambia = dataLogin.cambiaPassword == "true" ? true : false;
                    
                    dataUser.user = dataLogin.nome + " " + dataLogin.cognome;
                    dataUser.idRS = dataLogin.idRS;
                    dataUser.username = dataLogin.username;
                    dataUser.idRuolo = dataLogin.idRuolo;
                    dataUser.ruolo = dataLogin.ruolo;
                    dataUser.email = dataLogin.emailUser;
                    dataUser.sediUser = dataLogin.sediUser;
                    dataUser.ragioneSociale = dataLogin.ragioneSociale;
                    dataUser.sedeLegaleIndirizzo = dataLogin.sedeLegaleIndirizzo;
                    dataUser.sedeLegalePR = dataLogin.sedeLegalePR;
                    dataUser.sedeLegaleCAP = dataLogin.sedeLegaleCAP;
                    dataUser.sedeLegaleLuogo = dataLogin.sedeLegaleLuogo;
                    dataUser.sedeLegaleCF = dataLogin.sedeLegaleCF;
                    dataUser.registroNR = dataLogin.registroNR;
                    dataUser.registroData = dataLogin.registroData;
                    dataUser.sedeLegaleEmail = dataLogin.sedeLegaleEmail;
                    dataUser.path = dataLogin.imgPath;
                    dataUser.prof = dataLogin.prof == "true" ? true: false;

                    parSedi.campoID.idRS = dataLogin.idRS;
                    parOre.campoID.idRS = dataLogin.idRS;

                    if (Auth.ruoloCambia) {
                        Auth.resetPass = "auto";
                        tipoAlert = "Benvenuto, " + dataUser.user + "!";
                        tipoMsg = "Reimposta la tua password; <br /> <strong> minimo 8 caratteri</strong> e non può essere uguale / simile al tuo nomeutente!"
                        tipoImg = "";
                        window.location.href = "#/utentiProfilo";

                    } else {
                        Auth.ruoloAdmin = dataLogin.admin == "true" ? true : false;       // $(xml).find("admin").text() == "true" ? true : false;
                        Auth.ruoloGestione = dataLogin.gestione == "true" ? true : false; // $(xml).find("gestione").text() == "true" ? true : false;
                        Auth.ruoloModifica = dataLogin.modifica == "true" ? true : false; // $(xml).find("modifica").text() == "true" ? true : false;
                        Auth.ruoloLettura =  dataLogin.lettura == "true" ? true : false;  // $(xml).find("lettura").text() == "true" ? true : false;
                        Auth.privacy =  dataLogin.privacyUser == "true" ? true : false;   // $(xml).find("privacyUser").text() == "true" ? true : false;

                        Auth.userLogged = true;
                        Auth.userPublic = true;
                        
                        $scope.admin =    Auth.ruoloAdmin;
                        $scope.gestione = Auth.ruoloGestione;
                        $scope.modifica = Auth.ruoloModifica;
                        $scope.lettura =  Auth.ruoloLettura;

                        $scope.userLogged = Auth.userLogged;

                        $scope.$apply();

                        $("#typeConnect").html("Connesso");
                        $("#iconConnect").html("<span class='glyphicon glyphicon-off'></span>");

                        $("#nameUser").html(">> " + dataUser.user + " <<  ");
                        $("#ruoloUser").html(">> " + dataUser.ruolo + " <<  ");
                        //$("#iconUser").html("<span class='glyphicon glyphicon-user'></span>");

                        tipoAlert = "Benvenuto, " + dataUser.user + "!";
                        tipoMsg = ""
                        tipoImg = "OK.png";

                        getDropElenco(parSedi, 1, Auth.db, (dropElenco) => {
                            let sediUser = dataUser.sediUser;
                            let elencoSedi;
                            if (contaRecord(dropElenco) == 1) {
                                let tempElenco = new Array();
                                tempElenco.push(dropElenco)
                                elencoSedi = tempElenco;
                            } else if (contaRecord(dropElenco) == 0) {
                                elencoSedi = new Array();
                            } else {
                                elencoSedi = dropElenco;
                            };
                            console.log(elencoSedi);
                            elencoSedi = elencoSedi.filter((sede) => {
                                return sediUser.indexOf(sede.idSede) > -1;
                            });

                            $scope[parSedi.dropElenco] = elencoSedi;
                            Auth.elencoSedi = elencoSedi;
                            $scope.$apply();
                        });

                        getDropElenco(parOre, 0, Auth.db, (dropElenco) => {
                            Auth[parOre.dropElenco] = dropElenco;
                            //console.log(parOre.dropElenco);
                            //console.log(Auth[parOre.dropElenco]);
                        });

                        //window.location.href = !Auth.from ? "#/main" : Auth.from;
                        //console.log(dataUser);
                        if (dataUser.prof) {
                            window.location.href = "#/main";
                        } else {
                            window.location.href="#/dbItalia"
                        };
                      
                    };
                    break;
            };
        };

        //------------------------- Procedure di reset password ----------------------------//
        
        $scope.reset = function () {
            $scope.login = !$scope.login;
        };

        //$scope.resetAnnulla = function () {
        //    $scope.login = true;
        //};

        $scope.resetAccount = function () {
            var textModal = "Invio Mail Reset Utente in corso..."
            var imgModal = "gear1.gif";
            runDialog(textModal, imgModal, () => {

                //setTimeout(function () {
                newPass = String.fromCharCode(65 + parseInt(Math.random() * 25)) + String.fromCharCode(97 + parseInt(Math.random() * 25)) + parseInt(Math.random() * 100000) + String.fromCharCode(65 + parseInt(Math.random() * 25)) + String.fromCharCode(97 + parseInt(Math.random() * 25));
                let parametri = {};
                parametri.email = $("#emailAccount").val();
                parametri.newPass = hash(newPass);               
                parametri.db = Auth.db;
                
                let criterio = JSON.stringify(parametri);
                console.log(criterio);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/gestioneUtenti.aspx/admResetUtente",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: resetAccount_success,
                    error: errorDialog
                });
                //}, 100);
            });
        };

        const resetAccount_success = (response) => {
            //var xmlDoc = $.parseXML(response.d);
            //var xml = $(xmlDoc);
            let myData = xml2json(response.d).NewDataSet["reset"]
            var ID = parseInt(myData.OK); // $(xml).find("OK").text();
            console.log(ID);
            switch (ID) {
                case 0:
                    var tipoAlert = "";
                    var tipoMsg = "Email non presente in archivio";
                    infoDialog(tipoMsg, tipoAlert, imgKO);
                    break;

                case 1:
                    mailResetAccount(newPass);
                    Auth.resetPass = "utente";
                    break;
            };
            $scope.login = true;
            $scope.$apply();
        };

        const mailResetAccount = (newPass) => {
            var parInvio = {};
            parInvio.mail = $("#emailAccount").val();
            parInvio.user = $("#emailAccount").val().split("@")[0];
            parInvio.np = newPass;
            parInvio.db = Auth.db;
            var criterio = JSON.stringify(parInvio);
            console.log(criterio);
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/gestioneUtenti.aspx/mailResetUtente",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: runDialog(textModal, imgModal),
                success: mailResetAccount_success,
                error: errorDialog
            });

        };

        const mailResetAccount_success = (response) => {
            console.log(xml2json(response.d));
            let dataReset = xml2json(response.d)["sendmail"];
            closeDialog();  
            //var xmlDoc = $.parseXML(response.d);
            //var xml = $(xmlDoc);
            let esito = dataReset.esito; // $(xml).find("esito").text();
            let codice = dataReset.codice; // $(xml).find("codice").text();
            let imgMsg;
            if (codice == 1) {imgMsg = imgOK } else { imgMsg = imgKO };
            infoDialog("Invio Mail", esito, imgMsg);
            window.location.href = "#/utentiLogin";
            $scope.login = true;
        };


        //----------------- recupera query parameters ----------------//
        const GetQueryStringParams = (sParam) => {
            let sPageURL = window.location.search.substring(1);
            let sURLVariables = sPageURL.split('&');
            let lenURLVariables = sURLVariables.length;
            for (let i = 0; i < lenURLVariables; i++) {
                let sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] == sParam) {
                    return sParameterName[1];
                };
            };
        };
    });

})();

//------------------------------End crtl-login controller--------------------------------------------------//