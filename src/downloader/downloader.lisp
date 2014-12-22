(in-package :arachne.downloader)

(defclass <downloader> ()
  ((middlewares :reader middlewares
                :initarg :middlewares
                :initform nil
                :type (proper-list <middleware>)
                :documentation "List of middlewares in the downloader."))
  (:documentation "A downloader object. Contains a list of middlewares to apply
  to requests and responses."))

(define-condition <middleware-condition> (arachne.condition:<arachne-condition>)
  ((middleware :reader condition-middlewre
               :initarg :middleware
               :type <middleware>)))

(define-condition <drop-request> (<middleware-condition>)
  ((request :reader condition-request
            :initarg :request
            :type arachne.http:<request>
            :documentation "The request that was dropped.")))

(define-condition <drop-response> (<middleware-condition>)
  ((response :reader condition-response
            :initarg :response
            :type arachne.http:<response>
            :documentation "The response that was dropped.")))

(defmethod apply-request-middlewares ((downloader <downloader>)
                                      (request arachne.http:<request>))
  "Take a downloader and a request, and apply all the middlewares in the
downloader to the request. Returns the final request, or `nil`, indicating that
the request should be ignored."
  (arachne.internal-utils:object-pipeline request
                                          processed-request
                                          (middlewares downloader)
                                          middleware
                                          (process-request middleware processed-request)
                                          <drop-request>))

(defmethod apply-response-middlewares ((downloader <downloader>)
                                       (response arachne.http:<response>))
  "Take a downloader and a response, and apply all the middlewares in the
downloader to the response. Returns the final response, or `nil`, indicating
that the response should be ignored."
  (arachne.internal-utils:object-pipeline response
                                          processed-response
                                          (middlewares downloader)
                                          middleware
                                          (process-response middleware processed-response)
                                          <drop-response>))

(defmethod download ((downloader <downloader>)
                     (request arachne.http:<request>))
  "Apply all middlewares in the downloader to the request, download the final
request (Unless it has been ignored), then apply the middlewares to the
response, and return the final response if it has not been ignored. Returns a
`<response>` instance if the request and response passed through the
middlewares, or `nil` if either the request or the response was ignored."
  (let ((final-request (apply-request-middlewares downloader request)))
    (when final-request
      (let ((response (arachne.http:send final-request)))
        (apply-response-middlewares downloader response)))))
