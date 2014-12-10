(in-package :arachne.downloader)

(defclass <middleware> ()
  ()
  (:documentation "The base class of all downloader middlewares.")

(defgeneric process-request (middleware request)
  (:documentation "The `process-request` method takes as its second argument a
`<request>` instance and returns another of the same. The first argument is the
`<middleware>` instance."))

(defgeneric process-response (middleware response)
  (:documentation "The `process-response` method takes as its second argument a
`<response>` instance and returns another of the same. The first argument is the
`<middleware>` instance."))

(defmethod process-request ((middleware <middleware>) (request arachne.http:<request>))
  "The default `process-request` method, simply pass the request forward."
  request)

(defmethod process-response ((middleware <middleware>) (response arachne.http:<response>))
  "The default `process-response` method, pass the response unchanged."
  response)
