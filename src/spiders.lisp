(in-package :arachne.spiders)

(defvar *spider*)

(defclass <spider> ()
  ((worker :accessor worker
           :type arachne.worker:<worker>))
  (:documentation "The base class of all spiders."))

(defmethod initialize-instance :after ((spider <spider>) &key)
  (setf (worker spider) (make-instance 'arachne.worker:<worker>)))

(defmacro with-spider (spider &rest body)
  "Execute `body` with the value of the `*spider*` special variable set to
`spider`."
  `(let ((*spider* ,spider))
     ,@body))

(defmacro with-response ((response request) &rest body)
  "Send `request`, and assign its value to `response`. If the request went
through the middlewares, execute `body`."
  `(let ((,response (arachne.worker:send (worker *spider*) ,request)))
     (when ,response
       (progn
         ,@body))))

(defun pipe (item)
  "Send `item` through the current spider's pipeline."
  (arachne.worker:filter (worker *spider*) item))
