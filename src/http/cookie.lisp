(in-package :arachne.http)

(defclass <cookie> ()
  ((name :reader cookie-name
         :initarg :name
         :type string
         :documentation "The cookie's name.")
   (value :reader cookie-value
          :initarg :value
          :type string
          :documentation "The cookie's value.")
   (expires :reader cookie-expires
            :initarg :expires
            :type local-time:timestamp
            :documentation "The timestamp when the cookie will expire.")
   (domain :reader cookie-domain
           :initarg :domain
           :type string
           :documentation "The cookie's domain.")
   (path :reader cookie-path
         :initarg :path
         :type string
         :documentation "The cookie's path.")
   (securep :reader cookie-secure-p
            :initarg :securep
            :type boolean
            :documentation "Whether the cookie will only be used over HTTPS.")
   (http-only-p :reader cookie-http-only-p
                :initarg :http-only-p
                :type boolean
                :documentation "Whether the cookie will only be used over HTTP and HTTPS and not, e.g., JavaScript."))
  (:documentation "A cookie. This class is essentially the same as Drakma's
 cookie class."))
