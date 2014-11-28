(defsystem arachne
  :version "0.1"
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:plump
               :drakma
               :lquery
               :trivial-types
               :local-time)
  :components ((:module "src"
                :serial t
                :components
                ((:file "packages")
                 (:module "http"
                  :serial t
                  :components
                  ((:file "cookie")
                   (:file "request")
                   (:file "response")
                   (:file "drakma"))))))
  :description "A web-scraping framework."
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op arachne-test))))
