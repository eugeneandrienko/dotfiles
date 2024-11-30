(use-package emacs
  :demand
  :delight
  (subword-mode)
  :hook
  ((c-mode . display-fill-column-indicator-mode)
   (sh-mode . display-fill-column-indicator-mode))
  :custom
  (compilation-scroll-output 1 "Scroll compilation window")
  (compilation-window-height 10 "Compilation window height")
  (compilation-max-output-line-length nil "Don't hide long lines")
  (compilation-always-kill t "Only one compilation at a time")
  (compilation-auto-jump-to-first-error t "Auto jump to the first compilation error")
  (c-default-style "linux" "Linux style for C code formatting")
  (c-basic-offset 4 "Tab = 4 spaces")
  (c-doc-comment-style '((java-mode . javadoc)
                         (pike-mode . autodoc)
                         (c-mode . doxygen))
                       "Comment styles")
  (project-vc-extra-root-markers '(".project" ".project.el")
                                 "Extra markers for project root")
  (global-subword-mode 1 "Iterate through CameCaseWords")
  (gdb-many-windows t "Multi-window layout for GDB")
  (gdb-show-main t "Show source when debug")
  (semanticdb-default-save-directory "~/.emacs.d/semanticdb")
  (semantic-idle-scheduler-idle-time 5 "Time of idle in seconds before reparsing starts")
  (help-window-select t "Always select opened help window")
  (comment-multi-line t "Enable autoidentation for multi-line comments")
  (comment-empty-lines t "Empty lines should be commented inside multiline comment")
  (Man-notify-method 'pushy "How manpage is displayed")

  :config
                                        ; Matching brackets highliting
  (add-hook 'java-mode-hook 'show-paren-local-mode)
  (add-hook 'c-mode-hook 'show-paren-local-mode)
  (add-hook 'LaTeX-mode-hook 'show-paren-local-mode)
  (add-hook 'bibtex-mode-hook 'show-paren-local-mode)
  (add-hook 'emacs-lisp-mode-hook 'show-paren-local-mode)
                                        ; Tab = 4 spaces
  (setq-default tab-width 4)
                                        ; Indent only by spaces by default
  (setq-default indent-tabs-mode nil)
                                        ; Highligth the current line for some modes
  (add-hook 'java-mode-hook 'hl-line-mode)
  (add-hook 'c-mode-hook 'hl-line-mode)
  (add-hook 'sh-mode-hook 'hl-line-mode)
  (add-hook 'LaTeX-mode-hook 'hl-line-mode)
  (add-hook 'bibtex-mode-hook 'hl-line-mode)
  (add-hook 'emacs-lisp-mode-hook 'hl-line-mode)
                                          ; Electric pair mode
  (add-hook 'java-mode-hook 'electric-pair-local-mode)
  (add-hook 'c-mode-hook 'electric-pair-local-mode)
  (add-hook 'sh-mode-hook 'electric-pair-local-mode)
  (add-hook 'LaTeX-mode-hook 'electric-pair-local-mode)
  (add-hook 'bibtex-mode-hook 'electric-pair-local-mode)
                                        ; Electric indent mode
  (add-hook 'java-mode-hook 'electric-indent-local-mode)
  (add-hook 'c-mode-hook 'electric-indent-local-mode)
  (add-hook 'sh-mode-hook 'electric-indent-local-mode)
  (add-hook 'LaTeX-mode-hook 'electric-indent-local-mode)
  (add-hook 'bibtex-mode-hook 'electric-indent-local-mode)
                                        ; Show trailing whitespaces only for necessary modes
  (setq-default show-trailing-whitespace nil)
  (defun enable-whitespace-fn()
    "Enable whitespace"
    (setq show-trailing-whitespace t))
  (add-hook 'java-mode-hook 'enable-whitespace-fn)
  (add-hook 'c-mode-hook 'enable-whitespace-fn)
  (add-hook 'sh-mode-hook 'enable-whitespace-fn)
  (add-hook 'LaTeX-mode-hook 'enable-whitespace-fn)
  (add-hook 'bibtex-mode-hook 'enable-whitespace-fn)
  (add-hook 'emacs-lisp-mode-hook 'enable-whitespace-fn)
                                        ; Hide trailing whitespaces for necessary modes
  (defun disable-whitespace-fn()
    "Disable whitespace"
    (setq show-trailing-whitespace nil))
  (add-hook 'org-mode-hook 'disable-whitespace-fn)
  (add-hook 'calendar-mode-hook 'disable-whitespace-fn)
  (add-hook 'message-mode-hook 'disable-whitespace-fn)
                                        ; Enable Semantic
  (require 'semantic)
  (global-semanticdb-minor-mode 1)
  (global-semantic-idle-scheduler-mode 1)
  (global-semantic-idle-summary-mode 1)
  (semantic-mode 1)
  (setq-mode-local c-mode
                   semanticdb-find-default-throttle
                   '(project unloaded system recursive))
  (defun my-inhibit-semantic-p ()
    (not (equal major-mode 'c-mode)))
  (with-eval-after-load 'semantic
    (add-to-list 'semantic-inhibit-functions #'my-inhibit-semantic-p))

                                        ; Setup native fill-column-indicator
  (setopt display-fill-column-indicator-column 80)
  (set-face-attribute 'fill-column-indicator nil
                      :background 'unspecified' :foreground "grey")
                                        ; Prettify some symbols
  (add-hook 'c-mode-hook (lambda ()
                           (push '("!=" . ?≠) prettify-symbols-alist)
                           (push '("<=" . ?⩽) prettify-symbols-alist)
                           (push '(">=" . ?⩾) prettify-symbols-alist)
                           (prettify-symbols-mode)))
  (add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode))

(use-package dabbrev
                                        ; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
  :config
  (add-to-list 'dabbrev-ignored-buffer-regexps "\\(\\` \\)\\|\\(^\\*\\)"))

(use-package dockerfile-mode
  :pin melpa
  :disabled)

(use-package sql-indent
  :pin gnu
  :disabled
  :custom
  (sql-product 'postgres "Default SQL dialect")
  :config
  (add-hook 'sql-mode-hook 'sqlind-minor-mode)
  (defun sqlind-set-my-offset()
    "Setup my offset"
    (setq sqlind-basic-offset 4))
  (add-hook 'sql-mode-hook 'sqlind-set-my-offset))

(use-package highlight-thing
  :pin melpa
  :delight
  (highlight-thing-mode)
  (hi-lock-mode)
  :hook
  ((c-mode . highlight-thing-mode)
   (java-mode . highlight-thing-mode)
   (sh-mode . highlight-thing-mode)
   (emacs-lisp-mode . highlight-thing-mode))
  :custom
  (highlight-thing-what-thing 'word "Highlight words")
  (highlight-thing-delay-seconds 1.0)
  (highlight-thing-case-sensitive-p t)
  :custom-face
  (highlight-thing ((t (:inherit hi-pink :weight bold)))))

(use-package rainbow-delimiters
  :pin melpa
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package eldoc
  :ensure nil
  :commands eldoc-mode
  :hook (emacs-lisp-mode . turn-on-eldoc-mode)
  :diminish eldoc-mode
  :config
  ;; Show ElDoc messages in the echo area immediately, instead of after 1/2 a second.
  (setq eldoc-idle-delay 0))

(use-package ielm
  :hook
  ((ielm-mode . rainbow-delimiters-mode)
   (ielm-mode . show-paren-local-mode)
   (ielm-mode . electric-indent-local-mode)
   (ielm-mode . disable-whitespace-fn)
   (ielm-mode . eldoc-mode))
  :bind
  (:map inferior-emacs-lisp-mode-map
        ("C-l" . comint-clear-buffer))
  (:map global-map
        ("C-M-:" . ielm))
  (:map paredit-mode-map
        ("RET" . nil)
        ("C-j" . paredit-newline))
  :config
                                        ; Save history
  (defun g-ielm-init-history ()
    (let ((path (expand-file-name "ielm/history" user-emacs-directory)))
      (make-directory (file-name-directory path) t)
      (setq-local comint-input-ring-file-name path))
    (setq-local comint-input-ring-size 10000)
    (setq-local comint-input-ignoredups t)
    (comint-read-input-ring))
  (add-hook 'ielm-mode-hook 'g-ielm-init-history)
  (defun g-ielm-write-history (&rest _args)
    (with-file-modes #o600
      (comint-write-input-ring)))
  (advice-add 'ielm-send-input :after 'g-ielm-write-history)
  (define-key inferior-emacs-lisp-mode-map (kbd "C-r")
              'comint-history-isearch-backward-regexp)
                                        ; Setup prompt
  (cl-defun my-make-right-arrow-icon ()
    "Return a string that displays arrow icon  when inserted in a buffer."
    (propertize (nerd-icons-octicon "nf-oct-chevron_right")
                'face `(:family ,(nerd-icons-octicon-family) :height 1.2)
                'display '(raise 0)))
  (setq ielm-prompt (concat (my-make-right-arrow-icon) " "))
                                        ; Setup buffer position
  (add-to-list 'display-buffer-alist
               '("*ielm*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 10)))
                                        ; No header
  (setq ielm-header ""))

(use-package imenu-list
  :delight
  :bind
  ("<f2>" . 'imenu-list-smart-toggle)
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t "Autoresize imenu buffer")
  (imenu-list-position 'right)
  :config
                                        ; Disable recenter buffer when go to entry
  (setq imenu-list-after-jump-hook nil))

(use-package paredit
  :pin melpa-stable
  :delight
  :hook
  ((ielm-mode . paredit-mode)
   (emacs-lisp-mode . paredit-mode))
  :config
  (defun ea-setup-paredit-keybindings ()
    "Setup proper keybindings for some modes"
    (progn
      (define-key paredit-mode-map (kbd "RET") 'paredit-newline)
      (define-key paredit-mode-map (kbd "C-j") nil)))
  (add-hook 'emacs-lisp-mode-hook 'ea-setup-paredit-keybindings))

(use-package minimap
  :pin gnu
  :bind
  ("<f3>" . minimap-mode)
  :custom
  (minimap-window-location 'right)
  (minimap-hide-fringes t)
  (minimap-minimum-width 25)
  (minimap-width-fraction 0)
  (minimap-major-modes '(prog-mode conf-mode)))

(use-package speedbar
  :ensure nil
  :bind
  ("<f10>" . speedbar)
  :custom
  (speedbar-frame-parameters
   '((name . "speedbar")
     (title . "speedbar")
     (minibuffer . nil)
     (border-width . 2)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 10)))
  (speedbar-use-images t "Use images in speedbar")
  (speedbar-update-flag t "Enable auto update")
  :config
  (speedbar-add-supported-extension
   (list ".sh"
         ".html"
         ".htm"
         ".js"
         ".json"
         ".css"
         ".scss"
         ".sass"
         ".c"
         ".h"
         "makefile"
         "MAKEFILE"
         "Makefile"
         ".java"
         ".el"
         ".org"
         ".txt"
         "README")))

(use-package eldoc
  :ensure nil
  :custom
  (eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)
    :config
    (add-to-list 'display-buffer-alist
                 '("^\\*eldoc for" display-buffer-at-bottom
                   (window-height . 4)))
    (eldoc-add-command-completions "paredit-"))
