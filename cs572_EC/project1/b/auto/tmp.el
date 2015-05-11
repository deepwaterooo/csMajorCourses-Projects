(TeX-add-style-hook "tmp"
 (lambda ()
    (LaTeX-add-environments
     '("narrow" 2))
    (TeX-run-style-hooks
     "graphicx"
     "geometry"
     "listings"
     "multicol"
     "multirow"
     "CJKutf8"
     "fontenc"
     "T1"
     "inputenc"
     "utf8"
     "latex2e"
     "art10"
     "article"
     "")))

