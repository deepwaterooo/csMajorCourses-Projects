#!/usr/bin/clisp
;; require two arguments
(if (not (= 2 (length *args*))) (progn
    (print "ERROR: we take only two arguments: player and input board file name.")
    (exit)
    )
  ; else
;  (progn
;    (print "OK, we got 2 arguments")
;   (print "arg1 is ")
;   (print (nth 0 *args*))
;   (print "arg2 is ")
;    (print (nth 1 *args*))
;  )
)

;; check if the first arg is "x" or "o" only
;; set playermark
(let ((arg1 (car *args*)))
  (if (not (or (equal arg1 "x") (equal arg1 "o")))
      (progn (print "Player can take two values: x or o.")) ))
;    (setf playermark arg1)
;(exit) ))

;;; set current player value
(setf player 
  (let ((arg1 (car *args*)))
    ;(if (= (car *args*) "x") 1 2))
      (if (equal arg1 "x") 1 2)))

(setf playermark 
  (cond ((= player 1) #\x)
	((= player 2) #\o)))

;(format t "~A" "the player value is")
;(format t "~A" player)

;; read lines
;(let ((in (open (nth 1 *args*) :if-does-not-exist nil)))
;  (when in
;    (loop for line = (read-line in nil)
;	 while line do (format t "~a~%" line))
;   (close in)))
;(close in)))

(defparameter *L* (open (nth 1 *args*)))
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

;(format t "~%~A" b)
(setf board (make-array '(4 4 4)))

;;; try to read b11
(loop for i from 0 to 3
     do (setf 
	 (aref board 0 0 i) (subseq b i (+ i 1))))

;;; read whole b1
(loop for j from 0 to 3
  collect (loop for i from 0 to 3
	do (setf 
         (aref board 0 j i) (subseq b (+ (* 4 j) i) (+ (+ (* 4 j) i) 1)))))

;;; read whole b
(loop for x from 0 to 3
  collect
    (loop for j from 0 to 3
      collect (loop for i from 0 to 3
	 do (setf (aref board x j i) 
	   (parse-integer (subseq b (+ (* 4 j) (* 16 x) i) (+ (+ (* 4 j) (* 16 x) i) 1)))))))


;(defun update-result (board player)
;  (setf pos (car (bestm_pos board player)))
;      (cond ((= (/ (- pos (mod pos 16)) 16) 0)
;	    (setf (aref b1
;			 (* (/ (- pos (mod pos 4)) 4) 10) (* 2 (mod pos 4))) playermark))

(setf x (coerce "0000000000000000000000000000000000000000000000000000000000000000" 'string))

(if (equal b x) ( ;then
(format t "~%~A" "The original input board:")
(let ((in (open (car (cdr *args*)) :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	 while line do (format t "~a~%" line))
    (close in))
(close in))
(defparameter *L* (open (car (cdr *args*))))
(setf b1 (subseq (read-line *L*) 0 37))
(setf b2 (subseq (read-line *L*) 0 37))
(setf b3 (subseq (read-line *L*) 0 37))
(setf b4 (subseq (read-line *L*) 0 37))
(setf b5 (subseq (read-line *L*) 0 37))
(setf b6 (subseq (read-line *L*) 0 37))
(setf b7 (subseq (read-line *L*) 0 37))
;(setf (aref b1 2) playermark)
;(format t "~%~A" b1)
;;; write to *standard-output*
(format t "~%~A" "The Updated Final board is:")
(format t "~%~A" b1)
(format t "~%~A" b2)
(format t "~%~A" b3)
(format t "~%~A" b4)
(format t "~%~A" b5)
(format t "~%~A" b6)
(format t "~%~A" b7) ))
;else

;;; define name of player, return current player or of empty fields.
;(defun name-of (player)
;  "Return character of currect player or of empty field."
;  (char ".xo" player))

;;; define opponent player
(defun opponent (player)
  "Return the opponent of PLAYER."
  (if (eql player 1) 2 1))

;;; ------------------------------------------------------------------------------------------------
;;; Part 1: Check for input board has winned condition or now
;;; ------------------------------------------------------------------------------------------------

;;; "A player has won if either a complete row, a complete column or a complete diagonal is finished."

;;; process results for define winner:
;;; check winner: for b11
(defun check_winner (player board)
  (if (= (loop for i from 0 to 3 sum (aref board 0 0 i))
      (* player 4)) 1 0))

;;; check winner: for b1
(defun check_winner (player board)
  (loop for j from 0 to 3 
     sum (+ 0 
	(if (= (loop for i from 0 to 3 sum (aref board 0 j i))
	       (* player 4)) 1 0)) ))


;;; check winner 1: for board, 16 situations towards y axis (i direction)
(defun check_winner_i (player board)
  (loop for x from 0 to 3
     sum (+ 0
       (loop for j from 0 to 3 
	 sum (+ 0 
	   (if (and (= (loop for i from 0 to 3 sum (* (aref board x j i) (aref board x j i)))
		       (* player player 4))
		    (= (aref board x j 3) player))
	       1 0)) )) ))

;;; check winner 2: for board, 16 situations towards z axis (x direction)
(defun check_winner_x (player board)
  (loop for j from 0 to 3
    sum (+ 0
      (loop for i from 0 to 3 
	 sum (+ 0 
	  (if (and (= (aref board 3 j i) player)
		   (= (loop for x from 0 to 3 sum (* (aref board x j i) (aref board x j i)))
		 (* player player 4)))
	       1 0)) )) ))

;;; check winner 3: for board, 16 situations towards x axis (j direction)
(defun check_winner_j (player board)
  (loop for x from 0 to 3
    sum (+ 0
      (loop for i from 0 to 3 
	 sum (+ 0 
	  (if (and (= (aref board x 3 i) player)
		   (= (loop for j from 0 to 3 sum (* (aref board x j i) (aref board x j i)))
		 (* player player 4)))
	       1 0)) )) ))

;;; check winner 4: for board, 8 crosss situations towards yz axis (j direction)
(defun check_winner_cj (player board) 
  (+ 0
     (loop for j from 0 to 3 
	sum (+ 0 
	 (if (and (= (aref board 3 j 3) player)
		  (= (loop for i from 0 to 3 sum (* (aref board i j i) (aref board i j i))) 
		(* player player 4)))
	     1 0)))
     (loop for j from 0 to 3
	sum (+ 0
	 (if (and (= (aref board 3 j 0) player)
		  (= (loop for i from 0 to 3 sum (* (aref board i j (- 3 i)) (aref board i j (- 3 i))))
		(* player player 4)))
	     1 0) )) ))

;;; check winner 5: for board, 8 cross situations towards xz axis (i direction)
(defun check_winner_ci (player board)
  (+ 0
     (loop for i from 0 to 3 
	sum (+ 0 
	 (if (and (= (aref board 3 3 i) player)
		  (= (loop for x from 0 to 3 sum (* (aref board x x i) (aref board x x i))) (* player player 4)))
	     1 0)))
     (loop for i from 0 to 3
	sum (+ 0
	 (if (and (= (aref board 3 0 i) player)
		  (= (loop for x from 0 to 3 sum (* (aref board x (- 3 x) i) (aref board x (- 3 x) i)))
		(* player player 4)))
	     1 0) ))))

;;; check winner 6: for board, 8 cross situations towards xy axis (x direction)
(defun check_winner_cx (player board)
  (+ 0
     (loop for x from 0 to 3 
	sum (+ 0 
	 (if (and (= (aref board x 3 3) player)
		  (= (loop for j from 0 to 3 sum (* (aref board x j j) (aref board x j j))) (* player player 4)))
	     1 0)))
     (loop for x from 0 to 3
	sum (+ 0
	 (if (and (= (aref board x 3 0) player)
		  (= (loop for j from 0 to 3 sum (* (aref board x j (- 3 j)) (aref board x j (- 3 j))))
		(* player player 4)))
	     1 0) ))))

;;; check winner 7: 4 cross corner-to-corner situations
(defun check_winner_cc (player board)
  (+ 0
     (if (and (= (aref board 2 2 2) player)
	      (= (loop for i from 0 to 3 sum (* (aref board i i i) (aref board i i i))) (* player player 4)) )
	 1 0)
     (if (and (= (aref board 2 2 1) player)
	      (= (loop for i from 0 to 3 sum (* (aref board i i (- 3 i)) (aref board i i (- 3 i))))
	    (* player player 4))) 1 0)
     (if (and (= (aref board 2 1 2) player)
	      (= (loop for i from 0 to 3 sum (* (aref board i (- 3 i) i) (aref board i (- 3 i) i)))
	    (* player player 4))) 1 0)
     (if (and (= (aref board 2 1 1) player)
	      (= (loop for i from 0 to 3 sum (* (aref board i (- 3 i) (- 3 i)) (aref board i (- 3 i) (- 3 i))))
	    (* player player 4))) 1 0) ))
	 
;;; final: win, combining 1 to 7
(defun win_check (player board)
  (+ (check_winner_i player board)
	    (check_winner_x player board)
	    (check_winner_j player board)
	    (check_winner_cj player board)
	    (check_winner_ci player board)
	    (check_winner_cx player board)
	    (check_winner_cc player board)))
;;; if win return greater than 0, the player has winned already!

;;; quote: I copied this function from http://stackoverflow.com/questions/7912232/how-do-you-copy-an-array-in-common-lisp website
(defun copy-array (array &key
                   (element-type (array-element-type array))
                   (fill-pointer (and (array-has-fill-pointer-p array)
                                      (fill-pointer array)))
                   (adjustable (adjustable-array-p array)))
  "Returns an undisplaced copy of ARRAY, with same fill-pointer and
adjustability (if any) as the original, unless overridden by the keyword
arguments."
  (let* ((dimensions (array-dimensions array))
         (new-array (make-array dimensions
                                :element-type element-type
                                :adjustable adjustable
                                :fill-pointer fill-pointer)))
    (dotimes (i (array-total-size array))
      (setf (row-major-aref new-array i)
            (row-major-aref array i)))
    new-array))

;;; define a function to change vector index to 4x4x4 array index
(defun array-index (board pos)
  (if (or (< pos 0) (> pos 63)) 0
      (aref board (/ (- pos (mod pos 16)) 16) 
	    (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 
	    (mod (mod pos 16) 4))))

(defun pos_index (pos)
  (setf x (/ (- pos (mod pos 16)) 16)) 
  (setf y (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4))
  (setf z (mod (mod pos 16) 4)) )


;;; get potential move positions
(defun potent (board)
 (loop for i from 0 to 63
    collect (if (= (array-index board i) 0) i 0)))  ;;; return only one value here

(defun potent2 (L)
  (if (null L) nil
      (if (= (car L) 0) (potent2 (cdr L)) (cons (car L) (potent2 (cdr L))))))

(defun potential (board)
  (if (= (array-index board 0) 0) (cons 0 (potent2 (potent board))) (potent2 (potent board))))


;(format t "~%~A" (potential board))


;;; check potential 4 in a row: potential win check
(defun win_check_pp (board pos player)
  (setf *c* (copy-array board))
  (setf (aref *c* (/ (- pos (mod pos 16)) 16) 
	      (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 
	      (mod (mod pos 16) 4)) player)
  (win_check player *c*))


;;; update potential list positions for check pp_3ina_row
(defun potent3l (L player)
  (if (null L) nil
      (if (> (win_check_pp board (car L) player) 0) (potent3l (cdr L) player)
	  (cons (car L) (potent3l (cdr L) player)))))


;;;; Auxiliary Functions
(defun check-k-in-a-row (board x y z k dx dy dz player)
  "Does player have k in a row, through (x y z) in direction (+/-dx +/-dy +/-dz)?"
  (if (>= (+ (count-pieces-in-direction board x y z (- dx) (- dy) (- dz) player) 
	     (count-pieces-in-direction board x y z dx dy dz player) -1) 
	  k) 1 0))

(defun count-pieces-in-direction (board x y z dx dy dz player)
  "Count player's pieces starting at (x y z) going in direction (dx dy dz)."
  (if (and (< -1 x 4) (< -1 y 4) (< -1 z 4) (eq (aref board x y z) player))
      (+ 1 (count-pieces-in-direction board (+ x dx) (+ y dy) (+ z dz) dx dy dz player))
    0))


;;; check potential 3 or 2 in a row	
(defun pp_k_ina_row (board pos k player)
  (setf *c* (copy-array board))
  (setf (aref *c* (/ (- pos (mod pos 16)) 16) 
	      (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 
	      (mod (mod pos 16) 4)) player)
  (pos_index pos)
 (+ (check-k-in-a-row *c* x y z k 0 1 0 player)
    (check-k-in-a-row *c* x y z k 0 0 1 player)
    (check-k-in-a-row *c* x y z k 1 0 0 player)
    (check-k-in-a-row *c* x y z k 1 1 0 player)
    (check-k-in-a-row *c* x y z k -1 1 0 player)
    (check-k-in-a-row *c* x y z k 1 0 1 player)
    (check-k-in-a-row *c* x y z k -1 0 1 player)
    (check-k-in-a-row *c* x y z k 0 1 1 player)
    (check-k-in-a-row *c* x y z k 0 1 -1 player)
    (check-k-in-a-row *c* x y z k -1 1 1 player)
    (check-k-in-a-row *c* x y z k 1 1 1 player)
    (check-k-in-a-row *c* x y z k -1 1 -1 player)
    (check-k-in-a-row *c* x y z k 1 1 -1 player)
))

;;; update potential list positions for check pp_2ina_row
(defun potent2l (L player)
  (if (null L) nil
      (if (> (pp_3ina_row board (car L) player) 0) (potent2l (cdr L) player)
	  (cons (car L) (potent2l (cdr L) player)) )))

;;; check potential 2 in a row
;;; share pp_k_ina_row with 3-in-a-row except need to update position list


;;; develop evaluation function
(defun pos_eval (board pos player)
  (+ 0
     (if (> (win_check_pp board pos player) 0) (* 1000 (win_check_pp board pos player))
	 (if (> (win_check_pp board pos (opponent player)) 0) (* -100 (win_check_pp board pos (opponent player)))
	     (if (> (pp_k_ina_row board pos 3 player) 0) (* 10 (pp_k_ina_row board pos 3 player))
		 (if (> (pp_k_ina_row board pos 3 (opponent player)) 0) 
		     (* -5 (pp_k_ina_row board pos 3 (opponent player)))
		     (if (> (pp_k_ina_row board pos 2 player) 0) (pp_k_ina_row board pos 2 player) 0
			 )
		     )
		 )))))

;;; loop for return the best value for one move
(defun bestm_pos_val (board player)
  (setf potL (potential board))
  (loop for i in potL maximize (pos_eval board i player)))
    
;;; a bug within this function, alternate with followed three helper functions  
;(defun bestm_pos (board player)
;  (setf potL (potential board))
;  (loop for i in potL 
;       for y = (pos_eval board i player)
;     finally return (list i (= y
;   (loop for i in potL maximize (pos_eval board i player))))))
;finally return (list (loop for i in potL maximize (pos_eval board i player)) i) ))

(defun bestm_pos2 (board player)
  (setf potL (potential board))
	(loop for i in potL collect 
	     (if (= (pos_eval board i player) (bestm_pos_val board player)) i 0)))

(defun bestm_pos3 (L)
  (if (null L) nil
      (if (= (car L) 0) (bestm_pos3 (cdr L)) 
	  (cons (car L) (bestm_pos3 (cdr L))) )))

(defun bestm_pos (board player)
  (if (= (pos_eval board 0 player) (bestm_pos_val board player)) 0
	 (bestm_pos3 (bestm_pos2 board player)) ))

(defun final_board (board player)
  (setf pos (car (bestm_pos board player)))
  (setf *c* (copy-array board))
  (setf (aref *c* (/ (- pos (mod pos 16)) 16)
	      (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 
	      (mod (mod pos 16) 4)) player))

;(defun array-to-string (board)
;  (loop for x from 0 to 3
;       collect (loop for j from 0 to 3 
;	     collect (loop for i from 0 to 3 collect (write-to-string (aref *c* x j i))))))

;(defun array-to-vector (board)
;  (loop for x from 0 to 3
;       collect (loop for j from 0 to 3
;	   colllect 


;;; update my result based on b vector than
;(defun update-vector(vect pos)
;  (setf vect b)
;  (if (or (< pos 0) (> pos 63)) null
;      (setf (aref b pos) 
;	    (cond ((= player 1) #\1)
;		  ((= player 2) #\2)))))

;;; set player = 1 here
;(setf f (update-vector b (car (bestm_pos board 1))))
;(setf c (substitute #\  #\0 
;		    (substitute #\o #\2
;		      	(substitute #\x #\1 b))))


(format t "~%~A" "The original input board:")
(format t "~%~A" "")
;;; reread stream in, and update specific character
;;; read lines
(let ((in (open (car (cdr *args*)) :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
	 while line do (format t "~a~%" line))
    (close in))
(close in))
(defparameter *L* (open (car (cdr *args*))))
(setf b1 (subseq (read-line *L*) 0 37))
(setf b2 (subseq (read-line *L*) 0 37))
(setf b3 (subseq (read-line *L*) 0 37))
(setf b4 (subseq (read-line *L*) 0 37))
(setf b5 (subseq (read-line *L*) 0 37))
(setf b6 (subseq (read-line *L*) 0 37))
(setf b7 (subseq (read-line *L*) 0 37))


;(setf pos (car (bestm_pos board player)))
;(format t "~%~A" pos)
;(format t "~%~A" b7)
;(setf (aref b7 34) #\x) 
;(format t "~%~A" (aref b7 34))
;(format t "~%~A" (playermark player))

(setf playermark 
  (cond ((= player 1) #\x)
	((= player 2) #\o)))

(defun update-result (board player)
  (setf pos (car (bestm_pos board player)))
      (cond ((= (/ (- pos (mod pos 16)) 16) 0)
	    (setf (aref b1
			 (* (/ (- pos (mod pos 4)) 4) 10) (* 2 (mod pos 4))) playermark))

	    ((= (/ (- pos (mod pos 16)) 16) 1) 
	    (setf (aref b3 
			(+ (* (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 10) (* 2 
                              (mod (mod pos 16) 4)))) playermark))

	    ((= (/ (- pos (mod pos 16)) 16) 2) 
	    (setf (aref b5
			(+ (* (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 10) (* 2 
                              (mod (mod pos 16) 4)))) playermark))

	    ((= (/ (- pos (mod pos 16)) 16) 3) 
	    (setf (aref b7 
			(+ (* (/ (- (mod pos 16) (mod (mod pos 16) 4)) 4) 10) (* 2 
			       (mod (mod pos 16) 4)))) playermark)) ))
(update-result board player)

;;; write to *standard-output*
(format t "~%~A" "The Updated Final board is:")
(format t "~%~A" b1)
(format t "~%~A" b2)
(format t "~%~A" b3)
(format t "~%~A" b4)
(format t "~%~A" b5)
(format t "~%~A" b6)
(format t "~%~A" b7) 
										 
