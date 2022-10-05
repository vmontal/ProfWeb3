//------------------------------ Begin --------------------------------//

'use strict';

//-------------------------------Print PDF----------------------------//
const pdfModuloIscrizione = (rs, sfondo, posizione, titolo, subTitolo, dataTable, larghezza, margini, datiPrivacy, larghezzaPrivacy, marginiPrivacy, formula, footerText, myIframe) =>  {
    //logo,
    let pdfOption = {
        pageSize: "A4",
        pageOrientation: posizione,
        pageMargins: [15, 100, 15, 60],

        header: function () {
            var sxMargin = "10%";
            var mdMargin = "80%";
            var dxMargin = "10%";
            return {
                margin: [5, 5],
                columns: [{
                    table: {
                        widths: [sxMargin, mdMargin, dxMargin],
                        body: [
                          [{

                          },
                          {
                              //image: logo,
                              //width: 100,
                              //alignment: "center"
                              text: rs,
                              style: 'header',
                          },
                          {
                              //table:
                              //  {
                              //      widths: larghezzaParametri,
                              //      body: tableParametri,
                              //  },
                              //margin: 0,
                              //layout: 'noBorders'
                          }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        footer: function () {
            var sxMargin = "75%";
            var dxMargin = "25%";
            return {
                margin: 20,
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body: [
                          [{
                              text: footerText,
                              style: "footerSX"
                          },
                          {
                              text: "Stampato il: " + oggi(),
                              style: "footerDX"
                          }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        background: function () {
            if (sfondo) {
                return {
                    image: logo,
                    width: 300,
                    margin: [300, 200],
                    alignment: "left"
                }
            } else {
                return {
                    text:" "
                }
            }
        },
        content: [
            {
                text: titolo,
                style: 'header',
            },
            {
                //text: subTitolo,
                //style: 'subHeader',
            },
            {
                table: {
                    widths: larghezza,
                    body: dataTable,
                    },
                margin: margini,
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 2 : 1;
                    },
                    vLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 2 : 1;
                    },
                    hLineColor: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 'black' : 'gray';
                    },
                    vLineColor: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray';
                    },
                    // paddingLeft: function(i, node) { return 4; },
                    // paddingRight: function(i, node) { return 4; },
                    // paddingTop: function(i, node) { return 2; },
                    // paddingBottom: function(i, node) { return 2; }
                }
            },
            {
                text: formula,
                style: 'subHeader',
            },
            {
                table:
                  {
                      widths: larghezzaPrivacy,
                      body: datiPrivacy,
                  },
                margin: marginiPrivacy,
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 1 : 1;
                    },
                    vLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 1 : 1;
                    },
                    hLineColor: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 'black' : 'gray';
                    },
                    vLineColor: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray';
                    },
                    // paddingLeft: function(i, node) { return 4; },
                    // paddingRight: function(i, node) { return 4; },
                    // paddingTop: function(i, node) { return 2; },
                    // paddingBottom: function(i, node) { return 2; }
                }
            },
        ],
        styles: {
            header: {
                fontSize: 18,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "black",
            },
            subHeader: {
                fontSize: 12,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "darkgray",
            },
            tableHeader: {
                color: "white",
                fillColor: "darkgray",
                fontSize: 8,
                bold: true,
                alignment: "center"
            },
            tableBody: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "justify"
            },
            tableTitle: {
                fillColor: "darkgray",
                color: "white",
                fontSize: 16,
                alignment: "center"
            },
            tableSx: {
                fillColor: "lightgray",
                color: "black",
                fontSize: 10,
                alignment: "right"
            },
            tableDx: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "left"
            },
            tableTextDx: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                //bold: true,                
                alignment: "left"
            },
            tableMd: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "center"
            },
            headerParametri: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "center",
            },
            parametri: {
                fillColor: "white",
                color: "darkgray",
                fontSize: 8,
                alignment: "right",
                margin: 0
            },
            footerSX: {
                alignment: "justify",
                fontSize: 8,
                color: "darkgray"
            },
            footerDX: {
                alignment: "right",
                fontSize: 8,
                color: "darkgray"
            },
        }
    };

    pdfMake.createPdf(pdfOption).getDataUrl(function (outDoc) {
        myIframe.src = outDoc;
    });

    //pdfMake.createPdf(pdfOption).download("/reports", titolo + ".pdf",);

    //pdfMake.createPdf(pdfOption).open();
    //closeDialog();
};

