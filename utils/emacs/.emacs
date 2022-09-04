; Increase GC limit to boot speedup
(setq gc-cons-threshold 100000000)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(ido-mode 'buffer nil (ido))
 '(initial-scratch-message nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:size "14pt" :family "Noto Mono-14"))))
 '(highlight-symbol-face ((((class color) (background dark)) (:background "OliveDrab")))))

(let ((default-directory  "~/.emacs.d/plugins/"))
  (setq load-path
        (append
         (let ((load-path  (copy-sequence load-path))) ;; Shadow
           (normal-top-level-add-subdirs-to-load-path))
         load-path)))

(load "~/.emacs.d/rc-emacs.el")
(load "~/.emacs.d/rc-ido.el")
(load "~/.emacs.d/rc-aspell.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-colortheme.el")
(load "~/.emacs.d/rc-rst-mode.el")
(load "~/.emacs.d/rc-fill-column-indicator.el")
(load "~/.emacs.d/rc-auto-complete.el")

;;default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)
