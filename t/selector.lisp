(in-package :arachne-test)

(def-suite selector)
(in-suite selector)

(test create-selector
  (signals arachne.selector:<empty-selector>
    (make-instance 'arachne.selector:<selector>))
  (is-true
   (typep (make-instance 'arachne.selector:<selector>
                         :text "<doc></doc>")
          'arachne.selector:<selector>))
  (is-true
   (typep (make-instance 'arachne.selector:<selector>
                         :response
                         (make-instance 'arachne.http:<response>
                                        :body "<doc></doc>"))
          'arachne.selector:<selector>)))
