(in-package :arachne.selector)

(defclass <selector> ()
  ((text :reader text
         :initarg :text
         :type string)
   (response :reader response
             :initarg :response
             :type arachne.http:<request>)
   (xml-node :accessor xml-node
             :initarg :xml-node
             :type plump:node)))

(define-condition <empty-selector> (arachne.condition:<arachne-condition>)
  ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Can't create a selector without a text or response."))))

(defmethod initialize-instance :after ((selector <selector>) &key)
  (let ((text
          (with-slots (text response) selector
            (if text
                text
                (if response
                    (arachne.http:response-body response)
                    (error '<empty-selector>))))))
    (setf (xml-node selector) (plump:parse selector))))

(defmethod css ((selector <selector>) css-selector)
  (clss:select css-selector (node selector)))
