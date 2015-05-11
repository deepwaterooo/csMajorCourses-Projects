(TeX-add-style-hook "try"
 (lambda ()
    (LaTeX-add-labels
     "sec-1"
     "sec-1-1"
     "sec-1-1-1"
     "sec-1-1-2"
     "sec-1-2"
     "sec-1-3"
     "sec-2"
     "sec-2-1"
     "sec-2-2"
     "sec-2-2-1"
     "sec-2-3"
     "sec-2-4")
    (TeX-run-style-hooks
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

