(in-package :arachne.items)

(defclass <filter> () ())

(defgeneric start (filter)
  (:documentation "Executed when the pipeline starts, taking the filter instance
  as its sole argument."))

(defgeneric stop (filter)
  (:documentation "Executed when the pipeline stops, taking the filter instance
  as its sole argument."))

(defmethod start ((filter <filter>))
  "The default start method for filters. Does nothing."
  t)

(defmethod stop ((filter <filter>))
  "The default stop method for filters. Does nothing."
  t)

(defgeneric filter (filter item)
  (:documentation "Takes the filter instance and an item as its arguments, and
  returns either a new or modified item or nil to drop the item from
  processing."))

(defmethod filter ((filter <filter>) (item <item>))
  "The default filtering method: Simply returns the `<item`> without
processing."
  item)

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
  item)
