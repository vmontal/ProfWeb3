$(document).ready(function () {

    $("#imgOK").hide();
    $("#imgKO").hide();
    $("#imgVerifica").hide();


    var GetQueryStringParams = function (sParam) {
        var sPageURL = window.location.search.substring(1);
        var sURLVariables = sPageURL.split('&');

        for (var i = 0; i < sURLVariables.length; i++) {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam) {
                return sParameterName[1];
            };
        };
    };

    var verificaMail_success = function (response) {

        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var esito = parseInt($(xml).find("esito").text());
        var testo = $(xml).find("testo").text();

        if (esito > 0) {
            $("#imgVerifica").hide();
            $("#imgOK").show();
            $("#textEsito").html(testo).show();
            //setTimeout(function () {
            //    window.location.href = "/pf.htm#/main";
            //}, 4000);
        } else {
            $("#imgVerifica").hide();
            $("#imgKO").show();
            $("#textEsito").html(testo).show();
        };
    };

    var verificaMail = function () {
        var parInvio = {};
        parInvio.mail = checkmail;
        parInvio.form = form;
        parInvio.db = db;
        var criterio = JSON.stringify(parInvio);
        $.ajax({
            type: "POST",
            url: "/dati/aspnet/gestioneUtenti.aspx/admVerificaMail",
            data: criterio,
            cache: false,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () { $("#imgVerifica").show(); },
            success: verificaMail_success,
            error: function (xhr, status, error) { $("#textEsito").html("La funzione è in Errore: " + xhr.status).show(); }
        });
    };

    var checkmail = GetQueryStringParams("mail");
    var form = GetQueryStringParams("form");
    var db = GetQueryStringParams("db");

    verificaMail();

});