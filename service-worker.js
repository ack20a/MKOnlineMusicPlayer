const CACHE_NAME = 'music-player-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/css/player.css',
  '/css/small.css',
  '/js/player.js',
  '/js/ajax.js',
  '/js/lyric.js',
  '/js/musicList.js',
  '/js/functions.js',
  '/js/jquery.min.js',
  '/js/jquery.mCustomScrollbar.concat.min.js',
  '/js/background-blur.min.js',
  '/plugns/layui/css/layui.css',
  '/plugns/layui/layui.js',
  '/images/player.png',
  '/images/player_cover.png'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});