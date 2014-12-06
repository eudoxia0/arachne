(in-package :arachne-test)

(def-suite http)
(in-suite http)

(defparameter +simple-request+
  (make-instance 'arachne.http:<request>
                 :url (arachne-test.server:make-url "/test")))

(defparameter +not-found-request+
  (make-instance 'arachne.http:<request>
                 :url (arachne-test.server:make-url "/some-wrong-url")))

(defparameter +metadata-request+
  (make-instance 'arachne.http:<request>
                 :url (arachne-test.server:make-url "/test")
                 :metadata (arachne.utils:hash
                            (1 2)
                            ("Test" "data"))))

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
    (arachne.http:response-status *response*)
    201))
  (is
   (equal
    (arachne.http:response-body *response*)
    "Test Response")))

(test not-found-request
  (finishes
    (setf *response* (arachne.http:send +not-found-request+)))
  (is-true
   (typep
    *response*
    'arachne.http:<response>))
  (is
   (equal
    (arachne.http:response-status *response*)
    404)))

(test metadata-request
  (finishes
    (setf *response* (arachne.http:send +metadata-request+)))
  (is-true
   (typep
    *response*
    'arachne.http:<response>))
    (is
   (equal
    (arachne.http:response-status *response*)
    201))
  (is
   (equal
    (arachne.http:response-body *response*)
    "Test Response"))
  (is
   (equal
    (gethash 1 (arachne.http:response-metadata *response*))
    2))
  (is
   (equal
    (gethash "Test" (arachne.http:response-metadata *response*))
    "data")))

(test clean-up
  (finishes
   ;; For future tests
   (setf *response* nil)))
