;(setf L ())
;(read-em f)
(defun read-em (f)
   (let ((s (read-line f nil nil)))
      (cond ((not (null s))
		(setf L (cons s L))
		(read-em f))
      )
   )
)
