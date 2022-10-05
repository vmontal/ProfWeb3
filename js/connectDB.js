//----------------- Gestione Chache Local -------------------//

var dbl = {};
dbl.name = "localPF";
dbl.store = "INDEXEDDB"; //""; //"localStorage";
dbl.attachDB = " ATTACH " + dbl.store + " DATABASE " + dbl.name + "; USE " + dbl.name + ";";
dbl.table = "pf_usrProfilo";
dbl.temp = "pf_tmpProfilo";

//var db = new alasql.Database();

var url = "http://localhost:61841/loadPazienti.htm";

var pf_admUtenti_CREATE = "DROP TABLE IF EXISTS " + dbl.table + "; CREATE TABLE " + dbl.table + "; INSERT INTO " + dbl.table + " VALUES ?";
var pf_admUtenti_SELECT = "SELECT * FROM " + dbl.table + ";" //WHERE ID = ?
var pf_admUtenti_UPDATE = "UPDATE " + dbl.table + " SET versione = ? , dataVersione = ?";
var pf_admUtenti_DROP   = "DROP TABLE IF EXISTS " + dbl.table + ";";

var pf_tmpUtente_CREATE = "DROP TABLE IF EXISTS " + dbl.temp + "; CREATE TABLE " + dbl.temp + "; INSERT INTO " + dbl.temp + " VALUES ?";
var pf_tmpUtente_SELECT = "SELECT * FROM " + dbl.temp + ";";
var pf_tmpUtente_DROP   = "DROP TABLE IF EXISTS " + dbl.temp + ";";

const creaLocalUser = function (user, callBack) {
    // Create IndexdDB database
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        //console.log(user);
        //console.log('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB);
        //console.log(pf_admUtenti_CREATE);
        alasql.promise(pf_admUtenti_CREATE, [user])
            .then(function () {
                if (callBack && typeof callBack == "function"){
                    callBack();
                };
                return true
            })

            .catch(function (error) {
                console.log(error);
            })
    });
};

const getLocalUser = function(callBack){
    var localUser;
 
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        alasql.promise(pf_admUtenti_SELECT, [])
            .then(function(user) {
                localUser = user[0];
                if (callBack && typeof callBack == "function") {
                    //localUser.ID = 1;
                    callBack(localUser);
                };              
            })
        
            .catch(function(error) {
                localUser = {"ID": 0, "nome":error}
                if (callBack && typeof callBack == "function"){
                    callBack(localUser);
                }; 
            })
    });    

};

const updateLocalUser = function (versione, dataVersione, callBack) {
    // Update IndexdDB database
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        console.log(versione, dataVersione);
        //console.log('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB);
        console.log(pf_admUtenti_UPDATE);
        alasql.promise(pf_admUtenti_UPDATE, [versione, dataVersione])
            .then(function () {
                if (callBack && typeof callBack == "function") {
                    callBack();
                };
                return true
            })

            .catch(function (error) {
                console.log(error);
            })
    });
};

const dropLocalUser = function(callBack){
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        alasql.promise(pf_admUtenti_DROP, [])
            .then(function () {
                if (callBack && typeof callBack == "function") {
                    callBack();
                }; 
                return true;
            })
    
            .catch(function () {
                if (callBack && typeof callBack == "function") {
                    callBack();
                }; 
                return false;
            });
    });
};

const newTmpLocalUser = function(newUser){
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        alasql.promise(pf_tmpUtente_CREATE, [newUser])
            .then(function(){
                return true;
            })
    
            .catch(function(){
                return false;
            });        
    });
};

const getTmpLocalUser = function(callBack){
    var tmpUser;

    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        alasql.promise(pf_tmpUtente_SELECT, [])
            .then(function(user) {
                tmpUser = user[0];
                //tmpUser.ID = 1;
                if (callBack && typeof callBack == "function"){
                    callBack(tmpUser);
                };              
            })
        
            .catch(function(error) {
                tmpUser = {"ID": 0, "nome": error}
                if (callBack && typeof callBack == "function"){
                    callBack(tmpUser);
                }; 
            })        
    });    
};

const dropTmpLocalUser = function(){
    alasql('CREATE ' + dbl.store + ' DATABASE IF NOT EXISTS ' + dbl.name + ';' + dbl.attachDB, [], function () {
        alasql.promise(pf_tmpUtente_DROP, [])
            .then(function(){
                return true;
            })
    
            .catch(function(){
                return false;
            });        
    });    
};

//const creaLocalDB = function (user) {
//    //db.exec(pf_admUtenti_CREATE + ";" + pf_admUtenti_INSERT + ";" + pf_admUtenti_SELECT, [user.ID, user.ID, user.username, user.password], function (res, error) {
//    //    console.log(res, error);
//    //});
//        //var db = alasql.promise("CREATE " + dbl.store + " DATABASE IF NOT EXISTS " + dbl.name + ";" + dbl.attachDB)


//    var createTable = db.exec(pf_admUtenti_CREATE, [], function (res) {
//        console.log(res);
//    });

//    try {
//        console.log(user);
//        var insertValue = db.exec(pf_admUtenti_INSERT, [user], function (res) {
//            console.log(res);
//        });
//    }

//    catch (err) {
//        console.log(err)
//    };

//    var selectValue = db.exec(pf_admUtenti_SELECT, [], function (res) {
//        console.log(res);
//    });

//};