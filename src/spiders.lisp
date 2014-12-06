(in-package :arachne.spiders)

(defclass <spider> ()
  ((worker :reader worker
           :initarg :worker
           :type arachne.worker:<worker>))
  (:documentation "The base class of all spiders."))
