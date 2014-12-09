(in-package :arachne-test)

(def-suite downloader)
(in-suite downloader)

(defparameter +empty-downloader+
  (make-instance 'arachne.downloader:<downloader>))

(test simple-download
  (let ((simple-request
          (make-instance 'arachne.http:<request>
                         :url (arachne-test.server:make-url "/test")))
        (response))
    (finishes
      (setf response (arachne.downloader:download +empty-downloader+
                                                  simple-request)))
    (is-true
     (typep response 'arachne.http:<response>))
    (is
     (equal (arachne.http:response-status response)
            201))
    (is
     (equal (arachne.http:response-body response)
            "Test Response"))))
