(in-package :arachne.http)

(defclass <request> ()
  ((url :reader request-url
        :initarg :url
        :type string)
   (method :reader request-method
           :initarg :method
           :initform :get
           :type keyword
           :documentation "Request method, e.g :get, :post.")
   (parameters :reader request-parameters
               :initarg :parameters
               :initform nil
               :type association-list)
   (body :reader request-body
         :initarg :body
         :initform ""
         :type string)
   (cookies :reader request-cookies
            :initarg :cookies
            :initform nil
            :type (list-of <cookie>))
   (content-type :reader request-content-type
                 :initarg :content-type
                 :initform "application/octet-stream"
                 :type string)
   (metadata :reader request-metadata
             :initarg :metadata
             :initform nil
             :type association-list)))

(defclass <form-request> (<request>) ())
