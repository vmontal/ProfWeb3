'use strict';

//(function () {

    var parametri = angular.module("parametri", []);

    parametri.controller('ctrl-parametri', function ($scope, Auth) {

        //$(".navMenu").html("");
        //$(".navMenu").hide();
        //$(".navLavori").hide();
        //$(".navLavori").hide();
        Auth.fromIDCliente = 0;
        console.log("parametri: " + versione);
        $("#currentVer").val(versione);
    });

//})();