const pdfRicevuta = (logo, timbro, dataTable, header, corpo, footer, parametri, myIframe) => {
    let parteIntera = dataTable.importoMov.split("€")[1].split(",")[0];
    let parteDecimale = dataTable.importoMov.split(",")[1];
    parteDecimale = parteDecimale ? parteDecimale : "00";
    let annullata = dataTable.deletedMov == "true" ? true : false;
    console.log(dataTable);
    let pdfOption = {
        pageSize: parametri.formato,
        pageOrientation: parametri.posizione,
        pageMargins: [30, 100, 30, 60],

        header: () => {
            let sxMargin = "50%";
            let dxMargin = "50%";
            return {
                margin: [40, 10, 40, 100],
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body:
                        [
                            [
                                {
                                    image: logo,
                                    width: 150,
                                    alignment: "center"
                                },
                                {
                                    image: logo,
                                    width: 150,
                                    alignment: "center"
                                }
                            ],
                            [
                                {
                                    text: "Sede legale " + header.sedeLegale + " - Codice fiscale " + header.codiceFiscale, 
                                    style: "subHeader",
                                },
                                {
                                    text: "Sede legale " + header.sedeLegale + " - Codice fiscale " + header.codiceFiscale,
                                    style: "subHeader",
                                }
                            ],
                            [
                                {
                                    text: "Iscritta al Registro Regionale/Provinciale del Volontariato Nr. " + header.registroVolontariatoNr + " Dal: " + header.registroVolontariatoDt,
                                    style: "subHeader",
                                },
                                {
                                    text: "Iscritta al Registro Regionale/Provinciale del Volontariato Nr. " + header.registroVolontariatoNr + " Dal: " + header.registroVolontariatoDt,
                                    style: "subHeader",
                                }
                            ]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        footer: () => {
            let sxMargin = "50%";
            let dxMargin = "50%";
            return {
                margin: 5,
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body: [
                            [{
                                text: "----",
                                style: "hidden"
                            },
                            {
                                text: "----",
                                style: "hidden"
                            }
                            ],
                            [
                            {
                                text: footer.sx,
                                style: "footer"
                            },
                            {
                                text: footer.dx,
                                style: "footer"
                            }
                            ],
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        content: [
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [
                            {
                                table: {
                                    widths: ["70%","30%"],
                                    body: [
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "Ricevuta Nr: " + dataTable.idProg }],
                                        ],
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "del: " + dataTable.dataMovGMA }],
                                        ],
                                        [
                                            [{ text: "della somma di " + dataTable.importoMov + " (" + sgart.convNumLett2(parteIntera) + "/" + parteDecimale + ")"}],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: " a titolo di " + dataTable.idCausale.split("-")[1]}],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: "da: " + dataTable.soggettoMov }],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: "CF: " + dataTable.codiceFiscaleMov }],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                    ]
                                },
                                layout: 'noBorders',
                                margin: [0, 10, 10, 30],
                            },
                            {
                                table: {
                                    widths: ["70%", "30%"],
                                    body: [
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "Ricevuta Nr: " + dataTable.idProg }],
                                        ],
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "del: " + dataTable.dataMovGMA }],
                                        ],
                                        [
                                            [{ text: "della somma di " + dataTable.importoMov + " (" + sgart.convNumLett2(parteIntera) + "/" + parteDecimale + ")" }],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: " a titolo di " + dataTable.idCausale.split("-")[1]}],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: "da: " + dataTable.soggettoMov }],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                        [
                                            [{ text: "CF: " + dataTable.codiceFiscaleMov}],
                                            [{ text: "----- ", style: "hidden" }],
                                        ],
                                    ]
                                },
                                layout: 'noBorders',
                                margin: [10, 10, 0, 30],
                            }
                        ],
                        [
                            {
                                text: corpo.dichiara,
                                style: "subHeaderPrivacySX",
                            },
                            {
                                text: corpo.dichiara,
                                style: "subHeaderPrivacyDX",
                            }
                        ],
                        [
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "-----", style: "hidden" }],
                                            [{ text: "Timbro e firma", style: "timbro" }]
                                        ]
                                    ]
                                },
                                layout: 'noBorders' 
                            },
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "-----", style: "hidden" }],
                                            [{ text: "Timbro e firma", style: "timbro" }]
                                        ]
                                    ]
                                },
                                layout: 'noBorders' 
                            }
                        ],
                        [
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "-----", style: "hidden" }],
                                            //[{ text: "-----" }]
                                            [{
                                                image: timbro,
                                                width: 120,
                                                alignment: "center"
                                            }]
                                        ]
                                    ]
                                },
                                layout: 'noBorders'
                            },
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "-----", style: "hidden" }],
                                            //[{ text: "-----" }]
                                            [{
                                                image: timbro,
                                                width: 120,
                                                alignment: "center"
                                            }]
                                        ]
                                    ]
                                },
                                layout: 'noBorders'
                            }
                        ],
                        [
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "________________", style: "timbro" }],
                                        ]
                                    ]
                                },
                                layout: 'noBorders'
                            },
                            {
                                table: {
                                    widths: ["*", "*"],
                                    body: [
                                        [
                                            [{ text: "----- ", style: "hidden" }],
                                            [{ text: "________________", style: "timbro" }],
                                        ]
                                    ]
                                },
                                layout: 'noBorders'
                            }
                        ],
                        [
                            {
                                text: corpo.privacy,
                                style: "subHeaderPrivacySX",
                            },
                            {
                                text: corpo.privacy,
                                style: "subHeaderPrivacyDX",
                            }
                        ],
                        [
                            {
                                text: "Nota: " + dataTable.notaMov,
                                style: "subHeaderPrivacySX",
                            },
                            {
                                text: "Nota: " + dataTable.notaMov,
                                style: "subHeaderPrivacySX",
                            }
                        ],
                        [
                            {
                                text: annullata ? "ANNULLATA" : " ",
                                style: annullata ? "textAnnullato" : "hidden",
                            },
                            {
                                text: annullata ? "ANNULLATA" : " ",
                                style: annullata ? "textAnnullato": "hidden",
                            }
                        ],
                    ],                    
                },
                margin: [0, 30, 0, 50],
                layout: {
                    hLineWidth: (i, node) => {
                        return 0;
                    },
                    vLineWidth: (i, node) => {
                        return (i === 0 || i === node.table.widths.length) ? 0 : 1;
                    },
                }
            },
            ],
        styles: {
            header: {
                fontSize: 11,
                bold: true,
                alignment: "center",
                margin: [0, 2],
                color: "black",
            },
            subHeader: {
                fontSize: 9,
                bold: false,
                alignment: "center",
                margin: [0, 3, 0, 0],
                color: "black",
            },
            subHeaderPrivacySX: {
                fontSize: 9,
                bold: false,
                alignment: "justify",
                margin: [0, 2, 10, 2],
                color: "black",
            },
            subHeaderPrivacyDX: {
                fontSize: 9,
                bold: false,
                alignment: "justify",
                margin: [10, 2, 0, 2],
                color: "black",
            },
            hidden: {
                color: "white",
                fillColor: "white",
            },
            timbro: {
                fontSize: 9,
                alignment: "center",
            },
            textAnnullato: {
                color: "red",
                fillColor: "darkgray",
                fontSize: 20,
                bold: true,
                alignment: "center"
            },
            tableHeader: {
                color: "white",
                fillColor: "darkgray",
                fontSize: 8,
                bold: true,
                alignment: "center"
            },
            tableBody: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "justify"
            },
            tableTitle: {
                fillColor: "darkgray",
                color: "white",
                fontSize: 16,
                alignment: "center"
            },
            tableSx: {
                fillColor: "lightgray",
                color: "black",
                fontSize: 10,
                alignment: "right"
            },
            tableDx: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "left"
            },
            tableTextDx: {
                fillColor: "white",
                color: "black",
                fontSize: 14,
                bold: true,
                alignment: "left"
            },
            tableMd: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "center"
            },
            headerParametri: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "center",
            },
            parametri: {
                fillColor: "white",
                color: "darkgray",
                fontSize: 8,
                alignment: "right",
                margin: 0
            },
            footer: {
                alignment: "center",
                fontSize: 8,
                color: "darkgray",
                margin: 0
            },
        }
    };

    //console.log(myIframe);
    pdfMake.createPdf(pdfOption).getDataUrl((outDoc) => {        
        myIframe.src = outDoc;
    });

    //pdfMake.createPdf(pdfOption).download("/reports", titolo + ".pdf",);

    //pdfMake.createPdf(pdfOption).open();
};

