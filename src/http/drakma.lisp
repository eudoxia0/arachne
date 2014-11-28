(in-package :arachne.http)

(defmethod cookie->drakma-cookie ((cookie <cookie>))
  (with-slots (name value expires domain path securep http-only-p)
      cookie
    (make-instance 'drakma:cookie
                   :name name
                   :value value
                   :expires (local-time:timestamp-to-universal
                             expires)
                   :domain domain
                   :path path
                   :securep securep
                   :http-only-p http-only-p)))

(defun cookies->drakma-cookie-jar (cookies)
  (make-instance
   'drakma:cookie-jar
   :cookies (loop for cookie in cookies collecting
              (cookie->drakma-cookie cookie))))

(defmethod drakma-cookie->cookie ((cookie drakma:cookie))
  (make-instance '<cookie>
                 :name (drakma:cookie-name cookie)
                 :value (drakma:cookie-value cookie)
                 :expires (local-time:universal-to-timestamp
                           (drakma:cookie-expires cookie))
                 :domain (drakma:cookie-domain cookie)
                 :path (drakma:cookie-path cookie)
                 :securep (drakma:cookie-securep cookie)
                 :http-only-p (drakma:cookie-http-only-p cookie)))

(defmethod drakma-cookie-jar->cookies ((cookie-jar drakma:cookie-jar))
  (loop for drakma-cookie in (drakma:cookie-jar-cookies cookie-jar) collecting
    (drakma-cookie->cookie drakma-cookie)))

(defmethod send-request ((request <request>) form-data-p)
  (let ((cookie-jar (cookies->drakma-cookie-jar (request-cookies request))))
    (response-from-drakma-values
     (multiple-value-list
      (with-slots (url method parameters body content-type)
          request
        (drakma:http-request url
                             :method method
                             :parameters parameters
                             :content body
                             :cookie-jar cookie-jar
                             :content-type content-type)))
     request
     cookie-jar)))

(defgeneric send (request)
  (:documentation "Send a request over the Internet, returning the corresponding
 response."))

(defmethod send ((request <request>))
  (send-request request nil))

(defmethod send ((request <form-request>))
  (send-request request t))

(defun response-from-drakma-values (value-list request cookie-jar)
  (destructuring-bind
      (body status headers uri stream must-close reason-phrase)
      value-list
    (declare (ignore stream must-close reason-phrase))
    (let ((parsed-body (if (stringp body)
                           body
                           ""))
          (parsed-url (with-output-to-string (str) (puri:render-uri uri str))))
      (make-instance '<response>
                     :url parsed-url
                     :status status
                     :headers headers
                     :body parsed-body
                     :cookies (drakma-cookie-jar->cookies cookie-jar)
                     :metadata (request-metadata request)))))
