(in-package :arachne.http)

(defclass <response> ()
  ((url :reader response-url
        :initarg :url
        :type string
        :documentation "Response URL.")
   (status :reader response-status
           :initarg :status
           :type integer
           :documentation "The integer status code of the response.")
   (headers :reader response-headers
            :initarg :headers
            :type association-list
            :documentation "An association list of headers.")
   (body :reader response-body
         :initarg :body
         :type string
         :documentation "The response body.")
   (cookies :reader response-cookies
            :initarg :cookies
            :type (proper-list <cookie>)
            :documentation "The cookies returned by the request.")
   (metadata :reader response-metadata
             :initarg :metadata
             :initform (make-hash-table)
             :type hash-table
             :documentation "A hash-table containing metadata sent along with
 the request."))
  (:documentation "A response generated by a server being given a request."))
