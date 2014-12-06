(in-package :arachne.items)

(defclass <item> () ())

(defmethod copy ((item <item>))
  (cl-mop:deep-copy item))
