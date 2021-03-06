(in-package :laconic)

(defmacro with ((&rest with-forms) &body body)
  (labels ((one-form (head body)
             (let* ((form (car head))
                    (name (car form))
                    (params (cdr form)))
               (if form
                   (multiple-value-bind (symbol source)
                       (find-symbol (concatenate 'string "WITH-" (string name)))
                     (unless source
                       (error "Symbol not found: WITH-~A~%Form: ~S" name form))
                     `((,symbol ,@params ,@(one-form (cdr head) body))))
                   body))))
    (car (one-form with-forms body))))
