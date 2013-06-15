(asdf:defsystem #:arachne
  :serial t
  :description "This project aims to be a Scrapy-like web scraping framework for Common Lisp."
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "MIT License"
  :depends-on (#:drakma
               #:closure-html
               #:xpath)
  :components ((:file "package")
               (:file "src/http")
               (:file "src/url")
               (:file "src/arachne")))
