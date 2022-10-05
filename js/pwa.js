(function () {

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/service-worker.js')
            .then(function () {
                console.log('[Service Worker] Registred')
            })
			.catch(function(err) {
			  console.log(err);
			});
    };

})();
