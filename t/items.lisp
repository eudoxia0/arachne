(in-package :arachne-test)

(def-suite items)
(in-suite items)

(defclass <test-item> (arachne.items:<item>)
  ((str :accessor str
        :initarg :str
        :type string)))

(defclass <identity-filter> (arachne.items:<filter>) ())

(defclass <uppercase-filter> (arachne.items:<filter>) ())

(defclass <lowercase-filter> (arachne.items:<filter>) ())

(defmethod arachne.items:filter ((filter <identity-filter>) (item <test-item>))
  item)

(defmethod arachne.items:filter ((filter <uppercase-filter>) (item <test-item>))
  (setf (str item) (string-upcase (str item)))
  item)

(defmethod arachne.items:filter ((filter <lowercase-filter>) (item <test-item>))
  (setf (str item) (string-downcase (str item)))
  item)

(defparameter +test-item+
  (make-instance '<test-item>
                 :str "test"))

(test identity-filter
  (is
   (equal "test"
          (str (arachne.items:filter
                (make-instance '<identity-filter>)
                (arachne.items:copy +test-item+))))))

(test uppercase-filter
  (is
   (equal "TEST"
          (str (arachne.items:filter
                (make-instance '<uppercase-filter>)
                (arachne.items:copy +test-item+))))))

(test uppercase-lowercase-filter
  (is
   (equal "test"
          (str (arachne.items:filter
                (make-instance '<lowercase-filter>)
                (arachne.items:filter
                 (make-instance '<uppercase-filter>)
                 (arachne.items:copy +test-item+)))))))

(defparameter +empty-pipeline+
  (make-instance 'arachne.items:<pipeline>))

(defparameter +uppercase-pipeline+
  (make-instance 'arachne.items:<pipeline>
                 :filters (list (make-instance '<uppercase-filter>))))

(defparameter +uppercase-lowercase-pipeline+
  (make-instance 'arachne.items:<pipeline>
                 :filters (list (make-instance '<uppercase-filter>)
                                (make-instance '<lowercase-filter>))))

(test empty-pipeline
  (is
   (equal "test"
          (str (arachne.items:filter
                +empty-pipeline+
                (arachne.items:copy +test-item+))))))

(test uppercase-pipeline
  (is
   (equal "TEST"
          (str (arachne.items:filter
                +uppercase-pipeline+
                (arachne.items:copy +test-item+))))))

(test complete-pipeline
  (is
   (equal "test"
          (str (arachne.items:filter
                +uppercase-lowercase-pipeline+
                (arachne.items:copy +test-item+))))))
