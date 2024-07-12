                                        ;my favourite scrolling
(setq scroll-step 1)
                                        ;turn off the panel
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
                                        ;turn off the menu
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
                                        ;compilation window shall scroll down
(setq compilation-scroll-output 1)
                                        ;disable the vertical scrollbars
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
                                        ;enable numbers of line and char
(line-number-mode t)
(column-number-mode t)
                                        ;disable the startup screen
(setq inhibit-startup-screen t)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-echo-area-message t)
                                        ;immediately show keystrokes
(setq echo-keystrokes 0.5)

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))


;; Save all backups to "~/.emacs.d/backups/"
(when (not (file-directory-p "~/.emacs.d/backups"))
  (make-directory "~/.emacs.d/backups"))
(if (file-directory-p "~/.emacs.d/backups")
    (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))

;; Save all auto save files to "~/.emacs.d/autosave/"
(when (not (file-directory-p "~/.emacs.d/autosave"))
  (make-directory "~/.emacs.d/autosave"))
(if (file-directory-p "~/.emacs.d/autosave")
    (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t))))

                                        ;matching brackets highliting
(show-paren-mode t)
                                        ;tab = 4 spaces
(setq-default tab-width 4)
                                        ;indent only by spaces by default
(setq-default indent-tabs-mode nil)
                                        ;highligth the current line
(global-hl-line-mode 1)
                                        ;auto-revert buffer
(global-auto-revert-mode t)

;; Identation by default
(defun my-ret-hook()
  "Make new lines indented"
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-hook 'octave-mode-hook 'my-ret-hook)
(add-hook 'sh-mode-hook 'fci-mode)

                                        ; Electric pair mode
(electric-pair-mode 1)

                                        ;height of compilation window
(setq compilation-window-height 10)
                                        ;y is rather short than yes
(fset 'yes-or-no-p 'y-or-n-p)
                                        ;use blinking cursor
(blink-cursor-mode t)
                                        ;insert newline at the EOF
(setq-default require-final-newline t)

                                        ;normal color in emacs shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
                                        ;bind 'M-g' to 'M-x goto-line'
(global-set-key "\eg" 'goto-line)

;; Default mode for text
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook '(lambda () (set-fill-column 78)))

;; Windmove
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;; MELPA setup
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(setq package-archive-priorities
      '(("melpa-stable" . 10)
        ("gnu" . 9)
        ("nongnu" . 8)
        ("melpa" . 1)))
(package-initialize)

;; Font for GUI
(add-to-list 'default-frame-alist
             '(font . "Noto Sans Mono-16"))

;; Emacs pinentry — ask password for GPG keys
(use-package pinentry
 :custom
 (pinentry-start))

;; Message mode for mutt
(add-to-list 'auto-mode-alist '("/mutt" . message-mode))
(setq mail-header-separator "")
(add-hook 'message-mode-hook
          (function
           (lambda ()
             (progn
               (setq show-trailing-whitespace nil)
               (local-unset-key "\C-c\C-c")
               (define-key message-mode-map "\C-c\C-c" '(lambda ()
                                                          "save and exit quickly"
                                                          (interactive)
                                                          (save-buffer)
                                                          (server-edit)))))))

;; Setup more smart buffer handling
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
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
                     (mode . c-mode)))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

;; Show trailing whitespace
(setq show-trailing-whitespace t)

;; Fix "<Mutli_key> is undefined" in FreeBSD:
(setq x-gtk-use-native-input 't)

;; Enable pixel scroll precision:
(if (>= emacs-major-version 29)
    (use-package emacs
      :bind
      ([remap scroll-up-command]   . pixel-scroll-interpolate-down)
      ([remap scroll-down-command] . pixel-scroll-interpolate-up)
      :custom
      (pixel-scroll-precision-interpolate-page t)
      :init
      (pixel-scroll-precision-mode 1)))
