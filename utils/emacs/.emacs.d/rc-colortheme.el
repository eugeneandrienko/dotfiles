(use-package color-theme-modern
  :config
  (progn (load-theme 'vim-colors t t)
	 (enable-theme 'vim-colors))
  :config
  (progn (set-face-background 'hl-line "#eeeeee")
	 (set-face-foreground 'highlight nil)))
