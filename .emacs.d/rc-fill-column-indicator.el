(add-to-list 'load-path "~/.emacs.d/elisp/fill-column-indicator/")
(require 'fill-column-indicator)

(setq fci-rule-width 1)
(setq fci-rule-color "grey")
(setq-default fill-column 80)
;(add-hook 'after-change-major-mode-hook 'fci-mode)
