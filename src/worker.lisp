(in-package :arachne.worker)

(defclass <worker> ()
  ((downloader :reader downloader
               :initarg :downloader
               :type arachne.downloader:<downloader>
               :documentation "The downloader used by the worker to process requests.")
   (pipeline :reader pipeline
             :initarg :pipeline
             :type arachne.items:<pipeline>
             :documentation "The worker's item pipeline.")))

(defmethod start ((worker <worker>))
  "Start the worker."
  (arachne.items:start-pipeline (pipeline worker)))

(defmethod stop ((worker <worker>))
  "Stop the worker."
  (arachne.items:stop-pipeline (pipeline worker)))

(defmethod filter ((worker <worker>) (item arachne.items:<item>))
  "Filter an item through the worker's pipeline. Returns nil if it was rejected,
t otherwise."
  (when (arachne.items:filter (pipeline worker) item)
    t))

(defmethod send ((worker <worker>) (request arachne.http:<request>))
  "Send a request through the worker's downloader."
  (arachne.downloader:download (downloader worker) request))
