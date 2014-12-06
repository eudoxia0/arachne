(in-package :arachne.utils)

(defmacro hash (&rest pairs)
  "Shortcut for building hash tables.

   (hash (1 2) (\"test\" #\a)) => {1 => 2, \"test\" => #\a}"
  `(let ((table (make-hash-table :test #'equal)))
     ,@(loop for pair in pairs collecting
         `(setf (gethash ,(first pair) table) ,(second pair)))
     table))
