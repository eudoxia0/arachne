(in-package :arachne.spider)

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
     (arachne.worker:start (worker spider))
     (unwind-protect
          (progn
            ,@body)
       (arachne.worker:stop (worker spider)))))

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

(defgeneric scrape (spider)
  (:documentation "The main method of a spider, encapsulating the actual
scraping functionality. When creating custom spiders, this is the method that
should be subclassed, rather than `run`."))

(defmethod scrape ((spider <spider>))
  "The default scrape method. Do nothing."
  t)

(defmethod run ((spider <spider>))
  "Run the spider."
  (with-spider spider
    (scrape spider)))
