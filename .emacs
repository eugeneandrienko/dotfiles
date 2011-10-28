;;start Emacs server
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(Man-notify-method (quote pushy))
 '(ido-mode (quote buffer) nil (ido))
 '(initial-scratch-message nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:size "14pt" :family "DroidSansMono"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :foreground "green" :height 1.1))))
 '(font-latex-sectioning-5-face ((((class color) (background dark)) (:inherit variable-pitch :foreground "green" :weight bold))))
 '(highlight-symbol-face ((((class color) (background dark)) (:background "OliveDrab")))))

;;(require 'site-gentoo)

(load "~/.emacs.d/rc-emacs.el")
(load "~/.emacs.d/rc-ido.el")
(load "~/.emacs.d/rc-edit-server.el")
(load "~/.emacs.d/rc-eshell.el")
(load "~/.emacs.d/rc-org.el")
(load "~/.emacs.d/rc-auctex.el")
(load "~/.emacs.d/rc-colortheme.el")
(load "~/.emacs.d/rc-slime.el")
(load "~/.emacs.d/rc-paredit.el")
(load "~/.emacs.d/rc-objc-mode.el")
(load "~/.emacs.d/rc-clojure-mode.el")
(load "~/.emacs.d/rc-haskell-mode.el")
(load "~/.emacs.d/rc-ahg.el")
(load "~/.emacs.d/rc-magit.el")
;(load "~/.emacs.d/rc-jabber.el")
(load "~/.emacs.d/rc-emms.el")
(load "~/.emacs.d/rc-noweb-mode.el")
(load "~/.emacs.d/rc-fill-column-indicator.el")
(load "~/.emacs.d/rc-elein.el")
(load "~/.emacs.d/rc-wiki-creole.el")
(load "~/.emacs.d/rc-verilog-mode.el")
(load "~/.emacs.d/rc-octave.el")
(load "~/.emacs.d/rc-emacs-w3m.el")

;;default cyr/latin input method
(setq default-input-method "russian-computer")
(global-set-key "\C-z" 'toggle-input-method)