const pdfReport = (rs, sfondo, posizione, titolo, subTitolo, dataTable, larghezza, margini, formula, footerText, myIframe) => { //imageChart, imageWidth,
    console.log(dataTable);
    let pdfOption = {
        pageSize: "A4",
        pageOrientation: posizione,
        pageMargins: [10, 100, 10, 40],

        header: function () {
            var sxMargin = "25%";
            var mdMargin = "50%";
            var dxMargin = "25%";
            return {
                margin: [40, 40, 40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, mdMargin, dxMargin],
                        body: [
                            [{

                            },
                            {
                                //image: logo,
                                //width: 300,
                                //alignment: "center",
                                text: rs,
                                style: 'header',
                            },
                            {
                                //table:
                                //  {
                                //      widths: larghezzaParametri,
                                //      body: tableParametri,
                                //  },
                                //margin: 0,
                                //layout: 'noBorders'
                            }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        footer: function () {
            var sxMargin = "50%";
            var dxMargin = "50%";
            return {
                margin: [40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body: [
                            [{
                                text: formula ? formula.sedeLegaleLuogo + ", " + oggi() : "Stampato il: " + oggi(),
                                style: formula ? "footerBilancio" : 'footerSX'
                            },
                            {
                                text: formula ? "Il Presidente" + "\n" + footerText : footerText,
                                style: formula ? "footerBilancio" : "footerDX"
                            }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        background: function () {
            if (sfondo) {
                return {
                    image: logo,
                    width: 300,
                    margin: [300, 200],
                    alignment: "left"
                }
            } else {
                return {
                    text: " "
                }
            }
        },
        content: [
            {
                text: formula ? "Sede legale: " + formula.sedeLegaleIndirizzo + " - " + formula.sedeLegaleCAP + " " + formula.sedeLegaleLuogo + "\n" + "Codice Fiscale:" + formula.sedeLegaleCF : titolo,
                style: formula ? "headerBilancio" : 'header',
            },
            {
                text: subTitolo,
                style: 'subHeader',
            },
            {
                table: {
                    widths: larghezza,
                    headerRows: 1,
                    keepWithHeaderRows: 1,
                    dontBreakRows: true,
                    body: dataTable,
                },
                margin: margini,
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 2 : 1;
                    },
                    vLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 2 : 1;
                    },
                    hLineColor: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 'black' : 'gray';
                    },
                    vLineColor: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray';
                    },
                    // paddingLeft: function(i, node) { return 4; },
                    // paddingRight: function(i, node) { return 4; },
                    // paddingTop: function(i, node) { return 2; },
                    // paddingBottom: function(i, node) { return 2; }
                },
                //pageBreak: 'after',
            },
            {
            //function() {
            //    if (imageChart) {
            //        return {
            //image: imageChart,
            //alignment: "center",
            //width: imageWidth,
            //height: parseInt(imageWidth / 1.5),
            //margin: [2, 2],
            //        }
            //    }
            //},
            }
        ],

        styles: {
            header: {
                fontSize: 16,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "black",
            },
            subHeader: {
                fontSize: 12,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "darkgray",
            },
            headerBilancio: {
                fontSize: 12,
                bold: true,
                alignment: "center",
                margin: [0, 10],
                color: "darkgray",
            },
            tableHeader: {
                color: "white",
                fillColor: "darkgray",
                fontSize: 10,
                bold: true,
                alignment: "center"
            },
            tableBody: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "left"
            },
            tableTotCat: {
                fillColor: "white",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotEnt: {
                fillColor: "yellow",
                color: "red",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotUsc: {
                fillColor: "red",
                color: "yellow",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotGen: {
                fillColor: "lightgray",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "left"
            },
            tableNumber: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "center"
            },
            reportString: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "left"
            },
            tableMoney: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "right"
            },
            tableMoneyTotCat: {
                fillColor: "white",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotEnt: {
                fillColor: "yellow",
                color: "red",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotUsc: {
                fillColor: "red",
                color: "yellow",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotGen: {
                fillColor: "lightgray",
                color: "black",
                bold: true,
                fontSize: 18,
                alignment: "right"
            },
            tableBodyTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "center"
            },
            tableNumberTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "center"
            },
            tableMoneyTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "right"
            },
            tableTitle: {
                fillColor: "darkgray",
                color: "white",
                fontSize: 16,
                alignment: "center"
            },
            tableSx: {
                fillColor: "lightgray",
                color: "black",
                fontSize: 10,
                alignment: "right"
            },
            tableDx: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "left"
            },
            tableMd: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "center"
            },
            headerParametri: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "center",
            },
            parametri: {
                fillColor: "white",
                color: "darkgray",
                fontSize: 8,
                alignment: "right",
                margin: 0
            },
            footerSX: {
                alignment: "left",
                fontSize: 8,
                color: "darkgray"
            },
            footerDX: {
                alignment: "center",
                fontSize: 8,
                color: "darkgray"
            },
            footerBilancio: {
                alignment: "center",
                fontSize: 12,
                color: "black"
            }
        }
    };

    pdfMake.createPdf(pdfOption).getDataUrl((outDoc) => {
        myIframe.src = outDoc;
    });

    //pdfMake.createPdf(pdfOption).download("reports/" + titolo + ".pdf");

    //pdfMake.createPdf(pdfOption).open();
    //closeDialog();
};

