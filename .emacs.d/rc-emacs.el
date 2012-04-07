;;my favourite scrolling
(setq scroll-step 1)
;turn off the panel
(tool-bar-mode 0)
;turn off the menu
(menu-bar-mode 0)
;compilation window shall scroll down
(setq compilation-scroll-output 1)
;disable the vertical scrollbars
(scroll-bar-mode 0)
;;enable numbers of line and char
(line-number-mode t)
(column-number-mode t)
;disable the startup screen
(setq inhibit-startup-screen t)
;;save all backups to "~/.emacs.d/backups/"
(when (not (file-directory-p "~/.emacs.d/backups"))
  (make-directory "~/.emacs.d/backups"))
(if (file-directory-p "~/.emacs.d/backups")
    (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))
;Matching brackets highliting
(show-paren-mode t)
;highligth the current line
(global-hl-line-mode 1)
;auto-revert buffer
(global-auto-revert-mode t)
;;identation by default
(defun my-ret-hook()
  "Make new lines indented"
  (local-set-key (kbd "RET") 'newline-and-indent)
)
(add-hook 'objc-mode-hook 'my-ret-hook)
(add-hook 'clojure-mode-hook 'my-ret-hook)
(add-hook 'haskell-mode-hook 'my-ret-hook)
(add-hook 'octave-mode-hook 'my-ret-hook)
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'sh-mode-hook
	  '(lambda ()
	     (linum-mode 1)))

