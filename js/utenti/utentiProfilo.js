//------------------------------Begin ctrl-profile controller---------------------------------------------//
'use strict';

(function () {

    var utentiProfilo = angular.module("utentiProfilo", []);

    utentiProfilo.controller("ctrl-profilo", function ($scope, $http, dataUser, Auth) {

        $scope.admin =    Auth.ruoloAdmin;
        $scope.gestione = Auth.ruoloGestione;
        $scope.modifica = Auth.ruoloModifica;
        $scope.lettura = Auth.ruoloLettura;

        $scope.luogo = Auth.luogo;
        $scope.db = Auth.db;
        $scope.idRS = dataUser.idRS;
        $scope.path = dataUser.path;
   
        $http.get("/dati/json/privacy.json?ver=" + versione).then(function (response) {
            $scope.dropPrivacy = response.data;
        });

        $scope.userLogged = Auth.userLogged;
        $scope.updatePrivacy = !Auth.privacy;


        var campiUtente =     ["cognome", "nome",    "email",   "username", "registra", "ultimo",  "attivo",  "idRuolo", "privacy", "adv"];
        var campiUtenteTipo = ["varchar", "varchar", "varchar", "varchar",  "varchar",  "varchar", "bit",     "int",     "bit",     "bit"];
        var cambiaProfilo = false;
        var resetPasswordUser = false;
        var resetPasswordAuth = false;

        $scope.oldPassZero = true;
        $scope.newPass2rip = true;
        $scope.newDiff = true;
        $scope.testOK = false;

        $scope.user = dataUser.username;
        $scope.oldPass = $("#oldPass").val();
        $scope.newPass = $("#newPass").val();
        $scope.ripPass = $("#ripPass").val();

        $scope.nuovoUtente = false;
        $scope.attivaUtente = false;
        $scope.resetFormPassword = false;
        $scope.resetAnnullaPassword = false;
        $scope.updateFormUtente = false;

        $scope.nuovoUtente = true;
        $scope.attuale = true;

        if (Auth.ruoloCambia) {
            $scope.resetFormPassword = true;
            $scope.updateFormUtente = false;
            $scope.attuale = false;
        };

        const verificaPasswordSimili = function (oldP, newP) {
            var s = 0;
            for (var i = 0; i < newP.length - 1; i++) {
                if (oldP.indexOf(newP.substr(i, 2)) > 0) {
                    s = s + 1;
                };
            };

            if (s > parseInt((oldP.length - 1)  * 0.4)) {
                infoDialog("Attenzione", "La nuova password è troppo simile alla precedente! <br/> Verificate " + s + " corrispondenze su " + (oldP.length - 1) + " possibili", imgKO);
                $("#newPass").val("");
                $scope.newDiff = true;
            } else {
                $scope.newDiff = false;
                $scope.testOK = true;
            };
            $scope.$apply();
        };

        $(document).on("keypress", ".verificaPass", function (e) {
            if (e.keyCode === 13) {
                e.preventDefault();
            };
        });

        //$(".verificaPass").focus(function () {
        //    //$("#msgError").text("").hide();
        //    $scope.testOK = false;
        //});

        //$(document).on("keyup", "#oldPass", function () {
        //    if ($("#oldPass").val().length > 1) {
        //        $scope.oldPassZero = false;
        //    } else {
        //        $scope.oldPassZero = true;
        //    };
        //    $scope.$apply();
        //});


        //$(document).on("keyup", "#newPass", function () {
        //    if ($("#newPass").val().length > 7) {
        //        $scope.newDiff = false;
        //    } else {
        //        $scope.newDiff = true;
        //    };
        //    $scope.$apply();
        //});

        //$(document).on("keyup", "#ripPass", function () {
        //    if ($("#newPass").val() == $("#ripPass").val() && $("#ripPass").val().length > 7) {
        //        $("#msgError").html(msgInfo.div("info", "Verifica ok")).show();
        //        $scope.newPass2rip = false;
        //    } else {
        //        $("#msgError").html(msgInfo.div("danger", "Ripeti la nuova password")).show();
        //        $scope.newPass2rip = true;
        //    };
        //    $scope.$apply();
        //});

        $("#newPass").focusin(function () {
            $("#newPass").val("");
            $("#oldPass").val("");
            
            $scope.newPass = $("#newPass").val();
            $scope.oldPass = $("#oldPass").val();
            $scope.newDiff = true;
            $scope.testOK = false;
            $scope.$apply();
        });

        $("#newPass").focusout(function () {
            var oldP = (Auth.ruoloCambia == true ? dataUser.username: $("#oldPass").val());
            var newP = $("#newPass").val();
            var user = dataUser.username;
            if (newP.length == 0) {
                $("#newPass").val("");
                $scope.newPass = $("#newPass").val();
                $scope.newDiff = true;
                $scope.testOK = false;
                $scope.$apply();
            } else if (newP == oldP || newP == user) {
                infoDialog("Attenzione", "La nuova password non può essere uguale alla precedente o coincidere con ID Utente", imgKO);
                $("#newPass").val("");
                $scope.newPass = $("#newPass").val();
                $scope.newDiff = true;
                $scope.testOK = false;
                $scope.$apply();
            } else {
                verificaPasswordSimili(oldP, newP);
            };

        });

        $(".profilo").change(function () {
            cambiaProfilo = true;
        });

        if (!Auth.modificaUtenti) {
            dataUser.cercaID = dataUser.userID;
        };

        if (Auth.ruoloAdmin) {
            $scope.attivaUtente = true;
        };

        $scope.annulla = function () {
            $scope.attivaUtente = false;
            $("#h_profilo").text("").hide();

            if (Auth.modificaUtenti) {
                Auth.modificaUtenti == !Auth.modificaUtenti;
                window.location.href = "#/utentiElenco";
            } else if (parseInt(dataUser.userID) == 0 || !dataUser.userID || !Auth.privacy) {
                $scope.logoutUser();
                window.location.href = "#/utentiLogin";
            } else {
                window.location.href = Auth.from;
            };
        };

        //$scope.cambiaPass = function () {
        //    $scope.updateFormUtente = false;
        //    $("#h_profilo").text("Reset Password");
        //    if (Auth.ruoloAdmin && dataUser.cercaID != dataUser.userID) {
        //        $scope.resetAnnullaPassword = true;
        //        $scope.resetFormPassword = false;
        //        var resetTitle = "Attenzione!";
        //        var resetMsg = "Stai annullando la password per l'utente: <strong>" + dataUser.username + ";</strong></br> la nuova password sarà impostata uguale allo username ed è obbigatorio cambiarla al primo accesso ";
        //        //infoDialog(resetTitle, resetMsg, "", 600, 400);
        //        $("#textReset").html(resetMsg)
        //        Auth.resetPass = "admin";
        //    } else {
        //        $scope.resetAnnullaPassword = false;
        //        $scope.resetFormPassword = true;
        //        Auth.resetPass = "auto";
        //    };
        //};

        //$scope.resetPassword = function () {
        //    resetPasswordAuth = true;
        //    resetPasswordUser = false;
        //    openDialog();

        //    setTimeout(function () {
        //        var aggiorna = {};
        //        aggiorna.ID = dataUser.cercaID;
        //        aggiorna.newPass = hash(dataUser.cercaUserName);
        //        aggiorna.db = Auth.db;
        //        var criterio = JSON.stringify(aggiorna);
        //        $.ajax({
        //            type: "POST",
        //            url: "/dati/aspnet/gestioneUtenti.aspx/admResetPassword",
        //            data: criterio,
        //            cache: false,
        //            contentType: "application/json; charset=utf-8",
        //            dataType: "json",
        //            //beforeSend: openDialog, 
        //            success: aggiornaPassword_success,
        //            error: errorDialog
        //        });
        //    }, 100);
        //};

        $scope.verificaPassword = function () {
            openDialog(function(){

                //setTimeout(function () {
                var aggiorna = {};
                aggiorna.utente = $.trim(dataUser.username);
                //aggiorna.password = $.trim($("#oldPass").val());
                aggiorna.password = hash($.trim($("#oldPass").val()));
                aggiorna.db = Auth.db;
                var criterio = JSON.stringify(aggiorna);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/gestioneUtenti.aspx/admLogin",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: verificaPassword_success,
                    error: errorDialog
                });
                //}, 100);
            });
        };

        function verificaPassword_success(response) {
            closeDialog();
            //let esito = xml2json(response.d).NewDataSet;
            //var xmlDoc = $.parseXML(esito.d);
            //var xml = $(xmlDoc);

            let esitoID = response.d; //esito.ID; // parseInt($(xml).find("ID").text());
            if (esitoID == dataUser.cercaID) {
                $scope.attuale = false;
                $scope.$apply();
            } else {
                $("#oldPass").val("");
                $scope.oldPass = $("#oldPass").val();
                infoDialog("Password errata!", "", imgKO);
            };
        };

        $scope.aggiornaPassword = function () {
            resetPasswordUser = true;
            resetPasswordAuth = false;
            //openDialog();
            var textModal = "Invio Mail di Verifica cambio password in corso..."
            var imgModal = "gear1.gif";
            runDialog(textModal, imgModal, function(){

                //setTimeout(function () {
                let aggiorna = {};
                aggiorna.ID = dataUser.cercaID;
                aggiorna.password = hash($.trim($("#newPass").val()));
                aggiorna.idRS = dataUser.idRS;
                aggiorna.db = Auth.db;

                let criterio = JSON.stringify(aggiorna);
                $.ajax({
                    type: "POST",
                    url: "/dati/aspnet/gestioneUtenti.aspx/admAggiornaPassword",
                    data: criterio,
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //beforeSend: openDialog,
                    success: aggiornaPassword_success,
                    error: errorDialog
                });
                //}, 100);
            });
        };

        function aggiornaPassword_success(esito) {
            console.log(esito);
            //var xmlDoc = $.parseXML(esito.d);
            //var xml = $(xmlDoc);
            //var esitoID = parseInt($(xml).find("ID").text());
            let esitoID = esito.d;
            if (esitoID == 1) {
                $("#oldPass").val("");
                $("#newPass").val("");
                $("#ripPass").val("");
                Auth.ruoloCambia = false;
                $scope.aggiorna = true;
                $scope.updateFormUtente = false;
                $scope.resetFormPassword = false;
                $scope.resetAnnullaPassword = false;
                $scope.oldPassZero = true;
                $scope.newPass2rip = true;
                $scope.newDiff = true;
                $scope.$apply();

                mailResetPassword();

            } else {
                closeDialog();
            };
        };

        const mailResetPassword = () => {
            //closeDialog();
            //var textModal = "Invio Mail di Verifica cambio password in corso..."
            //var imgModal = "gear1.gif";
            //runDialog(textModal, imgModal);

            var parInvio = {};
            parInvio.mail = dataUser.email; //$("#email").val();
            parInvio.user = (dataUser.email).split("@")[0]; //$("#email").val().split("@")[0];
            parInvio.resetAuth = resetPasswordAuth;
            parInvio.resetUser = resetPasswordUser;
            parInvio.sede = dataUser.ragioneSociale;
            parInvio.emailSede = dataUser.sedeLegaleEmail;
            parInvio.db = Auth.db;

            var criterio = JSON.stringify(parInvio);
            //console.log(criterio);
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/gestioneUtenti.aspx/mailResetPassword",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: runDialog(textModal, imgModal),
                success: mailSuccess,
                error: errorDialog
            });

            resetPasswordAuth = false;
            resetPasswordUser = false;
        };

        function mailVerificaUtente() {
            closeDialog();
            var textModal = "Invio Mail di verifica utente in corso..."
            var imgModal = "gear1.gif";
            runDialog(textModal, imgModal);

            var parInvio = {};
            parInvio.mail = $("#email").val();
            parInvio.user = $("#email").val().split("@")[0];
            parInvio.host = window.location.host;
            parInvio.form = "Utente";
            parInvio.db = Auth.db;
            var criterio = JSON.stringify(parInvio);

            //alert(criterio);
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/gestioneUtenti.aspx/mailVerificaUtente",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: runDialog(textModal, imgModal),
                success: mail_success,
                error: errorDialog
            });
        };

        const mailAvvisoModifica = () => {
            closeDialog();
            var parInvio = {};
            parInvio.mail = $("#email").val();
            parInvio.user = $("#email").val().split("@")[0];
            parInvio.host = window.location.host;
            parInvio.ruolo = $("#idRuolo option:selected").text();
            parInvio.sede = dataUser.ragioneSociale;
            parInvio.emailSede = dataUser.sedeLegaleEmail;
            parInvio.db = Auth.db;

            var criterio = JSON.stringify(parInvio);

            var textModal = "Invio Mail di modifica profilo in corso..."
            var imgModal = "gear1.gif";
            //alert(criterio);
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/gestioneUtenti.aspx/mailAvvisoModifica",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: runDialog(textModal, imgModal),
                success: mailSuccess,
                error: errorDialog
            });

        };

        const mailSuccess = (response) => {
            let codice = response.d;
            let imgMsg = (codice == 1 ? imgOK : imgKO);
            let esito = (codice == 1 ? "Cambio Password" : "Attenzione!");
            let msg = (codice == 1 ? "Invio Mail con Successo" : "Mail di conferma non inviata!");
            infoDialog(esito, msg, imgMsg, 800, 400);

            console.log(Auth.resetPass);

            switch (Auth.resetPass) {
                case "admin":
                    window.location.href = "#/utentiElenco";
                    break;

                case "auto":
                    if (!Auth.userLogged) {
                        window.location.href = "#/utentiLogin";
                    };
                    break;

                case "utente":
                    window.location.href = "#/utentiLogin";
                    break;
            };
        };
    });

})();

//------------------------------End ctrl-profile controller---------------------------------------------//