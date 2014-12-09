(in-package :arachne-test)

(def-suite http)
(in-suite http)

(defvar response)

(test simple-request
  (let ((simple-request
          (make-instance 'arachne.http:<request>
                         :url (arachne-test.server:make-url "/test")))
        (response))
    (finishes
      (setf response (arachne.http:send simple-request)))
    (is-true
     (typep response 'arachne.http:<response>))
    (is
     (equal (arachne.http:response-status response)
            201))
    (is
     (equal (arachne.http:response-body response)
            "Test Response"))))

(test not-found-request
  (let ((not-found-request
          (make-instance 'arachne.http:<request>
                         :url (arachne-test.server:make-url "/some-wrong-url")))
        (response))
    (finishes
      (setf response (arachne.http:send not-found-request)))
    (is-true
     (typep response 'arachne.http:<response>))
    (is
     (equal (arachne.http:response-status response)
            404))))

(test metadata-request
  (let ((metadata-request
          (make-instance 'arachne.http:<request>
                         :url (arachne-test.server:make-url "/test")
                         :metadata (arachne.util:hash
                                    (1 2)
                                    ("Test" "data"))))
        (response))
    (finishes
      (setf response (arachne.http:send metadata-request)))
    (is-true
     (typep response 'arachne.http:<response>))
    (is
     (equal (arachne.http:response-status response)
            201))
    (is
     (equal (arachne.http:response-body response)
            "Test Response"))
    (is
     (equal (gethash 1 (arachne.http:response-metadata response))
            2))
    (is
     (equal (gethash "Test" (arachne.http:response-metadata response))
            "data"))))
