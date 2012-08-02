(add-to-list 'load-path "~/.emacs.d/elisp/ecb/")
(require 'ecb)

(global-set-key "\e\ec"  'ecb-activate)
(global-set-key "\e\ed" 'ecb-deactivate)
(global-set-key "\e\et" 'ecb-toggle-ecb-windows)

(setq ecb-method-face 'zenburn-orange)
(setq ecb-source-face 'zenburn-orange)
(setq ecb-directory-face 'zenburn-orange)
;to avoid "ecb-activate-internal: Symbol's value as variable is void:
;stack-trace-on-error"
(setq stack-trace-on-error t)
