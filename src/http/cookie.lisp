(in-package :arachne.http)

(defclass <cookie> ()
  ((name :reader cookie-name
         :initarg :name
         :type string)
   (value :reader cookie-value
          :initarg :value
          :type string)
   (expires :reader cookie-expires
            :initarg :expires
            :type local-time:timestamp)
   (domain :reader cookie-domain
           :initarg :domain
           :type string)
   (path :reader cookie-path
         :initarg :path
         :type string)
   (securep :reader cookie-secure-p
            :initarg :securep
            :type boolean)
   (http-only-p :reader cookie-http-only-p
                :initarg :http-only-p
                :type boolean))
  (:documentation "A cookie. This class is essentially the same as Drakma's
 cookie class."))
