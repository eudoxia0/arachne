(in-package :arachne.settings)

(defclass <settings> ()
  ((downloader :reader downloader
               :initarg :downloader
               :initform (make-instance 'arachne.downloader:<downloader>)
               :type arachne.downloader:<downloader>
               :documentation "Downloader used to process requests.")
   (pipeline :reader pipeline
             :initarg :pipeline
             :initform (make-instance 'arachne.item:<pipeline>)
             :type arachne.item:<pipeline>
             :documentation "Item pipeline used to process requests and responses.")))