;
(setq compilation-window-height 10)
;Emacs font
(custom-set-faces '(default ((t (:size "14pt" :family "Droid Sans Mono-14")))))
;y is rather short than yes
(fset 'yes-or-no-p 'y-or-n-p)
;
(blink-cursor-mode t)
;
(custom-set-variables
 '(initial-scratch-message nil))

;normal color in emacs shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;Bind 'M-g' to 'M-x goto-line'
(global-set-key "\eg" 'goto-line)

;;default mode for text
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'longlines-mode)
(add-hook 'text-mode-hook '(lambda () (set-fill-column 78)))

;;windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;;templates for LaTeX
(define-skeleton template-latex-presentation
  "Presentation LaTeX skeleton"
"\\documentclass[hyperref={unicode=true},utf8x]{beamer}\n"
"\\documentclass[hyperref={unicode=true},utf8x]{beamer}\n"
"% add notes to show notes\n"
"% add notesonly to show only notes\n"
"\\usepackage[T2A]{fontenc}\n"
"\\usepackage{ucs}\n"
"\\usepackage[utf8x]{inputenc}\n"
"\\usepackage[english, russian]{babel}\n"
"\\usepackage{hyperref}\n"
"\\usepackage{breakurl}\n"
"\\usepackage{graphicx}\n"
"\\graphicspath{{images/}}\n"
"\\usepackage[labelformat=empty]{caption}\n"
"\\usepackage{verbatim}\n"
"\\usepackage{listings}\n"
"\n"
"\\lstset{language=C,\n"
"  escapechar=|,\n"
"  frame=tb,\n"
"  showstringspaces=false}\n"
"\n"
"\n"
"\\definecolor{mygreen}{rgb}{.2,.6,.2}\n"
"\\usetheme{Luebeck}\n"
"\\usecolortheme{lily}\n"
"\\useinnertheme{circles}\n"
"\\setbeamercolor*{palette primary} {use=structure, bg=mygreen}\n"
"\\setbeamercolor{frametitle}{fg=black}\n"
"\\setbeamercolor{framesubtitle}{fg=black}\n"
"\\setbeamercolor{titlelike}{fg=black}\n"
"\\setbeamercolor{section in toc}{fg=black}\n"
"\\setbeamercolor{section number projected}{bg=mygreen,fg=black}\n"
"\\setbeamercolor{itemize item}{fg=mygreen}\n"
"\\setbeamercolor{item projected}{fg=white,bg=mygreen}\n"
"\\setbeamercolor{block title}{bg=mygreen, fg=black}\n"
"\\setbeamercolor{description item}{fg=mygreen}\n"
"\n"
"\\title{}\n"
"\\date{}\n"
"\\institute{}\n"
"\\author{Андриенко Евгений}\n"
"\n"
"\\begin{document}\n"
"\n"
"\\begin{frame}\n"
"\\titlepage\n"
"\\end{frame}\n"
"\n"
"\\begin{frame}\n"
"\\tableofcontents\n"
"\\end{frame}\n"
"\n"
"%------------------------------------------------------------------\n"
"\n"
"%------------------------------------------------------------------\n"
"\n"
"\\end{document}\n")
(define-skeleton template-latex-report
  "Report LaTeX skeleton"
"\\documentclass[a4paper,12pt,oneside]{scrartcl}\n"
"\\documentclass[a4paper,12pt,oneside]{scrartcl}\n"
"%use scrartcl (scrreprt or scrbook) for smaller fields\n"
"\\usepackage[T2A]{fontenc}\n"
"\\usepackage{ucs}\n"
"\\usepackage[utf8x]{inputenc}\n"
"\\usepackage[english, russian]{babel}\n"
"\\usepackage{indentfirst}\n"
"\\usepackage[unicode=true]{hyperref}\n"
"\\usepackage{breakurl}\n"
"\\usepackage{graphicx}\n"
"\\usepackage[fleqn]{amsmath}\n"
"\\usepackage{amssymb}\n"
"\\usepackage{amsfonts}\n"
"\\usepackage{hyperref}\n"
"\\usepackage{graphicx}\n"
"\\graphicspath{{images/}}\n"
"\\usepackage{afterpage}\n"
"\\usepackage{paralist}\n"
"\\usepackage{topcapt}\n"
"\\usepackage{fancyhdr}\n"
"\\usepackage{cmap}\n"
"\n"
"\\renewcommand{\\le}{\\leqslant}\n"
"\\renewcommand{\\ge}{\\geqslant}\n"
"%hm for break formulas. For ex.: \\hm{=}\n"
"\\newcommand{\\hm}[1]{#1\\nobreak\\discretionary{}%\n"
"  {\\hbox{$\\mathsurround=0pt #1$}}{}}\n"
"%kill dead lines\n"
"\\clubpenalty=10000\n"
"\\widowpenalty=10000\n"
"\n"
"\\begin{document}\n"
"\n"
"%---------------------------------------------------------------------------\n"
"\n"
"\\begin{titlepage} % начало титульника\n"
"\\begin{center}\n"
"\n"
"\\large Санкт-Петербургский государственный университет информационных технологий \n"
"механики и оптики\\\\[4.5cm]\n"
"\n"
"\\huge Лабораторная работа~\\No~\\\\[0.6cm]\n"
"\\large по теме <<>>\\\\[3.7cm]\n"
"\n"
"\\begin{minipage}{0.5\\textwidth}\n"
"\\begin{flushleft}\n"
"\\emph{Автор:} Андриенко~Евгений\\\\\n"
"\\emph{Группа:} 5113\\\\\n"
"\\emph{Факультет:} КТиУ\\\\\n"
"\\emph{Преподаватель:} \\\\\n"
"\\end{flushleft}\n"
"\\end{minipage}\n"
"\n"
"\\vfill\n"
"\n"
"Санкт-Петербург\\\\\n"
"{\\large \\today}\n"
"\n"
"{\\large \\LaTeX}\n"
"\n"
"\\end{center}\n"
"\\thispagestyle{empty} % не нумеруем страницу\n"
"\\end{titlepage} % конец титульника\n"
"\n"
"%---------------------------------------------------------------------------\n"
"\n"
"\\pagestyle{empty}\n"
"\\pagestyle{fancy}\n"
"\\lhead{}\n"
"\\chead{}\n"
"\\rhead{smth}\n"
"\\lfoot{}\n"
"\\cfoot{}\n"
"\\rfoot{\\arabic{page}}\n"
"\n"
"\\tableofcontents{}\n"
"\\listoffigures\n"
"\\listoftables\n"
"\n"
"\\newpage\n"
"\n"
"%---------------------------------------------------------------------------\n"
"\n"
"\\end{document}\n")
