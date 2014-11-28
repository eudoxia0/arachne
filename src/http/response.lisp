(in-package :arachne.http)

(defclass <response> ()
  ((url :reader response-url
        :initarg :url
        :type string)
   (status :reader response-status
           :initarg :status
           :type integer)
   (headers :reader response-headers
            :initarg :headers
            :type association-list)
   (body :reader response-body
         :initarg :body
         :type string)
   (cookies :reader response-cookies
            :initarg :cookies
            :type (list-of <cookie>)
            :documentation "The cookies returned by the request.")
   (metadata :reader response-metadata
             :initarg :metadata
             :type association-list)))
