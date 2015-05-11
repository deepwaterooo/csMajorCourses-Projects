(defun load-array-from-file (filename)
  (with-open-file (in filename
                      :direction :input)
    (let* ((data-lol (loop :for line := (read-line in nil)
                           :while line
                           :collect (mapcar #'parse-number:parse-number
                                            (cl-ppcre:split "\\s+" line))))
           (rows (length data-lol))
           (columns (length (first data-lol))))
      (make-array (list rows columns)
                  :initial-contents data-lol))))

