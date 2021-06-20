(require 'color-theme-modern)
(add-to-list 'custom-theme-load-path "~/.emacs.d/plugins/color-theme-modern/")
(load-theme 'vim-colors t t)
(enable-theme 'vim-colors)

; Set color of current line highlighting
(set-face-background 'hl-line "#eeeeee")
(set-face-foreground 'highlight nil)
