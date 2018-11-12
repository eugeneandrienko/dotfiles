(if (not (package-installed-p 'color-theme))
  (progn
     (package-refresh-contents)
     (package-install 'color-theme)))

(require 'color-theme)
(color-theme-initialize)

(color-theme-vim-colors)
