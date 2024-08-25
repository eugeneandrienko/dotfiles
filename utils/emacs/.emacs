;; Increase GC limit to boot speedup
(setq gc-cons-threshold 100000000)

(load "~/.emacs.d/rc-emacs.el")

(load "~/.emacs.d/rc-vertico.el")
(load "~/.emacs.d/rc-marginalia.el")
(load "~/.emacs.d/rc-dired.el")
(load "~/.emacs.d/rc-langtool.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-colortheme.el")
(load "~/.emacs.d/rc-git.el")
(load "~/.emacs.d/rc-company.el")
(load "~/.emacs.d/rc-dockerfile-mode.el")
(load "~/.emacs.d/rc-org.el")
(load "~/.emacs.d/rc-mu4e.el")
(load "~/.emacs.d/rc-olivetti.el")
(load "~/.emacs.d/rc-sql.el")
(load "~/.emacs.d/rc-pass.el")
(load "~/.emacs.d/rc-pdf-tools.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'pushy)
 '(initial-scratch-message nil)
 '(package-selected-packages '(pinentry org company use-package auto-complete auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:size "14pt" :family "Noto Sans Mono-14"))))
 '(italic ((t (:slant italic :weight light :height 160 :width normal :family "Noto Sans Mono Italic" :spacing proportional))))
 '(popup-tip-face ((t (:background "#eee8d5" :foreground "#657b83" :box (:line-width (2 . 2) :color "dim gray" :style flat-button))))))

;; Default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)
(put 'dired-find-alternate-file 'disabled nil)
(put 'narrow-to-region 'disabled nil)
