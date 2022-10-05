(function () {

    var app = angular.module("PROF-Web",
            ["ngRoute", "main", "parametri","master",
             "utentiLogin", "utentiProfilo",
                "anagrafe", "prenota", "controllo", "controlloItalia", "dbItalia" //"lezioni", "registra",
            ]);

    app.service("dataUser", function () {

    });

    app.service("msgInfo", function () {     
        this.div = function (tipoAlert, tipoMsg) {
            return "<div class='alert alert-" + tipoAlert + " alert-dismissable text-center'>" +
                    "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>" +
                    tipoMsg +
                "</div>"
        };
    });

    app.service("Auth", function () {

    });

    app.service("mask", function () {

        this.celltext = function (cell, formatterParams) {
            //var data = cell.getData();
            let value = cell.getValue();
            let rowCell = !value ? [] : value.split(",");
            let myCell = "";
            let idStatus = 0;
            let backgroudColor;
            let color = "black";
            let allinea = "left";
            let fontSize = "1.5rem";

            //console.log(rowCell, typeof(value), parseInt(value));

            if (rowCell.length != 1) {

                rowCell.forEach(function (element) {
                    let key = element.split(":")[0];
                    let valore = element.split(":")[1];
                    //console.log(valore);
                    //console.log(valore.substr(0, 2));
                    if (key !== "id" && key !== "idStudente" && key !== "idStatus" && valore !== "0" && valore.substr(0, 3) !== " --") {
                        myCell += "<div><strong> " + key + "</strong>" + ": " + valore + "</div>";
                    } else if (key === "idStatus") {
                        idStatus = parseInt(valore);
                    };

                });

            } else {

                myCell = value;
                allinea = "center";
                fontSize = "2.5rem";
            };

            switch (idStatus){
                case 1:
                    backgroudColor = "lightgray";
                    break;

                case 2:
                    backgroudColor = "lightgreen";
                    break;

                case 3:
                    color = "green";
                    backgroudColor = "white";
                    break;

                case 5:
                    color = "blue";
                    backgroudColor = "yellow";
                    break;

                case 11:
                    color = "white";
                    backgroudColor = "red";
                    break;

                case 12:
                    color = "lightgray";
                    backgroudColor = "white";
                    break;

                default:
                    backgroudColor = "white";
                    break;

            };

            myCell = "<div style='background-Color:" + backgroudColor + "; color:" + color + "; font-size: " + fontSize + "; padding: 1rem; border-radius: 1rem; text-align:" + allinea + ";'>" + myCell + "</div>";
            //console.log(myCell);
            return myCell;
        };

        this.cellLezione = function (cell, formatterParams) {
            var data = cell.getData();
            var value = cell.getValue();

            var rowCell = !value ? [ ] : value.split(",");
            var myCell = "";
            rowCell.forEach(function (element, index) {
                if (index == 0) {
                    myCell += "<div><strong> " + element.split(":")[0] + "</strong>" + ": " + element.split(":")[1] + ":" + element.split(":")[2] + "</div>";
                } else {
                    myCell += "<div><strong> " + element.split(":")[0] + "</strong>" + ": " + element.split(":")[1] + "</div>";
                };
            });

            return myCell;
        };

        this.cellCheck = function (cell, formatterParams) {
            const data = cell.getData();
            const campo = !cell.getValue() ? "*" : cell.getValue();

            const value = parseInt(campo.split("*")[0]);
            let lezioni = campo.split("*")[1];
            lezioni = !lezioni ? "" : "-" + lezioni;
            let cal = 0;
            let color;
            let backgroudColor;
            //console.log(value);
            if (value < 0){
                cal = data.settimana ? -1 : 1
                color = cal  === -1 ? "white" : "red";
                backgroudColor = "red";
            } else if (value >= 0){
                color = "white";
                backgroudColor = "green";
                cal = 1;
            //} else if (value > 0) {
            //    color = "white";
            //    backgroudColor = "blue";
            //    cal = 1;
            } else {
                color = "lightgray";
                backgroudColor = "lightgray";   
                cal = 0;
                lezioni = "";
            };
            //console.log(value * cal + lezioni);
            //const myCell = "<div style='background-Color:" + backgroudColor + "; color:" + color + "; height:50px; font-size: 2rem; padding: 1rem'>" + value*cal + lezioni + "</div>";
            const myCell = "<div style='background-Color:" + backgroudColor + "; color:" + color + "' class='cellCheck'>" + value*cal + lezioni + "</div>";
            return myCell;
        };

        this.cellPrenota = function (cell, formatterParams) {
            if (cell.getValue()) {
                const value = cell.getValue().split("//")[1];
                let color;
                let backgroundColor;
                switch (value) {
                    case "-2":
                        color = "lightgray";
                        backgroundColor = "lightgray";
                        break;

                    case "-1":
                        color = "green";
                        backgroundColor = "green";
                        break;

                    default:
                        color = "white";
                        backgroundColor = "blue";
                        break;
                };
                const myCell = "<div style='background-Color:" + backgroundColor + "; color:" + color + "' class='cellCheck'>" + value + "</div>";

                return myCell;
            } else {
                return "";
            };
        };

        this.cellBold = function (cell, formatterParams) {
            var value = cell.getValue();
            var myCell = "<div style='font-weight:bold; font-size: 20px'>" + value + "</div>";

            return myCell;
        };

        this.cellBold10 = function (cell, formatterParams) {
            var value = cell.getValue();
            var myCell = "<div style='font-weight:bold; font-size: 1.5rem'>" + value + "</div>";

            return myCell;
        };

        this.cellRichiestaStud = (cell, formatterParams) => {
            let value = cell.getValue();
            let data = cell.getData();
            //console.log(data, data["richiesteStud"], data["richiesteProf"] );
            let myCell = value;
            if (parseInt(data["richiesteStud"]) > parseInt(data["richiesteProf"])) {
                myCell = "<div style='font-weight:bold; font-size: 16px; color:red'>" + value + "</div>";
            };
            
            return myCell;
        };

        this.cellAttiva = function (cell, formatterParams) {
            var value = cell.getValue();
            var color = value == "1" || value == "true" ? "red" : "green";
            var myCell = "<div style='background-Color:" + color + "; color:" + color + "; height:50px'></div>";

            return myCell;
        };

        this.cellDisattiva = function (cell, formatterParams) {
            let value = cell.getValue();
            let color = value == "0" || value == "false" ? "red" : "green";
            let myCell = "<div style='background-Color:" + color + "; color:" + color + "; height:50px'></div>";

            return myCell;
        };

        this.cellSegno = function (cell, formatterParams) {
            let value = cell.getValue();
            let testo = value == "1"  ? "E" : "U";
            let colorText = value == "1" ? "black" : "white";
            let colorBack = value == "1" ? "lightgreen" : "red";
            let myCell = "<div style='background-Color: " + colorBack + "; color: " + colorText + "; text-align:center; font-weight:bold; vertical-align:middle; height:50px'>" + testo + "</div>";

            return myCell;
        };

        this.cellAnnullata = function (cell, formatterParams) {
            let value = cell.getValue();
            let testo = value == "1" || value == "true" ? "Annullato" : " ";
            let colorText = value == "1" || value == "true" ? "darkgray" : "white";
            let colorBack = value == "1" || value == "true" ? "lightgray" : "white";
            let myCell = "<div style='background-Color: " + colorBack + "; color: " + colorText + "; height:50px'>" + testo + "</div>";

            return myCell;
        };

        this.moneyFormatter = function (cell, formatterParams) {
            let value = cell.getValue();

            return accounting.formatMoney(value, "€ ", 2, ".", ",");
        };

        //this.moraFormatter = function (value, data, cell, row, options, formatterParams) {
        //    if (data.rataMoraManuale == "true" || data.moratoriaCap == "true" || data.moratoriaInt == "true") {
        //        return "<span style='color:red; font-weight:bold;'>" + accounting.formatMoney(value, "€ ", 2, ".", ",") + "</span>";
        //    } else {
        //        return accounting.formatMoney(value, "€ ", 2, ".", ",");
        //    };
        //};

        //this.decimalFormatter = function (value, data, cell, row, options, formatterParams) {
        //    return accounting.formatNumber(value, 2, ".", ",");
        //};

        //this.integerFormatter = function (value, data, cell, row, options, formatterParams) {
        //    return accounting.formatNumber(value, 0, ".", ",");
        //};

        //this.percentFormatter = function (value, data, cell, row, options, formatterParams) {
        //    // Scalare
        //    if (value == undefined || data.TUSURA == undefined || data.TEG108 == undefined || data.TSOG == undefined || data.TEGM == undefined) {
        //        return 0;
        //    } else if (parseFloat(value.replace(",", ".")).toFixed(3) > parseFloat(data.TUSURA.replace(",", ".")).toFixed(3) && parseFloat(data.TUSURA.replace(",", ".")).toFixed(3) > 0 && parseFloat(data.TEG108.replace(",", ".")).toFixed(3) > 0) {
        //        return "<span style='color:red; font-weight:bold;'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    } else if (parseFloat(value.replace(",", ".")).toFixed(3) > parseFloat(data.TSOG.replace(",", ".")).toFixed(3) && parseFloat(data.TUSURA.replace(",", ".")).toFixed(3) > 0 && parseFloat(data.TEG108.replace(",", ".")).toFixed(3) > 0) {
        //        return "<span style='color:orange; font-weight:bold;'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    } else if (parseFloat(value.replace(",", ".")).toFixed(3) > parseFloat(data.TEGM.replace(",", ".")).toFixed(3) && parseFloat(data.TUSURA.replace(",", ".")).toFixed(3) > 0 && parseFloat(data.TEG108.replace(",", ".")).toFixed(3) > 0) {
        //        return "<span style='color:blue; font-weight:bold;'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    } else if (parseFloat(data.TEG108.replace(",", ".")).toFixed(3) > 0) {
        //        return "<span style='color:green; font-weight:bold;'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    // Valore di default
        //    } else {
        //        return accounting.formatNumber(value * 100, 3, ".", ",") + "%";
        //    };
        //};

        //this.mutuoFormatter = function (value, data, cell, row, options, formatterParams) {
        //    // Piano di Ammortamento
        //    if (parseFloat(value.replace(",", ".")).toFixed(3) >= parseFloat(data.tassoSoglia.replace(",", ".")).toFixed(3) && parseFloat(data.tassoSoglia.replace(",", ".")).toFixed(3) > 0 ) {
        //        return "<span style='color:red; font-weight:bold; font-size:10'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    } else if (parseFloat(value.replace(",", ".")).toFixed(3) >= parseFloat(data.tassoMedio.replace(",", ".")).toFixed(3) && parseFloat(data.tassoMedio.replace(",", ".")).toFixed(3) > 0) {
        //        return "<span style='color:orange; font-weight:bold; font-size:10'>" + accounting.formatNumber(value * 100, 3, ".", ",") + "%" + "</span>";

        //    // Valore di default
        //    } else {
        //        return accounting.formatNumber(value * 100, 3, ".", ",") + "%";
        //    };
        //};

        //this.statoRata = function (value, data, cell, row, options, formatterParams) {
        //    switch (parseInt(data.stato)) {
        //        case 0:
        //            return "<span style='color:red; font-weight:bold'>"    + value + "</span>";
        //            break;

        //        case 1:
        //            return "<span style='color:green; font-weight:bold'>"  + value + "</span>";
        //            break;

        //        case -1:
        //            return "<span style='color:black; font-weight:bold'>"   + value + "</span>";
        //            break;

        //        case 2:
        //            return "<span style='color:orange; font-weight:bold'>" + value + "</span>";
        //            break;
        //    };
        //};

        //this.tipoTasso = function (value, data, cell, row, options, formatterParams) {
        //    if (parseInt(value) == 1) {
        //        return "<span style='font-weight:bold;'>" + "Varia" + "</span>";
        //    } else {
        //        return "<span style='font-weight:bold;'>" + "Fisso" + "</span>";
        //    };
        //};

        //this.tassoFormatter = function (value, data, cell, row, options, formatterParams) {
        //    var valore = accounting.formatNumber(value * 100, 3, ".", ",") + "%";
        //    if (value <= 0) {
        //        return "<span style='color:red'>" + valore + "</span>";
        //    } else {
        //        return "<span style='color:black'>" + valore + "</span>";
        //    };
        //};

        //this.iconProfilo = function () {
        //    return "<i class='glyphicon glyphicon-user'></i>"
        //};

        //this.iconBanca = function () {
        //    return "<i class='glyphicon glyphicon-bitcoin'></i>"
        //};  

        //this.iconRapporto = function () {
        //    return "<i class='glyphicon glyphicon-subtitles'></i>"
        //};

        //this.iconMutuo = function () {
        //    return "<i class='glyphicon glyphicon-scale'></i>"
        //};

        //this.iconAmmorta = function () {
        //    return "<i class='glyphicon glyphicon-menu-hamburger'></i>"
        //};

        //this.iconScalare = function () {
        //    return "<i class='glyphicon glyphicon-menu-hamburger'></i>"
        //};

        //this.iconRuoli = function () {
        //    return "<i class='glyphicon glyphicon-cog   '></i>"
        //};

        //this.iconGruppi = function () {
        //    return "<i class='glyphicon glyphicon-th'></i>"
        //};

        //this.iconDomini = function () {
        //    return "<i class='glyphicon-cloud'></i>"
        //};

        //this.imgLogoCPB = function () {
        //    return "<img src='images/CPB.LogoQ.png' width='20' />"
        //};

    });

    setTimeout(function () {
        console.log("currentVersion: " + versione);
    }, 0);

    app.config(function ($routeProvider) {
        $routeProvider

        .when('/master', {
            controller: 'ctrl-master',
            templateUrl: '/html/master.html?ver=' + versione,
        })

        .when('/main', {
            controller: 'ctrl-main',
            templateUrl: '/html/home.html?ver=' + versione,
        })

        .when('/esci', {
            controller: 'ctrl-main',
            templateUrl: '/html/home.html?ver=' + versione,
        })

        .when('/parametri', {
            controller: 'ctrl-parametri',
            templateUrl: '/html/parametri.html?ver=' + versione,
        })

        .when('/utentiLogin', {
            controller:  'ctrl-login',
            templateUrl: '/html/utenti/utentiLogin.html?ver=' + versione,
        })

        .when('/utentiProfilo', {
            controller: 'ctrl-profilo',
            templateUrl: '/html/utenti/utentiProfilo.html?ver=' + versione,
        })

        //.when('/utentiElenco', {
        //    controller: 'ctrl-elenco',
        //    templateUrl: '/html/utenti/utentiElenco.html?ver=' + versione,
        //})

        //.when('/ruoliElenco', {
        //    controller: 'ctrl-gruppi',
        //    templateUrl: '/html/utenti/utentiGruppi.html?ver=' + versione,
        //})

        //.when('/utentiRegistra', {
        //    controller: 'ctrl-profilo',
        //    templateUrl: '/html/utenti/utentiProfilo.html?ver=' + versione,
        //})

        .when('/anagrafe', {
            controller: 'ctrl-anagrafe',
            templateUrl: '/html/scheda/anagrafe.html?ver=' + versione,
        })

        .when('/prenota', {
            controller: 'ctrl-prenota',
            templateUrl: '/html/scheda/prenota.html?ver=' + versione,
        })

        //.when('/lezioni', {
        //    controller: 'ctrl-lezioni',
        //    templateUrl: '/html/scheda/lezioni.html?ver=' + versione,
        //})

        //.when('/lezioniWeb', {
        //    controller: 'ctrl-lezioniWeb',
        //    templateUrl: '/html/scheda/lezioniWeb.html?ver=' + versione,
        //})

        //.when('/registra', {
        //    controller: 'ctrl-registra',
        //    templateUrl: '/html/scheda/registra.html?ver=' + versione,
        //})

        .when('/controllo', {
            controller: 'ctrl-controllo',
            templateUrl: '/html/scheda/controllo.html?ver=' + versione,
        })

        .when('/controlloItalia', {
            controller: 'ctrl-controlloItalia',
            templateUrl: '/html/scheda/controlloItalia.html?ver=' + versione,
        })

        .when('/dbItalia', {
            controller: 'ctrl-dbItalia',
            templateUrl: '/html/dbItalia.html?ver=' + versione,
        })

        .otherwise({ redirectTo: '/main' });

    });

})();
