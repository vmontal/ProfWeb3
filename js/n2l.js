var sgart = sgart || {};
 
/* http://www.sgart.it
 * converte i numeri da cifre a lettere
 */
sgart.convNumLett2 = (n, abbr, separator) => {
    //console.log(n, typeof n)
  if (isNaN(n) == true) {
    return "!!! Inserisci un numero valido !!!";
  }
  if (n.indexOf('.') >= 0 || n.indexOf(',') >= 0) {
    return "!!! Solo numeri interi !!!";
  }
 
  if (n == '0') {
    return "ZERO";
  }
  const lettere = {
    numeri: [null, "Uno", "Due", "Tre", "Quattro", "Cinque", "Sei", "Sette", "Otto", "Nove", "Dieci", "Undici", "Dodici", "Tredici", "Quattordici", "Quindici", "Sedici", "Diciassette", "Diciotto", "Diciannove"],
    decine: [null, null, "Venti", "Trenta", "Quaranta", "Cinquanta", "Sessanta", "Settanta", "Ottanta", "Novanta"],
    decine1: [null, null, "Vent", "Trent", "Quarant", "Cinquant", "Sessant", "Settant", "Ottant", "Novant"],
    cento: "Cento",
    multipli: [null, "Mila", "Milioni", "Miliardi", "Bilioni", "Biliardi", "Trilioni", "Triliardi", "Quadrilioni", "Quadriliardi"],
    multipli1: [null, "Mille", "Milione", "Miliardo", "Bilione", "Biliardo", "Trilione", "Triliardo", "Quadrilione", "Quadriliardo"],
    un: "Un"
  };
 
  let numero = n.replace(/^\s+|\s+$/g, "");
  if (numero.length > lettere.multipli.length * 3) {
    return "!!! Numero troppo grande !!!";
  }
  let abbrNum = "";
  if (abbr === true) {
    if (numero.length > 2) {
      abbrNum = numero.substr(numero.length - 2, 2);
      numero = numero.substr(0, numero.length - 2) + "00";
    }
  }
 
  //per semplificare il calcolo arrotondo la lunghezza a un mutiplo di 3
  const padding3 = numero.length % 3;
  if (padding3 === 1)
    numero = "00" + numero;
  else if (padding3 === 2)
    numero = "0" + numero;
  const len = numero.length;
 
  // trovo quanti gruppi di 3 cifre ci sono
  let mult3 = numero.length / 3 - 1;
 
  const sep = separator === true ? " " : "";
  let result = "";
  let i = 0;
  while (i < len) {
    //console.log("group", numero.substr(i, 3));
    let v = parseInt(numero.substr(i, 3));
    let r = "";
    //cifra delle centinaia
    const n100 = parseInt(numero.charAt(i))
    if (n100 > 0) {
      if (n100 === 1) {
        r += sep + lettere.cento;
      } else {
        r += sep + lettere.numeri[n100] + sep + lettere.cento;
      }
    }
    //decine e unità
    const n10 = parseInt(numero.substr(i + 1, 2));
    if (n10 > 0) {
      if (n10 < 20) {
        // numeri da 1 a 19
        r += sep + lettere.numeri[n10];
      } else {
        //nueri da 20 a 99
        const n20 = parseInt(numero.charAt(i + 1));
        const n2 = parseInt(numero.charAt(i + 2));
        r += sep + (n2 === 1 ? lettere.decine1[n20] : lettere.decine[n20]);
        if (n2 > 0) {
          r += sep + lettere.numeri[n2];
        }
      }
    }
    if (v > 0 && mult3 > 0) {
      if (v === 1)
        result += (mult3 === 1 ? "" : lettere.un + sep) + lettere.multipli1[mult3];
      else
        result += r + sep + lettere.multipli[mult3];
    } else {
      result += r;
    }
    i += 3;
    mult3--;
  }
  return result + (abbrNum.length > 0 ? " / " + abbrNum : "");
}