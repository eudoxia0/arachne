(in-package #:arachne)

(defclass response ()
    ((body
        :accessor   body
        :initarg    :body
        :initform   "")
     (status-code
        :accessor   status-code
        :initarg    :status-code
        :initform   200)
     (status-line
        :accessor   status-line
        :initarg    :status-line
        :initform   "OK")
     (headers
        :accessor   headers
        :initarg    :headers
        :initform   '())
     (url
        :accessor   url
        :initarg    :url
        :initform   "")
     (referrer
        :accessor   referrer
        :initarg    :referrer
        :initform   ""
        :documentation "From where was this request made?")))

(defclass request ()
    ((url
        :accessor   url
        :initarg    :url
        :initform   "")
     (method
        :accessor   method
        :initarg    :method
        :initform   :get)
     (data
        :accessor   data
        :initarg    :data
        :initform   '())
     (cookies
        :accessor   cookies
        :initarg    :cookies
        :initform   '())
     (login
        :accessor   login
        :initarg    :login
        :initform   '())
     (callback
        :accessor   callback
        :initarg    :callback
        :initform   nil)
     (filter
        :accessor   filter
        :initarg    :filter
        :initform   t)))

(defun request (url &key (method :get) data cookies login callback filter)
    (make-instance 'request :url url :method method :data data :cookies cookies
        :login login :callback callback :filter filter))

(defmethod fetch ((rq request))
    (let* ((out (multiple-value-list (drakma:http-request (url rq) :method (method rq)
                                        :parameters (data rq)
                                        :cookie-jar (cookies rq)
                                        :basic-authorization (login rq))))
           (response (make-instance 'response :body (nth 0 out)
                        :status-code (nth 1 out)
                        :headers (nth 2 out)
                        :url (nth 3 out))))
        (if (callback rq)
            (progn
                (funcall (callback rq) response)
                response)
            response)))