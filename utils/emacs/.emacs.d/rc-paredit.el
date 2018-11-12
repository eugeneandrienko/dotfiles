(if (not (package-installed-p 'paredit))
  (progn
     (package-refresh-contents)
     (package-install 'paredit)))

(require 'paredit)

;(autoload 'enable-paredit-mode "paredit"
;  "Turn on pseudo-structural editing of Lisp code."
;  t)
;(autoload 'paredit-mode "paredit"
;  "Minor mode for pseudo-structurally editing Lisp code." t)
