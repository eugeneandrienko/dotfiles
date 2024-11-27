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
  :demand
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
  ("C-x f" . nil)
                                        ; Reverse C-x o
  ("C-x O" . (lambda () (interactive) (other-window -1) (setq this-command 'other-window)))
  ("<Scroll_Lock>" . read-only-mode)

  :custom
                                        ; List of manually installed packages
  (package-selected-packages '(highlight-thing
                               pinentry
                               org
                               corfu
                               use-package
                               auto-complete
                               auctex))
                                        ; Interface configuration
  (scroll-step 1 "My favorite scrolling")
  (auto-window-vscroll nil "Nicer scrolling without random half-screen jumps")
  (scroll-step 1 "Default scroll step")
  (scroll-conservatively 100000 "Dont jump to center")
  (scroll-margin 0 "Start scrolling when marker at top/bottom")
  (scroll-preserve-screen-position 'always "Point doesn't jumping around")
  (mouse-wheel-scroll-amount '(1) "Mouse scroll moves 1 line at a time")
  (mouse-wheel-progressive-speed nil "Don't use progressive speed when scrolling with mouse")
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
  (window-combination-resize t "Take new window space from ALL other windows, not the current one")
  (echo-keystrokes 0.01 "Show keystroke in echo area as fast as possible")
  (isearch-lazy-count t "Show size of search results")
  (lazy-count-prefix-format "(%s/%s) " "Format of search results")
  (x-stretch-cursor nil "Do not stretch cursor for wide characters")
  (cursor-in-non-selected-windows nil "Don't render cursor in inactive window")
  (highlight-nonselected-windows nil "Don't render selection in inactive window")
  (lazy-highlight-initial-delay 0 "No delay before highlight search matches")
  (buffer-file-coding-system 'utf-8-unix "Preferrable file coding system")
  (locale-coding-system 'utf-8 "Code system for system messages")
  (x-select-enable-clipboard t "Copy/paste uses clipboard")
                                        ; Auto revert non-file buffers
  (global-auto-revert-non-file-buffers t)
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
  (global-subword-mode 1 "Iterate through CameCaseWords")
  (gdb-many-windows t "Multi-window layout for GDB")
  (gdb-show-main t "Show source when debug")
  (semanticdb-default-save-directory "~/.emacs.d/semanticdb")
  (semantic-idle-scheduler-idle-time 5 "Time of idle in seconds before reparsing starts")
  (help-window-select t "Always select opened help window")
  (comment-multi-line t "Enable autoidentation for multi-line comments")
  (comment-empty-lines t "Empty lines should be commented inside multiline comment")
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
                     (mode . ielm-mode)
                     (name . "^\\*scratch\\*$")))
            ("Dired" (mode . dired-mode))
            ("EAT" (mode . eat-mode))))))
  (ibuffer-never-show-predicates '("*Messages\\*" "*Help\\*" "*Quick Help\\*"
                                   "*Quail Completions\\*" "*Warnings\\*"
                                   "*Calc Trail\\*" "*Compile-Log\\*"
                                   "*Async-native-compile-log\\*"
                                   "*Native-compile-log\\*"
                                   "*Calculator\\*" "*Calendar\\*"
                                   "*Warning\\*" "*prodigy.*" "magit:.*"
                                   "*Org Help\\*"))
  (switch-to-buffer-obey-display-actions t "Don't distuingish automatic and manual window switching")
                                        ; Desktop save/restore
  (desktop-base-file-name "emacs.desktop")
  (desktop-base-lock-name "emacs.desktop.lock")
  (desktop-save t "Do not ask to save desktop")
  (desktop-load-locked-desktop t "Load locked desktop")
  (desktop-auto-save-timeout 600 "Autosave every 5 minutes")
                                        ; Misc
  (epg-pinentry-mode 'loopback)
  (user-mail-address "evg.andrienko@gmail.com")
  (user-full-name "Eugene Andrienko")
  (mail-header-separator "")
  (recentf-max-menu-items 25)
  (recentf-max-saved-items 25)
  (delete-old-versions t "Delete old backup versions")
  (Man-notify-method 'pushy "How manpage is displayed")
  (history-length 100 "Minibuffer history length")
  (auth-sources '("~/.authinfo.gpg"))
                                        ; Disable writing custom options to the end of ~/.emacs
  (custom-file (make-temp-file "emacs-custom-"))
                                        ; Speedbar settings
  (speedbar-use-images t "Use images in speedbar")
                                        ; Save last place in file
  (save-place-mode 1)

  :config
                                        ; Use UTF8 everywhere
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-language-environment "UTF-8")
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
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
                                        ; Auto-revert buffer
  (global-auto-revert-mode t)
                                        ; For desktop saving
  (setq desktop-dirname ".")
  (setq desktop-path (list "~/.emacs.d/desktop"))
  (setq desktop-files-not-to-save "^$")
  (add-hook 'server-after-make-frame-hook (lambda ()
                                            (desktop-read)
                                            (desktop-save-mode 1)))
                                        ; Enable region narrowing
  (put 'narrow-to-region 'disabled nil)
                                        ; Compilation related settings
  (setq compilation-always-kill t)
  (setq compilation-scroll-output 'first-error)
                                        ; Notify when Emacs Daemon started
  (add-hook 'emacs-startup-hook
            (lambda ()
              (call-process "dunstify" nil nil nil
                            "Emacs"
                            (format "Daemon started in %.2f seconds with %d garbage collections"
                                    (float-time
                                     (time-subtract after-init-time before-init-time))
                                    gcs-done)
                            "-u" "normal")))
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
                                           "/usr/bin/ssh-askpass-fullscreen")
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
  (default ((t (:size "14pt" :family "Hack-16"))))
  (italic ((t (:slant italic :weight light :height 160 :width normal :family "Hack Italic-16" :spacing proportional))))
  (popup-tip-face ((t (:background "#eee8d5" :foreground "#657b83" :box (:line-width (2 . 2) :color "dim gray" :style flat-button))))))

