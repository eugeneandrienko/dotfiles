(require 'haskell-mode-autoloads)

;;
;; Configuration:
;;
(custom-set-variables
  ; Ask user to remove redundant imports when building/loading modules:
  '(haskell-process-suggest-remove-import-lines t)
  ; Auto-import loaded module:
  '(haskell-process-auto-import-loaded-modules t)
  ; Add more logging info to the same named buffer:
  '(haskell-process-log t)
  ; Auto recognition of Haskell interpreter type:
  '(haskell-process-type 'auto)
  ; Auto reindentation when insertion of some characters like: ,;)}]
  '(haskell-indentation-electric-flag t)
  ; Call stylish-haskell before save:
  '(haskell-stylish-on-save t)
  ; Generate tags by hasktags on the file save:
  '(haskell-tags-on-save t))

; Disable Emacs warning for that function:
(put 'downcase-region 'disabled nil)

; Enable doc-mode for Haskell to show documentation on the fly:
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
; Enable Haskell indentation:
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
; Auto insert of module template on the start of every module:
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
; Enable interactive mode:
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;;
;; Hotkeys:
;;
(eval-after-load "haskell-mode"
 '(progn
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
     (define-key haskell-mode-map [f1] 'haskell-interactive-bring)
     (define-key haskell-mode-map [f8] 'haskell-navigate-imports)))
(eval-after-load "haskell-cabal"
  '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))

