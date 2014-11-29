(in-package :cl-user)
(defpackage arachne-test.server
  (:use :cl :lucerne)
  (:export :make-url
           :start-server
           :stop-server))
(in-package :arachne-test.server)
(annot:enable-annot-syntax)

(defparameter +port+ 4242)

(defun make-url (&rest args)
  (concatenate 'string
               (format nil "http://localhost:~A" +port+)
               (apply #'format (cons nil args))))

(defapp app)

@route app "/test"
(defview test ()
  (respond "Test Response" :status 201))

(defun start-server ()
  (start app :port +port+))

(defun stop-server ()
  (stop app))
