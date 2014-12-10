(in-package :arachne.selector)

(defclass <selector> ()
  ((node :accessor node
         :initarg :node
         :type plump:node)
   (text :reader text
         :initarg :text
         :type string)
   (response :reader response
             :initarg :response
             :type arachne.http:<request>)))

(define-condition <empty-selector> (arachne.condition:<arachne-condition>)
  ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Can't create a selector without a text or response."))))

(defmethod initialize-instance :after ((selector <selector>) &key)
  (with-slots (text response) selector
    (if text
        (setf (node selector) (plump:parse text))
        (if response
            (setf (node selector)
                  (plump:parse (arachne.http:response-body response)))
            (error '<empty-selector>)))))
