#!/usr/local/bin/clisp
;; require two arguments
;(if (not (= 2 (length *args*))) (progn (print "usage: comeg.lisp x/o output") (exit)))
;; check if the first arg is "x" or "o" only
;(let ((arg1 (car *args*)))
;  (if (not (or (equal arg1 "x") (equal arg1 "o")))
;      (progn (print "usage: example [xo] filename")) (exit)))
;  )
;;;; open a file with command line argument 2
;(let ((filename (nth 1 *args*)))
;  (print board.txt))









;;; set current player value
;(setf player 
;      (if (= (car *args*) "x") 1 2))

;;; read lines
(let ((in (open "board.txt" :if-does-not-exist nil)))
  (when in
;    (loop for line = (read-line in nil)
;	 while line do (format t "~a~%" line))
;   (close in)))
(close in)))


(if (= 1 1)(progn (print  "test if it is working" )) (exit))


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

; concatenate into one string: bc (120)
(setf bbb (concatenate 'string b1 b2 b3 b4))
(setf ba (substitute #\1 #\x bbb))
(setf bb (substitute #\2 #\o ba))
(setf b (substitute #\0 #\  bb))

;(setf a (parse-integer bc))
;(loop for x in (coerce bb 'list)
 ;    do (print x))

(setf *b* (make-array '(4 4 4)))

;;; try to read b11
(loop for i from 0 to 3
     do (setf 
	 (aref *b* 0 0 i) (subseq b i (+ i 1))))

;;; read whole b1
(loop for j from 0 to 3
  collect (loop for i from 0 to 3
	do (setf 
         (aref *b* 0 j i) (subseq b (+ (* 4 j) i) (+ (+ (* 4 j) i) 1)))))

;;; read whole b
(loop for x from 0 to 3
  collect
    (loop for j from 0 to 3
      collect (loop for i from 0 to 3
	 do (setf (aref *b* x j i) 
	   (parse-integer (subseq b (+ (* 4 j) (* 16 x) i) (+ (+ (* 4 j) (* 16 x) i) 1)))))))




;;; set current player value
;(setf player 
;      (if (= (car *args*) "x") 1 2))


;;; define name of player, return current player or of empty fields.
(defun name-of (player)
  "Return character of currect player or of empty field."
  (char ".xo" player))


;;; define opponent player
;(defun opponent (player)
;  "Return the opponent of PLAYER."
;  (if (eql player 1) 2 1))


;;; Access to board           This is something that I need to think about
;(defun place-piece (move player board)
;  "Place a piece to a board location."
;  (setf (row-major-aref board move) player))


;(defun legal-p (move board)
;  "A legal move must be into an empty field."
;  (eql empty (row-major-aref board move)))


;(defun legal-moves (board)
;  "Return list of legal moves."
;  (loop for move below (array-total-size board)
;       when (legal-p move board) collect move))


;;; ------------------------------------------------------------------------------------------------
;;; Part 1: Check for input board has winned condition or now
;;; ------------------------------------------------------------------------------------------------


;;; "A player has won if either a complete row, a complete column or a complete diagonal is finished."

;;; process results for define winner:
;;; check winner: for b11
(defun check_winner (player board)
  (if (= (loop for i from 0 to 3 sum (aref *b* 0 0 i))
      (* player 4)) 1 0))

;;; check winner: for b1
(defun check_winner (player board)
  (loop for j from 0 to 3 
     sum (+ 0 
	(if (= (loop for i from 0 to 3 sum (aref *b* 0 j i))
	       (* player 4)) 1 0)) ))




;;; check winner 1: for *b*, 16 situations towards y axis (i direction)
(defun check_winner_i (player board)
  (loop for x from 0 to 3
     sum (+ 0
       (loop for j from 0 to 3 
	 sum (+ 0 
	   (if (= (loop for i from 0 to 3 sum (* (aref board x j i) (aref board x j i))) 
		  (* player player 4))
	       1 0)) )) ))

;;; check winner 2: for *b*, 16 situations towards z axis (x direction)
(defun check_winner_x (player board)
  (loop for j from 0 to 3
    sum (+ 0
      (loop for i from 0 to 3 
	 sum (+ 0 
	  (if (= (loop for x from 0 to 3 sum (* (aref board x j i) (aref board x j i))) 
		 (* player player 4))
	       1 0)) )) ))

;;; check winner 3: for *b*, 16 situations towards x axis (j direction)
(defun check_winner_j (player board)
  (loop for x from 0 to 3
    sum (+ 0
      (loop for i from 0 to 3 
	 sum (+ 0 
	  (if (= (loop for j from 0 to 3 sum (* (aref board x j i) (aref board x j i))) 
		 (* player player 4))
	       1 0)) )) ))

;;; check winner 4: for *b*, 8 crosss situations towards yz axis (j direction)
(defun check_winner_cj (player board) 
  (+ 0
     (loop for j from 0 to 3 
	sum (+ 0 
	 (if (= (loop for i from 0 to 3 sum (* (aref board i j i) (aref board i j i))) 
		(* player player 4))
	     1 0) ))
     (loop for j from 0 to 3
	sum (+ 0
	 (if (= (loop for i from 0 to 3 sum (* (aref board i j (- 3 i)) (aref board i j (- 3 i))))
		(* player player 4))
	     1 0) )) ))

;;; check winner 5: for *b*, 8 cross situations towards xz axis (i direction)
(defun check_winner_ci (player board)
  (+ 0
     (loop for i from 0 to 3 
	sum (+ 0 
	 (if (= (loop for x from 0 to 3 sum (* (aref board x x i) (aref board x x i))) (* player player 4))
	     1 0) ))
     (loop for i from 0 to 3
	sum (+ 0
	 (if (= (loop for x from 0 to 3 sum (* (aref board x (- 3 x) i) (aref board x (- 3 x) i)))
		(* player player 4))
	     1 0) )) ))

;;; check winner 6: for *b*, 8 cross situations towards xy axis (x direction)
(defun check_winner_cx (player board)
  (+ 0
     (loop for x from 0 to 3 
	sum (+ 0 
	 (if (= (loop for j from 0 to 3 sum (* (aref board x j j) (aref board x j j))) (* player player 4))
	     1 0) ))
     (loop for x from 0 to 3
	sum (+ 0
	 (if (= (loop for j from 0 to 3 sum (* (aref board x j (- 3 j)) (aref board x j (- 3 j))))
		(* player player 4))
	     1 0) )) ))

;;; check winner 7: 4 cross corner-to-corner situations
(defun check_winner_cc (player board)
  (+ 0
     (if (= (loop for i from 0 to 3 sum (* (aref board i i i) (aref board i i i))) (* player player 4)) 
	 1 0)
     (if (= (loop for i from 0 to 3 sum (* (aref board i i (- 3 i)) (aref board i i (- 3 i))))
	    (* player player 4)) 1 0)
     (if (= (loop for i from 0 to 3 sum (* (aref board i (- 3 i) i) (aref board i (- 3 i) i)))
	    (* player player 4)) 1 0)
     (if (= (loop for i from 0 to 3 sum (* (aref board i (- 3 i) (- 3 i)) (aref board i (- 3 i) (- 3 i))))
	    (* player player 4)) 1 0) ))
	 
;;; final: win, combining 1 to 7
(defun win (player board)
  (if (> (+ (check_winner_i player board)
	    (check_winner_x player board)
	    (check_winner_j player board)
	    (check_winner_cj player board)
	    (check_winner_ci player board)
	    (check_winner_cx player board)
	    (check_winner_cc player board))
	 0) 1 0)) 
;;; if win return 1, the other player has winned already!



;;; output ;;; this one is not working properly anymore, need print to screen outside
;(defun print-board (board &optional (print t))
;  "Print a board."
;  (when print
;    (let ((size (first (array-dimensions board))))  ;; let size = 4
;      (format t "~2&~3T")
;      (loop for x below size do
;	   (format t "~A " (1+ x))
;	   (loop for j below size do
;		(format t "~&~2D" (1+ i))
;		(loop for i below size do
;		     (format t " ~A" (name-of (aref board x j i)))))))))

;;; use the *standard-output* for outputing
;(with-open-file (*standard-output* "output.txt" :direction :output
;                                   :if-exists :supersede)
; )





;;; define a function to change vector index to 4x4x4 array index
(defun array-index (pos)
  (if (or (< pos 0) (> pos 63)) 0
      (aref *b* (/ pos 16) (/ (mod pos 16) 4) (mod (mod pos 16) 4)) ))
;;; division is not working for this one yet !!! need adjustment


;;; define new-board
;(map 'array (lambda (x) x
;		    (cons n (loop as x from 1 to (* n n) collect 0))))
;;; displayboard





;;; check for tie

;;; return continue


