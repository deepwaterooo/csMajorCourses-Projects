
;;; -------------------------------------------------------------------------
;;;  Tic-tac-toe - A small example project in Lisp
;;;  Written by Peter Dalenius <petda@ida.liu.se> in November 2003
;;; -------------------------------------------------------------------------

;;; This classic game has many names: Tic-tac-toe, Naughts and Crosses,
;;; Three in a row. The game consists of a board of 3x3 positions. The
;;; two players take turns placing either a X or a O in a free space.
;;; The first player to get three of his or her symbols in a row wins.
;;; In some versions of the game the players get to move the symbols
;;; around when the board is full, but here we just call it a draw if
;;; neither wins.

;;; Start the game with (tic-tac-toe).

;;; -------------------------------------------------------------------------
;;;  Part 1: The abstract data type board
;;; -------------------------------------------------------------------------

;;; The possible symbols that the board can contain are defined
;;; by three global constants:

(defconstant *empty* #\Space)
(defconstant *naught* #\O)
(defconstant *cross* #\X)

;;; The board is an array of 3x3 positions. Each position should
;;; contain one of three possible symbols defined above.
;;; All functions operating on the board take coordinates (x, y)
;;; where x is the column and y is the row according to the
;;; diagram below. The X has coordinates (1, 2).

;;;     0   1   2
;;;   +---+---+---+
;;; 0 |   |   |   |
;;;   +---+---+---+
;;; 1 |   |   |   |
;;;   +---+---+---+
;;; 2 |   | X |   |
;;;   +---+---+---+

;;; ----- 1.1. Primitive functions for the board -----

(defun make-board ()
  "-> board"
  (make-array '(3 3) :initial-element *empty*))

(defun get-position (board x y)
  "board x coordinate x coordinate -> symbol"
  (aref board x y))

(defun free-position? (board x y)
  "board x coordinate x coordinate -> truth value"
  (let ((sym (aref board x y)))
    (eq sym *empty*)))

(defun update-board (board x y sym)
  "board x coordinate x coordinate x symbol -> board"
  (setf (aref board x y) sym)
  board)

(defun print-board (board)
  "board ->"
  (labels ((print-row (y)
	     (format t " ~a " y)
	     (dotimes (x 3)
	       (format t "| ~a " (get-position board x y)))
	     (format t "|~&"))
	   (print-separator ()
	     (format t "   +---+---+---+~&")))
    (format t "~&     0   1   2~&")
    (print-separator)
    (dotimes (y 3)
      (print-row y)
      (print-separator))))

(defun board-full? (board)
  "board -> truth value"
  (let ((free-positions 0))
    (dotimes (x 3)
      (dotimes (y 3)
	(if (free-position? board x y) (incf free-positions))))
    (= 0 free-positions)))

;;; ----- 1.2. Checking who is the winner -----

;;; This function will check all 8 possible winning combinations
;;; and return the symbol of the winning participant or the empty
;;; symbol if there is no winner.

(defun winner (board)
  "board -> symbol"
  (let ((combinations '(((0 . 0) (0 . 1) (0 . 2))
			((1 . 0) (1 . 1) (1 . 2))
			((2 . 0) (2 . 1) (2 . 2))
			((0 . 0) (1 . 0) (2 . 0))
			((0 . 1) (1 . 1) (2 . 1))
			((0 . 2) (1 . 2) (2 . 2))
			((0 . 0) (1 . 1) (2 . 2))
			((0 . 2) (1 . 1) (2 . 0))))
	(result *empty*))
    (labels ((get-combination (combination)
	       (mapcar #'(lambda (coords) (get-position board 
							(car coords)
							(cdr coords)))
		       combination)))
      (dolist (combination combinations result)
	(let ((row (get-combination combination)))
	  (if (and (eq (first row) (second row))
		   (eq (second row) (third row))
		   (not (eq (first row) *empty*)))
	      (setq result (first row))))))))

;;; -------------------------------------------------------------------------
;;;  Part 2: The computer player
;;; -------------------------------------------------------------------------

;;; This is the main function for the computer player. Input is the current
;;; board and the symbol the computer player should use. It will call one
;;; of several possible functions for generating moves. To make the
;;; computer player better or worse, change the name of the generating
;;; function here.

(defun computer-move (board computer-symbol)
  "board x symbol ->"
  (format t "~&The computer makes a move.")
  (generate-move-random board computer-symbol))

;;; The stupid computer player: Completely random moves
;;; (Possible infinite loop if the board is full)

(defun generate-move-random (board computer-symbol)
  "board x symbol ->"
  (let ((x 0) (y 0))
    (loop
      (setq x (random 3))
      (setq y (random 3))
      (when (free-position? board x y)
	(update-board board x y computer-symbol)
	(return)))))

;;; TODO: Add more different computer player algorithms here...

;;; -------------------------------------------------------------------------
;;;  Part 3: The main program
;;; -------------------------------------------------------------------------

;;; This macro will swap the values of two variables.

(defmacro swap (var1 var2)
  `(let ((temp ,var1))
     (setq ,var1 ,var2)
     (setq ,var2 temp)))

;;; Main function. Call this one to start the game.

(defun tic-tac-toe ()
  (let ((input nil))
    (loop
      (format t "~&Welcome to Tic-tac-toe!~&-----------------------~&")
      (format t "1. Play game~&2. Quit~&Enter choice and press Enter: ")
      (setq input (read))
      (if (and (numberp input) (= input 1))
	  (main-loop))
      (if (and (numberp input) (= input 2))
	  (return)))))

;;; Main loop for the game itself. It will let the players play a number
;;; of rounds and collect points for each round. 2 points to the winner
;;; or 1 point to each one if it's a draw.

(defun main-loop ()
  (let ((rounds 0) 
	(points-player 0) (points-computer 0)
	(symbol-player *naught*) (symbol-computer *cross*)
	(winner *empty*))
    ;; 1. Get the number of rounds
    (format t "~&A new game begins!")
    (loop
      (format t "~&Enter number of rounds and press Enter: ")
      (setq rounds (read))
      (when (and (numberp rounds) (>= rounds 1))
	(return))
      (format t "~&Invalid numbe of rounds! Try again!"))
    ;; 2. Play the rounds
    (dotimes (this-round rounds)
      (format t "~&Round ~a of ~a. You play ~a.~&" 
	      (1+ this-round) rounds symbol-player)
      (setq winner (game-loop symbol-player))
      (cond ((eq winner symbol-player) 
	     (incf points-player 2))
	    ((eq winner symbol-computer) 
	     (incf points-computer 2))
	    (t (incf points-player)
	       (incf points-computer)))
      (if (eq winner *empty*)
	  (format t "~&It's a draw!~&")
	(format t "~&~a is the winner!~&" winner))
      (format t "Current score: Player ~a points, Computer ~a points~&"
	      points-player points-computer)
      (swap symbol-player symbol-computer))
    ;; 3. Print the final result
    (cond ((> points-computer points-player)
	   (format t "~&The computer wins the whole game!~&"))
	  ((< points-computer points-player)
	   (format t "~&The player wins the whole game!~&"))
	  (t (format t "~&Nobody wins!~&")))))

;;; Main loop for a single game.

(defun game-loop (symbol-player)
  (let ((symbol-computer (if (eq *cross* symbol-player) *naught* *cross*))
	(board (make-board))
	(winner *empty*)
	(current (if (eq *cross* symbol-player) 'player 'computer)))
    (loop
      (print-board board)
      (if (eq current 'player)
	  (computer-move board symbol-computer)
	(player-move board symbol-player))
      (setq current (if (eq current 'player) 'computer 'player))
      (setq winner (winner board))
      (when (not (eq winner *empty*))
	(print-board board)
	(return winner))
      (when (board-full? board)
	(print-board board)
	(return *empty*)))))

;;; Reads a move from the user.

(defun player-move (board symbol-player)
  (let ((x 0) (y 0))
    (loop
      (loop
	(format t "~&Enter X and Y coordinates with space in between: ")
	(setq x (read))
	(setq y (read))
	(when (and (numberp x) (numberp y)
		   (<= 0 x 2) (<= 0 y 2))
	  (return)))
      (when (free-position? board x y)
	(update-board board x y symbol-player)
	(return))
      (format t "~&Position taken! Try again!"))))

;;; -------------------------------------------------------------------------

;;; Diskussionsfr錱or
;;; - Var det l鋞t att f鰎st� programkoden? Vad gjorde det l鋞tare
;;;   eller sv錼are? Vad tyckte du om organisationen av funktioner 
;;;   i k鋖lkodsfilen?
;;; - Hela programmet 鋜 skrivet p� engelska. Var det bra eller d錶igt?
;;;   Kan man blanda svenska och engelska?

