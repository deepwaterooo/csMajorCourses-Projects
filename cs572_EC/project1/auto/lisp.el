(TeX-add-style-hook "lisp"
 (lambda ()
    (LaTeX-add-labels
     "sec-1"
     "sec-2"
     "sec-3"
     "sec-4"
     "sec-5"
     "sec-6"
     "sec-7"
     "sec-8"
     "sec-9"
     "sec-10")
    (TeX-run-style-hooks
     "geometry"
     "listings"
     "CJKutf8"
     "hyperref"
     "amssymb"
     "wasysym"
     "marvosym"
     "textcomp"
     "amsmath"
     "ulem"
     "normalem"
     "rotating"
     "wrapfig"
     "float"
     "longtable"
     "graphicx"
     "fixltx2e"
     ""
     "fontenc"
     "T1"
     "inputenc"
     "utf8"
     "latex2e"
     "art11"
     "article"
     "11pt")))

