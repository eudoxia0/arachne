(defsystem arachne-test
  :author "Fernando Borretti"
  :license "MIT"
  :depends-on (:arachne
               :fiveam
               :lucerne)
  :components ((:module "t"
                :serial t
                :components
                ((:file "setup")
                 (:file "server")
                 (:file "http")
                 (:file "downloader")
                 (:file "item")
                 (:file "selector")
                 (:file "final")))))
