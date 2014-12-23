(in-package :arachne-test)

(def-suite integration)
(in-suite integration)

(defclass <test-spider> (arachne.spider:<spider>)
  ())

(defmethod arachne.spider:scrape ((spider <test-spider>))
  t)

(test run
  (is-true
   (arachne.spider:run (make-instance '<test-spider>))))
