(use-package solarized-theme
  :pin melpa
  :init
  (load-theme 'solarized-light t)
  :custom
  (solarized-use-variable-pitch nil "Don't change font for headings")
  (solarized-scale-org-headlines nil "Don't change font for Org headlines")
  (solarized-high-contrast-mode-line t "High contrast modeline")
  (x-underline-at-descent-line t "Put underline below font bottomline for X"))
