(defun word-char (c)
  (or (alpha-char-p c)
      (digit-char-p c)))

;; return a list of words from string s
(defun words (s)

   ; if s is empty
   (if (emptystr s) nil

         ; if first char is a "word char"
	 (if (word-char (char s 0))
            ; then go into "in word" mode
            (in-word (cdrstr s) (string (char s 0)) nil)
          ; else try next char
            (words (cdrstr s))
         )
   )
)
