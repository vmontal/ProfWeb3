//------------------------------Begin ctrl-lezioniApp controller--------------------------------------------//
'use strict';

(function () {

    var lezioniApp = angular.module("lezioniApp", []);

    lezioniApp.controller("ctrl-lezioniApp", function ($scope, $http) {

        $("#schedaLezioniApp").show();

        const startAPP = () => {
            getLocalUser(function (user) {
                console.log(user);
                if (user.ID != 0) {
                    $scope.creaProfilo = false;
                    $scope.login = true;
                    cambioPagina($("#pages .current"), $("#lezioni"));
                    $("#headerProfilo").text("Profilo Utente").fadeIn(100);
                    console.log($scope.versione, user.versione)
                    if ($scope.versione != user.versione) {
                        $scope.updateApp = true;
                        myUser = user;
                    } else {
                        $scope.updateApp = false;
                        myUser = {};
                    };

                    $("#nomeUser").val(user.nomeUser);
                    $("#emailUser").val(user.emailUser);
                    $("#tipoUser").val(user.tipoUser);
                    //$("#sedeUser").val(user.db);
                    $("#istitutoNome").val(user.istitutoNome);
                    $("#istitutoTipo").val(user.istitutoTipo);
                    $("#annoStud").val(user.annoStud);
                    $scope.tipoUser = $("#tipoUser").val();
                    let elencoMaterie = user.materiaProf ? (user.materiaProf).split("@") : "";
                    $scope.materiaProf = JSON.parse(JSON.stringify(elencoMaterie));
                    emailUser = user.emailUser;

                    parLezioni.campoID.tipo = user.tipoUser;
                    parLezioni.campoID.idProf = user.tipoUser == "D" ? user.ID : 0;
                    parLezioni.campoID.idStud = user.tipoUser == "S" ? user.ID : 0;
                    $scope.$apply();
                    //console.log($scope.updateApp);

                    getData(parLezioni);
                    if ($scope.tipoUser == "G") {
                        fillDrop(parLezioni);
                    };

                } else {
                    getTmpLocalUser(function (tmpUser) {
                        $scope.creaProfilo = true;
                        //console.log(tmpUser);
                        if (tmpUser.ID != 0) {
                            $scope.inviaDati = false;
                            $("#headerProfilo").text("Inserisci Codice").fadeIn(100);
                            cambioPagina($("#pages .current"), $("#profilo"));
                            let elencoCampi = findProfilo.elencoCampi;
                            elencoCampi.forEach(function (campo) {
                                $("#" + campo).val(tmpUser[campo]);
                            });
                            $("#sede").val(tmpUser.db)
                        } else {
                            $scope.creaProfilo = true;
                            $("#headerProfilo").text("Registra profilo").fadeIn(100);
                            cambioPagina($("#pages .current"), $("#profilo"));
                        };
                        $scope.$apply();
                    });
                };
            });
        };

        $http.get("/dati/json/parametri.json?ver=" + versione)
            .then((response) => {
                $scope.as = response.data.as;
                $scope.versione = response.data.versione;
                $scope.dataVersione = response.data.dataVersione;
            })

            .then(() => {
                startAPP();
            })

        //const protocollo = window.location.href.split(":")[0];
        //const locale = window.location.href.split(":")[1].substr(2, 1);
        const myUrl = window.location.href;

        //if (protocollo == "http" && locale != "l") {
        //    myUrl = "https://" + window.location.href.split("//")[1];
        //    window.location.href = myUrl;
        //    console.log(myUrl);
        //} else {
        //    myUrl = window.location.href;
        //    console.log(myUrl);
        //};

        $scope.checkCode = 0;
        $scope.inviaDati = true;
        $scope.logout = false;
        $scope.login = false;
        $scope.ricordami = true;
        $scope.tipoUser = $("#tipoUser").val();
        $scope.updateApp = false;
        $scope.tabStudente = 0;
        $scope.tabMateria = 0;

        var myUser;
        const imgKO = "ack-KO.png";
        const imgOK = "ack-OK.png";
        const controlCode = $("#txtCheckCode");

        var link, emailUser;

        const evento = $(window).width() < 800 ? "touchend" : "click";

        const findProfilo = {
            spRead: "pf_anagrafeGeneraleRead",
            tabella: "find",
            ricercaCampi: ["email", "tipo"],
            elencoCampi:  ["email", "tipo", "sede"],
            upperCase: true
        };

        const checkProfilo = {
            spRead :"pf_anagrafeGeneraleCheck",
            tabella: "check",
            ricercaCampi: ["email", "tipo", "txtCheckCode"],
            elencoCampi:["nomeUser", "emailUser", "tipoUser"],
            upperCase: true
        };

        const parStudenti = {
            spRead: "pf_anagrafeStudentiRead",
            tabella: "Studenti",
            dropElenco: "elencoStudenti",
            dropCampo: "cercaStudente",
            campoID: { idStudente: 0, idSede: 0, drop: 2 }
        };

        const parProfessori = {
            spRead: "pf_anagrafeProfessoriRead",
            tabella: "Professori",
            dropElenco: "elencoProfessori",
            dropCampo: "cercaDocente",
            campoID: { idProfessore: 0, idSede: 0, drop: 2 }
        };

        const parLezioni = {
            spRead: "pf_pianoOffertePrenotateReadApp",
            tabella: "lezioni",
            campoID: { idOfferta: 0, idStatusOfferta: 2, dataIniziale: oggi(), dataFinale: oggi(365), "delete": 0, idStud: 0, idProf: 0, tipo: "G"},
            dropGet:[parStudenti, parProfessori],
            drop: false,
        };

        const parArgomenti = {
            spRead: "pf_pianoOfferteErogateReadApp",
            tabella: "argomenti",
            campoID: { idOfferta: 0, idStatusOfferta: 3, "delete": 0, idStud: 0, idMat: 0, tipo: "D"},
            drop: false 
        };

        $scope.aggiornaLezioni = function(tipo){
            parLezioni.campoID.idProf = $scope.cercaDocente ? $scope.cercaDocente : 0;
            parLezioni.campoID.idStud = $scope.cercaStudente ? $scope.cercaStudente : 0;
            getData(parLezioni);
        };

        $(".bar-tab a").on(evento, function (e) {
            e.preventDefault();
            $(".bar-tab a").removeClass("active");
            $(e.currentTarget).addClass("active");


            var fromPage = $("#pages .current"),
                nextPage = $(e.currentTarget.hash);

            link = $(e.currentTarget).attr('href');
            cambioPagina(fromPage, nextPage, function () {
                link = link.split("#")[1];

                switch (link) {
                    case "profilo":
                        console.log(link);
                        break;

                    case "lezioni":
                        console.log(link);
                        getLocalUser(function (user) {
                            //console.log(user);
                            if (user.ID != 0) {
                                $scope.creaProfilo = false;
                                $scope.login = true;
                                cambioPagina($("#pages .current"), $("#lezioni"));
                                emailUser = user.emailUser;
                                parLezioni.campoID.tipo = user.tipoUser;
                                parLezioni.campoID.idProf = user.tipoUser == "D" ? user.ID : 0;
                                parLezioni.campoID.idStud = user.tipoUser == "S" ? user.ID : 0;
                                $scope.$apply();

                                getData(parLezioni);
                                if ($scope.tipoUser == "G") {
                                    fillDrop(parLezioni);
                                };
                            };
                        });
                        break;

                    case "imposta":
                        console.log(link);
                        $scope.logout = false;
                        $scope.$apply();
                        break;

                };
            });
        });

        const aggiornaApp = function () {
            const aggiornaVersione = {
                spUpdate: "admVersione",
                userID: myUser.ID,
                versione: $scope.versione,
                dataVersione: $scope.dataVersione,
                tipoUser: myUser.tipoUser,
                email: myUser.emailUser
            };

            updData(aggiornaVersione);
        };

        const cambioPagina = function (daPagina, aPagina, callback) {
            daPagina.removeClass("current");
            aPagina.addClass("current");

            if (callback && typeof callback == "function") {
                callback();
            };
        };

        const fillDrop = function(ricerca){
            //console.log(ricerca);
            let dropGet = ricerca.dropGet;
            dropGet.forEach(function (dropParametri) {
                let dropPush = dropParametri.dropPush;
                getDropElenco(dropParametri, 1, "DB_ProfWeb30", function (dropElenco) {
                    //console.log(dropElenco);
                    if (dropPush) {
                        dropElenco.push(dropPush);
                    };
                    $scope[dropParametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                    $("#" + dropParametri.dropCampo).val("0");
                    $scope[dropParametri.dropCampo] = "0";
                    $scope.$apply();
                });
            });
        };

        const sendCheckCode = function (userData) {
            let aggiorna = {
                email: userData.email,
                tipoUser: $("#tipo>option:selected").text(),
                checkCode: userData.checkCode,
                db: $("#sede>option:selected").text() || $("#sedeUser>option:selected").text()
            };
            let criterio = {
                data: JSON.stringify(aggiorna),
                email: userData.email
            };
            criterio = JSON.stringify(criterio);
            console.log(criterio)
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/appGetData.aspx/sendCheckCode",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: openDialog,
                success: function(response){
                    cambioPagina($("#pages .current"), $("#profilo"));
                    
                    let tmpUser = {};
                    tmpUser.ID = userData.ID;
                    tmpUser.email = userData.email;
                    tmpUser.db = $("#sede").val();
                    tmpUser.tipo = $("#tipo").val();
                    newTmpLocalUser(tmpUser);

                    $("#btnCreaProfilo").prop("disabled", false);
                    $("#btnCreaProfilo").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Invia dati');
                    
                    $scope.inviaDati = false;
                    $scope.checkCode = userData.checkCode;
                    $scope.$apply();

                    $("#msgConsole").text("Inserisci il Codice di Controllo che hai ricevuto nella tua email").fadeIn(500);                            
                },
                error: function(error){
                    cambioPagina($("#pages .current"), $("#profilo"));
                    $("#btnCreaProfilo").prop("disabled", false);
                    $("#btnCreaProfilo").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Invia dati');
                    $("#msgConsole").text(error.responseJSON.Message).fadeIn(500);
                }
            });
        };

        $("#btnCreaProfilo").on(evento, function (e) {
            e.preventDefault();
            $("#btnCreaProfilo").prop("disabled", true);
            $("#btnCreaProfilo").html('<i class="fa fa-spinner fa-spin"></i> Invio Codice in corso...');
            dropLocalUser(function() {
                getData(findProfilo);
            });
        });

        $("#btnCheckCode").on(evento, function (e) {
            e.preventDefault();
            $scope.inviaDati = false;
            if (controlCode.val()){
                getData(checkProfilo);
            } else {
                $("#msgConsole").text("ATTENZIONE! Codice di Controllo assente").fadeIn(500).fadeOut(3000);
            };

            $scope.$apply();
        });

        $("#btnEsci").on(evento, function (e) {
            e.preventDefault();
            $scope.logout = true;
            //cambioPagina($("#pages .current"), $("#profilo"))
            //$scope.logout = true;
            //$scope.login = false;
            $scope.$apply();
        });

        $("#btn_esciCancella").on(evento, function (e) {
            e.preventDefault();
            $(this).prop("disabled", true)
            dropLocalUser(function () {
                resetApp();               
            });          
        });

        $("#btn_Update").on(evento, function (e) {
            e.preventDefault();
            aggiornaApp();
        });



        $("h1, h2").on(evento, function (e) {
            e.preventDefault();
            //resetApp();
        });

        $scope.loadArgomenti = (idStudente, idMateria) => {
            $scope.tabStudente = idStudente;
            $scope.tabMateria = idMateria;
            parArgomenti.campoID.idStud = idStudente;
            parArgomenti.campoID.idMat = idMateria;
            getData(parArgomenti);
        };

        $scope.showArgomenti = (idStudente, idMateria) => {
            return $scope.tabStudente === idStudente && $scope.tabMateria === idMateria;
        };

        $scope.closeArgomenti = () => {
            $scope.tabStudente = 0;
            $scope.tabMateria = 0;
        };

        const getData = function (ricerca, callback) {
            $("#msgConsole").text("");
            let ricercaCampi = ricerca.ricercaCampi;
            let aggiorna = {};
            aggiorna.spRead = ricerca.spRead;
            aggiorna.tabella = ricerca.tabella;
            aggiorna.drop = 0;

            if(ricerca.campoID){
                $.extend(aggiorna, ricerca.campoID);
                aggiorna.emailUser = emailUser;
            } else {
                ricercaCampi.forEach(function(campo){
                    aggiorna[campo] = $("#" + campo).val();
                    
                });
            };
            
            let criterio = {
                data: JSON.stringify(aggiorna),
                db: "DB_ProfWeb30"
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
                success: getData_success(ricerca, callback),
                error: function(xhr, status, error){
                    //console.log(xhr);
                    cambioPagina($("#pages .current"), $("#profilo"));
                    $("#msgConsole").text(xhr.responseJSON.Message).fadeIn(500);
                }
            });
        };

        const getData_success = function (ricerca, callback) {
            return function (response) {                
                let tabella = ricerca.tabella;
                let elencoCampi = ricerca.elencoCampi;
             
                let jsonData = xml2json(response.d).NewDataSet[tabella];
                let numRecord = contaRecord(jsonData);
                let ID, checkCode;
                let elencoMaterie;
                //console.log(jsonData);

                switch (tabella){
                    case "find":
                        ID = jsonData.ID;
                        checkCode = jsonData.checkCode;
                        if (ID > checkCode){
                            cambioPagina($("#pages .current"), $("#profilo"));

                            jsonData.db = $("#sede").val();
                            jsonData.tipo = $("#tipo").val();
                            sendCheckCode(jsonData);
                                                      
                        } else {
                            $("#btnCreaProfilo").prop("disabled", false);
                            $("#btnCreaProfilo").html('<i class="fa fa-arrow-right" aria-hidden="true"></i> Invia dati');
                            $("#msgConsole").text("ATTENZIONE! Utente non registrato").fadeIn(500).fadeOut(3000);
                        };
                        break;

                    case "check":
                        ID = jsonData.ID;
                        checkCode = jsonData.checkCode;
                        emailUser = jsonData.emailUser;
                        if (checkCode > 0 ){
                            $("#msgConsole").text("Codice di Controllo riconosciuto").fadeIn(500).fadeOut(3000);
                            jsonData.db = $("#sede").val();

                            creaLocalUser(jsonData, function(){
                                $("#headerProfilo").text("Profilo Utente");
                                dropTmpLocalUser();
                            });
                            $scope.inviaDati = true;
                            $scope.creaProfilo = false;
                            $scope.login = true;
                            cambioPagina($("#pages .current"), $("#lezioni"));
                            elencoCampi.forEach(function(campo){
                                $("#" + campo).val(jsonData[campo]);
                            });
                            parLezioni.campoID.tipo = jsonData.tipoUser;
                            parLezioni.campoID.idProf = jsonData.tipoUser == "D" ? jsonData.ID: "0";
                            parLezioni.campoID.idStud = jsonData.tipoUser == "S" ? jsonData.ID: "0";
                            getData(parLezioni);
                            $scope.tipoUser = $("#tipoUser").val();
                            elencoMaterie = jsonData.materiaProf ? (jsonData.materiaProf).split("@") : "";

                            $scope.materiaProf = JSON.parse(JSON.stringify(elencoMaterie));
                            $scope.$apply();
                            //console.log($scope.materiaProf);
                            if ($scope.tipoUser == 'G') {
                                fillDrop(parLezioni);
                            };
                        } else {
                            $("#msgConsole").text("ATTENZIONE! Codice di controllo errato").fadeIn(500).fadeOut(3000);
                        };

                        break;

                    case "lezioni":
                        if (numRecord === 1){
                            jsonData = JSON.parse("[" + JSON.stringify(jsonData) + "]");
                        };
                        $scope.elencoLezioni = jsonData;
                        $scope.$apply();
                        break;


                    case "argomenti":
                        if (numRecord === 1) {
                            jsonData = JSON.parse("[" + JSON.stringify(jsonData) + "]");
                        };
                        jsonData = jsonData ? jsonData : [{dataOfferta: oggi(0), argomentoOfferta: "Nessuna lezione erogata per questa materia" }]
                        $scope.elencoArgomenti = jsonData;
                        $scope.$apply();
                        console.log(jsonData);
                        break;
                };

                if (callback && typeof callback === "function") {
                    callback();
                };

            };
        };

        const updData = (aggiorna) => {
            let criterio = {
                data: JSON.stringify(aggiorna),
                html: "",
                db: "DB_ProfWeb30"
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
                success: updData_success (aggiorna),
                error: function (xhr, status, error) {
                    //console.log(xhr);
                    cambioPagina($("#pages .current"), $("#profilo"));
                    $("#msgConsole").text(xhr.responseJSON.Message).fadeIn(500);
                }
            });
        };

        const updData_success = (aggiorna) => {
            return function (response) {
                let jsonData = parseInt(response.d);
                if (jsonData === 1) {
                    updateLocalUser(aggiorna.versione, aggiorna.dataVersione, function () { resetApp(); })

                } else {
                    cambioPagina($("#pages .current"), $("#profilo"));
                    $("#msgConsole").text("ATTENZIONE: Aggiornamento versione fallito!").fadeIn(500);
                };
            };
        };


});
    //------------------------------End ctrl-lezioniApp controller--------------------------------------------//

})();