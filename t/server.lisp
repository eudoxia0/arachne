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
  (apply #'format (append (list nil "http://localhost:~A" +port+)
                          args)))

(defapp app)

@route app "/test"
(defview test ()
  (respond "Test Response"))

(defun start-server ()
  (start app :port +port+))

(defun stop-server ()
  (stop app))
