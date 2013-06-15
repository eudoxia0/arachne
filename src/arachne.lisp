(in-package #:arachne)

(defclass spider ()
    ((name
        :accessor   name
        :initarg    :name)
     (domains
        :accessor   domains
        :initform   '()
        :initarg    :domains)
     (base
        :accessor   base
        :initform   ""
        :initarg    :base)
     (start-urls
        :accessor   start-urls
        :initform   '()
        :initarg    :start-urls)
     (rules
        :accessor rules
        :initform '()
        :initarg :rules))
    (:documentation "The base class for all spiders."))

(defmacro defrule (&rest body)
    "A rule is a lambda that takes a response and produces a request (object)."
    `(lambda (crawler response)
        ,@body))

(defmethod apply-rule ((crawler spider) response rule seen-urls)
    "Applies the rule to the response, checks resulting request urls against
    allowed domains and seen urls, and returns requests that pass"
    (remove-if #'(lambda (request) (valid crawler request seen-urls))
        (funcall rule crawler response)))

(defmethod apply-all-rules ((crawler spider) response seen-urls)
    (loop for rule in (rules crawler) do
        (apply-rule crawler response rule seen-urls)))

(defmethod crawl ((crawler spider) request seen-urls)
    "Takes a request and fetch it, applies the spider's rules to 
    the response object, and calls itself on each response. `crawl` returns a 
    node object which represents a visited page on the navigation tree."
    (let* ((response (fetch request))
        (new-seen-urls (append seen-urls (url response)))
        (new-requests (apply-all-rules crawler response new-seen-urls)))
        (if new-requests
            (crawl crawler new-requests new-seen-urls)
            (list :node response))))

(defmethod start-crawling ((crawler spider))
    "Start crawling the site. Download the `start-urls` and apply the rules to
    each. Returns a navigation graph."
    (unless (start-urls crawler)
        (error "No start urls"))
    (loop for url in (start-urls crawler) do
        (crawl crawler (request url) (make-instance 'seen-urls))))
