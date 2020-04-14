'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "4cbfdb929cb7f312d067714d3dd7d1e5",
"/": "4cbfdb929cb7f312d067714d3dd7d1e5",
"main.dart.js": "f9260e507cef84fecc94ddacf6bb813e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f006e84e269ecbd05411f12d1b58615b",
"assets/LICENSE": "e5e2d0065143c12c4e3ad493cab06fa5",
"assets/AssetManifest.json": "8f8e1e180a396f15d9fc80b1a7dba55f",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/images/plates.png": "23833a1223c8e5f3ae93b21bf79c8f6d",
"assets/assets/images/ingredients.png": "533f3b1437f1bcfd0bcdd6fa1d0e0b10",
"assets/assets/images/floor.png": "cef7dac8cebcb8ac71989d3cdb451953",
"assets/assets/images/snake.png": "1e2bd17c2543ea9907203f1754113df9"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
