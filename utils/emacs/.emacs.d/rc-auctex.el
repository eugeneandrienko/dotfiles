(require 'tex-site)
(setq TeX-PDF-mode t)


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
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
;;setup Zathura as default document viewer
(setq TeX-view-program-list '(("Zathura"
				      ("zathura %o"
				       (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" "))
				      "zathura")))
(setq TeX-view-program-selection '((output-pdf "Zathura")))
(setq LaTeX-command "latex")
;use pdflatex unstead of latex
(setq TeX-PDF-mode t)
;enabled RefTeX
(setq reftex-plug-into-AUCTeX t)

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

