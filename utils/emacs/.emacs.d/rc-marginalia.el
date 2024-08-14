(use-package marginalia
  :pin melpa
  :requires vertico
  :after vertico
  :bind
  (:map minibuffer-local-map
        ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
