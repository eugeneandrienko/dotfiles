(require 'tex-site)
(require 'auctex-latexmk)
(auctex-latexmk-setup)
(setq TeX-PDF-mode t)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)


(add-hook 'LaTeX-mode-hook '(lambda () (set-fill-column 80)))
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

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
;enabled RefTeX
(setq reftex-plug-into-AUCTeX t)
(custom-set-faces
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :foreground "OliveDrab" :height 1.1))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :foreground "OliveDrab" :height 1.1))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :foreground "OliveDrab" :height 1.1))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "OliveDrab" :height 1.1))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "OliveDrab" :height 1.1))))
 '(font-latex-sectioning-5-face ((((class color) (background dark)) (:inherit variable-pitch :foreground "OliveDrab" :weight bold))))
 '(font-latex-string-face  ((t (:inherit font-lock-keyword-face :foreground "OliveDrab" :height 1.0)))))

;;templates for LaTeX
(defun template-latex-report()
  "Copy LaTeX report to current directory and open it."
  (interactive)
  (let ((latex-report-path "~/.emacs.d/templates/latex-report/*.tex")
    (main-file-name "report.tex"))
    (progn
      (shell-command (concat "cp " latex-report-path " ."))
      (find-file (expand-file-name (concat "./" main-file-name))))))

(defun template-latex-presentation()
  "Copy LaTeX presentation to current directory and open it."
  (interactive)
  (let ((latex-presentation-path "~/.emacs.d/templates/latex-beamer/*.tex")
    (main-file-name "presentation.tex"))
    (progn
      (shell-command (concat "cp " latex-presentation-path " ."))
      (find-file (expand-file-name (concat "./" main-file-name))))))

