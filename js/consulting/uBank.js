//------------------------------Begin ctrl-uBank controller--------------------------------------------//
'use strict';

(function () {
    
    var uBank = angular.module("uBank", []);

    uBank.controller("ctrl-uBank", function ($scope, dataUser, msgInfo, Auth, mask) {

        if (dataUser.user != 0 && dataUser.user != null && Auth.ruoloGestione == "true" && Auth.Gruppo == 1) {

            $scope.elenco_uBank = true;
            var jsonOutput;

            var dataRapportiXML = [];
            var dataRicavoXML = [];
            var dataUtilizzatoXML = [];
            var dataAccordatoXML = [];
            var dataXML = [];

            var dataBolleXML = [];
            var bolleRapporti;

            var totNRAP = 0;
            var totRICAVO = 0;
            var totUTILIZZATO = 0;
            var totACCORDATO = 0;

            var tableData = new Array();

            var rowData = new Array();
            //var rowData = [];
            rowData.push([{ text: "Livello", style: "tableHeader" }]);
            rowData.push([{ text: "Numero Rapporti", style: "tableHeader" }]);
            rowData.push([{ text: "Ricavi", style: "tableHeader" }]);
            rowData.push([{ text: "Utilizzato", style: "tableHeader" }]);
            rowData.push([{ text: "Accordato", style: "tableHeader" }]);
            rowData.push([{ text: "Utilizzo %", style: "tableHeader" }]);
            rowData.push([{ text: "Indice Rischio", style: "tableHeader" }]);
            tableData.push(rowData);

            google.charts.load('current', { packages: ['corechart'] });

            tabella_uBank();

            get_uBank();

            setTimeout(function () {
                get_uBank_bolle();
            },
                1500
            );

        } else {
            alert(dataUser.user);
            window.location.href = "#/main";
        };

        function get_uBank() {
            $.ajax({
                type: "POST",
                url: "appGetData.aspx/Get_uBank",
                //data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () { $("#msgError").html(msgInfo.div("info", "<p class='text-center'><img src='images/ajax-loader.gif'></p>")).show(); },
                success: get_uBank_success,
                error: function (xhr, status, error) { $("#msgError").html(msgInfo.div("danger", "La funzione è in Errore: " + xhr.status + xhr.responseText)).show(); }
            });
        };

        function get_uBank_success(response) {
            $("#msgError").html("").hide();

            var nrc = JSON.stringify(xml2json(response.d)).slice(-3);
            var pqa = (nrc == "]}}" ? "" : "[");
            var pqc = (nrc == "]}}" ? "" : "]");

            jsonOutput = pqa + JSON.stringify(xml2json(response.d).NewDataSet.uBank) + pqc;
            $("#tabella_uBank").tabulator("setData", jsonOutput);

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);

            $(xml).find("uBank").each(function () {
                var rowData = new Array();
                //var rowData = [];
                var livello = $(this).find("Livello").text();
                livello = livello.substr(4, livello.length - 4);

                totNRAP += parseInt($(this).find("NRAP").text());
                totRICAVO += parseFloat($(this).find("RICAVO").text());
                totUTILIZZATO += parseFloat($(this).find("UTILIZZATO").text());
                totACCORDATO += parseFloat($(this).find("ACCORDATO").text());

                rowData.push([{ text: livello, alignment: "left" }]);
                rowData.push([$(this).find("NRAP").text()]);
                rowData.push([accounting.formatMoney(parseFloat($(this).find("RICAVO").text()), "€ ", 2, ".", ",")]);
                rowData.push([accounting.formatMoney(parseFloat($(this).find("UTILIZZATO").text()), "€ ", 2, ".", ",")]);
                rowData.push([accounting.formatMoney(parseFloat($(this).find("ACCORDATO").text()), "€ ", 2, ".", ",")]);
                rowData.push([accounting.formatNumber(parseFloat($(this).find("IU").text()) * 100, 2, ".", ",") + "%"]);
                rowData.push([accounting.formatNumber(parseFloat($(this).find("IGS").text()), 2, ".", ",")]);
                tableData.push(rowData);

                dataRapportiXML.push([livello, parseFloat($(this).find("NRAP100").text())]);
                dataRicavoXML.push([livello, parseFloat($(this).find("RICAVO100").text())]);
                dataUtilizzatoXML.push([livello, parseFloat($(this).find("UTILIZZATO100").text())]);
                dataAccordatoXML.push([livello, parseFloat($(this).find("ACCORDATO100").text())]);

            });

            var rowData = new Array();
            //var rowData = [];
            rowData.push([{text: "TOTALI: ", style: "tableFooter" }]);
            rowData.push([{ text: accounting.formatNumber(totNRAP, 0, ".", ","), style: "tableFooter" }]);
            rowData.push([{ text: accounting.formatMoney(totRICAVO, "€ ", 2, ".", ","), style: "tableFooter" }]);
            rowData.push([{ text: accounting.formatMoney(totUTILIZZATO, "€ ", 2, ".", ","), style: "tableFooter" }]);
            rowData.push([{ text: accounting.formatMoney(totACCORDATO, "€ ", 2, ".", ","), style: "tableFooter" }]);
            rowData.push([{ text: accounting.formatNumber(totUTILIZZATO / totACCORDATO * 100, 2, ".", ",") + "%", style: "tableFooter" }]);
            rowData.push([{ text: " ", style: "tableFooter" }]);
            tableData.push(rowData);

            google.charts.setOnLoadCallback(drawChart);
        };

        function drawChart() {
            var serie = ["Rapporti", "Ricavo", "Utilizzato", "Accordato"];

            for (var i = 0; i < serie.length; i++) {
                // Define the chart to be drawn.
                var data = new google.visualization.DataTable();
                data.addColumn("string", "Livello");
                data.addColumn("number", serie[i]);
                switch (i) {
                    case 0:
                        data.addRows(dataRapportiXML);
                        break;

                    case 1:
                        data.addRows(dataRicavoXML);
                        break;

                    case 2:
                        data.addRows(dataUtilizzatoXML);
                        break;

                    case 3:
                        data.addRows(dataAccordatoXML);
                        break;
                };
                
                var options = {
                    title: "Distribuzione del Rischio per " + serie[i],
                    fontSize: 12,
                    slices: {
                        0: {color: "green" },
                        1: {color: "blue"},
                        2: {color: "orange"},
                        3: {color: "red" },
                    },
                    height: 300,
                    is3D: true,
                };

                // Instantiate and draw the chart.
                var Pie = new google.visualization.PieChart(document.getElementById("Pie" + serie[i]));
                Pie.draw(data, options);

            };
        };

        function get_uBank_bolle() {
            $.ajax({
                type: "POST",
                url: "appGetData.aspx/Get_uBank_bolle",
                //data: criterio,
                cache: false,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () { $("#msgError").html(msgInfo.div("info", "<p class='text-center'><img src='images/ajax-loader.gif'></p>")).show(); },
                success: get_uBank_bolle_success,
                error: function (xhr, status, error) { $("#msgError").html(msgInfo.div("danger", "La funzione è in Errore: " + xhr.status + xhr.responseText)).show(); }
            });
        };

        function get_uBank_bolle_success(response) {
            $("#msgError").html("").hide();

            var nrc = JSON.stringify(xml2json(response.d)).slice(-3);
            var pqa = (nrc == "]}}" ? "" : "[");
            var pqc = (nrc == "]}}" ? "" : "]");

            jsonOutput = pqa + JSON.stringify(xml2json(response.d).NewDataSet.uBankReport) + pqc;

            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var index = 0;

            $(xml).find("uBankReport").each(function () {
                var livelloRicavoInt = parseInt($(this).find("LivelloRicavo").text().substr(0, 1));
                var livelloRicavoTxt = $(this).find("LivelloRicavo").text();
                livelloRicavoTxt = livelloRicavoTxt.substr(4, livelloRicavoTxt.length - 4);

                var livelloIndiceInt = parseInt($(this).find("LivelloIACT").text().substr(0, 1));
                var livelloIndiceTxt = $(this).find("LivelloIACT").text();
                livelloIndiceTxt = livelloIndiceTxt.substr(4, livelloIndiceTxt.length - 4);

                var livello = "Ricavi Fascia: " + livelloRicavoTxt + " - Rischio Fascia: " + livelloIndiceTxt;
                dataBolleXML.push(["", livelloRicavoInt, livelloIndiceInt, "Rischio " + livelloIndiceTxt, parseInt($(this).find("NRAP").text())]);
            });

            google.charts.setOnLoadCallback(drawBolle);
        };

        function drawBolle() {
            // Define the chart to be drawn.
            var dataBolle = new google.visualization.DataTable();
            dataBolle.addColumn('string', 'Livello');
            dataBolle.addColumn('number', 'Ricavi');
            dataBolle.addColumn('number', 'Rischio');
            dataBolle.addColumn('string', 'Descrizione');
            dataBolle.addColumn('number', 'Rapporti');
            dataBolle.addRows(dataBolleXML);

            var optionsBolle = {
                title: "Analisi Qualitativa",
                hAxis: {
                    title: "Distribuzione Ricavi",
                    minValue: 0,
                    maxValue: 5,
                    gridlines: { count: 5 },
                    ticks: [0, 1, 2, 3, 4],
                },
                series: {
                    "Rischio Basso": { color: "green" },
                    "Rischio Medio Basso": { color: "blue" },
                    "Rischio Medio Alto": { color: "orange" },
                    "Rischio Alto": { color: "red" }
                },
                vAxis: {
                    title: "Livello di Rischio",
                    minValue: 0,
                    maxValue: 5,
                    gridlines: { count: 5 },
                    ticks: [0, 1, 2, 3, 4],
                },
                height: 500
            };

            // Instantiate and draw the chart.
            var divBolle = $("#bolle");
            bolleRapporti = new google.visualization.BubbleChart(document.getElementById("bolle"));
            bolleRapporti.draw(dataBolle, optionsBolle);
        };

        function getParametriTXT() {
            $http.get("/dati/parStatus.txt").then(function (response) {
                $scope.dropStatus = response.data.elencoStatus;
             });

            $http.get("/dati/parAzioni.txt").then(function (response) {
                $scope.dropAzioni = response.data.azioni;
            });

            $http.get("/dati/parLegali.txt").then(function (response) {
                $scope.dropLegali = response.data.legale;
            });

            $scope.$apply();
        };

        //------------------------------ Tabella Banca ------------------------------------------------//

        function tabella_uBank() {
            var larghezza = $("#tabella_uBank").width();

            $("#tabella_uBank").tabulator({
                height: "200px",
                fitColumns: true,
                columns: [
                    { title: "", formatter: mask.iconProfilo, width: parseInt(larghezza * 0.05), align: "center"},
                    { title: "Livello", field: "Livello", width: parseInt(larghezza * 0.2)},
                    { title: "Numero Rapporti", field: "NRAP", formatter: mask.integerFormatter, width: parseInt(larghezza * 0.07), sorter: "number", align: "center" },
                    { title: "Ricavi",     field: "RICAVO",     formatter: mask.moneyFormatter, width: parseInt(larghezza * 0.15), sorter: "number", align: "right" },
                    { title: "Utilizzato", field: "UTILIZZATO", formatter: mask.moneyFormatter, width: parseInt(larghezza * 0.15), sorter: "number", align: "right" },
                    { title: "Accordato",  field: "ACCORDATO",  formatter: mask.moneyFormatter, width: parseInt(larghezza * 0.15), sorter: "number", align: "right" },
                    { title: "Indice Utilizzo", field: "IU", formatter: mask.decimalFormatter, width: parseInt(larghezza * 0.1), sorter: "number", align: "center" },
                    { title: "Indice Rischio", field: "IGS", formatter: mask.decimalFormatter, width: parseInt(larghezza * 0.1), sorter: "number", align: "center" },
                ],

                index: "Livello",

                rowClick: function (e, id, data, row) {

                },

                rowFormatter: function (row, data) {

                },

                colResizable: false,
                sortable: false,
                //pagination: true,
                //paginationSize: 12,
                //progressiveRenderSize: 12,
                //progressiveRenderPeriod: 100
            });

        };

        //-----------------------------End Gestione Tabelle----------------------------------------------//

        function gage(valoreIndice) {
            $("#igs").empty();
            var igs = new JustGage({
                id: "igs",
                decimals: 2,
                value: valoreIndice.replace(",", "."),
                min: 0,
                max: 10,
                gaugeWidthScale: 0.6,
                counter: true,
                pointer: true,
                title: "Livello di Rischio",
                textRenderer: function (val) {
                    if (val < 5) {
                        return "Regolare " + val.toFixed(2);
                    } else if (val >= 5 && val < 8) {
                        return "Pericolo " + val.toFixed(2);
                    } else if (val >= 8) {
                        return "Allarme " + val.toFixed(2);
                    }
                },
            });
        };

        $scope.chiudi = function () {
            $("#msgError").html("").hide();

            if ($scope.elenco_uBank == true) {
                window.location.href = "#/main";
            } else {
                $scope.elenco_uBank = true;
            };
        };

        //$scope.stampa = function () {
        $("#btn_print").click(function () {

            $("#msgError").html("").hide();

            var b4TxtModal = "Elaborazione Report in corso...";
            var b4ImgModal = "../images/CPB.LogoT.png";

            var successTxtModal = "Elaborazione terminata con successo!";
            var successImgModal = bolleRapporti.getImageURI();

            var docDefinition = {
                pageSize: "A4",
                pageOrientation: "landscape",
                pageMargins: [40, 100, 40, 60],

                header: {
                    columns: [
                        //{ image: "pofesr_sicilia_2014_2020.jpg", style: "jpg" },
                        { text: "Logo", style: "txt" },
                        { text: "uBank", style: "header1" },
                        { text: "Istituto di Credito", style: "txt" },
                    ]

                },
                footer: {
                    columns: [
                      { text: "Powered", alignment: "center" },
                      { text: "SVS.Impresa Srls", alignment: "center" },
                    ]
                },
                content: [
                    {
                        text: "Analisi Grafica del Rischio",
                        style: "header2"
                    },
                    {
                        image: "chartBubble",
                        width: 750,
                    },
                    {
                        table:
                          {
                              widths: [150, 50, 120, 120, 120, 70, 70],
                              body: tableData,                                 
                          },
                        style:"tableBody"   
                    },
                        ],

                images: {
                    chartBubble: successImgModal,
                },
                styles: {
                    header1: {
                        fontSize: 20,
                        bold: true,
                        alignment: "center",
                        margin: [0, 30, 0, 10],
                    },
                    header2: {
                        fontSize: 16,
                        bold: true,
                        alignment: "center",
                        margin: 5
                    },
                    tableBody: {
                        headerRows: 1,
                        margin: [0, 5, 0, 10],
                        fontSize: 10,
                        alignment:"right"
                    },
                    tableHeader: {
                        bold: true,
                        //italics: true,
                        fillColor: "gray",
                        fontSize: 11,
                        color: "red",
                        alignment:"center"
                    },
                    tableFooter: {
                        bold: true,
                        fillColor: "yellow",
                        fontSize: 11,
                        color: "blue",
                        alignment: "right"
                    },
                    txt: {
                        fontSize: 12,
                        color: "red",
                        alignment: "center",
                        margin: 30
                    },
                    jpg: {
                        width: 100
                    }
                }
            };

            pdfMake.createPdf(docDefinition).open();

        });

        function table(data, columns) {
            return {
                table: {
                    headerRows: 1,
                    body: buildTableBody(data, columns),
                    widths: [150, 50, 120, 120, 120, 70, 70],
                    style: "tableBody"
                }
            };
        };

        function buildTableBody(data, columns) {
            var body = [];

            body.push(columns);

            $.each(JSON.parse(data), function (row) {
                var dataRow = [];
                $.each(columns, function (column) {
                    dataRow.push(row[column]);
                    alert(dataRow);
                });

                body.push(dataRow);
            });

            return body;
        };

        function b4Modal(testo, img) {
            $("#runModal").modal();

            $("#txtModal").html(testo);
            $("#imgModal").attr("src", img);
        };

        function successModal(testo, img) {
            $("#runModal").modal("hide");
            $("#runModal").modal();

            $("#txtModal").html(testo);
            $("#imgModal").attr("src", img);
        };

        function errorModal(xhr, status, error) {
            $("#runModal").modal("hide");
            //$("#runModal").modal();

            $("#msgError").html(msgInfo.div("danger", "La funzione è in Errore: " + xhr.status + "<br/>" + xhr.responseText));
        };

    });

    //------------------------------End ctrl-uBank controller--------------------------------------------//

})();