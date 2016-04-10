;;my favorite scrolling
(setq scroll-step 1)
;turn off the panel
(tool-bar-mode 0)
;turn off the menu
(menu-bar-mode 0)
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
;highligth the current line
(global-hl-line-mode 1)
;auto-revert buffer
(global-auto-revert-mode t)
;Emacs font
;(custom-set-faces '(default ((t (:size "14pt" :family "Droid Sans Mono-14")))))
(set-default-font "-unknown-Droid Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
;y is rather short than yes
(fset 'yes-or-no-p 'y-or-n-p)
;
(blink-cursor-mode t)
;
(custom-set-variables
 '(initial-scratch-message nil))
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

(require 'color-theme)
(color-theme-initialize)
(color-theme-retro-green)

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\\\.org\\\\'" . org-mode))
(global-set-key "\e\el" 'org-store-link)
(global-set-key "\e\ec" 'org-capture)
(global-set-key "\e\ea" 'org-agenda)
(global-set-key "\e\eb" 'org-iswitchb)

(setq default-directory "~/Dropbox/org/")
(setq org-directory "~/Dropbox/org/")
(setq org-agenda-files (quote ("~/Dropbox/org/")))

;my preferred indentation
(setq org-startup-indented t)
;disable wrapping
(setq org-startup-truncated t)

;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "STARTED(s)" "|" "DONE(d)" "CANCELLED(c)"))))
(setq org-tag-alist
      (quote (("todo" . ?t) ("books" . ?b))))
;


;;default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)
