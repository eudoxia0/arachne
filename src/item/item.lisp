(in-package :arachne.item)

(defclass <item> ()
  ()
  (:documentation "The superclass of all items scraped by spiders."))

(defmethod copy ((item <item>))
  "Copy an item."
  (cl-mop:deep-copy item))
