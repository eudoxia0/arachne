(in-package :arachne-test)

(progn
  (arachne-test.server:start-server)
  (unwind-protect
       (progn
         (run! 'http))
    (arachne-test.server:stop-server)))
