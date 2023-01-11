(use-package tex-site
  :ensure auctex
  :config
  (progn
    (add-hook 'LaTeX-mode-hook '(lambda () (set-fill-column 80)))
    (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
    ;; Asks for master file in multi-file TeX documents
    (setq-default TeX-master nil)
    ;; Enable RefTeX
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (setq reftex-plug-into-AUCTeX t)
    (setq LaTeX-reftex-cite-format-auto-activate t))
  :custom
  (TeX-PDF-mode t)
  (TeX-open-quote "<<")
  (TeX-close-quote ">>")
  (TeX-auto-save t)
  (TeX-save-query t)
  (TeX-parse-self t "Allow document parsing")
  (TeX-source-correlate-mode t "For SyncTeX")
  (TeX-source-correlate-method 'synctex)
  (TeX-view-program-list '(("Zathura"
			    ("zathura %o"
			     (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" "))
			    "zathura"))
			 "Setup Zathura as default document viewer with SyncTeX support")
  (TeX-view-program-selection '((output-pdf "Zathura")))
  (LaTeX-command "latex")
  (TeX-PDF-mode t "Use pdflatex instead of latex")
  (LaTeX-electric-left-right-brace t "Automatically close braces")
  :init
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
  :custom-face
  (font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face
					      :foreground "OliveDrab"
					      :height 1.1))))
  (font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face
					      :foreground "OliveDrab"
					      :height 1.1))))
  (font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face
					      :foreground "OliveDrab"
					      :height 1.1))))
  (font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face
					      :foreground "OliveDrab"
					      :height 1.1))))
  (font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face
					      :foreground "OliveDrab"
					      :height 1.1))))
  (font-latex-sectioning-5-face ((((class color)
				   (background dark))
				  (:inherit variable-pitch
					    :foreground "OliveDrab"
					    :weight bold))))
  (font-latex-string-face ((t (:inherit font-lock-keyword-face
					:foreground "OliveDrab"
					:height 1.0))))
  (highlight-symbol-face ((((class color)
			    (background dark))
			   (:background "OliveDrab")))))

