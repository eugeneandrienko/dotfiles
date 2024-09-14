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
  ("M-j" . (lambda ()
             (interactive)
             (join-line -1)))

  :hook
  ((c-mode . display-fill-column-indicator-mode)
   (sh-mode . display-fill-column-indicator-mode))

  :custom
                                        ; List of manually installed packages
  (package-selected-packages '(highlight-thing
                               pinentry
                               org
                               company
                               use-package
                               auto-complete
                               auctex))
                                        ; Interface configuration
  (scroll-step 1 "My favorite scrolling")
  (pixel-scroll-precision-interpolate-page t "For pixel-precision scrolling")
  (line-number-mode t "Show line number in modeline")
  (column-number-mode t "Show column number in modeline")
  (inhibit-startup-screen t "Disable startup screen")
  (inhibit-startup-echo-area-message t "Disable startup message")
  (initial-buffer-choice t "Always start from *scratch* buffer")
  (initial-scratch-message nil "Remove message in *scratch*")
  (use-file-dialog nil "Don't use GUI file dialog")
  (use-dialog-box nil "Don't use GUI dialog boxes")
  (echo-keystrokes 0.2 "Immediately show keystrokes")
  (calendar-week-start-day 1 "Monday is the start of the week")
  (calendar-date-style 'iso)
  (calendar-time-zone-style 'numeric)
  (x-gtk-use-native-input t "Fix '<Multi_key> is undefined' on FreeBSD")
  (vc-follow-symlinks t "Do not ask when follow symlink")
  (frame-title-format '("(%+) %b on %F"))
  (find-file-visit-truename t "Show real filename when visit symlink")
  (warning-minimum-level :emergency "Don't show warnings in buffer")
  (hl-line-sticky-flag nil "Don't show hl-line on unfocused windows")
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
  (package-install-upgrade-built-in t "Update built-in packages")
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
            ("LISP" (or
                     (mode . emacs-lisp-mode)
                     (name . "^\\*scratch\\*$")))
            ("Dired" (mode . dired-mode))
            ("EAT" (mode . eat-mode))))))
  (ibuffer-never-show-predicates '("*Messages\\*" "*Help\\*" "*Quick Help\\*"
                                   "*Quail Completions\\*" "*Warnings\\*"
                                   "*Calc Trail\\*" "*Compile-Log\\*"
                                   "*Async-native-compile-log\\*"
                                   "*Native-compile-log\\*"
                                   "*Calculator\\*" "*Calendar\\*"
                                   "*Warning\\*"))
                                        ; Desktop save/restore
  (desktop-base-file-name "emacs.desktop")
  (desktop-base-lock-name "emacs.desktop.lock")
  (desktop-save t "Do not ask to save desktop")
  (desktop-load-locked-desktop t "Load locked desktop")
  (desktop-auto-save-timeout 600 "Autosave every 5 minutes")
                                        ; Misc
  (epg-pinentry-mode 'loopback)
  (mail-header-separator "")
  (recentf-max-menu-items 25)
  (recentf-max-saved-items 25)
  (Man-notify-method 'pushy "How manpage is displayed")
                                        ; Disable writing custom options to the end of ~/.emacs
  (custom-file (make-temp-file "emacs-custom-"))

  :config
                                        ; Use UTF8 everywhere
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment "UTF-8")
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
                                        ; Auto-revert buffer
  (global-auto-revert-mode t)
                                        ; Identation by default
  (defun my-ret-hook()
    "Make new lines indented"
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'octave-mode-hook 'my-ret-hook)
  (add-hook 'sh-mode-hook 'fci-mode)
                                        ; Electric pair mode
  (add-hook 'java-mode-hook 'electric-pair-local-mode)
  (add-hook 'c-mode-hook 'electric-pair-local-mode)
  (add-hook 'sh-mode-hook 'electric-pair-local-mode)
  (add-hook 'LaTeX-mode-hook 'electric-pair-local-mode)
  (add-hook 'bibtex-mode-hook 'electric-pair-local-mode)
  (add-hook 'emacs-lisp-mode-hook 'electric-pair-local-mode)
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
                                        ; Prettify some symbols
  (add-hook 'c-mode-hook (lambda ()
                           (push '("==" .?＝) prettify-symbols-alist)
                           (push '("!=" . ?≠) prettify-symbols-alist)
                           (push '("<=" . ?⩽) prettify-symbols-alist)
                           (push '(">=" . ?⩾) prettify-symbols-alist)
                           (prettify-symbols-mode)))
  (add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)
                                        ; For desktop saving
  (setq desktop-dirname ".")
  (setq desktop-path (list "~/.emacs.d/desktop"))
  (setq desktop-files-not-to-save "^$")
  (add-hook 'server-after-make-frame-hook (lambda ()
                                            (desktop-read)
                                            (desktop-save-mode 1)))
                                        ; Enable region narrowing
  (put 'narrow-to-region 'disabled nil)
                                        ; Notify when Emacs Daemon started
  (add-hook 'emacs-startup-hook
            (lambda ()
              (call-process "dunstify" nil nil nil
                            "Emacs" "Daemon started" "-u" "normal")))
                                        ; Setup language switching
  (add-hook 'emacs-startup-hook
            (lambda ()
              (progn
                (setq default-input-method "russian-computer")
                (global-set-key "\C-z" 'toggle-input-method))))
                                        ; Functions to shutdown Emacs Daemon
  (defun emacs-shutdown ()
    "Save buffers, quit, shutdown Emacs server and system"
    (interactive)
    (save-some-buffers)
    (desktop-save-in-desktop-dir)
    (add-hook 'kill-emacs-hook
              (lambda ()
                (progn
                  (setenv "SUDO_ASKPASS" (cond
                                          ((eq system-type 'gnu/linux)
                                           "/usr/bin/x11-ssh-askpass")
                                          ((eq system-type 'berkeley-unix)
                                           "/usr/local/bin/x11-ssh-askpass")))
                  (call-process "sudo" nil nil nil "-A" "poweroff"))))
    (kill-emacs))
  (defun emacs-stop ()
    "Save buffers, quit and shutdown Emacs server"
    (interactive)
    (save-some-buffers)
    (desktop-save-in-desktop-dir)
    (add-hook 'kill-emacs-hook
              (lambda ()
                (call-process "dunstify" nil nil nil
                              "Emacs" "Daemon stopped" "-u" "normal")))
    (kill-emacs))

  :init
  (pixel-scroll-precision-mode 1)
  :custom-face
  (default ((t (:size "14pt" :family "Noto Sans Mono-14"))))
  (italic ((t (:slant italic :weight light :height 160 :width normal :family "Noto Sans Mono Italic" :spacing proportional))))
  (popup-tip-face ((t (:background "#eee8d5" :foreground "#657b83" :box (:line-width (2 . 2) :color "dim gray" :style flat-button))))))

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

(use-package pdf-view-restore
  :pin melpa
  :after pdf-tools
  :hook
  (pdf-view-mode . pdf-view-restore-mode)
  :custom
  (pdf-view-restore-filename "~/.emacs.d/.pdf-view-restore"))

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

(use-package nov
  :pin melpa
  :mode ("\\.epub\\'" . nov-mode)
  :custom
  (nov-text-width 100 "EPUB text width"))

(use-package fb2-reader
  :pin melpa
  :mode ("\\.fb2\\(\\.zip\\)?\\'" . fb2-reader-mode)
  :commands (fb2-reader-continue)
  :custom
  (fb2-reader-page-width 100)
  (fb2-reader-image-max-width 600)
  (fb2-reader-image-max-height 600))

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
  (add-to-list 'eat-message-handler-alist (cons "open" 'my-eat-open))
  (defun eat2 ()
    "Open 2 EAT windows with fuck_censorship in one"
    (interactive)
    (eat)
    (eat "zsh -i -c fuck_censorship" 1))
  (defun eat-work ()
    "Open 2 EAT windows with connection to work"
    (interactive)
    (eat "~/work.sh" 9)
    (eat "~/work.sh" 8)))

(use-package highlight-thing
  :pin melpa
  :delight
  (hightlight-thing-mode)
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
