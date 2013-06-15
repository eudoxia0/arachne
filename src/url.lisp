(in-package #:arachne)

(defun normalize (url &optional (base nil))
    "Performs URL normalization, optionally with a base URL to use with relative
    URLs".)

(defun seenp (request seen-urls)
    (member request seen-urls :test #'equal))
