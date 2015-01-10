(in-package :arachne.selector)

(defclass <selector> ()
  ((text :reader text
         :initarg :text
         :type string
         :documentation "XML string used to initialize the selector.")
   (response :reader response
             :initarg :response
             :type arachne.http:<response>
             :documentation "Response whose body is used to initialize the selector.")
   (plump-document :accessor plump-document
                   :type plump:node
                   :documentation "The Plump document parsed from the XML during initialization. Used for extracting data with CSS selectors.")
   (cxml-document :accessor cxml-document
                  :type cxml-stp:document
                  :documentation "The CXML document, parsed from the serialized Plump document, during initialization. Used for extracting data through XPath selectors.")))

(define-condition <empty-selector> (arachne.condition:<arachne-condition>)
  ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Can't create a selector without a text or response.")))
  (:documentation "A condition that is raised when a selector is instantiated
 without text or a response."))

(defmethod initialize-instance :after ((selector <selector>) &key)
  (let ((text
          (if (slot-boundp selector 'text)
              (text selector)
              (if (slot-boundp selector 'response)
                  (arachne.http:response-body (response selector))
                  (error '<empty-selector>)))))
    (setf (plump-document selector) (plump:parse text))
    ;; Because CXML is far less lenient than Plump, we serialize the Plump
    ;; document and parse that with CXML
    (setf (cxml-document selector)
          (cxml:parse
           (with-output-to-string (str)
             (plump:serialize (plump-document selector) str))
           (stp:make-builder)))))

(defmacro with-selector ((sel response) &rest body)
  "Create a selector `sel` from a response `response`, and execute `body` in
that binding."
  `(let ((,sel (make-instance '<selector> :response ,response)))
     ,@body))

(defmethod css ((selector <selector>) css-selector)
  "Extract data through a CSS selector."
  (reduce #'(lambda (l r) (concatenate 'string l r))
          (loop for node across (clss:select css-selector (plump-document selector))
                collecting (plump:text node))))

(defmethod xpath ((selector <selector>) xpath-selector)
  "Extract data through an XPath selector."
  (reduce #'(lambda (l r) (concatenate 'string l r))
          (loop for node in (xpath:all-nodes
                             (xpath:evaluate xpath-selector
                                             (cxml-document selector)))
                collecting (xpath:string-value node))))
