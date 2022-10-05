//------------------------------Begin ctrl-anagrafe controller--------------------------------------------//
'use strict';

(function () {

    var lezioni = angular.module("lezioniWeb", []);

    lezioni.controller("ctrl-lezioniWeb", function ($scope, $http, dataUser, Auth, mask) {

        Auth.userPublic = true;

        $("#schedaLezioniWeb").show();

        $http.get("/dati/json/parametri.json?ver=" + versione).then(function (response) {
            $scope.as = response.data.as;
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

            getLezioni(parametri, modal, function () {
                $("#tabella" + parametri.tabella).tabulator("redraw");
            });

        };

        var largo = $(window).width();
        var alto = $(window).height();
        var larghezza = largo * 0.75;
        var aggiornaData = 0;
        var idKey = 0;
        var jsonOutput;
        var modal = "tabella";

        var mobile = largo < 768 ? false : true;

        $(window).resize(function () {
            largo = $(window).width();
            alto = $(window).height();
            larghezza = largo * 0.75;
            mobile = largo < 768 ? true : false;
            setTimeout(function () {
                if ($("#tabella" + parametri.tabella).hasClass("tabulator")) {
                    $("#tabella" + parametri.tabella).tabulator("setData", jsonOutput);
                    $("#tabella" + parametri.tabella).tabulator("redraw");
                };
            }, 200);
        });

        var parStudenti = {
            idKey: "idStudente",
            campoID: { "idStudente": 0 },
            tabella: "Studenti",
            spRead: "pf_anagrafeStudentiRead",
            dropElenco: "elencoStudenti",
        };

        var parStatusOfferte = {
            idKey: "idStatusOfferta",
            campoID: { "idStatusOfferta": 0 },
            tabella: "StatusOfferta",
            spRead: "pf_parStatusOfferteRead",
            dropElenco: "statusOfferte"
        };

        var parLezioni = {
            idKey: "idOfferta",
            campoID: { "idOfferta": 0, "idStatusOfferta": 2, "dataIniziale": oggi(), "dataFinale": oggi(365), "delete": 0 },
            tabella: "Lezioni",
            spRead: "pf_pianoOffertePrenotateRead",
            elencoCampi: ["idOfferta", "dataOffertaGMA", "nomeProf", "materia", "orario", "anni", "statusOfferta", "nomeStud", "idStatusOfferta", "idLezione", "idProfessore", "idMateria", "idOrario", "attivo", "notaOfferta", "idStudente", "anno", "istitutoTipo"],
            campiTabella: [
                    //{ title: "", field: "idStatusOfferta", visible: false },
                    //{ title: "Giorno", field: "dataOffertaGMA", width: parseInt(larghezza * 0.20), headerSort: false, formatter: "textarea", align: "left", headerFilter: false, visible: mobile, responsive: 4 },
                    //{ title: "Orario", field: "ora", width: parseInt(larghezza * 0.20), headerSort: false, align: "center", headerFilter: false }, //width: parseInt(larghezza * 0.10),
                    { title: "Lezioni Prenotate", field: "Offerta", width: parseInt(larghezza * 0.95), headerSort: false, formatter: mask.cellLezione, align: "left", headerFilter: true }, //, cellClick: getLezione 
            ],
            scheda: "schedaLez",
            drop: false,
        };

        var largo = $(window).width();
        var alto = $(window).height();

        var larghezza = $("#tabellaLezioni").width();

        var imgKO = "ack-KO.png";
        var imgOK = "ack-OK.png";

        $(".tempo").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: "1D"
        });

        $(".tempo").datepicker($.datepicker.regional["it"]);

        var idKey = 0;
        var parametri = parLezioni;

        var id = parametri.idKey;
        parametri.campoID[id] = idKey;

        var getLezioni = function (ricerca, modal, callback) {
            var parametri = {};
            parametri.spRead = ricerca.spRead;
            parametri.tabella = ricerca.tabella;
            parametri.drop = 0;
            $.extend(parametri, ricerca.campoID);

            var criterio = {
                data: JSON.stringify(parametri),
                db: Auth.db
            };
            criterio = JSON.stringify(criterio);
            $.ajax({
                type: "POST",
                url: "/dati/aspnet/appGetData.aspx/getData",
                data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //beforeSend: openDialog,
                success: getLezioni_success(ricerca, modal, callback),
                error: errorDialog
            });
        };

        var getLezioni_success = function (ricerca, modal, callback) {
            return function (response) {
                var jsonData = JSON.stringify(xml2json(response.d));
                var nrc = jsonData.slice(-3);
                var pqa = (nrc == "]}}" ? "" : "[");
                var pqc = (nrc == "]}}" ? "" : "]");

                var idKey = ricerca.idKey;
                var id = ricerca.campoID[idKey];
                var archivio = ricerca.tabella;
                var tabella = modal + archivio;
                var elencoCampi = ricerca.elencoCampi;
                var scheda = ricerca.scheda;

                if (id === 0) {
                    var myData = xml2json(response.d).NewDataSet[archivio];
                    if (jsonData.length > 100) {
                        jsonOutput = pqa + JSON.stringify(myData) + pqc;
                        //console.log(jsonOutput);
                        $("#" + tabella).tabulator("setData", jsonOutput);
                        //$("#" + tabella).tabulator("redraw");
                    } else {
                        $("#" + tabella).tabulator("clearData");
                    };

                    if (ricerca.drop) {
                        var dropGet = ricerca.dropGet;
                        dropGet.forEach(function(parametri){
                            getDropElenco(parametri, function (dropElenco) {
                                dropElenco.push({ "idstudente": "0", "nomeStud": "--> Seleziona Studente <--" });
                                //console.log(dropElenco);
                                $scope[parametri.dropElenco] = dropElenco; //= "[" + JSON.stringify(xml2json(response.d)).split("[")[1].split("]")[0] + "]";
                            });
                        });
                    };
                };

                if (callback && typeof callback === "function") {
                    callback();
                };

            };
        };

        var tabella = function (larghezza, parametri, callback) {
            var tabella = parametri.tabella;
            var elencoCampi = parametri.elencoCampi;
            var campiTabella = parametri.campiTabella;
            var scheda = parametri.scheda;
            var style = new styleCell();
            //$scope[scheda] = false;

            $("#tabella" + tabella).tabulator({
                height: "800px",
                //responsiveLayout: true,
                layout: "fitColumns",
                colResizable: false,
                columnVertAlign: "center",
                selectable: 0,
                layoutColumnsOnNewData: true,
                groupBy: ["dataOffertaGMA"],

                columns: campiTabella,

                index: elencoCampi[0],

                groupToggleElement: "header",

                groupHeader: function (value, count, data, group) {
                    var testo = (count === 1 ? " Lezione Prenotata" : " Lezioni Prenotate");
                    return "<span style='color:black; background-color:pink; margin-left:10px; font-size:14px'>" + value + " | (" + count + testo + ")</span>";
                },  

                groupStartOpen: [
                    function (value, count, data, group) {
                        var giorno = value.split("|")[1].replace(/-/g, "/").trim();
                        return giorno == oggi();
                    }
                ],

                rowFormatter: function (row) {
                    var data = row.getData();
                    var giorno = data["dataOffertaGMA"].split("|")[1].replace(/-/g, "/").trim();

                    if (giorno == oggi()) {
                        var style = new styleCell("#8facb2", "#9af", "bold");
                    } else {
                        var style = new styleCell("#c78766", "#000", "normal");
                    };
 
                    row.getElement().css({
                        height: "auto",
                        backgroundColor: style.backColor,
                        color: style.color,
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

        tabella(larghezza, parametri);

        //------------------------------Begin Gestione Tabella--------------------------------------------- ---//

        //$scope.download_xlsx = function () {
        //    $("#tabella").tabulator("download", "xlsx", "elenco.xlsx");
        //};
       
        //-----------------------------End Gestione Tabella----------------------------------------------//

        $scope.annullaScheda = function () {

            if (parametri === undefined || !$scope[parametri.scheda]) {
                idKey = 0;
                $scope.cambia = false;
                $scope.userLogged = false;
                window.location.href = "#/main";
            } else {
                if ($scope.cambia) {
                    var id = parametri.idKey;
                    parametri.campoID[id] = idKey;
                    getOfferte(parametri);
                } else {
                    idKey = 0;
                    $scope[parametri.scheda] = false;
                };
            };

        };

});
    //------------------------------End ctrl-banca controller--------------------------------------------//

})();