$(document).ready(function () {

    var sendMail = function (aggiorna) {

        aggiorna.orario = aggiorna.orario.replace(/:/g, " ");
        var criterio = {
            data: JSON.stringify(aggiorna),
            emailStud: aggiorna.emailStud,
            emailProf: aggiorna.emailProf
        };
        criterio = JSON.stringify(criterio);
        console.log(criterio);
        $.ajax({
            type: "POST",
            url: "/dati/aspnet/appGetData.aspx/SendMail",
            data: criterio,
            cache: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function () { console.log("inviato")},
            //error: errorDialog
        });

    };

    var getLezioni = function () {
        var parInvio = {};
        parInvio.sp = "pf_pianoOfferteOggi";
        parInvio.tabella = "offerteOggi";
        parInvio.idStatusOfferta = 2;

        var criterio = {
            data: JSON.stringify(parInvio)
        };
        criterio = JSON.stringify(criterio);
        $.ajax({
            type: "POST",
            url: "/dati/aspnet/appGetData.aspx/getData",
            data: criterio,
            cache: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: sendMailLezioni,
            error: function (xhr, status, error) { $("#textEsito").html("La funzione è in Errore: " + xhr.status ).show(); }
        });
    };

    var sendMailLezioni = function (response) {
        var jsondata = xml2json(response.d).NewDataSet.offerteOggi;
        if (jsondata) {
            jsondata.forEach(function (record) {
                sendMail(record);
            });
            //sendMail(jsondata[0]);

        } else {
            console.log("zero");
        };


    };

    getLezioni();

});