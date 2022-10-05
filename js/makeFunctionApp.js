'use strict';

const imgKO = "ack-KO.png";
const imgOK = "ack-OK.png";
const imgWhite = "big-logoWhite.png";

//------------ Aggiorna App -------------------------//
const resetApp = () => {
    caches.keys()
        .then(function (keyList) {
            return Promise.all(keyList.map(function (key) {
                console.log('[Service Worker] Removing old cache:', key);
                return caches.delete(key);
            }))
                .then(function () {
                    navigator.serviceWorker.getRegistrations().then(function (registrations) {

                        for (let registration of registrations)

                            registration.unregister();

                    }).catch(function (err) {

                        console.log('Service Worker registration failed: ', err);

                    });

                    location.reload(true)
                });
        });
};

//---------------- Crea Hash della password ----------------//
const hash = (stringa) => {
    var bcrypt = dcodeIO.bcrypt;
    var salt = "$2a$12$Fg0j.x19986i9LEeOIcuTu";
    return bcrypt.hashSync(stringa, salt);
};

//---------------- Formatta Campo Numerico ----------------//
const formatoNumero = (campo) => {
    if ($("#" + campo).val() != undefined) {
        return parseFloat($("#" + campo).val().split(".").join("").replace(",", "."));
    };
};

const formatoTasso = (campo) => {
    if ($("#" + campo).val() != undefined) {
        return parseFloat($("#" + campo).val().split("%")[0].split(".").join("").replace(",", "."));
    };
};

//---------- Converte immagine in formato Base64 ------- //
const img2Canvas = (pathFile) => {
    var img = new Image();
    img.src = pathFile;
    img.ratio = img.naturalWidth / img.naturalHeight;

    var canvas = document.createElement("canvas");
    canvas.width = img.naturalWidth;
    canvas.height = img.naturalHeight;

    var ctx = canvas.getContext('2d');
    ctx.drawImage(img, 0, 0);

    var imgBase64 = canvas.toDataURL("image/png");

    return imgBase64;
};


// -------- Oggi -------//
const oggi = (delta) => {
    let giorni = !delta ? 0 : delta;
    let today = new Date();
    today.setDate(today.getDate() + giorni);
    let dd = today.getDate();
    let mm = today.getMonth() + 1; //January is 0!
    let yy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    };

    if (mm < 10) {
        mm = '0' + mm
    };

    const data_it_today = dd + '/' + mm + '/' + yy;
    return data_it_today;
};

// ------------ parseData ----------//
const parseData = (data) => {
    let anno = data.split("/")[2];
    let mese, giorno;
    if (anno) {
        mese = data.split("/")[1];
        giorno = data.split("/")[0];
    } else {
        anno = data.split("-")[2];
        mese = data.split("-")[1];
        giorno = data.split("-")[0];
    };

    return anno + mese + giorno;
};

const changeData = (data, giorni) => {
    giorni = giorni == undefined ? 0 : giorni;
    let today = new Date(data);
    today.setDate(today.getDate() + giorni);
    let dd = today.getDate();
    let mm = today.getMonth() + 1; //January is 0!
    let yy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    };

    if (mm < 10) {
        mm = '0' + mm
    };

    let data_it_today = dd + '/' + mm + '/' + yy;

    return data_it_today;
};

const creaData = (anno, mese, giorno) => {
    return giorno + "-" + mese + "-" + anno;
};

//------------Conta Record--------//
const contaRecord = (myData) => {
    if (myData && !myData.length) {
        return 1;
    } else if (myData) {
        return myData.length;
    } else if (!myData) {
        return 0;
    };
};


//----------- Documentazione------//
var styleCell = function (backColor, textColor, fontWeight) {
    this.backColor = !backColor ? "#fff" : backColor;
    this.textColor = !textColor ? "#000" : textColor;
    this.fontWeight = !fontWeight ? "normal" : fontWeight;
};

const getDropElenco = (parametri, dropElenco, db, callback) => {
    let dropTabella = parametri.tabella;
    let cerca = {};
    cerca.spRead = parametri.spRead;
    cerca.tabella = parametri.tabella;
    cerca.drop = dropElenco;
    $.extend(cerca, parametri.campoID);

    var criterio = {
        data: JSON.stringify(cerca),
        db: db
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
        success: function (response) {
            //console.log(xml2json(response.d).NewDataSet);
            callback(xml2json(response.d).NewDataSet[dropTabella]);
        },
        error: function (xhr, status, error) {
            //console.log(xhr.responseJSON.Message);
            errorDialog(xhr, status, error);
        } 
    });
};

