(require 'parenscript)

(defun ps2js (f)
  (in-package :ps)
  (do
   ((form (read f nil) (read f nil)))
   ((not form))
    (format *error-output*  "// ~A~%" form)
    (format t "~A~%" (ps:ps* form))))

(defun main (argv)
  (if (cdr argv)
      (dolist (file (cdr argv))
        (with-open-file (f file)
          (handler-bind
              ((error
                (lambda (e) 
                  (format *error-output* "~A~%" e)
                  (sb-ext:exit :code 1))))
            (ps2js f))))
      (ps2js *standard-input*)))
