(in-package :arachne.spider)

(defclass <spider> ()
  ((settings :reader settings
             :initarg :settings
             :initform (make-instance 'arachne.settings:<settings>)
             :type arachne.settings:<settings>
             :documentation "The spider's settings."))
  (:documentation "The base class of all spiders."))

(defvar *spider* nil
  "The current spider.")

(defmacro with-spider (spider &rest body)
  "Execute `body` with the value of the `*spider*` special variable set to
`spider`."
  `(let ((*spider* ,spider))
     (arachne.item:start-pipeline (arachne.settings:pipeline (settings spider)))
     (unwind-protect
          (progn ,@body)
       (arachne.item:stop-pipeline (arachne.settings:pipeline (settings spider))))))

(defmacro with-response ((response request) &rest body)
  "Send `request`, and assign its value to `response`. If the request went
through the middlewares, execute `body`."
  `(let ((,response (arachne.downloader:download
                     (arachne.settings:downloader (settings *spider*) ,request))))
     (when ,response
       (progn
         ,@body))))

(defun pipe (item)
  "Send `item` through the current spider's pipeline."
  (arachne.item:filter (arachne.settings:pipeline (settings *spider*)) item))

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
    (scrape spider))
  t)
