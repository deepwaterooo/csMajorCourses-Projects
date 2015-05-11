#!/usr/bin/clisp
;;; require two arguments
(if (not (= 2 (length *args*))) (progn (print "usage: example [xo] filename") (exit)))
;;; check that first arg is an "x" or an "o"
(let ((arg1 (car *args*)))
  (if (not (or (equal arg1 "x") (equal arg1 "o"))) (progn (print "usage: example [xo] filename") (exit)))
  )

;;; open a file with command line argument 2
(let ((filename (nth 1 *args*)))
  )

