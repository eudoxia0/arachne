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

(defparameter +simple-document+ "
<list>
  <item>1</item>
  <item class='a'>2</item>
  <item class='a b'>3</item>
</list>")

(defparameter +booklist+ "
<booklist>
  <book>
    <title>ANSI Common Lisp</title>
    <author>Paul Graham</author>
  </book>
  <book>
    <title>Practical Common Lisp</title>
    <author>Peter Seibel</author>
  </book>
</booklist>")

(test css
  (let ((selector (make-instance 'arachne.selector:<selector>
                                 :text +simple-document+)))
    (finishes
      (print (arachne.selector:css selector "list > item"))
      (print (arachne.selector:xpath selector "//item[@class='a']")))))
