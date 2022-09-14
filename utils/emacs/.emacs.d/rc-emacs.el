                                        ;my favourite scrolling
(setq scroll-step 1)
                                        ;turn off the panel
;(tool-bar-mode 0)
                                        ;turn off the menu
(menu-bar-mode 0)
                                        ;compilation window shall scroll down
(setq compilation-scroll-output 1)
                                        ;disable the vertical scrollbars
;(scroll-bar-mode 0)
                                        ;enable numbers of line and char
(line-number-mode t)
(column-number-mode t)
                                        ;disable the startup screen
(setq inhibit-startup-screen t)
                                        ;immediately show keystrokes
(setq echo-keystrokes 0.5)

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
                                        ;highligth the current line
(global-hl-line-mode 1)
                                        ;auto-revert buffer
(global-auto-revert-mode t)
                                        ;use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Identation by default
(defun my-ret-hook()
  "Make new lines indented"
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-hook 'octave-mode-hook 'my-ret-hook)
(add-hook 'sh-mode-hook 'fci-mode)
(add-hook 'sh-mode-hook
          '(lambda ()
             (linum-mode 1)))

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
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(global-set-key (kbd "C-c h")  'windmove-left)
(global-set-key (kbd "C-c k")    'windmove-up)
(global-set-key (kbd "C-c j")  'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-right)

;; MELPA setup
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)