const pdfReportItalia = (rs, sfondo, posizione, titolo, subTitolo, dataTable, larghezza, margini, formula, footerText, imageChart, imageWidth, myIframe) => {
    console.log(dataTable);
    let pdfOption = {
        pageSize: "A4",
        pageOrientation: posizione,
        pageMargins: [10, 100, 10, 40],

        header: function () {
            var sxMargin = "25%";
            var mdMargin = "50%";
            var dxMargin = "25%";
            return {
                margin: [40, 40, 40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, mdMargin, dxMargin],
                        body: [
                            [{

                            },
                            {
                                //image: logo,
                                //width: 300,
                                //alignment: "center",
                                text: rs,
                                style: 'header',
                            },
                            {
                                //table:
                                //  {
                                //      widths: larghezzaParametri,
                                //      body: tableParametri,
                                //  },
                                //margin: 0,
                                //layout: 'noBorders'
                            }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        footer: function () {
            var sxMargin = "50%";
            var dxMargin = "50%";
            return {
                margin: [40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body: [
                            [{
                                text: formula ? formula.sedeLegaleLuogo + ", " + oggi() : "Stampato il: " + oggi(),
                                style: formula ? "footerBilancio" : 'footerSX'
                            },
                            {
                                text: formula ? "Il Presidente" + "\n" + footerText : footerText,
                                style: formula ? "footerBilancio" : "footerDX"
                            }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        background: function () {
            if (sfondo) {
                return {
                    image: logo,
                    width: 300,
                    margin: [300, 200],
                    alignment: "left"
                }
            } else {
                return {
                    text: " "
                }
            }
        },
        content: [
            {
                text: formula ? "Sede legale: " + formula.sedeLegaleIndirizzo + " - " + formula.sedeLegaleCAP + " " + formula.sedeLegaleLuogo + "\n" + "Codice Fiscale:" + formula.sedeLegaleCF : titolo,
                style: formula ? "headerBilancio" : 'header',
            },
            {
                text: subTitolo,
                style: 'subHeader',
            },
            {
                table: {
                    widths: larghezza,
                    headerRows: 1,
                    keepWithHeaderRows: 1,
                    dontBreakRows: true,
                    body: dataTable,
                },
                margin: margini,
                layout: {
                    hLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 2 : 1;
                    },
                    vLineWidth: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 2 : 1;
                    },
                    hLineColor: function (i, node) {
                        return (i === 0 || i === node.table.body.length) ? 'black' : 'gray';
                    },
                    vLineColor: function (i, node) {
                        return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray';
                    },
                    // paddingLeft: function(i, node) { return 4; },
                    // paddingRight: function(i, node) { return 4; },
                    // paddingTop: function(i, node) { return 2; },
                    // paddingBottom: function(i, node) { return 2; }
                },
                pageBreak: 'after',
            },
            {
                //function() {
                //    if (imageChart) {
                //        return {
                image: imageChart,
                alignment: "center",
                width: imageWidth,
                height: parseInt(imageWidth / 1.5),
                margin: [2, 2],
                //        }
                //    }
                //},
            }
        ],

        styles: {
            header: {
                fontSize: 16,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "black",
            },
            subHeader: {
                fontSize: 12,
                bold: true,
                alignment: "center",
                margin: [0, 5],
                color: "darkgray",
            },
            headerBilancio: {
                fontSize: 12,
                bold: true,
                alignment: "center",
                margin: [0, 10],
                color: "darkgray",
            },
            tableHeader: {
                color: "white",
                fillColor: "darkgray",
                fontSize: 10,
                bold: true,
                alignment: "center"
            },
            tableBody: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "left"
            },
            tableTotCat: {
                fillColor: "white",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotEnt: {
                fillColor: "yellow",
                color: "red",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotUsc: {
                fillColor: "red",
                color: "yellow",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableTotGen: {
                fillColor: "lightgray",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "left"
            },
            tableNumber: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "center"
            },
            reportString: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "left"
            },
            tableMoney: {
                fillColor: "white",
                color: "black",
                fontSize: 12,
                alignment: "right"
            },
            tableMoneyTotCat: {
                fillColor: "white",
                color: "black",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotEnt: {
                fillColor: "yellow",
                color: "red",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotUsc: {
                fillColor: "red",
                color: "yellow",
                bold: true,
                fontSize: 14,
                alignment: "right"
            },
            tableMoneyTotGen: {
                fillColor: "lightgray",
                color: "black",
                bold: true,
                fontSize: 18,
                alignment: "right"
            },
            tableBodyTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "center"
            },
            tableNumberTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "center"
            },
            tableMoneyTotal: {
                fillColor: "yellow",
                color: "black",
                fontSize: 12,
                bold: true,
                alignment: "right"
            },
            tableTitle: {
                fillColor: "darkgray",
                color: "white",
                fontSize: 16,
                alignment: "center"
            },
            tableSx: {
                fillColor: "lightgray",
                color: "black",
                fontSize: 10,
                alignment: "right"
            },
            tableDx: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "left"
            },
            tableMd: {
                fillColor: "white",
                color: "black",
                fontSize: 10,
                alignment: "center"
            },
            headerParametri: {
                fillColor: "white",
                color: "black",
                fontSize: 8,
                alignment: "center",
            },
            parametri: {
                fillColor: "white",
                color: "darkgray",
                fontSize: 8,
                alignment: "right",
                margin: 0
            },
            footerSX: {
                alignment: "left",
                fontSize: 8,
                color: "darkgray"
            },
            footerDX: {
                alignment: "center",
                fontSize: 8,
                color: "darkgray"
            },
            footerBilancio: {
                alignment: "center",
                fontSize: 12,
                color: "black"
            }
        }
    };

    pdfMake.createPdf(pdfOption).getDataUrl((outDoc) => {
        myIframe.src = outDoc;
    });

    //pdfMake.createPdf(pdfOption).download("reports/" + titolo + ".pdf");

    //pdfMake.createPdf(pdfOption).open();
    //closeDialog();
};

const pdfMakeChart = (chart1, chart2, larghezza, margini, logo, titolo, tableParametri, larghezzaParametri, posizione, myIframe) =>  {

    var pdfOption = {
        pageSize: "A4",
        pageOrientation: posizione,
        pageMargins: [15, 100, 15, 60],

        header: function () {
            var sxMargin = "25%";
            var mdMargin = "50%";
            var dxMargin = "25%";
            return {
                margin: [40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, mdMargin, dxMargin],
                        body: [
                          [{
                              image: logo,
                              width: 80,
                              alignment: "left"
                          },
                          {
                              text: titolo,
                              style: "header1"
                          },
                          {
                              table:
                                {
                                    widths: larghezzaParametri,
                                    body: tableParametri,
                                },
                              margin: 0,
                              layout: 'noBorders'
                          }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        footer: function() {
            var sxMargin = "50%";
            var dxMargin = "50%";
            return {
                margin: [40, 10],
                columns: [{
                    table: {
                        widths: [sxMargin, dxMargin],
                        body: [
                          [{
                              text: " ",
                              //style: "foo"
                          },
                          {
                              text: " ",
                              //image: "logoFooter",
                              //width: 60,
                              //alignment: "right"
                          }]
                        ]
                    },
                    layout: 'noBorders'
                }]
            };
        },
        content: [
            {
                image: chart1,
                alignment: "center",
                width: larghezza,
                margin: margini,
                pageBreak: 'after',
            },
            {
                image: chart2,
                alignment: "center",
                width: larghezza,
                margin: margini,
            },
        ],
        //content: function() {
        //    var numeroChart = elencoChart.length;
        //    var i = 0;
        //    return                 
        //    //{
        //    //    image: chartTassi,
        //    //    alignment: "center",
        //    //    width: larghezza,
        //    //    margin: 0,
        //    //    //pageBreak: 'after',
        //    //},
        //    {
        //        image: elencoChart[i]
        //        //alignment: "center",
        //        //width: larghezza,
        //        //margin: 0,
        //        //pageBreak: 'before'

        //        //for (i; i < numeroChart; i++){

        //        //image: elencoChart[i],

        //        //};
        //        };
        
        //},

        styles: {
            header1: {
                fontSize: 14,
                bold: true,
                alignment: "center",
                margin: [0, 15, 0, 5],
                color:"darkgray",
            },
            parametri: {
                fillColor: "white",
                color: "darkgray",
                fontSize: 8,
                alignment: "right",
                margin: 0
            },
        }
    };

    pdfMake.createPdf(pdfOption).getDataUrl(function (outDoc) {
        myIframe.src = outDoc;
    });

    //pdfMake.createPdf(pdfOption).open();

    closeDialog();
};

