;;my favorite scrolling
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)
;turn off the panel
;(tool-bar-mode 0)
;turn off the menu
(menu-bar-mode 0)
;disable the vertical scrollbars
;(scroll-bar-mode 0)
;;enable numbers of line and char
(line-number-mode t)
(column-number-mode t)
;disable the startup screen
(setq inhibit-startup-screen t)
(setq inhibit-splash-screen t)
;;save all backups to "~/.emacs.d/backups/"
(when (not (file-directory-p "~/.emacs.d/backups"))
  (make-directory "~/.emacs.d/backups"))
(if (file-directory-p "~/.emacs.d/backups")
    (setq backup-directory-alist '(("." . "~/.emacs.d/backups"))))
;;create directories for autocomplete
(when (not (file-directory-p "~/.emacs.d/auto-complete"))
    (make-directory "~/.emacs.d/auto-complete"))
(if (file-directory-p "~/.emacs.d/auto-complete")
    (setq unix-init-ac-path "~/.emacs.d/auto-complete"))
(when (not (file-directory-p "~/.emacs.d/auto-complete/dict"))
    (make-directory "~/.emacs.d/auto-complete/dict"))
(if (file-directory-p "~/.emacs.d/auto-complete/dict")
    (setq unix-init-ac-dict-path "~/.emacs.d/auto-complete/dict"))
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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (intellij)))
 '(custom-safe-themes
   (quote
    ("e0c6e4273bbb272e090a60a834310669490a41f67b9f8206aa7a140661cf7e5b" "e3fc83cdb5f9db0d0df205f5da89af76feda8c56d79a653a5d092c82c7447e02" "38e66a2a20fa9a27af5ffc4f4dd54f69e3fef6b51be7b351e137b24958bfebd7" default)))
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

;;enable package manager
(when (>= emacs-major-version 24)
 (require 'package)
 (package-initialize)
 (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
)

;;Setup Intellij color theme
(add-to-list 'load-path "~/.emacs.d/intellij-theme/")
(require 'intellij-theme)

(show-paren-mode t)
(setq show-paren-style 'expression)

(setq use-dialog-box nil)
(setq redisplay-dont-pause t)

;;Codepage setup
(set-language-environment 'UTF-8)
(progn
 (setq default-buffer-file-coding-system 'utf-8)
 (setq-default coding-system-for-read    'utf-8)
 (setq file-name-coding-system           'utf-8)
 (set-selection-coding-system            'utf-8)
 (set-keyboard-coding-system        'utf-8-unix)
 (set-terminal-coding-system             'utf-8)
 (prefer-coding-system                   'utf-8))

;;enable line numbers
(require 'linum)
(global-linum-mode t)
(setq linum-format " %d ")

;;IDO setup
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;;Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t)
(setq font-lock-maximum-decoration t)

;;Tabs and idents
(setq-default indent-tabs-mode nil)
(setq-default tab-width          4)
(setq-default c-basic-offset     4)
(setq-default standart-indent    4)
(setq-default lisp-body-indent   4)
(global-set-key (kbd "RET") 'newline-and-indent)

;;default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)

;;Clipboard settigns
(setq x-select-enable-clipboard t)

;;Require final newline
(setq require-final-newline t)
(setq next-line-add-newlines nil)

;;Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;;CEDET
(require 'cedet) ;; использую "вшитую" версию CEDET. Мне хватает...
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(semantic-mode   t)
(global-ede-mode t)
(require 'ede/generic)
(require 'semantic/ia)
(ede-enable-generic-projects)

;;Auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete)
(defun ac-init()
    (require 'auto-complete-config)
    (ac-config-default)
    (add-to-list 'ac-dictionary-directories unix-init-ac-dict-path)
    (setq ac-auto-start        t)
    (setq ac-auto-show-menu    t)
    (global-auto-complete-mode t)
    (add-to-list 'ac-modes   'lisp-mode)
    (add-to-list 'ac-sources 'ac-source-semantic) ;; искать автодополнения в CEDET
    (add-to-list 'ac-sources 'ac-source-variables) ;; среди переменных
    (add-to-list 'ac-sources 'ac-source-functions) ;; в названиях функций
    (add-to-list 'ac-sources 'ac-source-dictionary) ;; в той папке где редактируемый буфер
    (add-to-list 'ac-sources 'ac-source-words-in-all-buffer) ;; по всему буферу
    (add-to-list 'ac-sources 'ac-source-files-in-current-dir))
(when
    (file-directory-p unix-init-ac-path)
    (add-to-list 'load-path unix-init-ac-path)
    (ac-init))

;; C mode...
(setq c-basic-offset 4)
(setq c-default-style "linux")


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
