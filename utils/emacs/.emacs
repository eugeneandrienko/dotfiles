;; Increase GC limit to boot speedup
(setq gc-cons-threshold 100000000)

(custom-set-variables
 '(Man-notify-method 'pushy)
 '(ido-mode 'buffer nil (ido))
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(use-package fill-column-indicator color-theme-modern auto-complete auctex-latexmk auctex lsp-java)))
(custom-set-faces
 '(default ((t (:size "14pt" :family "Noto Mono-14")))))

(load "~/.emacs.d/rc-use-package.el")
(load "~/.emacs.d/rc-emacs.el")
(load "~/.emacs.d/rc-ido.el")
(load "~/.emacs.d/rc-aspell.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-colortheme.el")
(load "~/.emacs.d/rc-rst-mode.el")
(load "~/.emacs.d/rc-fill-column-indicator.el")
(load "~/.emacs.d/rc-auto-complete.el")

;; Default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)

