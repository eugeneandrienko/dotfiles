;; Increase GC limit to boot speedup
(setq gc-cons-threshold 100000000)

(load "~/.emacs.d/rc-use-package.el")
(load "~/.emacs.d/rc-emacs.el")

(load "~/.emacs.d/rc-ido.el")
(load "~/.emacs.d/rc-aspell.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-colortheme.el")
(load "~/.emacs.d/rc-magit.el")
(load "~/.emacs.d/rc-rst-mode.el")
(load "~/.emacs.d/rc-fill-column-indicator.el")
(load "~/.emacs.d/rc-company.el")
(load "~/.emacs.d/rc-c-mode.el")
(load "~/.emacs.d/rc-dockerfile-mode.el")
(load "~/.emacs.d/rc-project.el")
(load "~/.emacs.d/rc-org.el")
(load "~/.emacs.d/rc-olivetti.el")
(load "~/.emacs.d/rc-sql.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(ido-mode 'buffer nil (ido))
 '(initial-scratch-message nil)
 '(package-selected-packages
   '(pinentry org company projectile lsp-ui lsp-java use-package fill-column-indicator color-theme-modern auto-complete auctex))
 '(show-trailing-whitespace t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:size "14pt" :family "Noto Sans Mono-14"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :foreground "OliveDrab" :height 1.1))) t)
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :foreground "OliveDrab" :height 1.1))) t)
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :foreground "OliveDrab" :height 1.1))) t)
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "OliveDrab" :height 1.1))) t)
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "OliveDrab" :height 1.1))) t)
 '(font-latex-sectioning-5-face ((((class color) (background dark)) (:inherit variable-pitch :foreground "OliveDrab" :weight bold))) t)
 '(font-latex-string-face ((t (:inherit font-lock-keyword-face :foreground "OliveDrab" :height 1.0))) t)
 '(highlight-symbol-face ((((class color) (background dark)) (:background "OliveDrab"))) t)
 '(italic ((t (:slant italic :weight light :height 160 :width normal :family "Noto Sans Mono Italic" :spacing proportional)))))

;; Default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)
