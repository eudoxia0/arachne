(in-package :arachne-test)

(def-suite items)
(in-suite items)

(defclass <test-item> (arachne.item:<item>)
  ((str :accessor str
        :initarg :str
        :type string)))

(defclass <identity-filter> (arachne.item:<filter>) ())

(defclass <uppercase-filter> (arachne.item:<filter>) ())

(defclass <lowercase-filter> (arachne.item:<filter>) ())

(defmethod arachne.item:filter ((filter <identity-filter>) (item <test-item>))
  item)

(defmethod arachne.item:filter ((filter <uppercase-filter>) (item <test-item>))
  (setf (str item) (string-upcase (str item)))
  item)

(defmethod arachne.item:filter ((filter <lowercase-filter>) (item <test-item>))
  (setf (str item) (string-downcase (str item)))
  item)

(defparameter +test-item+
  (make-instance '<test-item>
                 :str "test"))

(test identity-filter
  (is
   (equal "test"
          (str (arachne.item:filter
                (make-instance '<identity-filter>)
                (arachne.item:copy +test-item+))))))

(test uppercase-filter
  (is
   (equal "TEST"
          (str (arachne.item:filter
                (make-instance '<uppercase-filter>)
                (arachne.item:copy +test-item+))))))

(test uppercase-lowercase-filter
  (is
   (equal "test"
          (str (arachne.item:filter
                (make-instance '<lowercase-filter>)
                (arachne.item:filter
                 (make-instance '<uppercase-filter>)
                 (arachne.item:copy +test-item+)))))))

(defparameter +empty-pipeline+
  (make-instance 'arachne.item:<pipeline>))

(defparameter +uppercase-pipeline+
  (make-instance 'arachne.item:<pipeline>
                 :filters (list (make-instance '<uppercase-filter>))))

(defparameter +uppercase-lowercase-pipeline+
  (make-instance 'arachne.item:<pipeline>
                 :filters (list (make-instance '<uppercase-filter>)
                                (make-instance '<lowercase-filter>))))

(test empty-pipeline
  (is
   (equal "test"
          (str (arachne.item:filter
                +empty-pipeline+
                (arachne.item:copy +test-item+))))))

(test uppercase-pipeline
  (is
   (equal "TEST"
          (str (arachne.item:filter
                +uppercase-pipeline+
                (arachne.item:copy +test-item+))))))

(test complete-pipeline
  (is
   (equal "test"
          (str (arachne.item:filter
                +uppercase-lowercase-pipeline+
                (arachne.item:copy +test-item+))))))
