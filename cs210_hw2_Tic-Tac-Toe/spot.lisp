;;; This is Spot, the TTT playing dog.  He just picks a random unoccupied
;;; position on the board and goes there.  You should be able to beat him. :-)
;;;
;;; To use Spot, do something like the following:
;;; (load "3dttt.lisp")
;;; (load "spot.lisp")
;;; (3dttt:connect)
;;; (3dttt:login 'spot)
;;; (3dttt:play-game 'fluffy)

;;; Make sure you put your (make-move) function in the 3DTTT package so that
;;; (play-game) can find it.
(in-package :3dttt)
(export 'new-game)

;;; This is a required user function.  Takes no arguments and doesn't return a
;;; meaningful value.  Simply for record-keeping and internal board
;;; representation purposes.  Called once by (play-game) before a game is
;;; started.  This can do nothing if you like.
(defun new-game NIL
  (setq move-list NIL)
  (dotimes (i 64)
    (setq move-list (append move-list (list i)))
  )
)

;;; This is the required function.  It gets two arguments, the most recent
;;; move, and the current board state (a 64-element array of {-1,0,1} where a
;;; -1 means the opponent occupies the position, a 0 means the position is
;;; free, and a 1 means you occupy the position).  It should return a legal
;;; move.  Remember here to stick to the 5-second time limit.
;;;
;;; In the case of Spot, this simply updates an internal representation of the
;;; game state and chooses a random legal move.  Dogs are dumb.
(defun make-move (last-move board)
  (if (not (null last-move))
    (setq move-list (remove last-move move-list))
  )
  (let ((x (nth (random (length move-list)) move-list)))
    (setq move-list (remove x move-list))
    x
  )
)

