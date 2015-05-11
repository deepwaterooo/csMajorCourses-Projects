;;; Everything is in the package "3dttt", so call things in the style
;;; (3dttt:connect)
(defpackage :3dttt
  (:export #:connect #:logout #:login #:list-players #:play-game))
(in-package :3dttt)

;;; This is the I/O stream with the server
(setq *stream* NIL)
(setq *board* NIL)

;;; Connect takes two keyword options: host and port which have defaults 
(defun connect (&key (host "cycle1") (port 6666))
  (setq *stream* (acl-socket:make-socket :remote-host host :remote-port port))
)

;;; Please call logout before exiting or re-connecting, as it helps the server
;;; clean up resources.  (Otherwise it may not reclaim your nickname at all, at
;;; least until you exit lisp.)
(defun logout NIL
  (format *stream* "QUIT~%")
  (close *stream*)
)

;;; List-players returns a list of players currently logged in.
;;; Each entry consists of a player name followed by one of the following:
;;; 1) Nothing, if the player is neither waiting for a game nor playing one.
;;; 2) A tab, "wf", another tab, and then the name of the person this player is
;;;    waiting to play (can be "ANY").
;;; 3) A tab, "p", another tab, and then the name of the person this player is
;;;    currently playing against.
(defun list-players NIL
  (let ((l NIL) (n NIL))
    (format *stream* "LIST~%")
    (finish-output *stream*)
    (loop
      (if (not (equalp (setq n (read-line *stream*)) ""))
        (setq l (append l (list n)))
        (return l)
      )
    )
  )
)

;;; Play-game takes a player name as an argument and attempts to play a game
;;; against him/her/it.  If an error occurs, it is printed, and NIL is
;;; returned.  If the game is completed, -1 is returned for a loss, 0 for a
;;; tie, and 1 for a win.
;;; This function makes repeated calls to (make-move), a user defined function.
(defun play-game (name)
  (format *stream* "PLAY ~A~%" name)
  (finish-output *stream*)
  (let ((val (read *stream*)))
    (cond
      ((string-equal val 'ERROR)
        (format t "~A ~A~%" val (read-line *stream*))
	NIL
      )
      ((string-equal val 'OKAY)
        (let ((arg (read *stream*)))
          (cond
	    ((string-equal arg 'Waiting.)
	      (let ((move (get-move)))
		(if (numberp move)
		  (play move)
	          (format t "~A" move)
		)
	      )
	    )
	    ((string-equal arg 'Your)
	      (read-line *stream*)
	      (play NIL)
	    )
	  )
	)
      )
      (t (format t "Unexpected data ~A ~A~%" val (read-line *stream*)) NIL)
    )
  )
)

;;; Plays out an already-started game
(defun play (move)
  (setq *board* (make-array 64 :initial-element 0))
  (new-game)
  (let ((val NIL))
    (loop
      (if (not (null move))
	(setf (aref *board* move) -1)
      )
      (setq val (move (make-move move *board*)))
      (cond
        ((not (numberp val))
	  (setq move (get-move))
	  (if (not (numberp move))
	    (cond
	      ((string-equal move 'WIN)
	        (return 1)
	      )
	      ((string-equal move 'TIE)
	        (return 0)
	      )
	      ((string-equal move 'LOSE)
	        (return -1)
	      )
	      (t (format t "Invalid move data ~A~%" move) (return NIL))
	    )
	  )
        )
	(t (return val))
      )
    )
  )
)

;;; Get-move gets a move from the opponent
(defun get-move NIL
  (let ((val (read *stream*)))
    (cond
      ((string-equal val 'ERROR)
        (format t "~A ~A~%" val (read-line *stream*))
	NIL
      )
      ((string-equal val 'MOVE)
        (read *stream*)
      )
      ((string-equal val 'WIN)
        (read-line *stream*)
	'WIN
      )
      ((string-equal val 'TIE)
        (read-line *stream*)
	'TIE
      )
      ((string-equal val 'LOSE)
        (read-line *stream*)
	'LOSE
      )
      (t (format t "Unexpected data ~A ~A~%" val (read-line *stream*)) NIL)
    )
  )
)

;;; Move sends a move to the server, takes a single argument: what move to make
(defun move (num)
  (setf (aref *board* num) 1)
  (format *stream* "MOVE ~D~%" num)
  (finish-output *stream*)
  (let ((val (read *stream*)))
    (cond
      ((string-equal val 'ERROR)
        (format t "~A ~A~%" val (read-line *stream*))
        NIL
      )
      ((string-equal val 'OKAY)
        (read-line *stream*)
        t
      )
      ((string-equal val 'TIE)
        (read-line *stream*)
	0
      )
      ((string-equal val 'WIN)
        (read-line *stream*)
	1
      )
      (t (format t "Unexpected data ~A ~A~%" val (read-line *stream*)) NIL)
    )
  )
)

;;; Login takes a single argument: what name you would like to call your player
(defun login (name)
  (format *stream* "NAME ~A~%" name)
  (finish-output *stream*)
  (let ((val (read *stream*)))
    (cond
      ((string-equal val 'ERROR)
        (format t "~A ~A~%" val (read-line *stream*))
	NIL
      )
      ((string-equal val 'OKAY)
        (read-line *stream*)
	t
      )
      (t (format t "Unexpected data ~A ~A~%" val (read-line *stream*)) NIL)
   )
  )
)

