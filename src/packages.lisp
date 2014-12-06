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

(defpackage :arachne.downloader
  (:use :cl :trivial-types)
  (:export :<middleware>
           :process-request
           :process-response
           :<downloader>
           :download)
  (:documentation "The Downloader downloads takes requests, passes them through
request middlewares (Which can modify, or drop those requests), downloads them
into responses, sends the response through the chain of middlewares, and finally
returns the processed response."))

(defpackage :arachne.items
  (:use :cl :trivial-types)
  (:export :<item>
           :copy
           :<filter>
           :start
           :stop
           :filter
           :<pipeline>
           :start-pipeline
           :stop-pipeline
           :filter)
  (:documentation "Items represent a piece of data downloaded by a
 spider. Pipelines are used to process items: They are a collection of filters,
 which can either manipulate an item or drop it from the pipeline altogether."))

(defpackage :arachne.worker
  (:use :cl :trivial-types)
  (:export :<worker>))

(defpackage :arachne.spiders
  (:use :cl :trivial-types))

(defpackage :arachne.utils
  (:use :cl)
  (:export :hash))
