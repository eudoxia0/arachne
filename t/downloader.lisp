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

(defclass <test-middleware> (arachne.downloader:<middleware>) ())

(defmethod arachne.downloader:process-request ((middleware <test-middleware>)
                                               (request arachne.http:<request>))
  (setf (gethash :request (arachne.http:request-metadata request)) t))

(defmethod arachne.downloader:process-response ((middleware <test-middleware>)
                                                (response arachne.http:<response>))
  (setf (gethash :response (arachne.http:response-metadata response)) t))

(test simple-download
  (let ((downloader
          (make-instance 'arachne.downloader:<downloader>
                         :middlewares (list (make-instance '<test-middleware>))))
        (simple-request
          (make-instance 'arachne.http:<request>
                         :url (arachne-test.server:make-url "/test")))
        (response))
    (finishes
      (setf response (arachne.downloader:download downloader simple-request)))
    (is-true
     (typep response 'arachne.http:<response>))
    (is-true
     (gethash :request (arachne.http:response-metadata response)))
    (is-true
     (gethash :response (arachne.http:response-metadata response)))))
