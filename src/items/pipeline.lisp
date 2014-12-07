(in-package :arachne.items)

(defclass <filter> () ())

(defgeneric start (filter)
  (:documentation "Executed when the pipeline starts, taking the filter instance
  as its sole argument."))

(defgeneric stop (filter)
  (:documentation "Executed when the pipeline stops, taking the filter instance
  as its sole argument."))

(defmethod start ((filter <filter>))
  "The default start method for filters.n Does nothing."
  t)

(defmethod stop ((filter <filter>))
  "The default stop method for filters. Does nothing."
  t)

(defgeneric filter (filter item)
  (:documentation "Takes the filter instance and an item as its arguments, and
  returns either a new or modified item or raises <drop-item> to stop processing
  of this item. In the latter case, the method returns nil."))

(defmethod filter ((filter <filter>) (item <item>))
  "The default filtering method: Simply returns the `<item>` without
processing."
  item)

(define-condition <drop-item> (arachne.conditions:<arachne-condition>)
  ((item :reader condition-item
         :initarg :item
         :type <item>
         :documentation "The item that was dropped.")
   (filter :reader condition-filter
           :initarg :filter
           :type <filter>
           :documentation "The filter that dropped the item."))
  (:documentation "This condition is raised when a filter in a pipeline rejects an item."))

(defclass <pipeline> ()
  ((filters :reader filters
            :initarg :filters
            :initform nil
            :type (proper-list <filter>)
            :documentation "A list of filter in the pipeline."))
  (:documentation "A pipeline is a sequence of filters that successively filter
 and process items."))

(defmethod start-pipeline ((pipeline <pipeline>))
  "Go through the filters in the pipeline, calling their start methods."
  (loop for filter in (filters pipeline) do
    (start filter)))

(defmethod stop-pipeline ((pipeline <pipeline>))
  "Go through the filters in the pipeline, calling their stop methods."
  (loop for filter in (filters pipeline) do
    (stop filter)))

(defmethod filter ((pipeline <pipeline>) (item <item>))
  "Send an item through a pipeline. Returns an item, or nil if the item was
rejected at some point during processing."
  (if (filters pipeline)
      (let ((new-item item))
        (loop for filter in (filters pipeline) do
          (setf new-item (filter filter (copy new-item))))
        new-item)
      item))
