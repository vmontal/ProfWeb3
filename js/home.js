//------------------------------Begin ctrl-main controller--------------------------------------------//
'use strict';

(function () {

    var main = angular.module("main", []);

    main.controller("ctrl-main", function ($scope, $http, dataUser, Auth) {
        
        $("#main").show();

        //var myUrl;
        //Auth.protocollo = window.location.href.split(":")[0];
        //Auth.locale = window.location.href.split(":")[1].substr(2, 1);

        //if (Auth.protocollo == "http" && Auth.locale != "l") {
        //    myUrl = "https://" + window.location.href.split("//")[1];
        //    window.location.href = myUrl;
        //} else {
        //    myUrl = window.location.href;
        //};
        
        Auth.idSede = 0;

        const parSedi = {
            idKey: "idSede",
            campoID: { idSede: '0', idRS: 0 },
            tabella: "Sedi",
            spRead: "pf_parSediRead",
            spUpdate: "pf_parSediUpdate",
            dropElenco: "elencoSedi"
        };

        Auth.db = "DB_ProfWeb30";
        $scope.db = Auth.db;

        //Auth.avvio = false;
        //$scope.avvio = false;
        $scope.avvio = Auth.avvio;
        $scope.luogo = Auth.luogo;
        $scope.idRS = dataUser.idRS;
        $scope.path = dataUser.path;
        $scope.vista = "unSelect";
        $scope.elencoSede = false;
        $scope.ragioneSociale = dataUser.ragioneSociale;
        $scope.versione = adesso();
        //var parametri = parSedi;

        //console.log($scope.path + "assId" + $scope.idRS + ".jpg");

        // prova a inserire il getDropElenco del modulo utentiLogin.js
        //getDropElenco(parSedi, 1, Auth.db, (dropElenco) => {
        //    let sediUser = dataUser.sediUser;
        //    let elencoSedi;
        //    if (contaRecord(dropElenco) == 1) {
        //        let tempElenco = new Array();
        //        tempElenco.push(dropElenco)
        //        elencoSedi = tempElenco;
        //    } else {
        //        elencoSedi = dropElenco;
        //    };
        //    elencoSedi = elencoSedi.filter((sede) => {
        //        return sediUser.indexOf(sede.idSede) > -1;
        //    });

        //    $scope[parSedi.dropElenco] = elencoSedi;
        //    Auth.elencoSedi = elencoSedi;
        //    $scope.$apply();
        //});

        $http.get("/dati/json/parametri.json?ver=" + versione).then(function (response) {
            $scope.as = response.data.as;
            Auth.as = $scope.as;
        });

        $scope.apri = function (modulo, sezione, apri, vista) {
            if (!$scope.elencoSede) {
                Auth.from = "#/" + sezione;
                Auth.vista = vista;
                $scope.vista = modulo;
                $scope[parSedi.dropElenco] = Auth.elencoSedi;
                console.log(Auth.elencoSedi);
                $(".mainSez").each(function () {
                    let elemento = $(this).prop("id");
                    if (elemento !== modulo) {
                        $(this).css({ opacity: "0.1" });
                    } else {
                        $(this).css({ opacity: "1" });
                    };
                });
                //console.log(dataUser.sediUser); console.log(typeof dataUser.sediUser.length);
                if (apri === 0 || dataUser.sediUser.length == 1) {
                    $scope.elencoSede = false;
                    Auth.idSede = dataUser.sediUser;                    
                    Auth.idRS = dataUser.idRS;

                    let elencoSedi = $scope[parSedi.dropElenco];
                    //Auth.idSede = elencoSedi[0].idSede;
                    if (elencoSedi[0]) {
                        console.log(elencoSedi[0]);
                        Auth.luogo = elencoSedi[0].descrizioneSede
                        Auth.emailSede = elencoSedi[0].emailSede;
                    };
                    $scope.luogo = Auth.luogo;
                    $scope.idSede = Auth.idSede;

                    $("#main").hide(() => {
                        window.location.href = Auth.from;
                    });
                } else {
                    $scope.elencoSede = true;
                };
            } else {
                $scope.elencoSede = false;
                $scope.vista = "unSelect";
                $(".mainSez").each(function () {
                    $(this).css({ opacity: "1" });
                });
            };
        };

        $scope.unSelect = (modulo) =>{
            return $scope.vista !== modulo && $scope.elencoSede;
        };

        $scope.selectSede = (sede) => {
            let elencoSedi = $scope[parSedi.dropElenco];
            let selectSede = elencoSedi.filter((mySede) => {
                return mySede.idSede == sede;
            });
            console.log(selectSede[0])
            Auth.idRS = dataUser.idRS;
            Auth.idSede = selectSede[0].idSede;
            Auth.luogo = selectSede[0].descrizioneSede
            Auth.emailSede = selectSede[0].emailSede;

            $scope.luogo = Auth.luogo;
            $scope.idSede = Auth.idSede;

            $("#main").hide(() => {
                window.location.href = Auth.from;
            });
        };

        Auth.myLightAmministra = "R";
        Auth.myLightGestione = "R";
        Auth.myLightControllo = "R";

        if (!Auth.userLogged) {
            $(".userMenu").hide();
            $(".adminMenu").hide();
            $(".fuoriMenu").show();
        };

        if (Auth.ruoloAdmin) {
            Auth.myLightAmministra = "G";
            Auth.myLightGestione = "G";
            Auth.myLightControllo = "G";

        } else if (Auth.ruoloGestione) {
            Auth.myLightAmministra = "G";
            Auth.myLightGestione = "G";
            Auth.myLightControllo = "R";

        } else if (Auth.ruoloModifica) {
            Auth.myLightAmministra = "G";
            Auth.myLightGestione = "G";
            Auth.myLightControllo = "R";

        } else {
            Auth.myLightAmministra = "R";
            Auth.myLightGestione = "R";
            Auth.myLightControllo = "R";
        };


        $scope.userLogged = Auth.userLogged;
        console.log("userLogged: " + !!$scope.userLogged);

        $scope.lightAmministra = function (setLight) {
            return Auth.myLightAmministra == setLight;
        };

        $scope.lightGestione = function (setLight) {
            return Auth.myLightGestione == setLight;
        };

        $scope.lightControllo = function (setLight) {
            return Auth.myLightControllo == setLight;
        };

        $scope.mainBack = function () {
            $scope.avvio = false;
            $scope.luogo = Auth.luogo;
            window.location.href = "#/main";
        };

        $scope.backHome = function () {
            //$scope.avvio = false;
            $scope.luogo = "";
            Auth.luogo = "";
            $scope.elencoSede = false;
            window.location.href = "#/main";
            $(".mainSez").each(function () {
                //$(this).prop("disabled", false)
                $(this).css({ opacity: "0.6" });
            });
        };

        $scope.myProfilo = function () {
            window.location.href = Auth.ruoloAdmin ? "#/utentiElenco" : "#/utentiProfilo";
        };

        $scope.logoutUser = () => {
            Auth.userLogged = false;
            $scope.userLogged = Auth.userLogged;

            $(".userMenu").hide();
            $(".adminMenu").hide();
            $(".fuoriMenu").show();

            $scope.admin = false;
            $scope.gestione = false;
            $scope.lettura = false;
            $scope.modifica = false;

            Auth.myLightAmministra = "R";
            Auth.myLightGestione = "R";
            Auth.myLightControllo = "R";

            Auth.modificaUtenti = false;

            Auth.ruoloAdmin = false;
            Auth.ruoloGestione = false;
            Auth.ruoloModifica = false;
            Auth.ruoloLettura = false;

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
    //} else {
    //    window.location.href = mobile ? "#/main" : "#/utentiLogin";
    //};
    //        },2000);    
        //    });

        if (!Auth.userLogged) {
            window.location.href = "#/utentiLogin";
        } else {
            parSedi.campoID.idRS = dataUser.idRS;
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
                elencoSedi = elencoSedi.filter((sede) => {
                    return sediUser.indexOf(sede.idSede) > -1;
                });

                $scope[parSedi.dropElenco] = elencoSedi;
                Auth.elencoSedi = elencoSedi;
                $scope.$apply();
            });
        };
    
    });

    //------------------------------End ctrl-main controller--------------------------------------------//


})();