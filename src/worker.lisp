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
