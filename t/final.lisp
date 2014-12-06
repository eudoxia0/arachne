(in-package :arachne-test)

(progn
  (arachne-test.server:start-server)
  (unwind-protect
       (progn
         (run! 'http)
         (run! 'downloader)
         (run! 'items))
    (arachne-test.server:stop-server)))
