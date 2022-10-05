/* Italian initialisation for the jQuery UI date picker plugin. */
/* Written by Keith Wood (kbwood{at}iinet.com.au),
			  Stéphane Nahmani (sholby@sholby.net),
			  Stéphane Raimbault <stephane.raimbault@gmail.com> */
( function( factory ) {
	if ( typeof define === "function" && define.amd ) {

		// AMD. Register as an anonymous module.
		define( [ "../widgets/datepicker" ], factory );
	} else {

		// Browser globals
		factory( jQuery.datepicker );
	}
}( function( datepicker ) {

datepicker.regional.it = {
	closeText: "Chiudi",
	prevText: "Precedente",
	nextText: "Successivo",
	currentText: "Oggi",
	monthNames: [ "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
		"Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre" ],
	monthNamesShort: [ "Gen", "Feb", "Mar", "Apr", "Mag", "Giu",
		"Lug", "Ago", "Set", "Ott", "Nov", "Dic" ],
	dayNames: [ "Domenica", "Lunedì", "Mertedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato" ],
	dayNamesShort: [ "dom", "lun", "mar", "mer", "gio", "ven", "sab" ],
	dayNamesMin: [ "D","L","M","M","G","V","S" ],
	weekHeader: "Set.",
	dateFormat: "dd/mm/yy",
	firstDay: 1,
	isRTL: false,
	showMonthAfterYear: false,
	yearSuffix: "" };
datepicker.setDefaults( datepicker.regional.it );

return datepicker.regional.it;

} ) );
