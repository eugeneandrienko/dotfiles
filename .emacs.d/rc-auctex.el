;loading AuCTeX
(require 'tex-site)
;loading Preview-LaTeX
(require 'preview-latex)
;;allow document parsing
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;;setup Apvlv as default document viewer
(setq TeX-view-program-list '(("EvincE" "evince %o")))
(setq TeX-view-program-selection '((output-pdf "EvincE")))
 (setq LaTeX-command "latex")
;use pdflatex unstead of latex
(setq TeX-PDF-mode t)
(custom-set-faces
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-5-face ((((class color) (background dark)) (:inherit variable-pitch :foreground "green" :weight bold)))))
