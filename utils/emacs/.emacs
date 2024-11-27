;;; Performance

;; Increase GC limit to boot speedup:
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
;; And restore it after startup:
(add-hook 'after-init-hook (lambda ()
                             (setq gc-cons-threshold (* 16 1024 1024))))

;; Don't resize frame during startup:
(setq frame-inhibit-implied-resize t)

;; Ignore X resources processing
(advice-add #'x-apply-session-resources :override #'ignore)

;; Remove "for information about gnu emacs..." message at startup
(advice-add #'display-startup-echo-area-message :override #'ignore)

;; Suppress the vanilla startup screen completely
(advice-add #'display-startup-screen :override #'ignore)

;; Never show the hello file
(defalias #'view-hello-file #'ignore)

;; Unset `file-name-handler-alist' temporarily. Every file opened and
;; loaded by Emacs will run through this list to check for a proper
;; handler for the file, but during startup, it won’t need any of
;; them.
(defvar file-name-handler-alist-old file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old)))

;; Disable bidirectional text processing
(setq bidi-inhibit-bpa t)
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)


;;; Main configuration

(load "~/.emacs.d/rc-emacs.el")

(load "~/.emacs.d/rc-vertico.el")
(load "~/.emacs.d/rc-marginalia.el")
(load "~/.emacs.d/rc-dired.el")
(load "~/.emacs.d/rc-langtool.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-git.el")
(load "~/.emacs.d/rc-corfu.el")
(load "~/.emacs.d/rc-org.el")
(load "~/.emacs.d/rc-mu4e.el")
(load "~/.emacs.d/rc-pass.el")
(load "~/.emacs.d/rc-prodigy.el")
(load "~/.emacs.d/rc-cheatsheet.el")
