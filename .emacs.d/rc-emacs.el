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
;;identation by default
(defun my-ret-hook()
  "Make new lines indented"
  (local-set-key (kbd "RET") 'newline-and-indent)
)
(add-hook 'c-mode-hook 'my-ret-hook)
(add-hook 'c-mode-hook
	  '(lambda ()
	     (linum-mode 1)))
(add-hook 'c-mode-hook 'fci-mode)
(add-hook 'objc-mode-hook 'my-ret-hook)
(add-hook 'clojure-mode-hook 'my-ret-hook)
(add-hook 'haskell-mode-hook 'my-ret-hook)
(add-hook 'octave-mode-hook 'my-ret-hook)
;
(setq compilation-window-height 10)
;Emacs font
(custom-set-faces '(default ((t (:size "14pt" :family "DroidSansMono")))))
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
