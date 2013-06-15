(in-package #:arachne)

(defmacro defrule (&rest body)
    "A rule is a lambda that takes a response and produces a request (object)."
    `(lambda (crawler response)
        ,@body))

(defmethod apply-rule ((crawler spider) response rule seen-urls)
    "Applies the rule to the response, checks resulting request urls against
    allowed domains and seen urls, and returns requests that pass"
    (remove-if #'(lambda (request) (seenp request seen-urls))
        (funcall rule crawler response)))

(defmethod apply-all-rules ((crawler spider) response seen-urls)
    (loop for rule in (rules crawler) do
        (apply-rule crawler response rule seen-urls)))
