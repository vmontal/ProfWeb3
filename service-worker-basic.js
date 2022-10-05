// Evento install
self.addEventListener('install', event => {
    // Codice da eseguire su installazione
    console.log("Service Worker Installato");
});
// Evento activate 
self.addEventListener('activate', event => {
    // Codice da eseguire su attivazione 
    console.log("Service Worker Attivo");
});
// Evento fetch
self.addEventListener('fetch', event => {
    // Codice da eseguire su fetch di risorse
    //console.log("Richiesta URL: " + event.request.url);
});