(in-package :cl-user)

(defpackage arachne.http
  (:use :cl :trivial-types)
  (:export :<request>
           :request-url
           :request-method
           :request-parameters
           :request-body
           :request-cookies
           :request-content-type
           :request-metadata
           :<form-request>
           :send
           :<response>
           :response-url
           :response-status
           :response-headers
           :response-body
           :response-cookies
           :response-metadata
           :<cookie>
           :cookie-name
           :cookie-value
           :cookie-expires
           :cookie-domain
           :cookie-path
           :cookie-secure-p
           :cookie-http-only-p)
  (:documentation "Implements requests and responses and the machinery to send
 and receive them through Drakma."))
