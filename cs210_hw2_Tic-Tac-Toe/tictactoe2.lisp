; This is code to implement the Tic-Tac-Toe example in Chapter 1 of the
; book "Learning by Interacting". Read that chapter before trying to
; understand this code.


; States are lists of two lists and an index, e.g., ((1 2 3) (4 5 6) index), 
; where the first list is the location of the X's and the second list is 
; the location of the O's.   The index is into a large array holding the value 
; of the states.  There is a one-to-one mapping from index to the lists.  
; The locations refer not to the standard positions, but to the "magic square" 
; positions:
;
;    2 9 4
;    7 5 3
;    6 1 8
;
; Labelling the locations of the Tic-Tac-Toe board in this way is useful because 
; then we can just add up any three positions, and if the sum is 15, then we 
; know they are three in a row.  The following function then tells us if a list 
; of X or O positions contains any that are three in a row.

(defvar magic-square '(2 9 4 7 5 3 6 1 8))

(defun any-n-sum-to-k? (n k list)
  (cond ((= n 0) (= k 0))
        ((< k 0) nil)
        ((null list) nil)
        ((any-n-sum-to-k? (- n 1) (- k (first list)) (rest list)) t)   
             ; either the first element is included
        ((any-n-sum-to-k? n k (rest list)) t) ))                          
	     ; or it's not
         
; This representation need not be confusing.  To see any state, print it with:

(defun show-state (state)
  (let ((X-moves (first state))
        (O-moves (second state)))
    (format t "~%")
    (loop for location in magic-square
          for i from 0
          do
          (format t (cond ((member location X-moves) " X")
                          ((member location O-moves) " O")
                          (t " -"))) ;end format
          (when (= i 5) (format t "  ~,3F" (value state)))
          (when (= 2 (mod i 3)) (format t "~%")) ))
  (values))
                 

; The value function will be implemented as a big, mostly empty array.  Remember
; that a state is of the form (X-locations O-locations index), where the index 
; is an index into the value array.  The index is computed from the locations.  
; Basically, each side gets a bit for each position.  The bit is 1 is that side 
; has played there.  The index is the integer with those bits on.  X gets the 
; first (low-order) nine bits, O the second nine.  Here is the function that 
; computes the indices:

(defvar powers-of-2 
  (make-array 10 
              :initial-contents 
              (cons nil (loop for i below 9 collect (expt 2 i)))))

(defun state-index (X-locations O-locations)
  (+ (loop for l in X-locations sum (aref powers-of-2 l))
     (* 512 (loop for l in O-locations sum (aref powers-of-2 l)))))

(defvar value-table)
(defvar initial-state)

(defun init ()
  (setq value-table (make-array (* 512 512) :initial-element nil))
  (setq initial-state '(nil nil 0))
  (set-value initial-state 0.5)
  (values))

(defun value (state)
  (aref value-table (third state)))

(defun set-value (state value)
  (setf (aref value-table (third state)) value))
  
(defun next-state (player state move)
  "returns new state after making the indicated move by the indicated player"
  (let ((X-moves (first state))
        (O-moves (second state)))
    (if (eq player :X)
      (push move X-moves)
      (push move O-moves))
    (setq state (list X-moves O-moves (state-index X-moves O-moves)))
    (when (null (value state))
      (set-value state (cond ((any-n-sum-to-k? 3 15 X-moves) 0)
                             ((any-n-sum-to-k? 3 15 O-moves) 1)
                             ((= 9 (+ (length X-moves) (length O-moves))) 0)
                             (t 0.5))))
    state))


(defun terminal-state-p (state)
  (integerp (value state)))

(defvar alpha 0.5)
(defvar epsilon 0.01)

(defun possible-moves (state)
  "Returns a list of unplayed locations"
  (loop for i from 1 to 9 
        unless (or (member i (first state))
                   (member i (second state)))
        collect i))


(defun random-move (state)
  "Returns one of the unplayed locations, selected at random"
  (let ((possible-moves (possible-moves state)))
    (if (null possible-moves) nil
      (nth (random (length possible-moves)) possible-moves)) ))

; the part I may be interested in
(defun greedy-move (player state)
  "Returns the move that, when played, gives the highest valued position"
  (let ((possible-moves (possible-moves state)))
    (if (null possible-moves) nil
      (loop with best-value = -1
            with best-move
            for move in possible-moves
            for move-value = (value (next-state player state move))
            do (when (> move-value best-value) 
                 (setf best-value move-value)
                 (setf best-move move))
            finally (return best-move)))))

; Now here is the main function

(defvar state)

(defun game (&optional quiet)
  "Plays 1 game against the random player. Also learns and prints.
   :X moves first and is random.  :O learns"
  (setq state initial-state)
  (unless quiet (show-state state))
  (loop for new-state = (next-state :X state (random-move state)) 
        for exploratory-move? = (< (random 1.0) epsilon)
        do
        (when (terminal-state-p new-state)
          (unless quiet (show-state new-state))
          (update state new-state quiet)
          (return (value new-state)))
        (setf new-state (next-state :O new-state 
                                    (if exploratory-move?
                                      (random-move new-state)
                                      (greedy-move :O new-state))))
        (unless exploratory-move?
          (update state new-state quiet))
        (unless quiet (show-state new-state))
        (when (terminal-state-p new-state) (return (value new-state)))
        (setq state new-state)))

(defun update (state new-state &optional quiet)
  "This is the learning rule"
  (set-value state (+ (value state)
                      (* alpha
                         (- (value new-state)
                            (value state)))))
  (unless quiet (format t "                    ~,3F" (value state))))

(defun run ()
  (loop repeat 40 do (print (/ (loop repeat 100 sum (game t)) 
                                100.0))))

(defun runs (num-runs num-bins bin-size)   ; e.g., (runs 10 40 100)
  (loop with array = (make-array num-bins :initial-element 0.0)
        repeat num-runs do
        (init)
        (loop for i below num-bins do
              (incf (aref array i)
                    (loop repeat bin-size sum (game t))))
        finally (loop for i below num-bins 
                      do (print (/ (aref array i)
                                   (* bin-size num-runs))))))
