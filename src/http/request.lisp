(in-package :arachne.http)

(defclass <request> ()
  ((url :reader request-url
        :initarg :url
        :type string
        :documentation "Request URL.")
   (method :reader request-method
           :initarg :method
           :initform :get
           :type keyword
           :documentation "Request method, e.g :get, :post.")
   (parameters :reader request-parameters
               :initarg :parameters
               :initform nil
               :type association-list
               :documentation "The request parameters, as an association list.")
   (body :reader request-body
         :initarg :body
         :initform ""
         :type string
         :documentation "The body of the request.")
   (cookies :reader request-cookies
            :initarg :cookies
            :initform nil
            :type (proper-list <cookie>)
            :documentation "A list of cookies to send over with the request.")
   (content-type :reader request-content-type
                 :initarg :content-type
                 :initform "application/octet-stream"
                 :type string
                 :documentation "The request's content-type.")
   (metadata :reader request-metadata
             :initarg :metadata
             :initform (make-hash-table)
             :type hash-table
             :documentation "A hash-table containing request metadata, that will
be copied to the corresponding response."))
  (:documentation "A general HTTP request."))

(defclass <form-request> (<request>) ()
  (:documentation "A form request."))
