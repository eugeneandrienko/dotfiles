(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(require 'highlight-symbol)

(set 'tab-width 4)
(set 'haskell-font-lock-symbols t)
(put 'downcase-region 'disabled nil)

(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; Uncomment to enable auto-insertion of module templates
;(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;; Enable spell checking of strings and comments
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)

(setq highlight-symbol-idle-delay 1)
(defun my-haskell-mode-hook ()
  (highlight-symbol-mode)
  (setq highlight-symbol-face '((:underline t)))
  (local-set-key (kbd "C-c d") 'highlight-symbol-at-point)
  (custom-set-faces '(highlight-symbol-face ((((class color) (background dark)) (:background "OliveDrab"))))))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  ; type of using REPL (Cabal)
  '(haskell-process-type 'cabal-repl)
  '(haskell-indentation-electric-flag t))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

