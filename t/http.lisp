(in-package :arachne-test)

(def-suite http)
(in-suite http)

(defparameter +simple-request+
  (make-instance 'arachne.http:<request>
                 :url (arachne-test.server:make-url "/test")))

(defvar *response*)

(test simple-request
  (finishes
    (setf *response* (arachne.http:send +simple-request+)))
  (is-true
   (typep
    *response*
    'arachne.http:<response>))
  (is
   (equal
    (arachne.http:response-body *response*)
    "Test Response")))
