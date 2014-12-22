(in-package :arachne.internal-utils)

(defmacro object-pipeline (object new-object pipelines filter filter-expression drop-exception)
  `(if ,pipelines
       (let ((,new-object ,object))
         (loop for ,filter in ,pipelines do
           (handler-case
               (setf ,new-object ,filter-expression)
             (,drop-exception (condition)
               (declare (ignore condition))
               nil)))
         ,new-object)
       ,object))
