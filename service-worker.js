const versione = parseInt(Math.random() * 100000);

const CACHE_STATIC_NAME = 'static-v' + versione;
const CACHE_DYNAMIC_NAME = 'dynamic-v' + versione;

self.addEventListener('install', function(event) {
  console.log('[Service Worker] Installing Service Worker ...', event);
  event.waitUntil(
    caches.open(CACHE_STATIC_NAME)
      .then(function(cache) {
          const cacheApp = [
              './',
              './index.html',
              './js/pwa.js',
              './css/lezioniApp.min.css',
              './css/lezioniApp.css',
              './js/scheda/lezioniApp.min.js',
              './js/scheda/lezioniApp.js',
              './js/scheda/anagrafe.js',
              './js/scheda/controllo.js',
              './js/scheda/prenota.js',
              './js/makeFunctionApp.min.js',
              './js/connectDB.js'
          ];
        console.log('[Service Worker] Precaching App Shell');
		//console.log(cache);
        cache.addAll(cacheApp);
      })
  )
});

self.addEventListener('activate', function(event) {
  console.log('[Service Worker] Activating Service Worker ....', event);
  event.waitUntil(
    caches.keys()
      .then(function(keyList) {
        return Promise.all(keyList.map(function(key) {
          if (key !== CACHE_STATIC_NAME && key !== CACHE_DYNAMIC_NAME) {
            console.log('[Service Worker] Removing old cache.', key);
            return caches.delete(key);
          }
        }));
      })
  );
  return self.clients.claim();
});

self.addEventListener('fetch', function(event) {
    //console.log('[Service Worker] Fetch event ....', event);
    event.respondWith(
    caches.match(event.request)
      .then(function(response) {
        if (response) {
          return response;
        } else {
          return fetch(event.request)
            .then(function(res) {
              return caches.open(CACHE_DYNAMIC_NAME)
                .then(function(cache) {
                  cache.put(event.request.url, res.clone());
                  return res;
                })
            })
            .catch(function(err) {
                console.log(err)
            });
        }
      })
  );
});