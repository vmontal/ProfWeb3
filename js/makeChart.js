//------------------------------ Begin --------------------------------//

'use strict';

//----------------- Disegna Grafico Lineare --------------------------- //
const drawChart =  (lineData, larghezza, AsseX, Serie, vAxisFormat, Titolo, divChart) => {
    var dataLine = new google.visualization.DataTable();
    dataLine.addColumn('string', AsseX);
    var numero = Serie.length;
    var i = 0;
    for (i; i < numero; i++) {
        dataLine.addColumn('number', Serie[i]);
    };
    dataLine.addRows(lineData);

    var optionsLine = {
        animation: {
            duration: 2000,
            startup: true,
            easing: "linear",
        },
        title: Titolo,
        titleTextStyle: {
            color: "darkgray",
            fontName: "Verdana",
            fontSize: 16,
            bold: true,
            italic: false
        },
        //series: {
        //    0: {
        //        targetAxisIndex: 0,
        //        pointShape: "circle",
        //        pointSize: 6,
        //        //labelInLegend: "Tasso Effettivo",
        //        //visibleInLegend: true,

        //    },
        //    1: {
        //        targetAxisIndex: 0,
        //        pointShape: "square",
        //        pointSize: 6,
        //        //labelInLegend: "Tasso Effettivo con Mora",
        //        //visibleInLegend: true,
        //    },
        //    2: {
        //        targetAxisIndex: 0,
        //        pointShape: "triangle",
        //        pointSize: 6,
        //        //labelInLegend: "Tasso Soglia",
        //        //visibleInLegend: true,
        //    },
        //},
        hAxis: {
            title: "Periodo di Osservazione",
            slantedText: true,
        },
        vAxis: {
            title: "Valore",
            format: vAxisFormat,
            viewWindowMode: "pretty",
        },
        height: larghezza * 0.6,
        width: larghezza,
        curveType: "function",
        //legend: {
        //    position: "top",
        //    alignment: "start",
        //    style: "vertical",
        //},

    };

    var chartLine = new google.visualization.LineChart(document.getElementById(divChart));

    //var selectHandler = function () {
    //    selectedItem = chartScatter.getSelection()[0];
    //    if (selectedItem) {
    //        var getLivelloRicavi = parseFloat(dataScatter.getValue(selectedItem.row, 0));
    //        var getLivelloRischio = parseFloat(dataScatter.getValue(selectedItem.row, 1));
    //        var getTipoRapporto = dataScatter.getValue(selectedItem.row, 2);
    //        alert(getLivelloRicavi + " - " + getLivelloRischio + " - " + getTipoRapporto);
    //    };
    //};

    //google.visualization.events.addListener(chartLine, 'select', selectHandler);
    chartLine.draw(dataLine, optionsLine);

    return chartLine;
};

const drawBar = (barData, larghezza, altezza, areaDiv, titolo) => {
    var data = new google.visualization.DataTable();
    data.addColumn("string", "Elemento");
    data.addColumn("number", "Valore");
    data.addColumn({ type: "string", role: "style" });
    data.addColumn({ type: "string", role: "tooltip" });
    data.addRows(barData);

    var options = {
        title: titolo,
        titleTextStyle: {
            color: "darkgray",
            fontName: "Verdana",
            fontSize: 32,
            bold: true,
            italic: false
        },
        animation: {
            duration: 2000,
            startup: true,
            easing: "linear",
        },
        height: altezza,
        width: larghezza,
        hAxis: {
            format: "short",
            viewWindowMode: "maximized",
        },
        vAxis: {
            textPosition: "in"
        },
        legend: {
            position: "none"
        },
    };

    var barValori = new google.visualization.BarChart(document.getElementById(areaDiv));
    barValori.draw(data, options);

    return barValori;
};


//var drawBar = function (barData, larghezza, colore, testo, areaDiv) {
//    var data = new google.visualization.DataTable();
//    data.addColumn("string", "Elemento");
//    data.addColumn("number", "Valore");
//    data.addColumn({ type: "string", role: "style" });
//    data.addColumn({ type: "string", role: "tooltip" });
//    data.addRows(barData);

//    var options = {
//        title: "Il Tasso Effettivo Globale è " + testo,
//        titleTextStyle: {
//            color: colore,
//            fontName: "Verdana",
//            fontSize: 14,
//            bold: true,
//            italic: false
//        },
//        animation: {
//            duration: 1000,
//            startup: true,
//            easing: "linear",
//        },
//        height: larghezza * 0.4,
//        width: larghezza,
//        hAxis: {
//            format: "short",
//            viewWindowMode: "maximized",
//            minValue: 0
//        },
//        vAxis: {
//            textPosition: "out"
//        },
//        legend: {
//            position: "none"
//        },
//    };

//    var barValori = new google.visualization.BarChart(document.getElementById(areaDiv));
//    barValori.draw(data, options);

//    return barValori;
//};
