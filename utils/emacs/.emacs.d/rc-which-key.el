(use-package which-key
  :custom
  (which-key-show-early-on-C-h t)
  (which-key-idle-delay 10000)
  (which-key-idle-secondary-delay 0.5)
  (which-key-separator "→")
  (which-key-unicode-correction 1)
  (which-key-lighter "")
  :init
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook 'which-key-mode)))
