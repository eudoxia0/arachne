(defpackage #:arachne
  (:use #:cl)
  (:export #:spider)
  (:shadowing-import-from #:drakma
                          #:http-request))
