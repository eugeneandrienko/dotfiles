(if (not (package-installed-p 'color-theme))
  (progn
     (package-refresh-contents)
     (package-install 'color-theme)))

(require 'color-theme)
(color-theme-initialize)

(color-theme-vim-colors)

; Set color of current line highlighting
(set-face-background 'hl-line "#eeeeee")
(set-face-foreground 'highlight nil)
