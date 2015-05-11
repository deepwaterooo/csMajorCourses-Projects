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
     "sec-2-1-1"
     "sec-2-2"
     "sec-2-3")
    (TeX-run-style-hooks
     "CJKutf8"
     "hyperref"
     "menucolor=blue"
     "urlcolor=blue"
     "linkcolor=blue"
     "CJKbookmarks=true"
     "colorlinks=true"
     "xetex"
     "fancyhdr"
     "natbib"
     "latexsym"
     "algorithmic"
     "algorithm"
     "listings"
     "multicol"
     "multirow"
     "geometry"
     "textcomp"
     "float"
     "longtable"
     "xeCJK"
     "xcolor"
     "graphicx"
     ""
     "latex2e"
     "art10"
     "article"
     "b5paper"
     "10pt")))

