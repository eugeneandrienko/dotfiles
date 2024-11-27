;; Increase GC limit to boot speedup
(setq gc-cons-threshold (* 100 1000 1000))

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

;; Return GC limit back
(setq gc-cons-threshold (* 2 1000 1000))
