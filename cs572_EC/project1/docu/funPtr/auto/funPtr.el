(TeX-add-style-hook "funPtr"
 (lambda ()
    (LaTeX-add-environments
     "theorem"
     "proposition"
     "corollary"
     "lemma"
     "remark"
     "definition")
    (TeX-add-symbols
     "R"
     "S"
     "I")
    (TeX-run-style-hooks
     "hyperref"
     "xcolor"
     "graphics"
     "amsfonts"
     "amssymb"
     "amsmath"
     "graphicx"
     "geometry"
     "listings"
     "multicol"
     "multirow"
     "CJKutf8"
     ""
     "fontenc"
     "T1"
     "inputenc"
     "utf8"
     "latex2e"
     "art10"
     "article"
     "leqno"
     "10pt"
     "ch1")))

