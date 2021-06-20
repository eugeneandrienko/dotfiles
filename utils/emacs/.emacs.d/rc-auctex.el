(require 'tex-site)
(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq TeX-PDF-mode t)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)


(add-hook 'LaTeX-mode-hook '(lambda () (set-fill-column 80)))
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

(setq TeX-open-quote "<<")
(setq TeX-close-quote ">>")

;;allow document parsing
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;;activate forward/reverse search
(TeX-source-correlate-mode)
;;setup Zathura as default document viewer
(add-to-list 'TeX-view-program-list '("Zathura"
				      ("zathura %o"
				       (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" "))
				      "zathura"))
(add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))
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
