;;; First, setup use-package:
(condition-case nil
    (require 'use-package)
  (file-error
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))
;;; Then, configure use-package:
(use-package use-package
  :ensure nil
  :custom
  (use-package-compute-statistics t "Gather statistics for use-package-report")
  (use-package-always-ensure t "Always download package if not exists"))

(use-package delight
  :requires use-package
  :after use-package)

;;; Main Emacs configuration
;;; (not related to other packages)
(use-package emacs
  :demand
  :bind
  ([remap scroll-up-command]   . pixel-scroll-interpolate-down)
  ([remap scroll-down-command] . pixel-scroll-interpolate-up)
  ("M-g" . goto-line)
  ("C-c <left>" .  windmove-left)
  ("C-c <up>" . windmove-up)
  ("C-c <down>" . windmove-down)
  ("C-c <right>" . windmove-right)
  ("C-x C-b" . ibuffer)

  :hook
  ((c-mode . display-fill-column-indicator-mode)
   (sh-mode . display-fill-column-indicator-mode))

  :custom
                                        ; Interface configuration
  (scroll-step 1 "My favorite scrolling")
  (pixel-scroll-precision-interpolate-page t "For pixel-precision scrolling")
  (line-number-mode t "Show line number in modeline")
  (column-number-mode t "Show column number in modeline")
  (inhibit-startup-screen t "Disable startup screen")
  (inhibit-startup-echo-area-message t "Disable startup message")
  (use-file-dialog nil "Don't use GUI file dialog")
  (use-dialog-box nil "Don't use GUI dialog boxes")
  (echo-keystrokes 0.2 "Immediately show keystrokes")
  (calendar-week-start-day 1 "Monday is the start of the week")
  (x-gtk-use-native-input t "Fix '<Multi_key> is undefined' on FreeBSD")
  (vc-follow-symlinks t "Do not ask when follow symlink")
  (frame-title-format '("(%+) %b on %F"))
  (find-file-visit-truename t "Show real filename when visit symlink")
                                        ; Programming-related configuration
  (compilation-scroll-output 1 "Scroll compilation window")
  (compilation-window-height 10 "Compilation window height")
  (c-default-style "linux" "Linux style for C code formatting")
  (c-basic-offset 4 "Tab = 4 spaces")
  (c-doc-comment-style '((java-mode . javadoc)
                         (pike-mode . autodoc)
                         (c-mode . doxygen))
                       "Comment styles")
  (project-vc-extra-root-markers '(".project" ".project.el")
                                 "Extra markers for project root")
                                        ; Package sources
  (package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                      ("gnu" . "https://elpa.gnu.org/packages/")
                      ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                      ("melpa" . "https://melpa.org/packages/")))
  (package-archive-priorities
   '(("melpa" . 10)
     ("gnu" . 9)
     ("melpa-stable" . 8)
     ("nongnu" . 1)))
                                        ; Smart buffer handling
  (ibuffer-saved-filter-groups
   (quote (("default"
            ("Org" (or
                    (mode . org-mode)
                    (name . "^\\*Org Agenda\\*$")))
            ("Java" (or
                     (mode . java-mode)
                     (name . "^\\*EGLOT.+")))
            ("LaTeX" (or
                      (mode . LaTeX-mode)
                      (mode . bibtex-mode)))
            ("C" (or
                  (mode . c-mode)))
            ("Dired" (mode . dired-mode))
            ("EAT" (mode . eat-mode))))))
                                        ; Misc
  (epg-pinentry-mode 'loopback)
  (mail-header-separator "")
  (recentf-max-menu-items 25)
  (recentf-max-saved-items 25)
  (desktop-base-file-name "emacs.desktop")
  (desktop-base-lock-name "emacs.desktop.lock")
  (desktop-save t "Do not ask to save desktop")
  (desktop-load-locked-desktop nil "Do not load locked desktop")
  (desktop-auto-save-timeout 30 "Autosave every 30 seconds")

  :config
                                        ; Turn off the panel
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
                                        ; Turn off the menu
  (when (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
                                        ; Disable scrollbars
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
                                        ; Setup borders width
  (let ((no-border '(internal-border-width . 0)))
    (add-to-list 'default-frame-alist no-border)
    (add-to-list 'initial-frame-alist no-border))
                                        ; Save all backups to "~/.emacs.d/backups/"
  (when (not (file-directory-p "~/.emacs.d/backups"))
    (make-directory "~/.emacs.d/backups"))
  (if (file-directory-p "~/.emacs.d/backups")
      (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))
                                        ; Save all auto save files to "~/.emacs.d/autosave/"
  (when (not (file-directory-p "~/.emacs.d/autosave"))
    (make-directory "~/.emacs.d/autosave"))
  (if (file-directory-p "~/.emacs.d/autosave")
      (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t))))
                                        ; Matching brackets highliting
  (show-paren-mode t)
                                        ; Tab = 4 spaces
  (setq-default tab-width 4)
                                        ; Indent only by spaces by default
  (setq-default indent-tabs-mode nil)
                                        ; Highligth the current line
  (global-hl-line-mode 1)
                                        ; Auto-revert buffer
  (global-auto-revert-mode t)
                                        ; Identation by default
  (defun my-ret-hook()
    "Make new lines indented"
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'octave-mode-hook 'my-ret-hook)
  (add-hook 'sh-mode-hook 'fci-mode)
                                        ; Electric pair mode
  (electric-pair-mode 1)
                                        ; y is rather short than yes
  (fset 'yes-or-no-p 'y-or-n-p)
                                        ; Use blinking cursor
  (blink-cursor-mode t)
                                        ; Insert newline at the EOF
  (setq-default require-final-newline t)
                                        ; Default mode for text
  (setq default-major-mode 'text-mode)
  (add-hook 'text-mode-hook 'visual-line-mode)
  (add-hook 'text-mode-hook #'(lambda () (set-fill-column 78)))
                                        ; Font for GUI
  (add-to-list 'default-frame-alist
               '(font . "Noto Sans Mono-16"))
                                        ; Emacs pinentry
  (pinentry-start)
                                        ; Smart buffer handling
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default")))
                                        ; Enable recentf
  (recentf-mode 1)
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

                                        ; Setup native fill-column-indicator
  (setopt display-fill-column-indicator-column 80)
  (set-face-attribute 'fill-column-indicator nil :background nil
                      :foreground "grey")
                                        ; For dekstop saving
  (setq desktop-dirname ".")
  (setq desktop-path (list "~/.emacs.d/desktop"))
  (setq desktop-files-not-to-save "^$")

  :init
  (pixel-scroll-precision-mode 1))

;;; Setup nerd-icons
;;; M-x nerd-icons-install-fonts
;;; Installation path: ~/.local/share/fonts/
(use-package nerd-icons
  :custom
  (nerd-icons-color-icons nil))

(use-package nerd-icons-ibuffer
  :after nerd-icons
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package solarized-theme
  :pin melpa
  :init
  (load-theme 'solarized-light t)
  :custom
  (solarized-use-variable-pitch nil "Don't change font for headings")
  (solarized-scale-org-headlines nil "Don't change font for Org headlines")
  (solarized-high-contrast-mode-line t "High contrast modeline")
  (x-underline-at-descent-line t "Put underline below font bottomline for X"))

(use-package olivetti
  :pin melpa
  :bind
  ("<f11>" . 'olivetti-mode)
  :custom
  (olivetti-body-width 0.6)
  (olivetti-minimum-body-width 90))

(use-package pdf-tools
  :pin melpa
  :after tex-site
  :bind
  (:map pdf-view-mode-map
        ("M-g" . 'pdf-view-goto-page))
  :config
  (pdf-loader-install))

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
(use-package eat
  :pin nongnu
  :custom
  (eat-enable-directory-tracking t "Track current working directory")
  (eat-term-scrollback-size nil "Unlimited scrollback")
  :bind
  (:map eat-mode-map
        ("C-c C-p" . eat-send-password))
  :config
  (defun my-eat-open (file)
    "Opens file from EAT"
    (if (file-exists-p file)
        (find-file-other-window file t)
      (warn "File doesn't exists")))
  (add-to-list 'eat-message-handler-alist (cons "open" 'my-eat-open)))