(use-package tramp
  :custom
  (tramp-show-ad-hoc-proxies t)
  (tramp-default-method "sudo")
                                        ; Disable consult preview of remote buffer
  ;; From: https://github.com/minad/consult/discussions/969#discussioncomment-10871508
  (defun buffer-remote-p (buf)
    "Return t when BUF is remote."
    (if-let ((fp (buffer-file-name buf)))
        (file-remote-p fp)
      nil))
  (setq consult-preview-excluded-buffers 'buffer-remote-p))

(use-package window
  :ensure nil
  :preface
  (defun hsplit-last-buffer ()
    "Focus to the last created horizontal window."
    (interactive)
    (split-window-horizontally)
    (other-window 1))
  (defun vsplit-last-buffer ()
    "Focus to the last created vertical window."
    (interactive)
    (split-window-vertically)
    (other-window 1))
  (global-set-key (kbd "C-x 2") #'vsplit-last-buffer)
  (global-set-key (kbd "C-x 3") #'hsplit-last-buffer))

;;; Setup nerd-icons
;;; M-x nerd-icons-install-fonts
;;; Installation path: ~/.local/share/fonts/
(use-package nerd-icons
  :custom
  (nerd-icons-color-icons nil))

(use-package nerd-icons-ibuffer
  :requires nerd-icons
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
  :magic ("%PDF" . pdf-view-mode)
  :bind
  (:map pdf-view-mode-map
        ("M-g" . 'pdf-view-goto-page))
  :custom
  (pdf-annot-activate-created-annotations t)
  :config
  (pdf-loader-install)
  (setq-default pdf-view-display-size 'fit-page))

(use-package pdf-view-restore
  :pin melpa
  :after pdf-tools
  :hook
  (pdf-view-mode . pdf-view-restore-mode)
  :custom
  (pdf-view-restore-filename "~/.emacs.d/.pdf-view-restore"))

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
  :commands (eat eat-project)
  :custom
  (eat-enable-directory-tracking t "Track current working directory")
  (eat-kill-buffer-on-exit t "Kill buffer on exit")
  (eat-term-scrollback-size 16384)
  (process-adaptive-read-buffering nil "Faster EAT")
  (read-process-output-max (* 4 1024 1024))
  ;; (eat-term-name "xterm-256color" "https://codeberg.org/akib/emacs-eat/issues/119")
  :init
  (with-eval-after-load 'project
    (add-to-list 'project-switch-commands '(eat-project "Eat terminal" "t") t)
    (add-to-list 'project-kill-buffer-conditions '(major-mode . eat-mode)))
  :config
  (define-key project-prefix-map (kbd "t") 'eat-project)
  :bind
  (:map eat-mode-map
        ("C-c C-p" . eat-send-password)))

(use-package windresize
  :pin gnu
  :custom
  (windresize-pam t "Change window size by moving borders")
  :bind
  (:map global-map
        ("C-x C-w" . windresize)))

;; Dependencies: xclip, xdotool, xprop, xwininfo
(use-package emacs-everywhere
  :commands (emacs-everywhere)
  :config
  (if (eq system-type 'berkeley-unix)
      (progn
        (setq emacs-everywhere--display-server 'x11)
        (setq emacs-everywhere-app-info-function #'emacs-everywhere--app-info-linux-x11)
        (setq emacs-everywhere-copy-command
              (list "xclip" "-selection" "clipboard" "%f"))
        (setq emacs-everywhere-paste-command
              (list "xdotool" "key" "--clearmodifiers" "Shift+Insert"))
        (setq emacs-everywhere-window-focus-command
              (list "xdotool" "windowactivate" "--sync" "%w")))))
