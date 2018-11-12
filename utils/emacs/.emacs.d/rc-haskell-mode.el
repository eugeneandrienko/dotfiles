(if (not (package-installed-p 'haskell-mode))
  (progn
     (package-refresh-contents)
     (package-install 'haskell-mode)))

(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(set 'tab-width 4)
(set 'haskell-font-lock-symbols t)
(put 'downcase-region 'disabled nil)
