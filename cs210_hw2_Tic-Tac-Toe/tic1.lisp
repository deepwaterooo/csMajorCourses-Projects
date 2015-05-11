(defun new-board (n)
  (map 'array (lambda (x) x)
       (cons n (loop as x from 1 to (* n n) collect 0))))

(defun copy-board (board)
  (map 'array (lambda (x) x) (loop for i across board collect i)))

(defun same-board? (b1 b2)
  (let ((l (min (aref b1 0) (aref b2 0))))
    (reduce (lambda (x y) (and x y))
        (mapcar
         (lambda (x) (= (aref b1 x) (aref b2 x)))
         (loop for i from 0 to (* l l) collect i))
        :initial-value t)))

(defun board-full? (board)
  (= 0 (array-dimension (remove-if-not (lambda (x) (= x 0)) board) 0)))

(defun map-to-array-position (board x y)
  (let ((n (aref board 0)))
    (1+ (+ (* n x) y))))

(defun play-position (board x y player)
  (let* ((new-board (copy-board board)))
    (setf (aref new-board (map-to-array-position board x y)) player)
    new-board))

(defun can-play? (board x y)
  (and (< x (aref board 0)) (< y (aref board 0))
       (equal (aref board (map-to-array-position board x y)) 0)))

(defun all-same-player (board posns player)
  (= (list-length posns)
     (list-length
      (remove-if-not
       (lambda (x)
     (equal player
        (aref board (map-to-array-position board (car x) (cadr x)))))
       posns))))

(defun check-column (board x player)
  (let ((n (aref board 0)))
    (all-same-player board
             (loop for i from 0 to (1- n) collect (list i x))
             player)))

(defun check-row (board x player)
  (let ((n (aref board 0)))
    (all-same-player board
             (loop for i from 0 to (1- n) collect (list x i))
             player)))

(defun check-rows (board player)
  (let ((n (aref board 0)))
    (reduce (lambda (x y) (or x y))
       (loop for i from 0 to (1- n) collect
         (check-row board i player)))))

(defun check-columns (board player)
  (let ((n (aref board 0)))
    (reduce (lambda (x y) (or x y))
       (loop for i from 0 to (1- n) collect
         (check-column board i player)))))

(defun check-diagonals (board player)
  (let ((n (aref board 0)))
    (or
     (all-same-player board
              (loop for i from 0 to (1- n) collect
                (list i i))
              player)
     (all-same-player board
              (loop for i from 0 to (1- n) collect
                (list (- n (1+ i)) i))
              player))))

(defun is-winner (board player)
  (or
   (check-diagonals board player)
   (check-columns board player)
   (check-rows board player)))

(defun compute-winner (board)
  (cond
   ((is-winner board 1) 1)
   ((is-winner board 2) 2)
   (t 0)))

;(defun show-row (board row)
 ; (let ((n (aref board 0)))
  ;  (loop for i from 0 to (1- n) do
   ;   (progn
    ;    (let ((val (aref board (map-to-array-position board row i))))
     ;     (cond
      ;     ((= 0 val) (princ #-))
       ;    ((= 1 val) (princ #X))
        ;   (t (princ #O))))))))

(defun show-board (board)
  (let ((n (aref board 0)))
    (loop for i from 0 to (1- n) do
      (progn
        (fresh-line)
        (show-row board i)))
    (fresh-line)))

(defun build-tree (board player)
  (let* ((n (aref board 0))
     (posns (loop as x from 0 to (1- (* n n))
              collect (list (floor (/ x n)) (rem x n))))
     (valid-posns (remove-if-not
               (lambda (x) (can-play? board (car x) (cadr x)))
               posns)))
    (if (or (not valid-posns) (< 0 (compute-winner board)))
    (list board)
      (cons board (list
           (mapcar (lambda (i)
                  (build-tree
                    (play-position board
                           (car i)
                           (cadr i)
                           player)
                    (1+ (rem player 2))))
                 valid-posns))))))

(defparameter *game* (build-tree (new-board 4) 1) )


;;; first AI

(defun score-board (board player)
  (let ((winner (compute-winner board)))
    (cond
     ((= winner player) 2)
     ((= winner 0) 0)
     (t -1000))))

(defparameter *max-depth* 4)

(defun score-node (node player)
  (labels ((f (actual)
          (if (= player actual) 10000 -10000))
       (score-node-maxd (n actual d)
        (if (or (= *max-depth* d) (= 1 (list-length n)))
        (progn
          (score-board (car n) player))
          (reduce (lambda (x y)
            (if (= player actual) (min x y) (max x y)))
              (mapcar (lambda (x)
                (score-node-maxd
                 x
                 (1+ (rem actual 2))
                 (1+ d)))
                  (cadr n))
              :initial-value (f actual)))))
    (score-node-maxd node player 0)))

(defun play-ai (tree)
  (let ((scores (mapcar (lambda (x)
              (score-node  x 2))
            (cadr tree))))
    (cond
     ((= (list-length scores) 0) '())
     ((= (list-length scores) 1) (caadr tree))
     (t (let ((best (apply #'max scores)))
      (car (remove-if-not (lambda (x) (= best (score-node x 2)))
                  (cadr tree))))))))

(defun play-human (x y)
  (let ((board (car *game*)))
    (if (or (board-full? board) (= (list-length (cdr *game*)) 0))
    "Game over, no winner"
      (if (not (can-play? board x y))
      "No winner, the game is over or your move is ilegal"
    (let ((tmp-board (play-position board x y 1)))
      (if (= 1 (compute-winner tmp-board))
          (progn
        (setf *game* (list tmp-board))
        (show-board tmp-board)
        "You win, congratulations")
        (if (board-full? tmp-board)
        "Game over, no winner"
          (progn
        (setf *game*
              (play-ai
                  (car
                   (remove-if-not
                (lambda (x)
                  (same-board? (car x) tmp-board))
                (cadr *game*)))))
        (if *game*
            (progn
              (show-board (car *game*))
              (if (= (compute-winner (car *game*)) 2)
              (print "Computer wins!")))
          (print "To restart set *game* again"))))))))))



