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
  (arachne.items:start-pipeline (pipeline worker)))

(defmethod stop ((worker <worker>))
  (arachne.items:stop-pipeline (pipeline worker)))

(defmethod filter ((worker <worker>) (item arachne.items:<item>))
  (arachne.items:filter (pipeline worker) item))
