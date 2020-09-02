(if (not (package-installed-p 'color-theme-modern))
  (progn
     (package-refresh-contents)
     (package-install 'color-theme-modern)))

(require 'color-theme-modern)
(load-theme 'vim-colors t t)
(enable-theme 'vim-colors)

; Set color of current line highlighting
(set-face-background 'hl-line "#eeeeee")
(set-face-foreground 'highlight nil)
