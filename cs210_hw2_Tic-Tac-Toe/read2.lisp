;; read the first line only
; (let ((in (open "board.txt" :if-does-not-exist nil)))
;  (when in
;     (format t "~a~%" (read-line in))
;     (close in)))

;;; read all the four lines
; (with-open-file (stream "board.txt")
;    (do ((line (read-line stream nil)
;               (read-line stream nil)))
;        ((null line))
;      (print line)))

;;; read all the four lines
; (with-open-file (stream "board.txt")
;    (loop for line = (read-line stream nil 'foo)
;          until (eq line 'foo)
;          do (print line)))

;;; read character by character, each character in one line
;(values (read-sequence *L* (make-string-input-stream 
;(with-open-file (stream "board.txt")
;    (do ((char (read-char stream nil)
;               (read-char stream nil)))
;        ((null char))
;      (print char))) 
; this one is working too, need adustment

;;; read lines
(let ((in (open "board.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	 while line do (format t "~a~%" line))
    (close in)))

(defparameter *L* (open "board.txt"))
(setf b1 (subseq (read-line *L*) 0 37))
(setf b2 (subseq (read-line *L*) 0 37))
(setf b3 (subseq (read-line *L*) 0 37))
(setf b4 (subseq (read-line *L*) 0 37))
(setf b5 (subseq (read-line *L*) 0 37))
(setf b6 (subseq (read-line *L*) 0 37))
(setf b7 (subseq (read-line *L*) 0 37))

; cleaing b1 to be 16-char long string vector: b1
(setf b01 (remove #\| b1))
(setf b11 (subseq b01 0 4))
(setf b12 (subseq b01 7 11))
(setf b13 (subseq b01 14 18))
(setf b14 (subseq b01 21 25))
(setf b1 (concatenate 'string b11 b12 b13 b14))

; cleaing b3 to be 16-char long string vector: b2
(setf b02 (remove #\| b3))
(setf b21 (subseq b02 0 4))
(setf b22 (subseq b02 7 11))
(setf b23 (subseq b02 14 18))
(setf b24 (subseq b02 21 25))
(setf b2 (concatenate 'string b21 b22 b23 b24))

; cleaing b5 to be 16-char long string vector: b3
(setf b03 (remove #\| b5))
(setf b31 (subseq b03 0 4))
(setf b32 (subseq b03 7 11))
(setf b33 (subseq b03 14 18))
(setf b34 (subseq b03 21 25))
(setf b3 (concatenate 'string b31 b32 b33 b34))

; cleaing b7 to be 16-char long string vector: b4
(setf b04 (remove #\| b7))
(setf b41 (subseq b04 0 4))
(setf b42 (subseq b04 7 11))
(setf b43 (subseq b04 14 18))
(setf b44 (subseq b04 21 25))
(setf b4 (concatenate 'string b41 b42 b43 b44))



