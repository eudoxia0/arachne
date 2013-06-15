(in-package #:arachne)

(defclass seen-urls ()
    ((urls
        :accessor   urls
        :initarg    :urls
        :initform   (make-hash-table))))

(defmethod seenp ((seen seen-urls) request)
    (gethash (url request) (urls seen)))

(defun normalize (url &optional (base nil))
    "Performs URL normalization, optionally with a base URL to use with relative
    URLs"
    url)

(defmethod valid (request seen-urls base-url)
    "Checks if a URL is valid:
        1. Normalizes it
        2. Tests it against the seen-urls:
            * If it's seen, returns nil
            * If it's not, returns t, and adds the url to `seen-urls`"
    (seenp seen-urls (normalize (url request) base-url)))