const controllaCF = (cf) => {
    cf = cf.toUpperCase();

    if (!cf) return "Il Codice Fiscale non è stato compilato";

    if (! /^[0-9A-Z]{16}$/.test(cf)) return "Il Codice Fiscale deve contenere 16 cifre tra lettere e numeri.";

    let map = [1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 1, 0, 5, 7, 9, 13, 15, 17,
		19, 21, 2, 4, 18, 20, 11, 3, 6, 8, 12, 14, 16, 10, 22, 25, 24, 23];

    let s = 0;

    for (var i = 0; i < 15; i++) {
        var c = cf.charCodeAt(i);
        if (c < 65)
            c = c - 48;
        else
            c = c - 55;
        if (i % 2 == 0)
            s += map[c];
        else
            s += c < 10 ? c : c - 10;
    };

    let atteso = String.fromCharCode(65 + s % 26);

    if (atteso != cf.charAt(15)) {
        return "Il codice fiscale non è valido:\n" +
			"il codice di controllo non corrisponde.\n";
    } else {
        return "OK";
    };
};

const mail_success = (parametri, parInvio, insert) => {
    if (insert){
        let elencoCampi = parametri.elencoCampi;

        elencoCampi.forEach(function (campo) {
            $("#" + campo).val(undefined);
        });

    } else {
        let modalTitle = "Invio Mail di verifica!"
        let modalText = "<strong>Abbiamo inviato una eMail all'indirizzo da te registrato per verificarne la correttezza. </br> Fai attenzione se per caso la mail non sia stata recapitata nella posta indesiderata (spam)</strong>";
        let modalImg = "gear1.gif";
        infoDialog(modalTitle, modalText, modalImg);       
    };
};

const sendMailInsert = (parametri, aggiorna, form, insert) => {

    let parInvio = {};
    parInvio.mail = aggiorna["email"+form];
    parInvio.user = aggiorna["nome"+form];
    parInvio.host = window.location.host;
    parInvio.form = form === "Stud" ? "Studente": "Docente";
    parInvio.db = aggiorna.db;

    let criterio = JSON.stringify(parInvio);
    console.log(criterio);
    $.ajax({
        type: "POST",
        url: "/dati/aspnet/gestioneUtenti.aspx/mailVerificaUtente",
        data: criterio,
        cache: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //beforeSend: runDialog(textModal, imgModal),
        success: mail_success(parametri, parInvio, insert),
        error: errorDialog
    });

};


const sendMailAssemblea = (aggiorna, html, elencoSoci, db, callBack) => {

    let textModal = "Invio Mail Convocazione in corso..."
    let imgModal = "gear1.gif";

    let emailSoci = new String();
    let separa = "";

    elencoSoci = elencoSoci.filter((socio) => {
        if (aggiorna.idTipoAss == "D") {
            return parseInt(socio.idTipo) !== 1;
        } else {
            return parseInt(socio.idTipo) > 0;
        };
    });
   
    elencoSoci.forEach((socio) => {
        emailSoci += separa + socio.email;
        separa = "#";
    });

    let presidente = elencoSoci.filter((socio) => {
        return parseInt(socio.idTipo) === 3;
    });

    aggiorna.presidente = presidente[0].nominativo;

    let criterio = {
        data: JSON.stringify(aggiorna),
        html: html,
        elencoSoci: emailSoci,
        straord: aggiorna.idTipoAss == 'S' ? aggiorna.straord : " ",
        tipoAss: aggiorna.tipoAss,
        db: db
    };
    criterio = JSON.stringify(criterio);
    console.log(criterio);
    $.ajax({
        type: "POST",
        url: "/dati/aspnet/appGetData.aspx/SendMailConvocazione",
        data: criterio,
        cache: false,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        beforeSend: runDialog(textModal, imgModal),
        success: function () {
            closeDialog;
            return true
        },
        error: function (xhr, status, error) {
            errorDialog(xhr, status, error);
            return false
        }
    });

    if (callBack && typeof callBack === "function") {
        callBack();
    };
};



