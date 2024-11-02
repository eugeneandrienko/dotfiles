(use-package marginalia
  :pin melpa
  :requires vertico
  :after vertico
  :bind
  (:map minibuffer-local-map
        ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after (nerd-icons marginalia)
  :requires (nerd-icons marginalia)
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))
