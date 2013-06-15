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
    (loop for url in (start-urls crawler) do
        (crawl crawler (request url) )))
