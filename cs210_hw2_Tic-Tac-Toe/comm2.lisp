;; Demo getopts using sbcl and its  *posix-argv*
;; Couple of other functions in here that I didn't use.
;; Rev 1.1, after feedback from #lisp irc
;; 2008-01-04T17:27:45Z



(defun substr (s st end)
"Select the substring of s, starting at position st
and ending at position end.
Both are one based."
  (let ((en (min end (length s))))
    (if (and (>= st 1)
	     (<= st (length s) )
	     (>= en 1)
	     (>= en st)
	     (<= en (length s) ))
	(subseq s (- st 1) en)
	nil)
    )
  )


(defun strHyphen (str)
"Strip any prefix hyphens off str, if it starts with one "
  (if (equal (substr str 1 1) "-")
      (substr str 2 (length str))
      nil
      )
  )


(defun startswith (s v)
  "return t if string s starts with string v"
  (if (and 
       (stringp s)
       (stringp v))
      (if (equal (substr s 1 (length v)) v)
	  t
	  nil
	  )
      nil)
  )



(defun selftest()
"Selftest function. Terminal (which seems wrong"
  (format t "Running Selftest~%")
  (sb-ext:quit)
)

;;
;;  global parameters 
;;
(defvar *progname* "dovetails")
(defvar w nil "cutter width")
(defvar s nil "stock width")
(defvar d nil "stock thickness")
(defvar gapcount nil "Required number of gaps")
(defvar theta nil "Cutter acute angle [degrees]")
(defvar opfile nil "Results file name")





(defun processI (args)
"Return the car of the list args, if an Integer, else nil
args is expected to point to the parameter value of argv"
   (if (and
       (car args)
       (numberp (read-from-string (car args)))
       ) ;; good value available
      (read-from-string (car args))
      (format t "No Integer value found ~%")
      )
   )


(defun processR (args)
"Return the car of the list args, if a real, else nil
args is expected to point to the parameter value of argv"
   (if (and
       (car args)
       (numberp (read-from-string (car args)))
       ) ;; good value available
      (format nil "~,2f" (read-from-string (car args)))
      (format t "No real value found  ~%")
      )
   )


(defun processS (args)
"Return the car of the list args, if a string, else nil
args is expected to point to the parameter value of argv"
   (if (and
       (car args)
       (stringp (car args))
       ) ;; good value available
       (car args)
      (format t "No String value found  ~%")
      )
   )


(defvar usageString "Usage: dovetailCalc [options]
Evaluate dovetail spacing for a given cutter and stock width.
Use the same units (mm, inches....) for all measurements.
Specify Angles  in degrees.

Options:
-o [--output]. File for output, defaults to standard out
-w [--cwidth]. Max diameter of the cutter(no units)
-a [--angle].  Dovetail cutter angle (6-30 degs). 
               Subtract 90 if specified > 100
-s [--stock.   Thickness of stock (no units)
-d [--depth].  Depth of cut (default is stock thickness
               which will be used for through 
               or common dovetails.
-g [--gapcount]. Number of 'female' cuts. Must be even.
" )

(defun usage ()
"output the usage instructions for the program"
      (format t "~A~A~%" *progname* usageString) 
)


(defun getopts (args)
"Process an options string according to the param switch"
  (if args
      (progn
	(cond
	  ((equal (car args) "-w")(setf w (processR (cdr args))))
	  ((equal (car args) "-s")(setf s (processR (cdr args))))
	  ((equal (car args) "-a")(setf theta (processR (cdr args))))
	  ((equal (car args) "-d")(setf d (processR (cdr args))))
	  ((equal (car args) "-g")(setf gapcount (processR (cdr args))))
	  ((equal (car args) "-o")(setf opfile (processS (cdr args))))
					;Single param
	  ((equal (car args) "-t")(selftest))
	  ((equal (car args) "-t")(usage))
	  (t  (usage)     )
	  )
	(getopts (cddr args))
	)
      )
  )

;
;Main, if only lisp had one. 
;

;(format t "args # args = ~A~%" (length *posix-argv*))
(format t "Program  is ~A~%" (car *posix-argv* ))
;(format t "second arg is ~A~%" (nth 1 *posix-argv*))
;(format t "third arg is ~A~%" (nth 2 *posix-argv*))
;(format t "fourth arg is ~A~%" (nth 3 *posix-argv*))
;(format t "fifth arg is ~A~%~%" (nth 4 *posix-argv*))


(getopts (cdr *posix-argv*))
(progn
  (if w
      (format t "Cutter width ~A~%" w)
      )
  
  (if s
      (format t "Stock width ~A~%" s)
      )
  (if theta
      (format t "Cutter angle is ~A~%" theta)
      )
  (if opfile
      (format t "output file is ~A~%" opfile)
      )
  (if d
      (format t "Stock thickness is ~A~%" d)
      )
  (if gapcount
      (format t "Gap count is ~A~%" gapcount)
      )

  (sb-ext:quit)
)

;;
;; Copyright (C) 2007,2008 Dave Pawson
;;
;;  This program is free software; you can redistribute it and/or modify it under
;;  the terms of the GNU General Public License as published by the Free Software
;;  Foundation; either version 2 of the License, or (at your option) any later
;;  version.
;; 
;;  This program is distributed in the hope that it will be useful, but WITHOUT
;;  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;;  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;;  details.
;; 
;;  You should have received a copy of the GNU General Public License along with
;;  this program; if not, write to the Free Software Foundation, Inc., 51
;;  Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
;; 

