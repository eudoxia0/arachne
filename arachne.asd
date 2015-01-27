(defsystem arachne
  :author "Fernando Borretti <eudoxiahp@gmail.com>"
  :maintainer "Fernando Borretti <eudoxiahp@gmail.com>"
  :license "MIT"
  :version "0.1"
  :homepage "https://github.com/eudoxia0/arachne"
  :bug-tracker "https://github.com/eudoxia0/arachne/issues"
  :source-control (:git "git@github.com:eudoxia0/arachne.git")
  :depends-on (:drakma
               :plump
               :clss
               :xpath
               :cxml-stp
               :trivial-types
               :local-time
               :cl-mop)
  :components ((:module "src"
                :serial t
                :components
                ((:file "packages")
                 (:file "internal-utils")
                 (:file "condition")
                 (:module "http"
                  :serial t
                  :components
                  ((:file "cookie")
                   (:file "request")
                   (:file "response")
                   (:file "drakma")))
                 (:module "downloader"
                  :serial t
                  :components
                  ((:file "middleware")
                   (:file "downloader")))
                 (:module "item"
                  :serial t
                  :components
                  ((:file "item")
                   (:file "pipeline")))
                 (:file "settings")
                 (:file "spider")
                 (:file "selector")
                 (:file "util"))))
  :description "A web-scraping framework."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op arachne-test))))
