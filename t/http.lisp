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
                 :metadata (list (cons "Test" 'data))))

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
    'arachne.http:<response>)))

(test clean-up
  (finishes
   ;; For future tests
   (setf *response* nil)))
