(defun eshell-settings ()
  "Settings for `eshell'."
  (defun eshell-mode-hook-settings ()
    "Settings for `term-mode-hook'"
    (make-local-variable 'scroll-margin)
    (setq scroll-margin 0))
  
  (add-hook 'eshell-mode-hook 'eshell-mode-hook-settings))

(eval-after-load "eshell"
  `(eshell-settings))

(provide 'term-settings)
